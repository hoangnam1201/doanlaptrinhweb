package com.udemy.service;

import com.udemy.DAO.UserDAOImpl;
import com.udemy.model.User;

import java.util.List;
import java.util.Optional;

public class UserServiceImpl implements UserService {
    UserDAOImpl userDAO = new UserDAOImpl();

    @Override
    public List<User> getAllUser(){ return userDAO.getAllUser();}
    @Override
    public void addNew(User user) {
        userDAO.addNew(user);
    }
    public void update(User user){userDAO.update(user);}
    public void delete(Long id) {userDAO.delete(id);}

    @Override
    public User getUserbyId(Long id){return userDAO.getUserbyId(id);}
    @Override
    public Optional<User> findByUsername(String username) {
        return userDAO.findByUsername(username);
    }
}
