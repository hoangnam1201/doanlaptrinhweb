package com.udemy.controller;

import com.udemy.model.Category;
import com.udemy.model.User;
import com.udemy.service.CategoryServiceImpl;
import com.udemy.service.UserServiceImpl;
import com.udemy.util.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Optional;

@WebServlet(name = "AdminServlet", urlPatterns = "/admin/*")
public class AdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        switch (path) {
            case "/manager":
                postCategories(request, response);
                break;
            default:
                ServletUtils.forwardErrorPage("404", response);
                break;
        }
    }

    private void postCategories(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        String slug = request.getParameter("slug");
        String parentId = request.getParameter("parent");

        CategoryServiceImpl categoryService = new CategoryServiceImpl();
        Category parentCategory = parentId.isEmpty()
                ? null
                : categoryService.getCategoryById(Long.parseLong(parentId));

        Category category = new Category();
        category.setName(name);
        category.setImage(image);
        category.setSlug(slug);
        category.setParent(parentCategory);

        try {
            categoryService.addNew(category);
            ServletUtils.redirect("/", request, response);
        } catch (Exception ex) {
            PrintWriter out = response.getWriter();
            out.println(ex.getMessage());
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        switch (path) {
            case "/manager":
                ServletUtils.forward("/views/AddCategories.jsp", request, response);
                break;
            default:
                ServletUtils.forwardErrorPage("404", response);
                break;
        }
    }
}
