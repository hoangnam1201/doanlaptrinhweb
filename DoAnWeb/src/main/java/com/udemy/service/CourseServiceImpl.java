package com.udemy.service;

import com.udemy.DAO.CourseDAOImpl;
import com.udemy.model.Course;
import com.udemy.model.Lesson;
import com.udemy.model.Section;

import java.util.List;
import java.util.Optional;

public class CourseServiceImpl implements CourseService {
    CourseDAOImpl courseDAO = new CourseDAOImpl();

    @Override
    public List<Course> getCourseList() {
        return courseDAO.getCourseList();
    }

    @Override
    public Course getCourseById(Long id) {
        return courseDAO.getCourseById(id);
    }

    @Override
    public Section getSectionById(Course course, long sectionId) {
        Section section = course.getSections().stream()
                .filter(_section -> _section.getId().equals(sectionId))
                .findFirst().get();
        return section;
    }

    @Override
    public Lesson getLessonById(Course course, long sectionId, long lessonId) {
        Section section = this.getSectionById(course, sectionId);
        Lesson lesson = section.getLessons().stream()
                .filter(_lesson -> _lesson.getId().equals(lessonId))
                .findFirst().get();
        return lesson;
    }

    @Override
    public List<Course> getMyCourses(Long userId) {
        return courseDAO.getMyCourses(userId);
    }

    @Override
    public List<Course> getFeaturedCourses(int amount) {
        return courseDAO.getFeaturedCourses(amount);
    }

    @Override
    public void setCompleteById(Long id) {
        Course course = courseDAO.getCourseById(id);
        System.out.println(course.getName());
        course.setComplete(true);
        courseDAO.update(course);
    }

    @Override
    public void addNew(Course course) {
        courseDAO.addNew(course);
    }

    @Override
    public void addSection(long id, Section section) {
        Course course = courseDAO.getCourseById(id);
        course.getSections().add(section);
        courseDAO.update(course);
    }

    @Override
    public void addLesson(long id, long sectionId, Lesson lesson) {
        Course course = courseDAO.getCourseById(id);
        Section section = this.getSectionById(course, sectionId);
        section.getLessons().add(lesson);
        courseDAO.update(course);
    }

    @Override
    public void deleteById(Long id) {
        Course course = courseDAO.getCourseById(id);
        courseDAO.delete(course);
    }

    @Override
    public void deleteSection(Long id, Long sectionId) {
        Optional<Course> course = Optional.ofNullable(courseDAO.getCourseById(id));
        if (course.isPresent()) {
            course.get().getSections().removeIf(section -> section.getId().equals(sectionId));
            courseDAO.update(course.get());
        }
    }

    @Override
    public void deleteLesson(Long id, Long sectionId, Long lessonId) {
        Optional<Course> course = Optional.ofNullable(courseDAO.getCourseById(id));
        if (course.isPresent()) {
            Optional<Section> section = Optional.ofNullable(this.getSectionById(course.get(), sectionId));
            if (section.isPresent()) {
                section.get().getLessons().removeIf(lesson -> lesson.getId().equals(lessonId));
                courseDAO.update(course.get());
            }
        }
    }

    @Override
    public void update(Course course) {
        courseDAO.update(course);
    }
}
