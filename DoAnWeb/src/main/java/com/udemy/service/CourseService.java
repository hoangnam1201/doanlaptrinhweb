package com.udemy.service;

import com.udemy.model.Course;
import com.udemy.model.Lesson;
import com.udemy.model.Section;

import java.util.List;

public interface CourseService {
    Course getCourseById(Long id);

    Section getSectionById(Course course, long sectionId);

    Lesson getLessonById(Course course, long sectionId, long lessonId);

    List<Course> getMyCourses(Long userId);

    List<Course> getFeaturedCourses(int amount);

    void setCompleteById(Long id);

    void addNew(Course course);

    void addSection(long id, Section section);

    void addLesson(long id, long sectionId, Lesson lesson);

    void deleteById(Long id);

    void deleteSection(Long id, Long sectionId);

    void deleteLesson(Long id, Long sectionId, Long lessonId);

    void update(Course course);
}
