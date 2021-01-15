package com.udemy.filter;

import com.udemy.DAO.CategoryDAOImpl;
import com.udemy.model.Category;
import com.udemy.service.CategoryServiceImpl;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;
import java.util.List;

@WebFilter(filterName = "CategoryFilter", urlPatterns = "/*")
public class CategoryFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        CategoryServiceImpl categoryService = new CategoryServiceImpl();
        List<Category> list = categoryService.getAllParentAndSub();
        req.setAttribute("categoryList", list);
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {
    }

}
