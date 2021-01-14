package com.udemy.model;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.util.Date;

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

}
