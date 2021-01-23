package com.udemy.service;

import com.udemy.model.User;

import java.util.List;
import java.util.Optional;

public interface UserService {
    List<User> getAllUser();

    void addNew(User user);

    void update(User user);

    void delete(Long id);

    void addWishlist(User user, long courseId);

    void removeWishlist(User user, long courseId);

    Optional<User> findByUsername(String username);

}
