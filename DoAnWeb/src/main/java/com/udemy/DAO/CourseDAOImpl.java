package com.udemy.DAO;

import com.udemy.model.Category;
import com.udemy.model.Course;
import com.udemy.util.JpaUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
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
            return em.createQuery(queryString, Course.class).getSingleResult();
        } catch (NoResultException ex) {
            return null;
        } finally {
            em.close();
        }
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
        String queryString = "select c from Course c where c.isComplete = true";
        List<Course> list = em.createQuery(queryString, Course.class)
                .setMaxResults(amount).getResultList();
        em.close();
        return list;
    }

    @Override
    public List<Course> getMostViewsCourses(int amount) {
        return null;
    }

    @Override
    public List<Course> getLatestCourses(int amount) {
        return null;
    }

    @Override
    public void addNew(Course course) {
        EntityManager entityManager = emf.createEntityManager();
        entityManager.getTransaction().begin();
        try {
            entityManager.persist(course);
        } catch (Exception ex) {
            entityManager.getTransaction().rollback();
            throw ex;
        } finally {
            entityManager.getTransaction().commit();
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
    public void update(Course course) {
        EntityManager entityManager = emf.createEntityManager();
        entityManager.getTransaction().begin();
        try {
            entityManager.merge(course);
        } catch (Exception ex) {
            entityManager.getTransaction().rollback();
            throw ex;
        } finally {
            entityManager.getTransaction().commit();
            entityManager.close();
        }
    }
}
