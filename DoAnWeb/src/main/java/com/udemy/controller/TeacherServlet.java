package com.udemy.controller;

import com.udemy.model.*;
import com.udemy.service.CategoryServiceImpl;
import com.udemy.service.CourseServiceImpl;
import com.udemy.util.ServletUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@WebServlet(name = "InstructorServlet", urlPatterns = "/teacher/*")
public class TeacherServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = Optional.ofNullable(request.getPathInfo()).orElse("");
        CourseServiceImpl courseService = new CourseServiceImpl();

        User teacher;
        Course course;
        Section section;
        Lesson lesson;

        long courseId = Long.parseLong(Optional.ofNullable(request.getParameter("courseId")).orElse("0"));
        long sectionId = Long.parseLong(Optional.ofNullable(request.getParameter("sectionId")).orElse("0"));
        long lessonId = Long.parseLong(Optional.ofNullable(request.getParameter("lessonId")).orElse("0"));


        PrintWriter out = response.getWriter();
        try {
            switch (path) {
                case "/create":
                    course = setCourseDetails(false, request);
                    teacher = (User) request.getSession().getAttribute("authUser");
                    course.setTeacher(teacher);
                    courseService.addNew(course);
                    request.setAttribute("create", true);
                    request.setAttribute("success", true);
                    ServletUtils.forward("/views/TeacherCourseDetails.jsp", request, response);
                    break;
                case "/update-details":
                    course = setCourseDetails(true, request);
                    courseService.update(course);
                    ServletUtils.redirect("/teacher/manage/" + course.getId().toString() + "/details", request, response);
                    break;
                case "/submit":
                    courseService.setCompleteById(courseId);
                    ServletUtils.redirect("/teacher/courses", request, response);
                    break;
                case "/delete":
                    courseService.deleteById(courseId);
                    ServletUtils.redirect("/teacher/courses", request, response);
                    break;
                case "/add-section":
                    section = new Section();
                    setSectionDetails(section, request);
                    courseService.addSection(courseId, section);
                    ServletUtils.redirect("/teacher/manage/" + courseId + "/curriculum", request, response);
                    break;
                case "/add-lesson":
                    lesson = new Lesson();
                    setLessonDetails(lesson, request);
                    courseService.addLesson(courseId, sectionId, lesson);
                    ServletUtils.redirect("/teacher/manage/" + courseId + "/curriculum", request, response);
                    break;
                case "/update-section":
                    course = courseService.getCourseById(courseId);
                    section = courseService.getSectionById(course, sectionId);
                    setSectionDetails(section, request);
                    courseService.update(course);
                    ServletUtils.redirect("/teacher/manage/" + courseId + "/curriculum", request, response);
                    break;
                case "/update-lesson":
                    course = courseService.getCourseById(courseId);
                    lesson = courseService.getLessonById(course, sectionId, lessonId);
                    setLessonDetails(lesson, request);
                    courseService.update(course);
                    ServletUtils.redirect("/teacher/manage/" + courseId + "/curriculum", request, response);
                    break;
                case "/delete-section":
                    courseService.deleteSection(courseId, sectionId);
                    ServletUtils.redirect("/teacher/manage/" + courseId + "/curriculum", request, response);
                    break;
                case "/delete-lesson":
                    courseService.deleteLesson(courseId, sectionId, lessonId);
                    ServletUtils.redirect("/teacher/manage/" + courseId + "/curriculum", request, response);
                    break;
                default:
                    ServletUtils.forwardErrorPage(response);
                    break;
            }
        } catch (Exception ex) {
            out.println(ex.getCause() + " " + ex.getMessage());
        }


    }


    protected Course setCourseDetails(Boolean edit, HttpServletRequest request) throws IOException {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> items = null;
        try {
            items = upload.parseRequest(request);
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
        Iterator<FileItem> iter = items.iterator();
        Hashtable<String, String> params = new Hashtable<String, String>();
        String fileName = "";
        while (iter.hasNext()) {
            FileItem item = iter.next();
            if (item.isFormField()) {
                params.put(item.getFieldName(), item.getString());
            } else {
                try {
                    if (!item.getName().isEmpty()) {
                        String[] split = item.getName().split("\\.");
                        fileName = UUID.randomUUID().toString() + "." + split[split.length - 1];
                    }
                    String realPath = "D:/images/" + fileName;
                    File savedFile = new File(realPath);
                    System.out.println(realPath);
                    item.write(savedFile);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        CourseServiceImpl courseService = new CourseServiceImpl();
        CategoryServiceImpl categoryService = new CategoryServiceImpl();

        Category category = categoryService
                .getCategoryById(Long.parseLong(params.get("subcategory")));
        Course course;
        if (edit) {
            course = courseService.getCourseById(Long.parseLong(params.get("courseId")));
        } else {
            course = new Course();
        }

        course.setCategory(category);
        if (!fileName.isEmpty()) {
            course.setImage(fileName);
        }
        course.setName(params.get("name"));
        course.setPrice(Double.parseDouble(params.get("price")));
        course.setShortDescription(params.get("short-description"));
        course.setDescription(params.get("description"));
        course.setLanguage(params.get("language"));
        course.setLevel(params.get("level"));
        course.setLearnGoals(params.get("learn-goal"));
        course.setRequirements(params.get("requirements"));
        course.setTargetStudents(params.get("target-students"));
        return course;
    }

    protected void setSectionDetails(Section section, HttpServletRequest request) {
        section.setName(request.getParameter("name"));
        section.setRowOrder(Integer.parseInt(request.getParameter("row-order")));
    }

    protected void setLessonDetails(Lesson lesson, HttpServletRequest request) {
        lesson.setName(request.getParameter("name"));
        lesson.setRowOrder(Integer.parseInt(request.getParameter("row-order")));
        lesson.setVideoUrl(request.getParameter("video-url"));
        lesson.setDescription(request.getParameter("description"));
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = Optional.ofNullable(request.getPathInfo()).orElse("");
        CourseServiceImpl courseService = new CourseServiceImpl();
        request.setAttribute("success", false);
        switch (path) {
            case "/courses":
                List<Course> courseList = new ArrayList<Course>();
                Long userId = ((User) request.getSession().getAttribute("authUser")).getId();
                try {
                    courseList = courseService.getMyCourses(userId);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                request.setAttribute("courseList", courseList);
                ServletUtils.forward("/views/TeacherCourseList.jsp", request, response);
                break;
            case "/create":
                request.setAttribute("create", true);
                ServletUtils.forward("/views/TeacherCourseDetails.jsp", request, response);
                break;
            case "/manage":
                Course course = (Course) request.getAttribute("course");
                if (course != null) {
                    String section = request.getParameter("section");
                    request.setAttribute("course", course);
                    switch (section) {
                        case "details":
                            request.setAttribute("create", false);
                            ServletUtils.forward("/views/TeacherCourseDetails.jsp", request, response);
                            break;
                        case "curriculum":
                            ServletUtils.forward("/views/TeacherCourseCurriculum.jsp", request, response);
                            break;
                        default:
                            ServletUtils.redirect("/", request, response);
                            break;
                    }
                } else {
                    ServletUtils.forwardErrorPage(response);
                }
                break;
            default:
                ServletUtils.forwardErrorPage(response);
                break;
        }
    }
}
