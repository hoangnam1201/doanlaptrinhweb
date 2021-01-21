package com.udemy.controller;

import at.favre.lib.crypto.bcrypt.BCrypt;
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
        String path = request.getPathInfo();
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
                    request.setAttribute("authUser", user.get());
                }
                ServletUtils.forward("/views/Profile.jsp", request, response);
                break;
            case "/learning":
            case "/wishlist":
                ServletUtils.redirect("/", request, response);
                break;
            default:
                ServletUtils.forwardErrorPage(response);
                break;
        }
    }
}