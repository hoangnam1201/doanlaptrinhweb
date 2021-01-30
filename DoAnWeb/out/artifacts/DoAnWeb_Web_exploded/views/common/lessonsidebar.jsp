<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>


<header class="sidebar--header">
    <i class="fas fa-caret-left float-left"></i>
    <a class="a-unstyled ml-2" href="<c:url value="/course/${requestScope.course.id}"/>">
        ${requestScope.course.name}
    </a>
    <label class="close-button" for="header-mobile-toggle">&times;</label>
</header>
<c:choose>
    <c:when test="${requestScope.enrolled}">
        <button data-toggle="modal" data-target="#rating-form"
                class="w-100 d-block d-md-none btn outline-none content-text text-left">
                ${requestScope.enrollment.rating == 0 ? "Leave a rating":"Edit your rating"}
        </button>
    </c:when>
    <c:otherwise>
        <a href="<c:url value="/teacher/manage/${requestScope.course.id}/details" />"
           class="-block d-md-none btn outline-none content-text">Edit course</a>
    </c:otherwise>
</c:choose>

<div class="content-text">Course content</div>
<c:forEach items="${requestScope.course.sections}" var="section">
    <div data-toggle="collapse" data-target=".lessons${section.id}"
         class="btn d-flex section${requestScope.lesson.section.id.equals(section.id)?" active":""}">
        <span class="mr-3"><i class="fas fa-book"></i></span><span>${section.name}</span>
    </div>
    <div class="lessons${section.id} lesson-list collapse${requestScope.lesson.section.id.equals(section.id)?" show":""}">
        <ul class="lesson list-unstyled">
            <c:forEach items="${section.lessons}" var="lesson">
                <li><a class="d-flex a-unstyled${requestScope.lesson.id.equals(lesson.id)?" active":""}"
                       href="<c:url value="/course/${requestScope.course.id}/learn/${lesson.id}"/>">
                    <span class="mr-3"><i class="fas fa-video"></i></span><span>${lesson.name}</span>
                </a></li>
            </c:forEach>
        </ul>
    </div>
</c:forEach>
