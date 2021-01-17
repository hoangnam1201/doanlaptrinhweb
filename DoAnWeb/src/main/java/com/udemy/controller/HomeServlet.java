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

@WebServlet(name = "HomeServlet", urlPatterns = "/index")
public class HomeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CourseServiceImpl courseService = new CourseServiceImpl();
        List<Course> featuredCourseList = courseService.getFeaturedCourses(5);

        request.setAttribute("featuredCourses", featuredCourseList);

        String path =request.getPathInfo();
        if(path == null || path.equals("/")){
            path = "/index";
        }
        switch (path)
        {
            case "/index":
                HttpSession session = request.getSession();
                boolean auth =(boolean)session.getAttribute("auth");
                User authUser =(User) session.getAttribute("authUser");
                //System.out.println(auth);
                //System.out.println(authUser);
                ServletUtils.forward("/views/Home.jsp",request,response);
                break;
            default:
                break;
        }
    }
}
