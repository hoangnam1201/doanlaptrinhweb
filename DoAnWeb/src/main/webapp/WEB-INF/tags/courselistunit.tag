<%@tag description="Slide nhieu khoa hoc" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@attribute name="course" required="true" type="com.udemy.model.Course" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<a href="<c:url value="/course/${course.id}" />" class="course-row--container flex-column flex-md-row a-unstyled">
    <img width="300" src="<c:url value="/images/${course.image}"/>"
         alt="">
    <div class="p-2 flex-fill w-100">
        <h5 class="active-color font-weight-bold">${course.name}</h5>
        <p class="text-break mb-1">${course.shortDescription}</p>
        <small class="d-block">${course.teacher.name}</small>
        <p class="course-row--category">${course.category.name}</p>
        <ul class="list-dot p-0 mb-1">
            <li><span class="rating">
                    <span class="font-weight-bold">${course.avgRating}</span>
                    <div class="starrr" data-rating="${course.avgRating}"></div>
                    </span><small>(${course.ratingCount}) </small>
            </li>
            <li><small>${course.studentCount} students </small></li>
            <li><small>${course.level}</small></li>
        </ul>
        <p class="price">$${course.price}</p>
        <t:badge course="${course}" />
    </div>
</a>