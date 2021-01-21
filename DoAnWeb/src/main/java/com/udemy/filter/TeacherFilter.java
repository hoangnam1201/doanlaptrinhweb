package com.udemy.filter;

import com.udemy.model.Course;
import com.udemy.model.User;
import com.udemy.service.CourseServiceImpl;
import com.udemy.util.ServletUtils;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Optional;

@WebFilter(filterName = "TeacherFilter")
public class TeacherFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("authUser");
        if (!user.getRole().equals("teacher")) {
            ServletUtils.redirect("/", request, (HttpServletResponse) resp);
            return;
        }
        if (request.getPathInfo().equals("/manage")) {
            CourseServiceImpl courseService = new CourseServiceImpl();
            Long courseId = Long.parseLong(Optional.ofNullable(request.getParameter("id")).orElse("0"));
            Optional<Course> course = Optional.ofNullable(courseService.getCourseById(courseId));
            if (course.isPresent()) {
                if (!course.get().getTeacher().getId().equals(user.getId())) {
                    ServletUtils.redirect("/", request, (HttpServletResponse) resp);
                    return;
                }
                request.setAttribute("course", course.get());
            } else {
                ServletUtils.redirect("/", request, (HttpServletResponse) resp);
                return;
            }
        }
        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
