package com.udemy.filter;

import com.udemy.model.User;
import com.udemy.service.UserServiceImpl;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;
import java.util.List;

@WebFilter(filterName = "UserFilter")
public class UserFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        UserServiceImpl userService = new UserServiceImpl();
        List<User> list = userService.getAllUser();
        req.setAttribute("userList",list);
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
