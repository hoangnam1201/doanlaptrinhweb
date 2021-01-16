package com.udemy.DAO;

import com.udemy.model.Category;

import java.util.List;

public interface CategoryDAO {
    List<Category> getAllParentAndSub();

    List<Category> getMostEnrolledCategoriesLastWeek(int amount);

    void delete(Long id);

    void addNew(Category category);

    void update(Category category);
}
