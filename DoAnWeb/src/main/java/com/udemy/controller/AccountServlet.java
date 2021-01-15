package com.udemy.controller;

import com.udemy.util.ServletUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

@WebServlet(name = "AccountServlet", urlPatterns = "/Account/*")
public class AccountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        switch (path) {
            case "/Register":
                ServletUtils.forward("/views/AccountRegister.jsp", request, response);
                break;
            case "/Login":
                //request.setAttribute("hasError", false);
                ServletUtils.forward("/views/Login.jsp", request, response);
                break;
            case "/Profile":
                ServletUtils.forward("/views/Profile.jsp", request, response);
                break;
            default:
                ServletUtils.redirect("/NotFound", request, response);
                break;
        }
    }
}
