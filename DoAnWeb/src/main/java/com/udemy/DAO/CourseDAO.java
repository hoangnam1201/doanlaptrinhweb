package com.udemy.DAO;

import com.udemy.model.Category;
import com.udemy.model.Course;
import com.udemy.model.CourseListPageInfo;
import com.udemy.model.User;

import java.util.List;

public interface CourseDAO {
    Course getCourseById(Long id);

    List<Course> getCourseList();

    List<Course> getCourseList(Category category, User teacher);

    List<Course> getCourseListWithFilter(CourseListPageInfo courseListPageInfo);

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
