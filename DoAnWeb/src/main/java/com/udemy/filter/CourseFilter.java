package com.udemy.filter;

import com.udemy.model.Course;
import com.udemy.model.Enrollment;
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

@WebFilter(filterName = "CourseFilter")
public class CourseFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        CourseServiceImpl courseService = new CourseServiceImpl();

        User user = Optional.ofNullable((User) request.getSession().getAttribute("authUser")).orElse(new User());
        long courseId = Long.parseLong(Optional.ofNullable(request.getParameter("courseId"))
                .orElse(Optional.ofNullable(request.getParameter("id")).orElse("0")));
        long userId = Optional.ofNullable(user.getId()).orElse(0L);

        Optional<Course> course = Optional.ofNullable(courseService.getCourseById(courseId));
        if (!course.isPresent()) {
            ServletUtils.forwardErrorPage(response);
            return;
        }
        request.setAttribute("course", course.get());

        Optional<Enrollment> enrollment = Optional.ofNullable(courseService.getEnrollment(courseId, userId));


        if (enrollment.isPresent()) {
            request.setAttribute("enrolled", true);
            request.setAttribute("enrollment", enrollment.get());
        } else {
            request.setAttribute("enrolled", false);
        }

        chain.doFilter(req, resp);
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
