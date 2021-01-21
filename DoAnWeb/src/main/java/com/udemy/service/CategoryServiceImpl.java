package com.udemy.service;

import com.udemy.DAO.CategoryDAO;
import com.udemy.DAO.CategoryDAOImpl;
import com.udemy.model.Category;

import java.util.List;
import java.util.Optional;

public class CategoryServiceImpl implements CategoryService {
    private final CategoryDAOImpl categoryDAO = new CategoryDAOImpl();

    @Override
    public List<Category> getAllParentAndSub() {
        return categoryDAO.getAllParentAndSub();
    }

    @Override
    public List<Category> getMostEnrolledCategoriesLastWeek(int amount) {
        return categoryDAO.getMostEnrolledCategoriesLastWeek(amount);
    }

    @Override
    public Category getCategoryBySlugFromList(String catSlug, String parentCatSlug, List<Category> categoryList) {
        if (catSlug.isEmpty())
            return null;
        if (parentCatSlug.isEmpty()) {
            return categoryList.stream().filter(c -> c.getSlug().equals(catSlug)).findAny().orElse(null);
        } else {
            Category parent = categoryList.stream().filter(c -> c.getSlug().equals(parentCatSlug)).findFirst().orElse(null);
            if (parent == null)
                return null;
            else {
                return parent.getChildren().stream().filter(c -> c.getSlug().equals(catSlug)).findFirst().orElse(null);
            }
        }
    }

    @Override
    public Category getCategoryById(long id) {
        return categoryDAO.getCategoryById(id);
    }

    @Override
    public Category getCategoryByIdFromList(long id, List<Category> categoryList) {
        return categoryList.stream().filter(c -> c.getId() == id).findAny().orElse(null);
    }


    @Override
    public void delete(Long id) {
        categoryDAO.delete(id);
    }

    @Override
    public void addNew(Category category) {
        categoryDAO.addNew(category);
    }

    @Override
    public void update(Category category) {
        categoryDAO.update(category);
    }
}
