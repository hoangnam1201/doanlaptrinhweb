<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@attribute name="course" required="true" type="com.udemy.model.Course" %>

<div class="d-flex">
    <c:choose>
        <c:when test="${course.badge.equals('New')}">
            <div class="new-badge mr-1">New</div>
        </c:when>
        <c:when test="${course.badge.equals('Bestseller')}">
            <div class="bestseller-badge mr-1">Bestseller</div>
        </c:when>
        <c:when test="${course.badge.equals('High rated')}">
            <div class="high-rated-badge mr-1">High rated</div>
        </c:when>
    </c:choose>
</div>
