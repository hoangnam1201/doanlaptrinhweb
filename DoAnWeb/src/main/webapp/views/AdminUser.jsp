<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<t:genericpage>
    <jsp:body>
        <div class="sidebar-container">
            <div class="sidebar-logo">
                Udemy
            </div>
            <ul class="sidebar-navigation">
                <li>
                    <a href="#">
                        <i class="fa fa-home" aria-hidden="true"></i> Homepage
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="fa fa-tachometer" aria-hidden="true"></i> Dashboard
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
                    <a href="#">
                        <i class="fa fa-info-circle" aria-hidden="true"></i> Information
                    </a>
                </li>
            </ul>
        </div>

        <div class="content-container">

            <div class="container-fluid">

                <a class="btn btn-outline-success mb-2"
                   href="${pageContext.request.contextPath}/admin/addteacher" role="button"><i class="fa fa-plus" aria-hidden="true"></i>ADD</a>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">Username</th>
                        <th scope="col">Email</th>
                        <th scope="col">Role</th>
                        <th scope="col"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${requestScope.userList}" var="user">

                        <tr>
                            <td>${user.id}</td>
                            <td>${user.name}</td>
                            <td>${user.username}</td>
                            <td>${user.email}</td>
                            <td>${user.role}</td>
                            <td><form method="post" action="${pageContext.request.contextPath}/admin/deleteuser?id=${user.id}"><button type="submit" class="btn btn-sm btn-outline-danger"><i class="fa fa-trash" aria-hidden="true"></i></button></form></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

            </div>
        </div>
    </jsp:body>
</t:genericpage>