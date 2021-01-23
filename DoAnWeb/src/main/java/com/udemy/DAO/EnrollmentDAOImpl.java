package com.udemy.DAO;

import com.udemy.model.Category;
import com.udemy.model.Enrollment;
import com.udemy.util.JpaUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import java.util.List;

public class EnrollmentDAOImpl implements EnrollmentDAO {
    private final EntityManagerFactory emf;

    public EnrollmentDAOImpl() {
        emf = JpaUtil.getJPAFactory();
    }

    @Override
    public Enrollment getEnrollment(long courseId, long userId) {
        EntityManager em = emf.createEntityManager();
        String queryString = "from Enrollment e where e.course.id = ?1 and e.user.id = ?2";
        try {
            Enrollment enrollment = em.createQuery(queryString, Enrollment.class)
                    .setParameter(1, courseId).setParameter(2, userId).getSingleResult();
            return enrollment;
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Enrollment> getCourseEnrollment(long courseId) {
        EntityManager em = emf.createEntityManager();
        String queryString = "from Enrollment e where e.course.id = ?1";
        try {
            List<Enrollment> enrollmentList = em.createQuery(queryString, Enrollment.class)
                    .setParameter(1, courseId).getResultList();
            return enrollmentList;
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Enrollment> getUserEnrollment(long courseId) {
        return null;
    }

    @Override
    public void addNew(Enrollment enrollment) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        try {
            em.persist(enrollment);
            em.getTransaction().commit();
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw ex;
        } finally {
            em.close();
        }

    }

    @Override
    public void update(Enrollment enrollment) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        try {
            em.merge(enrollment);
            em.getTransaction().commit();
        } catch (Exception ex) {
            em.getTransaction().rollback();
            throw ex;
        } finally {
            em.close();
        }

    }


}
