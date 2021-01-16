package com.udemy.DAO;

import com.udemy.model.Course;
import com.udemy.model.User;

import java.util.List;
import java.util.Optional;

public interface UserDAO {
    void addNew(User user);

    Optional<User> findByUsername(String username);
}
