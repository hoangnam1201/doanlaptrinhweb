<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<t:genericpage>
    <jsp:body>
        <div class="sidebar-container">
            <div class="sidebar-logo">
                Dashboard
            </div>
            <ul class="sidebar-navigation">
                <li>
                    <a href="#">
                        <i class="fa fa-home" aria-hidden="true"></i> Homepage
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/managercat">
                        <i class="fa fa-book" aria-hidden="true"></i> Categories
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/manageruser">
                        <i class="fa fa-users" aria-hidden="true"></i> Users
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/managercourse">
                        <i class="fa fa-list-alt" aria-hidden="true"></i> Courses
                    </a>
                </li>
            </ul>
        </div>

        <div class="content-container">

            <div class="container-fluid">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">Price</th>
                        <th scope="col">Description</th>
                        <th scope="col">Language</th>
                        <th scope="col">Level</th>
                        <th scope="col">Category</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope.courseList}" var="course">
                        <tr>
                            <td>${course.id}</td>
                            <td>${course.name}</td>
                            <td>${course.price}</td>
                            <td>${course.shortDescription}</td>
                            <td>${course.language}</td>
                            <td>${course.level}</td>
                            <td>${course.category.name}</td>
                            <td><form method="post" action="${pageContext.request.contextPath}/admin/deletecourse?id=${course.id}"><button type="submit" class="btn btn-sm btn-outline-danger"><i class="fa fa-trash" aria-hidden="true"></i></button></form></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

            </div>
        </div>
    </jsp:body>
</t:genericpage>