package com.udemy.DAO;

import com.udemy.model.Category;
import com.udemy.model.Course;

import java.util.List;

public interface CourseDAO {
    Course getCourseById(Long id);

    List<Course> getMyCourses(Long userId);

    List<Course> getFeaturedCourses(int amount);

    List<Course> getMostViewsCourses(int amount);

    List<Course> getLatestCourses(int amount);

    void addNew(Course course);

    void delete(Course course);

    void update(Course course);
}
