<%@tag description="Slide nhieu khoa hoc" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@attribute name="course" required="true" type="com.udemy.model.Course" %>

<div class="col-3">
    <div class="a-unstyled bg-grey course-card--container">
        <div>
            <a href="<c:url value="/course/${course.slug}"/>">
                <img class="course-card--image"
                     src="<c:url value="/static/images/${course.image}" />"
                     alt="Card image cap">
            </a>
            <div class="card-body py-2 px-3">
                <div class="mb-1">
                    <a href="<c:url value="/courses/${course.category.slug}"/>"
                       class="course-card--category">${course.category.name}</a>
                </div>
                <div>
                    <a href="<c:url value="/course/${course.slug}"/>"
                       class="a-unstyled course-card--title">${course.name}</a>
                </div>
                <div>
                    <small class="text-muted">by
                        <a href="${course.teacher.slug}}">${course.teacher.username}</a>
                    </small>
                </div>
                <div class="mt-1 d-flex align-items-center">
                                        <span class="rating">
                                            <span class="font-weight-bold">${course.avgRating}</span>
                                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star-half-alt"></i>
                                        </span>
                    <small>(${course.ratingCount})</small>
                </div>
                <div class="mt-1">
                    <small class="d-block">
                        ${course.studentCount} students
                    </small>
                </div>
                <div class="mt-3 d-flex justify-content-between align-items-center">
                    <p class="price">$${course.price}</p>
                    <button class="btn p-0  outline-none"><i class="fas fa-cart-plus"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
