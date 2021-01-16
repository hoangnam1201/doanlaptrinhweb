package com.udemy.service;

import com.udemy.model.Category;

import java.util.List;
import java.util.Optional;

public interface CategoryService {
    List<Category> getAllParentAndSub();

    List<Category> getMostEnrolledCategoriesLastWeek(int amount);

    void delete(Long id);

    void addNew(Category category);

    void update(Category category);
}
