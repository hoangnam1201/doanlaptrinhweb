package com.udemy.model;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.util.Date;
import java.util.Objects;

@Entity
@Table
public class Enrollment {
    @EmbeddedId
    private EnrollmentID id;

    @MapsId("userId")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @MapsId("courseId")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "course_id")
    private Course course;

    @Column(columnDefinition = "decimal(15,2) default 0.0")
    private double price;
    @Lob
    private String comment;
    @Column(columnDefinition = "decimal(2,1) default 0.0")
    private double rating;

    @CreationTimestamp
    private Date createdAt;
    @UpdateTimestamp
    private Date updatedAt;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Enrollment that = (Enrollment) o;
        return Double.compare(that.price, price) == 0 && Double.compare(that.rating, rating) == 0 && Objects.equals(id, that.id) && Objects.equals(user, that.user) && Objects.equals(course, that.course) && Objects.equals(comment, that.comment) && Objects.equals(createdAt, that.createdAt) && Objects.equals(updatedAt, that.updatedAt);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, user, course, price, comment, rating, createdAt, updatedAt);
    }
}
