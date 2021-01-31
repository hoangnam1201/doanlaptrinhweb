package com.udemy.service;

import com.udemy.DAO.CourseDAOImpl;
import com.udemy.DAO.UserDAOImpl;
import com.udemy.DAO.WishlistDAOImpl;
import com.udemy.model.Course;
import com.udemy.model.Enrollment;
import com.udemy.model.User;
import com.udemy.model.Wishlist;
import org.hibernate.Hibernate;
import org.hibernate.proxy.HibernateProxy;

import java.util.List;
import java.util.Optional;

public class UserServiceImpl implements UserService {
    UserDAOImpl userDAO = new UserDAOImpl();
    CourseDAOImpl courseDAO = new CourseDAOImpl();
    WishlistDAOImpl wishlistDAO = new WishlistDAOImpl();

    @Override
    public List<User> getAllUser() {
        return userDAO.getAllUser();
    }

    @Override
    public List<User> getTeachers() {
        return null;
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
    public User getUserById(long id) {
        return userDAO.getUserById(id);
    }

    @Override
    public User getUserWithWishlistById(long id) {
        return userDAO.getUserWithWishlistById(id);
    }

    @Override
    public Wishlist getWishlist(long userId, long courseId) {
        return wishlistDAO.getWishlist(courseId, userId);
    }

    @Override
    public void addWishlist(long userId, long courseId) {
        User user = userDAO.getUserWithWishlistById(userId);
        Course course = courseDAO.getCourseById(courseId);
        if (course != null && user != null) {
            Wishlist wishlist = new Wishlist();
            wishlist.setCourse(course);
            wishlist.setUser(user);

            user.getWishlist().add(wishlist);
            userDAO.update(user);
        }
    }

    @Override
    public void removeWishlist(long userId, long courseId) {
        User user = userDAO.getUserWithWishlistById(userId);
        user.getWishlist().removeIf(_wishlist -> _wishlist.getCourse().getId().equals(courseId));
        userDAO.update(user);
    }

    @Override
    public Optional<User> findByUsername(String username) {
        return userDAO.findByUsername(username);
    }

    @Override
    public Optional<User> findByEmail(String email) {
        return userDAO.findByEmail(email);
    }
}
