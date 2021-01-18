package com.udemy.controller;

import com.udemy.model.Course;
import com.udemy.model.User;
import com.udemy.service.CourseServiceImpl;
import com.udemy.util.ServletUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = "/")
public class HomeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CourseServiceImpl courseService = new CourseServiceImpl();
        List<Course> featuredCourseList = courseService.getFeaturedCourses(5);

        request.setAttribute("featuredCourses", featuredCourseList);

        String path = request.getServletPath();
        if (path == null) {
            path = "/";
        }
        switch (path) {
            case "/":
                HttpSession session = request.getSession();
                boolean auth = (boolean) session.getAttribute("auth");
                User authUser = (User) session.getAttribute("authUser");
                ServletUtils.forward("/views/Home.jsp", request, response);
                break;
            default:
                ServletUtils.forwardErrorPage("404", response);
                break;
        }
    }
}
