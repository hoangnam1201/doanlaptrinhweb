package com.udemy.DAO;

import com.udemy.model.*;
import com.udemy.model.Category_;
import com.udemy.model.Course_;
import com.udemy.model.Enrollment_;
import com.udemy.util.JpaUtil;
import org.hibernate.Hibernate;

import javax.persistence.*;
import javax.persistence.criteria.*;
import java.util.ArrayList;
import java.util.List;

public class CourseDAOImpl implements CourseDAO {
    private final EntityManagerFactory emf;

    public CourseDAOImpl() {
        emf = JpaUtil.getJPAFactory();
    }

    @Override
    public Course getCourseById(Long id) {
        EntityManager em = emf.createEntityManager();
        String queryString = "select c from Course c left join fetch c.sections where c.id=" + id;
        try {
            Course course = em.createQuery(queryString, Course.class).getSingleResult();
            Hibernate.initialize(course.getEnrollments());
            return course;
        } catch (NoResultException ex) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Course> getCourseList() {
        EntityManager em = emf.createEntityManager();
        String queryString = "from Course c";
        try {
            return em.createQuery(queryString, Course.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Course> getCourseListWithFilter(CourseListPageInfo courseListPageInfo) {
        //Init
        EntityManager em = emf.createEntityManager();
        CriteriaBuilder builder = em.getCriteriaBuilder();
        CriteriaQuery<Course> query = builder.createQuery(Course.class);
        Root<Course> root = query.from(Course.class);

        //Condition
        Predicate isComplete = builder.isTrue(root.get(Course_.IS_COMPLETE));
        Predicate isNotDisable = builder.isFalse(root.get(Course_.IS_DISABLED));
        Predicate search = builder.like(root.get(Course_.NAME), "%" + courseListPageInfo.getSearchString() + "%");
        Predicate category = builder.and();
        if (courseListPageInfo.getCategory() != null) {
            if (courseListPageInfo.getCategory().getParent() != null) {
                category = builder.equal(root.get(Course_.CATEGORY), courseListPageInfo.getCategory().getId());
            } else {
                category = builder.equal(root.get(Course_.CATEGORY).get("parent"), courseListPageInfo.getCategory().getId());
            }
        }
        Predicate condition = builder.and(isComplete, isNotDisable, search, category);

        //Count
        CriteriaQuery<Long> totalResults = builder.createQuery(Long.class);
        totalResults.select(builder.count(totalResults.from(Course.class)));
        em.createQuery(totalResults);
        totalResults.where(condition);
        courseListPageInfo.setResultCount(em.createQuery(totalResults).getSingleResult());

        //List
        query.select(root).where(condition);
        if (courseListPageInfo.getSortDirection().equals("asc")) {
            query.orderBy(builder.asc(root.get(courseListPageInfo.getSortField())));
        } else {
            query.orderBy(builder.desc(root.get(courseListPageInfo.getSortField())));
        }

        List<Course> results = em.createQuery(query)
                .setFirstResult((courseListPageInfo.getCurrentPage() - 1) * CourseListPageInfo.pageLimit)
                .setMaxResults(CourseListPageInfo.pageLimit)
                .getResultList();
        em.close();
        return results;
    }

    @Override
    public List<Course> getMyCourses(Long userId) {
        EntityManager em = emf.createEntityManager();
        String queryString = "select c from Course c where c.teacher.id =" + userId;
        List<Course> list = em.createQuery(queryString, Course.class).getResultList();
        em.close();
        return list;
    }

    @Override
    public List<Course> getFeaturedCourses(int amount) {
        EntityManager em = emf.createEntityManager();
        String queryString = "select c from Course c join c.enrollments as e " +
                "where c.isComplete = true and c.isDisabled = false and " +
                "function('datediff',CURRENT_DATE, e.createdAt) < 7 " +
                "group by c.id " +
                "order by count(e.id) desc";

        List<Course> list = em.createQuery(queryString, Course.class)
                .setMaxResults(amount).getResultList();
        em.close();
        return list;
    }

    @Override
    public List<Course> getPopularCourses(int amount) {
        EntityManager em = emf.createEntityManager();
        String queryString = "select c from Course c " +
                "where c.isComplete = true and c.isDisabled = false " +
                "order by c.studentCount desc";

        List<Course> list = em.createQuery(queryString, Course.class)
                .setMaxResults(amount).getResultList();
        em.close();
        return list;
    }

    @Override
    public List<Course> getLatestCourses(int amount) {
        EntityManager em = emf.createEntityManager();
        String queryString = "select c from Course c where c.isComplete = true and c.isDisabled = false order by c.createdAt desc";
        List<Course> list = em.createQuery(queryString, Course.class)
                .setMaxResults(amount).getResultList();
        em.close();
        return list;
    }

    @Override
    public List<Course> getCourseRecommendations(Course course, int amount) {
        EntityManager em = emf.createEntityManager();
        String queryString = "select c from Course c " +
                "where c.category.id = ?1 and c.id != ?2 " +
                "order by c.studentCount desc";
        try {
            return em.createQuery(queryString, Course.class)
                    .setParameter(1, course.getCategory().getId())
                    .setParameter(2, course.getId())
                    .setMaxResults(amount).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public void addNew(Course course) {
        EntityManager entityManager = emf.createEntityManager();
        entityManager.getTransaction().begin();
        try {
            entityManager.persist(course);
            entityManager.getTransaction().commit();
        } catch (Exception ex) {
            entityManager.getTransaction().rollback();
            throw ex;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void delete(Course course) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        try {
            em.remove(em.contains(course) ? course : em.merge(course));
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw ex;
        } finally {
            em.getTransaction().commit();
            em.close();
        }
    }

    @Override
    public Course update(Course course) {
        EntityManager entityManager = emf.createEntityManager();
        entityManager.getTransaction().begin();
        try {
            course = entityManager.merge(course);
            entityManager.getTransaction().commit();
            return course;
        } catch (Exception ex) {
            entityManager.getTransaction().rollback();
            throw ex;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void updateRating(Course course) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        try {
            course = em.merge(course);

            Long totalRating = (Long) em.createQuery("select sum(e.rating) " +
                    "from Course c " +
                    "join c.enrollments as e where c.id = ?1 and e.rating != 0")
                    .setParameter(1, course.getId()).getSingleResult();

            Long ratingCount = (Long) em.createQuery("select count(c.id) " +
                    "from Course c join c.enrollments as e " +
                    "where c.id = ?1 and e.rating != 0").setParameter(1, course.getId())
                    .getSingleResult();

            course.setAvgRating((totalRating * 1.0) / ratingCount);
            course.setRatingCount(ratingCount.intValue());

            em.merge(course);
            em.getTransaction().commit();
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw ex;
        } finally {
            em.close();
        }

    }
}
