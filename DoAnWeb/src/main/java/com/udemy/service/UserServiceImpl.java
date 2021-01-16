package com.udemy.service;

import com.udemy.DAO.UserDAOImpl;
import com.udemy.model.User;

import java.util.Optional;

public class UserServiceImpl implements UserService {
    UserDAOImpl userDAO = new UserDAOImpl();

    @Override
    public void addNew(User user) {
        userDAO.addNew(user);
    }

    @Override
    public Optional<User> findByUsername(String username) {
        return userDAO.findByUsername(username);
    }
}
