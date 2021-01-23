package com.udemy.DAO;

import com.udemy.model.Course;
import com.udemy.model.Lesson;
import com.udemy.util.JpaUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;

public class LessonDAOImpl implements LessonDAO {
    private final EntityManagerFactory emf;

    public LessonDAOImpl() {
        emf = JpaUtil.getJPAFactory();
    }

    @Override
    public Lesson getLessonById(Long id) {
        EntityManager em = emf.createEntityManager();
        String queryString = "select l from Lesson l where l.id=" + id;
        try {
            return em.createQuery(queryString, Lesson.class).getSingleResult();
        } catch (NoResultException ex) {
            return null;
        } finally {
            em.close();
        }
    }
}
