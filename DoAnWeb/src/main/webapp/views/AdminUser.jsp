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
                   href="${pageContext.request.contextPath}/admin/addteacher" role="button"><i class="fa fa-plus"
                                                                                               aria-hidden="true"></i>ADD TEACHER</a>
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="student-tab" data-toggle="tab" href="#student" role="tab"
                           aria-controls="home" aria-selected="true">Student</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="teacher-tab" data-toggle="tab" href="#teacher" role="tab"
                           aria-controls="profile" aria-selected="false">Teacher</a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane show active" id="student" role="tabpanel">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Name</th>
                                <th scope="col">Username</th>
                                <th scope="col">Email</th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${requestScope.userList}" var="user">
                                <c:if test="${user.role == 'student'}">
                                    <tr>
                                        <td>${user.id}</td>
                                        <td>${user.name}</td>
                                        <td>${user.username}</td>
                                        <td>${user.email}</td>
                                        <td>
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/admin/deleteuser?id=${user.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger"><i
                                                        class="fa fa-trash"
                                                        aria-hidden="true"></i>
                                                </button>
                                            </form>
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/admin/banuser?id=${user.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger"><i
                                                        class="fas fa-lock${user.disabled ? "-open":""}"
                                                        aria-hidden="true"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane" id="teacher" role="tabpanel">
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Name</th>
                                <th scope="col">Username</th>
                                <th scope="col">Email</th>
                                <th scope="col">Job</th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${requestScope.userList}" var="user">
                                <c:if test="${user.role == 'teacher'}">
                                    <tr>
                                        <td>${user.id}</td>
                                        <td>${user.name}</td>
                                        <td>${user.username}</td>
                                        <td>${user.email}</td>
                                        <td>${user.job}</td>
                                        <td>
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/admin/deleteuser?id=${user.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger"><i
                                                        class="fa fa-trash"
                                                        aria-hidden="true"></i>
                                                </button>
                                            </form>
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/admin/banuser?id=${user.id}">
                                                <button type="submit" class="btn btn-sm btn-outline-danger"><i
                                                        class="fas fa-lock${user.disabled ? "-open":""}"
                                                        aria-hidden="true"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:genericpage>