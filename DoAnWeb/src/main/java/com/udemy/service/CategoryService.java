package com.udemy.service;

import com.udemy.model.Category;

import java.util.List;
import java.util.Optional;

public interface CategoryService {
    List<Category> getAllParentAndSub();

    List<Category> getMostEnrolledCategoriesLastWeek(int amount);

    Category getCategoryBySlugFromList(String catSlug, String parentCatSlug, List<Category> categoryList);

    Category getCategoryById(long id);

    void delete(Long id);

    void addNew(Category category);

    void update(Category category);
}
