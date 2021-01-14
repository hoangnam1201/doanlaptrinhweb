package com.udemy.controller;

import com.udemy.model.Category;

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

@WebServlet(name = "TestServlet", urlPatterns = "/test")
public class TestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html");
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("udemy");
        EntityManager entityManager = emf.createEntityManager();
        entityManager.getTransaction().begin();
        Category category = new Category();
        category.setName("React");
        category.setSlug("/react");
        entityManager.persist(category);
        entityManager.getTransaction().commit();
        entityManager.close();
        emf.close();
        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + "asdasd" + "</h1>");
        out.println("</body></html>");
    }
}
