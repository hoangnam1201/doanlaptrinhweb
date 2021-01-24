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
        if (request.getCharacterEncoding() == null) {
            request.setCharacterEncoding("UTF-8");
        }

        String path = Optional.ofNullable(request.getPathInfo()).orElse("");
        try {
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
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.forwardErrorPage(response);
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

        userService.addNew(user);
        ServletUtils.redirect("/account/login", request, response);

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
        session.setAttribute("authUser", new User());
        String url = request.getHeader("Referer");
        if (url == null) url = "/";
        ServletUtils.redirect(url, request, response);
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserServiceImpl userService = new UserServiceImpl();
        User user = (User) request.getSession().getAttribute("authUser");

        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String job = Optional.ofNullable(request.getParameter("job")).orElse("");
        String bio = Optional.ofNullable(request.getParameter("bio")).orElse("");

        user.setEmail(email);
        user.setUsername(username);
        user.setName(name);
        user.setJob(job);
        user.setBio(bio);

        String password = request.getParameter("password");
        if (!password.isEmpty()) {
            String bcryptHashString = BCrypt.withDefaults().hashToString(12, password.toCharArray());
            user.setPassword(bcryptHashString);
        }

        try {
            userService.update(user);
            ServletUtils.redirect("/account/profile", request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            ServletUtils.forwardErrorPage(response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = Optional.ofNullable(request.getPathInfo()).orElse("");
        CourseServiceImpl courseService = new CourseServiceImpl();
        UserServiceImpl userService = new UserServiceImpl();
        User user = (User) request.getSession().getAttribute("authUser");
        try {
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
                    ServletUtils.forward("/views/Profile.jsp", request, response);
                    break;
                case "/learning":
                    User newUser = userService.getUserById(user.getId());
                    newUser.getEnrollments().size();
                    request.setAttribute("user", newUser);
                    request.setAttribute("page", "My learning");
                    ServletUtils.forward("/views/UserMyLearning.jsp", request, response);
                case "/wishlist":
                    User userWithWishlist = userService.getUserWithWishlistById(user.getId());
                    request.setAttribute("user", userWithWishlist);
                    request.setAttribute("page", "Wishlist");
                    ServletUtils.forward("/views/UserMyLearning.jsp", request, response);
                    break;
                default:
                    ServletUtils.forwardErrorPage(response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            ServletUtils.forwardErrorPage(response);
        }
    }
}