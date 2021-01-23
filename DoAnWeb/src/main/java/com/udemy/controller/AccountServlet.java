package com.udemy.controller;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.udemy.model.Course;
import com.udemy.model.Lesson;
import com.udemy.model.Section;
import com.udemy.service.CourseServiceImpl;
import com.udemy.util.ServletUtils;
import com.udemy.model.User;
import com.udemy.service.UserServiceImpl;

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

@WebServlet(name = "AccountServlet", urlPatterns = "/account/*")
public class AccountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = Optional.ofNullable(request.getPathInfo()).orElse("");
        CourseServiceImpl courseService = new CourseServiceImpl();

        User teacher;
        Course course;
        Section section;
        Lesson lesson;

        long courseId = Long.parseLong(Optional.ofNullable(request.getParameter("courseId")).orElse("0"));
        long sectionId = Long.parseLong(Optional.ofNullable(request.getParameter("sectionId")).orElse("0"));
        long lessonId = Long.parseLong(Optional.ofNullable(request.getParameter("lessonId")).orElse("0"));
        switch (path) {
            case "/register":
                postRegister(request, response);
                break;
            case "/login":
                postLogin(request, response);
                break;
            case "/logout":
                postLogout(request, response);
                break;
            case "/profile":
                updateProfile(request, response);
                break;
            default:
                ServletUtils.forwardErrorPage(response);
                break;
        }
    }

    private void postRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String password = request.getParameter("password");
        String bcryptHashString = BCrypt.withDefaults().hashToString(12, password.toCharArray());
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String name = request.getParameter("name");

        UserServiceImpl userService = new UserServiceImpl();

        User user = new User();
        user.setEmail(email);
        user.setUsername(username);
        user.setName(name);
        user.setPassword(bcryptHashString);

        PrintWriter out = response.getWriter();
        try {
            userService.addNew(user);
            ServletUtils.redirect("/account/login", request, response);
        } catch (Exception ex) {
            out.println(ex.getMessage());
        }

    }

    private void postLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UserServiceImpl userService = new UserServiceImpl();
        Optional<User> user = userService.findByUsername(username);

        if (user.isPresent()) {
            BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), user.get().getPassword());
            if (result.verified) {
                HttpSession session = request.getSession();
                session.setAttribute("auth", true);
                session.setAttribute("authUser", user.get());
                String url = (String) session.getAttribute("retUrl");
                if (url == null) {
                    url = "/";
                }
                ServletUtils.redirect(url, request, response);
            } else {
                request.setAttribute("hasError", true);
                request.setAttribute("errorMessage", "Wrong password");
                ServletUtils.forward("/views/Login.jsp", request, response);
                return;
            }
        } else {
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "User not found!");
            ServletUtils.forward("/views/Login.jsp", request, response);
            return;
        }
    }

    private void postLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("auth", false);
        session.setAttribute("authUser", null);
        String url = request.getHeader("Referer");
        if (url == null) url = "/";
        ServletUtils.redirect(url, request, response);
    }
    private void updateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long id =Long.parseLong(request.getParameter("id"));
        String password = request.getParameter("password");
        String bcryptHashString = BCrypt.withDefaults().hashToString(12, password.toCharArray());
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String name = request.getParameter("name");

        UserServiceImpl userService = new UserServiceImpl();

        User user = (User) request.getSession().getAttribute("authUser");

        user.setEmail(email);
        user.setUsername(username);
        user.setName(name);
        user.setPassword(bcryptHashString);

        System.out.println(password);
        System.out.println(user.getPassword());

        PrintWriter out = response.getWriter();
        try {
            userService.update(user);
            ServletUtils.redirect("/account/profile", request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = Optional.ofNullable(request.getPathInfo()).orElse("");
        switch (path) {
            case "/register":
                if ((boolean) request.getSession().getAttribute("auth")) {
                    ServletUtils.redirect("/", request, response);
                    return;
                }
                ServletUtils.forward("/views/AccountRegister.jsp", request, response);
                break;
            case "/login":
                if ((boolean) request.getSession().getAttribute("auth")) {
                    ServletUtils.redirect("/", request, response);
                    return;
                }
                request.setAttribute("hasError", false);
                ServletUtils.forward("/views/Login.jsp", request, response);
                break;
            case "/profile":
                String username = request.getParameter("username");
                UserServiceImpl userService = new UserServiceImpl();
                Optional<User> user = userService.findByUsername(username);
                if (user.isPresent()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("auth", true);
                    session.setAttribute("authUser", user.get());
                    request.setAttribute("user", user.get());
                }

                ServletUtils.forward("/views/Profile.jsp", request, response);
                break;
            case "/mylearning":
                ServletUtils.forward("/views/UserMyLearning.jsp",request,response);
            case "/wishlist":
                ServletUtils.redirect("/", request, response);
                break;
            default:
                ServletUtils.forwardErrorPage(response);
                break;
        }
    }
}