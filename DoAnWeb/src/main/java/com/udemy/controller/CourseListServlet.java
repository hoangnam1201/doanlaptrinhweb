package com.udemy.controller;

import com.udemy.model.Category;
import com.udemy.model.Course;
import com.udemy.model.CourseListPageInfo;
import com.udemy.service.CategoryServiceImpl;
import com.udemy.service.CourseServiceImpl;
import com.udemy.util.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "CourseListServlet", urlPatterns = "/courses/*")
public class CourseListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryServiceImpl categoryService = new CategoryServiceImpl();
        CourseServiceImpl courseService = new CourseServiceImpl();

        String catSlug = Optional.ofNullable(request.getParameter("catSlug")).orElse("");
        String parentCatSlug = Optional.ofNullable(request.getParameter("parentCatSlug")).orElse("");
        if (catSlug.isEmpty() && !parentCatSlug.isEmpty()) {
            catSlug = parentCatSlug;
            parentCatSlug = "";
        }
        List<Category> categoryList = (List<Category>) request.getAttribute("categoryList");
        Category category = categoryService.getCategoryBySlugFromList(catSlug, parentCatSlug, categoryList);
        if (category == null) {
            ServletUtils.forward("/views/Error404.jsp", request, response);
        } else {
            try {
                String page = request.getParameter("p");
                String sort = request.getParameter("order");
                String search = Optional.ofNullable(request.getParameter("q")).orElse("");

                CourseListPageInfo courseListPageInfo = new CourseListPageInfo();
                courseListPageInfo.setCategory(category);
                List<Course> courseList = courseService
                        .getCourseListWithFilter(courseListPageInfo, page, sort, search);
                courseListPageInfo.setPagination();
                request.setAttribute("courseList", courseList);
                request.setAttribute("courseListPageInfo", courseListPageInfo);
                ServletUtils.forward("/views/CourseListPage.jsp", request, response);
            } catch (Exception e) {
                ServletUtils.forwardErrorPage(response);
            }
        }
    }
}
