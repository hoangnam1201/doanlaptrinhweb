package com.udemy.controller;

import com.udemy.model.Course;
import com.udemy.service.CourseServiceImpl;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = "/index")
public class HomeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CourseServiceImpl courseService = new CourseServiceImpl();
        List<Course> featuredCourseList = courseService.getFeaturedCourses(5);

        request.setAttribute("featuredCourses", featuredCourseList);

        RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/views/Home.jsp");
        dispatcher.forward(request, response);
    }
}
