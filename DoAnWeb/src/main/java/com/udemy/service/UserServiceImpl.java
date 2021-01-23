package com.udemy.service;

import com.udemy.DAO.CourseDAOImpl;
import com.udemy.DAO.UserDAOImpl;
import com.udemy.model.Course;
import com.udemy.model.Enrollment;
import com.udemy.model.User;
import com.udemy.model.Wishlist;

import java.util.List;
import java.util.Optional;

public class UserServiceImpl implements UserService {
    UserDAOImpl userDAO = new UserDAOImpl();
    CourseDAOImpl courseDAO = new CourseDAOImpl();

    @Override
    public List<User> getAllUser() {
        return userDAO.getAllUser();
    }

    @Override
    public void addNew(User user) {
        userDAO.addNew(user);
    }

    public void update(User user) {
        userDAO.update(user);
    }

    public void delete(Long id) {
        userDAO.delete(id);
    }

    @Override
    public void addWishlist(User user, long courseId) {
        Course course = courseDAO.getCourseById(courseId);
        if (course != null) {
            Wishlist wishlist = new Wishlist();
            wishlist.setCourse(course);
            wishlist.setUser(user);

            user.getWishlist().add(wishlist);
            userDAO.update(user);
        }
    }

    @Override
    public void removeWishlist(User user, long courseId) {
        user.getWishlist().removeIf(wishlist -> wishlist.getCourse().getId().equals(courseId));
        userDAO.update(user);
    }

    @Override
    public Optional<User> findByUsername(String username) {
        return userDAO.findByUsername(username);
    }
}
