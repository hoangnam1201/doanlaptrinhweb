package com.udemy.DAO;

import com.udemy.model.Enrollment;

import java.util.List;

public interface EnrollmentDAO {
    Enrollment getEnrollment(long courseId, long userId);

    List<Enrollment> getCourseEnrollment(long courseId);

    List<Enrollment> getUserEnrollment(long courseId);

    void addNew(Enrollment enrollment);

    void update(Enrollment enrollment);
}
