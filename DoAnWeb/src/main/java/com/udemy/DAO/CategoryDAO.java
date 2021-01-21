package com.udemy.DAO;

import com.udemy.model.Category;
import com.udemy.model.Course;

import java.util.List;

public interface CategoryDAO {
    List<Category> getAllParentAndSub();

    List<Category> getMostEnrolledCategoriesLastWeek(int amount);

    Category getCategoryById(long id);

    void addNew(Category category);

    void delete(Long id);

    void update(Category category);
}
