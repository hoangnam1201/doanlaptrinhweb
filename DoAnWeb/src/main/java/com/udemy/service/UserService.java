package com.udemy.service;

import com.udemy.model.User;
import com.udemy.model.Wishlist;

import java.util.List;
import java.util.Optional;

public interface UserService {
    List<User> getAllUser();

    void addNew(User user);

    void update(User user);

    void delete(Long id);

    User getUserById(long id);

    User getUserWithWishlistById(long id);

    Wishlist getWishlist(long userId, long courseId);

    void addWishlist(long userId, long courseId);

    void removeWishlist(long userId, long courseId);

    Optional<User> findByUsername(String username);

}
