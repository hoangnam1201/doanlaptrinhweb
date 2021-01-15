package com.udemy.DAO;

import com.udemy.model.Category;

import java.util.List;
import java.util.Optional;

public interface CategoryDAO {
    List<Category> getAllParentAndSub();

    void delete(Long id);

    void addNew(Category category);

    void update(Category category);

    Category findById(Long id);

    Optional<Category> findBySlug(String slug);
}
