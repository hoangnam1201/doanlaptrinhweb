package com.udemy.DAO;

import com.udemy.model.Category;
import com.udemy.model.Course;
import com.udemy.model.CourseListPageInfo;
import com.udemy.model.Enrollment;
import com.udemy.util.JpaUtil;
import org.hibernate.Hibernate;

import javax.persistence.*;
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
    public List<Course> searchCourses(String searchString) {
        return null;
    }

    @Override
    public List<Course> getCourseListByCategory(Category category, CourseListPageInfo courseListPageInfo) {
        int pageSize = 1;
        EntityManager em = emf.createEntityManager();
        String queryString = "select c from Course c where c.isComplete = true and " +
                " (c.category.id=?1 or c.category.parent.id=?1) ";
        Query query = em.createQuery(queryString).setParameter(1, category.getId());
        query.setFirstResult((courseListPageInfo.getCurrentPage() - 1) * pageSize);
        query.setMaxResults(pageSize);
        List<Course> list = query.getResultList();

        Query queryTotal = em.createQuery("select count(c.id) from Course c where c.isComplete = true and " +
                " (c.category.id=?1 or c.category.parent.id=?1) ");
        queryTotal.setParameter(1, category.getId());
        long countResult = (long) queryTotal.getSingleResult();
        courseListPageInfo.setResultCount((int) countResult);
        courseListPageInfo.setTotalPage((int) ((countResult / pageSize) + 1));
        em.close();
        return list;
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
                "where c.isComplete = true and " +
                "function('datediff',CURRENT_DATE, e.createdAt) < 7 " +
                "group by c.id " +
                "order by count(c.enrollments.size) desc";

        List<Course> list = em.createQuery(queryString, Course.class)
                .setMaxResults(amount).getResultList();
        em.close();
        return list;
    }

    @Override
    public List<Course> getPopularCourses(int amount) {
        EntityManager em = emf.createEntityManager();
        String queryString = "select c from Course c " +
                "where c.isComplete = true " +
                "group by c.id " +
                "order by count(c.enrollments.size) desc";

        List<Course> list = em.createQuery(queryString, Course.class)
                .setMaxResults(amount).getResultList();
        em.close();
        return list;
    }

    @Override
    public List<Course> getLatestCourses(int amount) {
        EntityManager em = emf.createEntityManager();
        String queryString = "select c from Course c where c.isComplete = true order by c.createdAt desc";
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
                "group by c.id " +
                "order by count(c.enrollments.size) desc";
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

            double totalRating = (double) em.createQuery("select sum(e.rating) " +
                    "from Course c " +
                    "join c.enrollments as e where c.id = ?1 and e.rating != 0")
                    .setParameter(1, course.getId()).getSingleResult();

            Long ratingCount = (Long) em.createQuery("select count(c.id) " +
                    "from Course c join c.enrollments as e " +
                    "where c.id = ?1 and e.rating != 0").setParameter(1, course.getId())
                    .getSingleResult();

            course.setAvgRating(totalRating / ratingCount);
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
