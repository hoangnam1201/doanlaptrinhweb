package com.udemy.service;

import com.udemy.DAO.*;
import com.udemy.model.*;

import java.util.List;
import java.util.Optional;

public class CourseServiceImpl implements CourseService {
    UserDAOImpl userDAO = new UserDAOImpl();
    CourseDAOImpl courseDAO = new CourseDAOImpl();
    LessonDAOImpl lessonDAO = new LessonDAOImpl();
    EnrollmentDAOImpl enrollmentDAO = new EnrollmentDAOImpl();

    @Override
    public List<Course> getCourseList() {
        return courseDAO.getCourseList();
    }

    @Override
    public Course getCourseById(Long id) {
        return courseDAO.getCourseById(id);
    }

    @Override
    public Enrollment getEnrollment(Long courseId, Long userId) {
        return enrollmentDAO.getEnrollment(courseId, userId);
    }

    @Override
    public Section getSectionById(Course course, long sectionId) {
        return course.getSections().stream()
                .filter(_section -> _section.getId().equals(sectionId))
                .findFirst().get();
    }

    @Override
    public Lesson getLessonById(long id) {
        return lessonDAO.getLessonById(id);
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
    public List<Course> getPopularCourses(int amount) {
        return courseDAO.getPopularCourses(amount);
    }

    @Override
    public List<Course> getLatestCourses(int amount) {
        return courseDAO.getLatestCourses(amount);
    }

    @Override
    public List<Course> getCourseListByCategory(Category category, CourseListPageInfo courseListPageInfo) {
        return courseDAO.getCourseListByCategory(category, courseListPageInfo);
    }

    @Override
    public List<Course> getCourseRecommendations(Course course, int amount) {
        return courseDAO.getCourseRecommendations(course, amount);
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
        lesson.setSection(section);
        section.getLessons().add(lesson);
        courseDAO.update(course);
    }

    @Override
    public void enroll(long id, long userId) {
        Course course = courseDAO.getCourseById(id);
        User user = userDAO.getUserById(userId);
        if (course != null && user != null) {
            Enrollment enrollment = new Enrollment();

            enrollment.setUser(user);
            user.getEnrollments().add(enrollment);

            course.setStudentCount(course.getStudentCount() + 1);
            enrollment.setCourse(course);
            course.getEnrollments().add(enrollment);


            courseDAO.update(course);
        }
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

    @Override
    public boolean updateRating(long courseId, long userId, int rating, String comment) {
        Course course = getCourseById(courseId);
        if (course != null) {
            Enrollment enrollment = course.getEnrollments().stream()
                    .filter(e -> e.getUser().getId().equals(userId)).findAny().orElse(null);
            if (enrollment != null) {
                try {
                    enrollment.setRating(rating);
                    enrollment.setComment(comment);

                    courseDAO.updateRating(course);
                    return true;
                } catch (Exception e) {
                    return false;
                }
            }
            return false;
        }
        return false;
    }
}
