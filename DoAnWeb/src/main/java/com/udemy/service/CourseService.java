package com.udemy.service;

import com.udemy.model.Course;

import java.util.List;

public interface CourseService {
    List<Course> getFeaturedCourses(int amount);
}
