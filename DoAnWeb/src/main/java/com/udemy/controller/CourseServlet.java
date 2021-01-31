package com.udemy.controller;

import com.udemy.model.*;
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

@WebServlet(name = "CourseServlet", urlPatterns = "/course/*")
public class CourseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = Optional.ofNullable(request.getPathInfo()).orElse("");
        CourseServiceImpl courseService = new CourseServiceImpl();
        UserServiceImpl userService = new UserServiceImpl();
        boolean enrolled = (boolean) request.getAttribute("enrolled");

        User user = (User) request.getSession().getAttribute("authUser");
        long courseId = Long.parseLong(Optional.ofNullable(request.getParameter("courseId")).orElse("0"));

        PrintWriter out = response.getWriter();
        try {
            switch (path) {
                case "/enroll":
                    if (user.getId() == null) {
                        request.getSession().setAttribute("retUrl", "/course/" + courseId);
                        out.println(request.getContextPath() + "/account/login");
                        out.flush();
                        return;
                    }
                    if (!enrolled) {
                        try {
                            courseService.enroll(courseId, user.getId());
                            response.setStatus(200);
                        } catch (Exception ex) {
                            response.sendError(500);
                        }
                    }
                    return;
                case "/rating":
                    int rating = Integer.parseInt(request.getParameter("rating"));
                    String comment = request.getParameter("comment");
                    if (courseService.updateRating(courseId, user.getId(), rating, comment)) {
                        response.setStatus(200);
                        return;
                    }
                    response.sendError(422);
                    break;
                case "/add-wishlist":
                    if (user.getId() == null) {
                        request.getSession().setAttribute("retUrl", "/course/" + courseId);
                        out.println(request.getContextPath() + "/account/login");
                        out.flush();
                        return;
                    }
                    try {
                        userService.addWishlist(user.getId(), courseId);
                        response.setStatus(200);
                    } catch (Exception ex) {
                        response.sendError(500);
                    }
                    return;
                case "/remove-wishlist":
                    try {
                        userService.removeWishlist(user.getId(), courseId);
                        response.setStatus(200);
                    } catch (Exception ex) {
                        response.sendError(500);
                    }
                    return;
                default:
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.forwardErrorPage(response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CourseServiceImpl courseService = new CourseServiceImpl();
        UserServiceImpl userService = new UserServiceImpl();
        HttpSession session = request.getSession();
        boolean learn = Optional.ofNullable(request.getParameter("learn")).isPresent();
        Course course = (Course) request.getAttribute("course");
        User user = (User) request.getSession().getAttribute("authUser");

        if (course.isDisabled()) {
            ServletUtils.forwardErrorPage(response);
            return;
        }

        if (!course.isComplete() && !course.getTeacher().getId().equals(user.getId())) {
            ServletUtils.redirect("/", request, response);
            return;
        }

        if (learn) {
            if (!(boolean) session.getAttribute("auth")) {
                String courseId = request.getParameter("id");
                String lessonId = request.getParameter("lesson");
                session.setAttribute("retUrl", request.getRequestURI() + "/" + courseId +
                        "/learn/" + lessonId);
                ServletUtils.redirect("/account/login", request, response);
                return;
            }

            boolean enrolled = (boolean) request.getAttribute("enrolled");
            long lessonId = Long.parseLong(Optional.ofNullable(request.getParameter("lesson")).orElse("0"));
            Lesson lesson = courseService.getLessonById(lessonId);
            if (lesson != null) {
                if (enrolled || course.getTeacher().getId().equals(user.getId())) {
                    request.setAttribute("lesson", lesson);
                    ServletUtils.forward("/views/LessonPage.jsp", request, response);
                } else {
                    String courseId = request.getParameter("id");
                    ServletUtils.redirect("/course/" + courseId, request, response);
                }
            } else {
                ServletUtils.forwardErrorPage(response);
            }
        } else {
            if (user.getId() != null) {
                Wishlist wishlist = userService.getWishlist(user.getId(), course.getId());
                if (wishlist != null) {
                    request.setAttribute("wishlist", true);
                } else {
                    request.setAttribute("wishlist", false);
                }
            } else {
                request.setAttribute("wishlist", false);
            }
            List<Course> courseList = courseService
                    .getCourseRecommendations(course, 5);
            request.setAttribute("recommendation", courseList);
            ServletUtils.forward("/views/CoursePage.jsp", request, response);
        }

    }
}
