<%@tag description="Slide nhieu khoa hoc" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@attribute name="course" required="true" type="com.udemy.model.Course" %>

<div class="course-row--container d-block">
    <div class="d-flex flex-column flex-lg-row">
        <a class="d-flex justify-content-center" href="<c:url value="/course/${course.id}" />">
            <img width="300" src="<c:url value="/images/${course.image}"/>"
                 alt="">
        </a>
        <div class="d-flex flex-fill flex-column flex-md-row">
            <div class="p-2 flex-fill">
                <div class="d-flex align-items-center mb-2">
                    <c:choose>
                        <c:when test="${course.disabled}">
                            <h5 class="text-muted font-weight-bold mb-0">${course.name}</h5>
                        </c:when>
                        <c:otherwise>
                            <a href="<c:url value="/course/${course.id}" />" class="a-unstyled">
                                <h5 class="active-color font-weight-bold mb-0">
                                        ${course.name}
                                </h5>
                            </a>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${course.disabled}">
                            <label style="font-size: 11px"
                                   class="bg-secondary text-white font-weight-bold d-flex align-items-center ml-2 mb-0 p-1">Disabled</label>
                        </c:when>
                        <c:when test="${course.complete}">
                            <label style="font-size: 11px"
                                   class="bg-success text-white font-weight-bold d-flex align-items-center ml-2 mb-0 p-1">Complete</label>
                        </c:when>
                        <c:otherwise>
                            <label style="font-size: 11px"
                                   class="bg-danger text-white font-weight-bold d-flex align-items-center ml-2 mb-0 p-1">Incomplete</label>
                        </c:otherwise>
                    </c:choose>
                </div>
                <p class="text-break mb-1">${course.shortDescription}</p>
                <a href="<c:url value="/courses/${course.category.parent.slug}/${course.category.slug}" />"><p
                        class="course-row--category">${course.category.name}</p></a>
                <c:if test="${course.complete}">
                    <ul class="list-dot p-0 mb-2">
                        <li><span class="rating">
                            <span class="font-weight-bold">${course.avgRating}</span>
                            <div class="starrr" data-rating="${course.avgRating}"></div>
                            </span><small>(${course.ratingCount}) </small>
                        </li>
                        <li><small>${course.studentCount} students </small></li>
                        <li><small>${course.level}</small></li>
                    </ul>
                </c:if>
                <p class="price">$${course.price}</p>
            </div>
            <a href="<c:url value="/teacher/manage/${course.id}/details" />"
               class="${course.disabled ? "d-none": "d-flex"} hover-darker p-3 font-weight-bold align-items-center text-decoration-none flex-shrink-0">
                <span><i class="fas fa-cog mr-1"></i> Edit / manage course</span>
            </a>
        </div>
    </div>
</div>