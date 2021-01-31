<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<t:genericpage>
    <jsp:attribute name="js">
        <script>
            $("#teacher-select").val('${empty param.teacherId ? "0":param.teacherId}')
            $("#cat-select").data('subCat', '${empty param.subCatId ? "0":param.subCatId}')
            $("#cat-select").val('${empty param.catId ? "0":param.catId}').trigger('change');
        </script>
    </jsp:attribute>
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
                <form>
                    <h5>Filter</h5>
                    <div class="row">
                        <div class="col">
                            <label>Category</label>
                            <select class="form-control" name="catId" id="cat-select">
                                <option value="0" selected>None</option>
                                <c:forEach items="${requestScope.categoryList}" var="category">
                                    <option value="${category.id}">${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col">
                            <label>Subcategory</label>
                            <select class="form-control" name="subCatId" id="subcat-select">
                            </select>
                        </div>
                        <div class="col">
                            <label>Teacher</label>
                            <select class="form-control" name="teacherId" id="teacher-select">
                                <option value="0">None</option>
                                <c:forEach items="${requestScope.teacherList}" var="teacher">
                                    <option value="${teacher.id}">${teacher.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <button class="btn btn-info text-white font-weight-bold px-4">Apply</button>
                </form>
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">Price</th>
                        <th scope="col">Language</th>
                        <th scope="col">Teacher</th>
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
                            <td>${course.language}</td>
                            <td>${course.teacher.name}</td>
                            <td>${course.category.name}</td>
                            <td>
                                <form method="post"
                                      action="${pageContext.request.contextPath}/admin/bancourse?id=${course.id}">
                                    <button type="submit" class="btn btn-sm btn-outline-danger"><i
                                            class="fas fa-lock${course.disabled ? "-open":""}"
                                            aria-hidden="true"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

            </div>
        </div>
    </jsp:body>
</t:genericpage>