package com.udemy.controller;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.udemy.model.Category;
import com.udemy.model.Course;
import com.udemy.model.User;
import com.udemy.service.CategoryServiceImpl;
import com.udemy.service.CourseServiceImpl;
import com.udemy.service.UserServiceImpl;
import com.udemy.util.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "AdminServlet", urlPatterns = "/admin/*")
public class AdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        switch (path) {
            case "/addcat":
                postCategories(request, response);
                break;
            case "/deletecat":
                deleteCategory(request, response);
                break;
            case "/editcat":
                updateCategory(request, response);
                break;
            case "/addteacher":
                postRegisterTeacher(request, response);
                break;
            case "/deleteuser":
                deleteUser(request, response);
                break;
            case "/deletecourse":
                deleteCourse(request, response);
                break;
            default:
                ServletUtils.forwardErrorPage(response);
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
            ServletUtils.redirect("/admin/managercat", request, response);
        } catch (Exception ex) {
            PrintWriter out = response.getWriter();
            out.println(ex.getMessage());
        }

    }
    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id =Long.parseLong(request.getParameter("id"));
        CategoryServiceImpl categoryService = new CategoryServiceImpl();

        try {
            categoryService.delete(id);
            ServletUtils.redirect("/admin/managercat",request,response);
        }
        catch (Exception ex)
        {
            throw ex;

        }
    }
    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id =Long.parseLong(request.getParameter("id"));
        String parentId = request.getParameter("parent");
        CategoryServiceImpl categoryService = new CategoryServiceImpl();
        Category category =categoryService.getCategoryById(id);
        Category parentCategory = parentId.isEmpty()
                ? null
                : categoryService.getCategoryById(Long.parseLong(parentId));

        category.setName(request.getParameter("name"));
        category.setSlug(request.getParameter("slug"));
        category.setParent(parentCategory);

        try {
            categoryService.update(category);
            ServletUtils.redirect("/admin/managercat",request,response);
        }
        catch (Exception ex)
        {
            throw ex;

        }
    }
    private void postRegisterTeacher(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String password = request.getParameter("password");
        String bcryptHashString = BCrypt.withDefaults().hashToString(12, password.toCharArray());
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String name = request.getParameter("name");

        String role ="teacher";

        UserServiceImpl userService = new UserServiceImpl();

        User user = new User();
        user.setEmail(email);
        user.setUsername(username);
        user.setName(name);
        user.setPassword(bcryptHashString);
        user.setRole(role);

        PrintWriter out = response.getWriter();
        try {
            userService.addNew(user);
            ServletUtils.redirect("/admin/manageruser", request, response);
        } catch (Exception ex) {
            out.println(ex.getMessage());
        }

    }
    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id =Long.parseLong(request.getParameter("id"));
        UserServiceImpl userService = new UserServiceImpl();

        try {
            userService.delete(id);
            ServletUtils.redirect("/admin/manageruser",request,response);
        }
        catch (Exception ex)
        {
            throw ex;

        }
    }
    private void deleteCourse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id =Long.parseLong(request.getParameter("id"));
        CourseServiceImpl courseService = new CourseServiceImpl();

        try {
            courseService.deleteById(id);
            ServletUtils.redirect("/admin/managercourse",request,response);
        }
        catch (Exception ex)
        {
            throw ex;

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CourseServiceImpl courseService = new CourseServiceImpl();

        String path = Optional.ofNullable(request.getPathInfo()).orElse("");
        switch (path) {
            case "/managercat":
                ServletUtils.forward("/views/Admin.jsp", request, response);
                break;
            case "/addcat":
                ServletUtils.forward("/views/AddCategories.jsp", request, response);
                break;
            case "/editcat":
                Long id =Long.parseLong(request.getParameter("id"));
                CategoryServiceImpl categoryService =new CategoryServiceImpl();
                Category category = categoryService.getCategoryById(id);
                request.setAttribute("category",category);
                ServletUtils.forward("/views/EditCategories.jsp", request, response);
                break;
            case "/manageruser":
                UserServiceImpl userService =new UserServiceImpl();
                List<User> userList = userService.getAllUser();
                request.setAttribute("userList",userList);
                ServletUtils.forward("/views/AdminUser.jsp", request, response);
                break;
            case "/addteacher":
                ServletUtils.forward("/views/AccountRegister.jsp", request, response);
                break;
            case "/managercourse":
                List<Course> courseList = courseService.getCourseList();
                request.setAttribute("courseList",courseList);
                ServletUtils.forward("/views/AdminCourse.jsp", request, response);
                break;
            default:
                ServletUtils.forwardErrorPage(response);
                break;
        }
    }
}
