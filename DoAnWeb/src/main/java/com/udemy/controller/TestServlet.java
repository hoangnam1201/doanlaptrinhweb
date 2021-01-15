package com.udemy.controller;

import com.udemy.DAO.CategoryDAO;
import com.udemy.DAO.CategoryDAOImpl;
import com.udemy.model.Category;
import com.udemy.util.JpaUtil;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "TestServlet", urlPatterns = "/test")
public class TestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        CategoryDAOImpl categoryDAO = new CategoryDAOImpl();
        List<Category> list =  categoryDAO.getAllParentAndSub();
        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println(list.get(0).getChildren().get(0).getName());
        out.println("</body></html>");
    }
}
