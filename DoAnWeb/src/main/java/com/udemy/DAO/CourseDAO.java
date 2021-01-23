package com.udemy.DAO;

import com.udemy.model.Category;
import com.udemy.model.Course;
import com.udemy.model.CourseListPageInfo;

import java.util.List;

public interface CourseDAO {
    Course getCourseById(Long id);

    List<Course> getCourseList();

    List<Course> searchCourses(String searchString);

    List<Course> getCourseListByCategory(Category category, CourseListPageInfo courseListPageInfo);

    List<Course> getMyCourses(Long categoryId);

    List<Course> getFeaturedCourses(int amount);

    List<Course> getPopularCourses(int amount);

    List<Course> getLatestCourses(int amount);

    List<Course> getCourseRecommendations(Course course, int amount);

    void addNew(Course course);

    void delete(Course course);

    Course update(Course course);

    void updateRating(Course course);
}
