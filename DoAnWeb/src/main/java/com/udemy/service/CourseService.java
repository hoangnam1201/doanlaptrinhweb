package com.udemy.service;

import com.udemy.model.*;

import java.util.List;

public interface CourseService {
    List<Course> getCourseList();

    Course getCourseById(Long id);

    Enrollment getEnrollment(Long courseId, Long userId);

    Section getSectionById(Course course, long sectionId);

    Lesson getLessonById(long id);

    Lesson getLessonById(Course course, long sectionId, long lessonId);

    List<Course> getMyCourses(Long userId);

    List<Course> getFeaturedCourses(int amount);

    List<Course> getPopularCourses(int amount);

    List<Course> getLatestCourses(int amount);

    List<Course> getCourseListWithFilter(CourseListPageInfo courseListPageInfo, String page, String sort, String search);

    List<Course> getCourseRecommendations(Course course, int amount);

    void setCompleteById(Long id);

    void addNew(Course course);

    void addSection(long id, Section section);

    void addLesson(long id, long sectionId, Lesson lesson);

    void enroll(long id, long userId);

    void deleteById(Long id);

    void deleteSection(Long id, Long sectionId);

    void deleteLesson(Long id, Long sectionId, Long lessonId);

    void update(Course course);

    boolean updateRating(long courseId, long userId, int rating, String comment);
}
