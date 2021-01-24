package com.udemy.DAO;

import com.udemy.model.Course;
import com.udemy.model.User;

import java.util.List;
import java.util.Optional;

public interface UserDAO {
    User getUserById(long id);

    User getUserWithWishlistById(long id);

    List<User> getAllUser();

    void addNew(User user);

    void update(User user);

    void delete(Long id);

    Optional<User> findByUsername(String username);
}
