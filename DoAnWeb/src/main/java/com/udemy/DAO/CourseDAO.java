package com.udemy.DAO;

import com.udemy.model.Course;

import java.util.List;

public interface CourseDAO {
    List<Course> getFeaturedCourses(int amount);

    List<Course> getMostViewsCourses(int amount);

    List<Course> getLatestCourses(int amount);
}
