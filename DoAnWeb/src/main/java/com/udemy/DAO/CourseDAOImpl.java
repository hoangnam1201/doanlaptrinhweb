package com.udemy.DAO;

import com.udemy.model.Course;
import com.udemy.util.JpaUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.List;

public class CourseDAOImpl implements CourseDAO {
    private final EntityManagerFactory emf;

    public CourseDAOImpl() {
        emf = JpaUtil.getJPAFactory();
    }

    @Override
    public List<Course> getFeaturedCourses(int amount) {
        EntityManager em = emf.createEntityManager();
        String queryString = "select c from Course c";
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
}
