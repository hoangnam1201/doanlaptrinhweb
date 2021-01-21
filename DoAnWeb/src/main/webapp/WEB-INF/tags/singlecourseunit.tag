<%@tag description="Slide 1 khoa hoc" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@attribute name="course" required="true" type="com.udemy.model.Course" %>

<a href="${pageContext.request.contextPath}/course/${course.id}"
   class="a-unstyled single-course--container flex-column flex-sm-row">
    <div>
        <img alt="" src="<c:url value="/images/${course.image}" />" class="mw-100" width="470"
             height="250">
    </div>
    <div class="featured-course-content mt-3 ml-1 ml-sm-3 mt-sm-0">
        <div>
            <div class="single-course--category">${course.category.name}</div>
            <h5 class="font-weight-bold">${course.name}</h5>
            <p class="m-0">${course.shortDescription}</p>
            <small>by <span class="active-color">${course.teacher.name}</span></small>
            <ul class="list-dot p-0">
                <li><span class="rating">
                                <span class="font-weight-bold">${course.avgRating}</span>
                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i
                        class="fas fa-star"></i><i class="fas fa-star-half-alt"></i></span><small>(${course.ratingCount}) </small></li>
                <li><small>${course.studentCount} students </small></li>
                <li><small>${course.level}</small></li>
            </ul>
        </div>
        <p class="price">
            $${course.price}
        </p>
    </div>
</a>