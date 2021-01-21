package com.udemy.filter;

import com.udemy.util.ServletUtils;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AuthenticationFilter")
public class AuthenticationFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        if (!(request.getServletPath() + request.getPathInfo())
                .matches("/account/login|/account/register")) {
            HttpSession session = request.getSession();
            boolean auth = (boolean) session.getAttribute("auth");
            if (!auth) {
                if (request.getServletPath().matches("/cart|/account")) {
                    session.setAttribute("retUrl", request.getRequestURI());
                    ServletUtils.redirect("/account/login", request, (HttpServletResponse) resp);
                } else if (request.getServletPath().matches("/admin|/teacher")) {
                    ServletUtils.redirect("/", request, (HttpServletResponse) resp);
                }
                return;
            }
        }
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
