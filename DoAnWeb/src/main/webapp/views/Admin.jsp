<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <jsp:include page="common/head.jsp"/>
</head>
<body>
<jsp:include page="common/navbar.jsp"/>
<main>
    <div class="w3-sidebar w3-light-grey w3-bar-block" style="width:25%">
        <h3 class="w3-bar-item">Dasboard</h3>
        <a href="#" class="w3-bar-item w3-button">Categories</a>
        <a href="#" class="w3-bar-item w3-button">Lessons</a>
        <a href="#" class="w3-bar-item w3-button">Users</a>
    </div>

    <!-- Page Content -->
    <div style="margin-left:25%">

        <div class="w3-container w3-teal">
            <h1>Adminstrator</h1>
        </div>

        <div class="w3-container">
            <table class="w3-table-all">
                <thead>
                <tr class="w3-light-grey w3-hover-red">
                    <th>ID</th>
                    <th>Name</th>
                    <th>Image</th>
                    <th>Parent_Id</th>
                </tr>
                </thead>
                <tr class="w3-hover-green">
                    <td>Jill</td>
                    <td>Smith</td>
                    <td>50</td>
                    <td>1</td>
                </tr>
                <tr class="w3-hover-blue">
                    <td>Eve</td>
                    <td>Jackson</td>
                    <td>94</td>
                    <td>1</td>
                </tr>
                <tr class="w3-hover-black">
                    <td>Adam</td>
                    <td>Johnson</td>
                    <td>67</td>
                    <td>1</td>
                </tr>
                <tr class="w3-hover-text-green">
                    <td>Bo</td>
                    <td>Nilson</td>
                    <td>35</td>
                    <td>1</td>
                </tr>
            </table>
        </div>
        <div style="margin-top: 10px; margin-left: 15px">
            <a class="header-button btn header-login-button d-none d-md-block" href="${pageContext.request.contextPath}/Account/Login" role="button">ADD</a>
            <button type="button" class="btn btn-outline-warning">Update</button>
            <button type="button" class="btn btn-outline-danger">Delete</button>
        </div>

    </div>
</main>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
