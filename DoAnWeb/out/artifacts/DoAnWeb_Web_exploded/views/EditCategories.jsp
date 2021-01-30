<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="common/head.jsp"/>
<body>
<jsp:include page="common/navbar.jsp"/>
<main>
    <script>
        $('#frmRegister').on('submit', function (e) {
            e.preventDefault();
        });
    </script>
    <form method="post" id="frmRegister">
        <div class="card">
            <div class="card-header">
                <h4>Edit Categoris</h4>
            </div>
            <div class="card-body">
                <div class="form-group">
                    <label for="txtName">Name</label>
                    <input type="text" class="form-control" id="txtName" name="name" value="${requestScope.category.name}">
                </div>
                <div class="form-group">
                    <label for="txtSlug">Slug</label>
                    <input type="text" class="form-control" id="txtSlug" name="slug" value="${requestScope.category.slug}">
                </div>
                <div class="form-group">
                    <label for="txtSlug">Parent</label>
                    <select name="parent" id="parent" class="form-control">
                        <option selected value="${requestScope.category.parent}">None</option>
                        <c:forEach items="${requestScope.categoryList}" var="category">
                            <option value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="txtImage">Image</label>
                    <input type="file" accept="image/png, image/jpeg" class="form-control" id="txtImage" name="image" value="${requestScope.category.image}">
                </div>
                <div class="card-footer">
                    <button type="submit" class="btn btn-outline-primary">
                        <i class="fa fa-backward" aria-hidden="true"></i>
                        Back
                    </button>
                    <form method="post" action="${pageContext.request.contextPath}/admin/editcat?id=${cat.id}"><button type="submit" class="btn btn-outline-success">
                        <i class="fa fa-wrench" aria-hidden="true"></i>
                        Update
                    </button></form>
                </div>
            </div>
        </div>
    </form>

</main>
<jsp:include page="common/footer.jsp"/>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</body>
</html>