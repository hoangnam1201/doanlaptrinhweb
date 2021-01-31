<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@attribute name="course" required="true" type="com.udemy.model.Course" %>

<div class="d-flex">
    <c:if test="${course.studentCount > 1}">
        <div class="bestseller-badge mr-1">Bestseller</div>
    </c:if>
</div>
