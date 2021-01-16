package com.udemy.service;

import com.udemy.DAO.CategoryDAOImpl;
import com.udemy.model.Category;

import java.util.List;
import java.util.Optional;

public class CategoryServiceImpl implements CategoryService {
    private CategoryDAOImpl categoryDAO = new CategoryDAOImpl();

    @Override
    public List<Category> getAllParentAndSub() {
        return categoryDAO.getAllParentAndSub();
    }

    @Override
    public List<Category> getMostEnrolledCategoriesLastWeek(int amount) {
        return null;
    }

    @Override
    public void delete(Long id) {

    }

    @Override
    public void addNew(Category category) {

    }

    @Override
    public void update(Category category) {

    }
}
