package com.udemy.service;

import com.udemy.model.User;

import java.util.Optional;

public interface UserService {
    void addNew(User user);

    Optional<User> findByUsername(String username);

}
