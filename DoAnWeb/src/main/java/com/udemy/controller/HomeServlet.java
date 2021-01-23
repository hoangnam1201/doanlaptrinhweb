package com.udemy.controller;

import com.udemy.model.Category;
import com.udemy.model.Course;
import com.udemy.service.CategoryServiceImpl;
import com.udemy.service.CourseServiceImpl;
import com.udemy.util.ServletUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.ObjectWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "HomeServlet", urlPatterns = "/")
public class HomeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CourseServiceImpl courseService = new CourseServiceImpl();
        CategoryServiceImpl categoryService = new CategoryServiceImpl();

        List<Course> featuredCourseList = courseService.getFeaturedCourses(10);
        List<Course> popularCourseList = courseService.getPopularCourses(10);
        List<Course> latestCourseList = courseService.getLatestCourses(10);
        List<Category> trendingCategoryList = categoryService.getMostEnrolledCategoriesLastWeek(10);

        request.setAttribute("featuredCourses", featuredCourseList);
        request.setAttribute("popularCourses", popularCourseList);
        request.setAttribute("latestCourses", latestCourseList);
        request.setAttribute("trendingCategories", trendingCategoryList);

        String path = request.getServletPath();
        if (path == null) {
            path = "/";
        }
        switch (path) {
            case "/":
                ServletUtils.forward("/views/Home.jsp", request, response);
                break;
            case "/get-subcategory":
                PrintWriter out = response.getWriter();
                response.setContentType("application/json;charset=UTF-8");
                String catId = Optional.ofNullable(request.getParameter("catId")).orElse("0");
                List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
                Category category = categoryService.getCategoryByIdFromList(Long.parseLong(catId), categoryList);
                if (category == null) {
                    response.setStatus(404);
                    out.println("Category not found!");
                } else {
                    response.setStatus(200);
                    ObjectWriter objectMapper = new ObjectMapper().writer().withDefaultPrettyPrinter();
                    String json = objectMapper.writeValueAsString(category.getChildren());
                    out.write(json);
                }
                out.flush();
                break;
            default:
                ServletUtils.forwardErrorPage(response);
                break;
        }
    }
}
