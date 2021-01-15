package com.udemy.service;

import com.udemy.model.Category;

import java.util.List;
import java.util.Optional;

public interface CategoryService {
    List<Category> getAllParentAndSub();

    void delete(Long id);

    void addNew(Category category);

    void update(Category category);

    Category findById(Long id);

    Optional<Category> findBySlug(String slug);
}
