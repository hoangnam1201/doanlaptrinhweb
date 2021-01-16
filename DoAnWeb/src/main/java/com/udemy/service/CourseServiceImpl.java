package com.udemy.service;

import com.udemy.DAO.CourseDAOImpl;
import com.udemy.model.Course;

import java.util.List;

public class CourseServiceImpl implements CourseService {
    CourseDAOImpl courseDAO = new CourseDAOImpl();

    @Override
    public List<Course> getFeaturedCourses(int amount) {
        return courseDAO.getFeaturedCourses(amount);
    }
}
