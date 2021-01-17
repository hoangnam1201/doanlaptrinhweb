package com.udemy.controller;

import com.udemy.model.Category;
import com.udemy.service.CategoryService;
import com.udemy.service.CategoryServiceImpl;
import com.udemy.util.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "CategoryServlet", urlPatterns = "/courses/*")
public class CategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryServiceImpl categoryService = new CategoryServiceImpl();
        String catSlug = Optional.ofNullable(request.getParameter("catSlug")).orElse("");
        String parentCatSlug = Optional.ofNullable(request.getParameter("parentCatSlug")).orElse("");
        if (catSlug.isEmpty() && !parentCatSlug.isEmpty()) {
            catSlug = parentCatSlug;
            parentCatSlug = "";
        }
        List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
        Category category = categoryService.getCategoryBySlugFromList(catSlug, parentCatSlug, categoryList);
        if (category == null) {
            ServletUtils.redirect("/", request, response);
            return;
        }
        PrintWriter out = response.getWriter();
        out.println(category.getName());
    }
}
