package com.udemy.model;


import javax.persistence.*;
import java.io.Serializable;
import java.util.Objects;

@Entity
@Table
public class UserLesson implements Serializable {
    @EmbeddedId
    private UserLessonID id;

    @MapsId("userId")
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @MapsId("lessonId")
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "lesson_id")
    private Lesson lesson;

    public UserLessonID getId() {
        return id;
    }

    public void setId(UserLessonID id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Lesson getLesson() {
        return lesson;
    }

    public void setLesson(Lesson lesson) {
        this.lesson = lesson;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserLesson that = (UserLesson) o;
        return Objects.equals(id, that.id) && Objects.equals(user, that.user) && Objects.equals(lesson, that.lesson);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, user, lesson);
    }
}
