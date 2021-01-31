<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="common/head.jsp"/>
<body>
<jsp:include page="common/navbar.jsp"/>
<main>
    <form method="post" action="${pageContext.request.contextPath}/admin/editcat">
        <input type="hidden" name="id" value="${requestScope.category.id}">
        <div class="card">
            <div class="card-header">
                <h4>Edit Categoris</h4>
            </div>
            <div class="card-body">
                <div class="form-group">
                    <label for="txtName">Name</label>
                    <input type="text" class="form-control" id="txtName" name="name"
                           value="${requestScope.category.name}">
                </div>
                <div class="form-group">
                    <label for="txtSlug">Slug</label>
                    <input type="text" class="form-control" id="txtSlug" name="slug"
                           value="${requestScope.category.slug}">
                </div>
                <div class="form-group">
                    <label for="txtSlug">Parent</label>
                    <select name="parent" id="parent" class="form-control">
                        <option selected value="">None</option>
                        <c:forEach items="${requestScope.categoryList}" var="category">
                            <option
                                    <c:if test="${!empty requestScope.category.parent && requestScope.category.parent.id.equals(category.id)}">selected</c:if>
                                    value="${category.id}">${category.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="card-footer">
                    <a href="<c:url value="/admin/managercat" />" class="btn btn-outline-primary a-unstyled">
                        <i class="fa fa-backward" aria-hidden="true"></i>
                        Back
                    </a>
                    <button type="submit" class="btn btn-outline-success">
                        <i class="fa fa-wrench" aria-hidden="true"></i>
                        Update
                    </button>
                </div>
            </div>
        </div>
    </form>
</main>
<jsp:include page="common/footer.jsp"/>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</body>
</html>