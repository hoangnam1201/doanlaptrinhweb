package com.udemy.controller;

import com.udemy.model.Course;
import com.udemy.model.CourseListPageInfo;
import com.udemy.service.CourseServiceImpl;
import com.udemy.util.ServletUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchServlet", urlPatterns = "/search")
public class SearchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CourseServiceImpl courseService = new CourseServiceImpl();
        try {
            String page = request.getParameter("p");
            String sort = request.getParameter("order");
            String search = request.getParameter("q");

            CourseListPageInfo courseListPageInfo = new CourseListPageInfo();
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
