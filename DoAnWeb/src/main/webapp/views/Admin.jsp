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

                <a class="btn btn-outline-success mb-2"
                   href="${pageContext.request.contextPath}/admin/addcat" role="button"><i class="fa fa-plus" aria-hidden="true"></i>ADD</a>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">Image</th>
                        <th scope="col">Slug</th>
                        <th scope="col">Parent</th>
                        <th scope="col"></th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope.categoryList}" var="cat">

                        <tr>
                        <td>${cat.id}</td>
                        <td>${cat.name}</td>
                        <td>${cat.image}</td>
                        <td>${cat.slug}</td>
                            <td>None</td>
                        <td><a class="btn btn-sm btn-outline-primary" role="button" href="${pageContext.request.contextPath}/admin/editcat?id=${cat.id}">
                            <i class="fa fa-pen" aria-hidden="true"></i></a></td>
                            <td><form method="post" action="${pageContext.request.contextPath}/admin/deletecat?id=${cat.id}"><button type="submit" class="btn btn-sm btn-outline-danger"><i class="fa fa-trash" aria-hidden="true"></i></button></form></td>
                         </tr>
                        <c:forEach items="${cat.children}" var="subcat">
                            <tr>
                                <td>${subcat.id}</td>
                                <td>${subcat.name}</td>
                                <td>${subcat.image}</td>
                                <td>${subcat.slug}</td>
                                <td>${subcat.parent.name}</td>
                                <td><a class="btn btn-sm btn-outline-primary" role="button" href="${pageContext.request.contextPath}/admin/editcat?id=${subcat.id}">
                                    <i class="fa fa-pen" aria-hidden="true"></i></a></td>
                                <td><form method="post" action="${pageContext.request.contextPath}/admin/deletecat?id=${subcat.id}"><button type="submit" class="btn btn-sm btn-outline-danger"><i class="fa fa-trash" aria-hidden="true"></i></button></form></td>
                            </tr>
                        </c:forEach>
                    </c:forEach>
                    </tbody>
                </table>

            </div>
        </div>
    </jsp:body>
</t:genericpage>