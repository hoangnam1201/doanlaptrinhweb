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
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Optional;

@WebServlet(name = "AccountServlet", urlPatterns = "/Account/*")
public class AccountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        switch (path) {
            case "/Register":
                postRegister(request, response);
                break;
            case "/Login":
                postLogin(request, response);
                break;
            case "/Logout":
                postLogout(request, response);
                break;
            default:
                ServletUtils.redirect("/NotFound", request, response);
                break;
        }
    }

    private void postRegister(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String password = request.getParameter("password");
        String bcryptHashString = BCrypt.withDefaults().hashToString(12, password.toCharArray());
        String email = request.getParameter("email");
        String username =request.getParameter("username");
        String role ="student";

        UserServiceImpl userService = new UserServiceImpl();

        User user = new User();
        user.setEmail(email);
        user.setUsername(username);
        user.setRole(role);
        user.setPassword(bcryptHashString);


        PrintWriter out = response.getWriter();
        try{
            userService.addNew(user);
            ServletUtils.redirect("/Account/Login",request,response);
            //out.println("Dang ky thanh cong");
        }catch (Exception ex){
            out.println(ex.getMessage());
        }

    }

    private void postLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UserServiceImpl userService = new UserServiceImpl();

        Optional<User> user = userService.findByUsername(username);

        PrintWriter out = response.getWriter();
        if (user.isPresent()) {
            BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), user.get().getPassword());
            if (result.verified) {
                //out.println("OK");
                HttpSession session = request.getSession();
                session.setAttribute("auth",true);
                session.setAttribute("authUser",user.get());
                String url =(String)session.getAttribute("retUrl");
                if(url ==null)
                {
                    url ="/index";
                }
                ServletUtils.redirect(url,request,response);
            } else {
                out.println("SAI PASS");
            }
        } else {
            out.println("Khong co user");
        }
    }

    private void postLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("auth",false);
        session.setAttribute("authUser", new User());
        String url =request.getHeader("referer");
        if(url==null) url ="/index";
        ServletUtils.redirect(url,request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        switch (path) {
            case "/Register":
                ServletUtils.forward("/views/AccountRegister.jsp", request, response);
                break;
            case "/Login":
                request.setAttribute("hasError", false);
                ServletUtils.forward("/views/Login.jsp", request, response);
                break;
            case "/Profile":
                ServletUtils.forward("/views/Profile.jsp", request, response);
                break;
            case "/IsAvailable":
                String username = request.getParameter("user");
                UserServiceImpl userService =new UserServiceImpl();
                Optional<User> user = userService.findByUsername(username);
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");
                out.print(!user.isPresent());
                out.flush();
                break;
            default:
                ServletUtils.redirect("/NotFound", request, response);
                break;
        }
    }
}
