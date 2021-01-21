<%@tag description="Slide nhieu khoa hoc" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@attribute name="course" required="true" type="com.udemy.model.Course" %>

<div class="a-unstyled course-card--container">
    <div>
        <a href="<c:url value="/course/${course.id}"/>">
            <img class="course-card--image"
                 src="<c:url value="/images/${course.image}" />"
                 alt="Card image cap">
        </a>
        <div class="card-body py-2 px-3 border-top">
            <div class="mb-1">
                <a href="<c:url value="/courses/${course.category.parent.slug}/${course.category.slug}"/>"
                   class="course-card--category">${course.category.name}</a>
            </div>
            <div>
                <a href="<c:url value="/course/${course.id}"/>"
                   class="a-unstyled course-card--title">${course.name}</a>
            </div>
            <div>
                <small class="text-muted">by
                    <span class="active-color">${course.teacher.name}</span>
                </small>
            </div>
            <ul class="list-dot p-0">
                <li><span class="rating">
                                <span class="font-weight-bold">${course.avgRating}</span>
                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i
                        class="fas fa-star"></i><i class="fas fa-star-half-alt"></i></span><small>(${course.ratingCount}) </small>
                </li>
                <li><small>${course.studentCount} students </small></li>
                <li><small>${course.level}</small></li>
            </ul>
            <div class="mt-3 d-flex align-items-center">
                <p class="price">$${course.price}</p>
            </div>
        </div>
    </div>
</div>
