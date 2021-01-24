<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<c:set var="hasComment" scope="page" value="${false}"/>
<fmt:formatDate var="createdDate" value="${requestScope.course.createdAt}" pattern="MM/dd/yyyy"/>
<fmt:formatDate var="updatedDate" value="${requestScope.course.updatedAt}" pattern="MM/dd/yyyy"/>

<t:genericpage>
    <jsp:attribute name="js">
        <script>
            $("#description").html(quillGetHTML('${requestScope.course.description}'));
        </script>
    </jsp:attribute>
    <jsp:body>
        <main>
            <div class="course-banner">
                <div class="container-fluid p-0 d-flex flex-column-reverse flex-lg-row">
                    <div class="banner-content">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb px-0 mb-1">
                                <li class="breadcrumb-item"><a href="<c:url value="/" />">Home</a></li>
                                <li class="breadcrumb-item">
                                    <a href="<c:url value="/courses/${requestScope.course.category.parent.slug}" />">
                                            ${requestScope.course.category.parent.name}
                                    </a>
                                </li>
                                <li class="breadcrumb-item">
                                    <a href="<c:url value="/courses/${requestScope.course.category.parent.slug}/${requestScope.course.category.slug}" />">
                                            ${requestScope.course.category.name}
                                    </a>
                                </li>
                            </ol>
                        </nav>
                        <div class="banner-title">${requestScope.course.name}</div>
                        <div class="banner-short-description">${requestScope.course.shortDescription}</div>
                        <div class="my-2">

                            <span class="rating">
                                <span class="font-weight-bold">${requestScope.course.avgRating}</span>
                                <div class="starrr" data-rating="${requestScope.course.avgRating}" }></div></span>
                            <small>${requestScope.course.ratingCount} ratings</small>
                        </div>
                        <p><i class="fas fa-user mr-1"></i> by <strong>${requestScope.course.teacher.name}</strong></p>
                        <div class="w-100 mb-2"><i class="fas fa-clock d-inline-block mr-2" aria-hidden="true"></i>
                            Created on ${createdDate}</div>
                        <div class="w-100 mb-2"><i class="fa fa-bullhorn d-inline-block mr-2" aria-hidden="true"></i>
                            Last updated ${updatedDate}</div>
                        <div class="d-flex">
                            <div class="mr-3"><i class="fa fa-language d-inline-block mr-2"
                                                 aria-hidden="true"></i> ${requestScope.course.language}</div>
                            <div><i class="fas fa-signal d-inline-block mr-2"></i> ${requestScope.course.level}</div>
                        </div>
                        <div class="banner-price">
                            $${requestScope.course.price}
                        </div>
                        <div class="mt-2">
                            <div class="d-block d-lg-flex align-items-center">
                                <c:choose>
                                    <c:when test="${requestScope.course.teacher.id.equals(sessionScope.authUser.id)}">
                                        <a class="btn btn-info" id="enroll-btn"
                                           href="<c:url value="/teacher/manage/${requestScope.course.id}/details"/>">Edit
                                            course</a>
                                    </c:when>
                                    <c:otherwise>
                                        <c:choose>
                                            <c:when test="${requestScope.enrolled}">
                                                <button id="enroll-btn" disabled class="btn btn-secondary">Enrolled
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <form class="mb-0" method="post"
                                                      action="<c:url value="/course/enroll" />">
                                                    <input name="courseId" type="hidden"
                                                           value="${requestScope.course.id}">
                                                    <button type="submit" class="btn btn-danger"
                                                            data-target="${requestScope.course.id}"
                                                            id="enroll-btn">Enroll now
                                                    </button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${!requestScope.course.teacher.id.equals(sessionScope.authUser.id)}">
                                    <form class="mb-0" method="post"
                                          action="<c:url value="/course/${requestScope.wishlist?'remove-wishlist':'add-wishlist'}" />">
                                        <input name="courseId" type="hidden"
                                               value="${requestScope.course.id}">
                                        <button class="btn wishlist ml ml-lg-2">${requestScope.wishlist ? "Wishlisted" : "Wishlist"}
                                            <i class="${requestScope.wishlist?"fas":"far"} fa-heart d-inline-block ml-2"></i>
                                        </button>
                                    </form>
                                </c:if>
                            </div>
                            <p class="ml-1 mb-0 mt-2"><strong>${requestScope.course.studentCount}</strong> already
                                enrolled
                            </p>
                        </div>
                    </div>
                    <div class="banner-image">
                        <img src="<c:url value="/images/${requestScope.course.image}" />">
                    </div>
                </div>
            </div>
            <div class="p-0 bg-white border-bottom">
                <ul class="container-fluid nav nav-tabs course-tab border-0 px-2" role="tablist">
                    <li><a class="course-tab-item active show" data-toggle="tab" href="#about">About</a></li>
                    <li><a class="course-tab-item" data-toggle="tab" href="#content">Content</a></li>
                    <li><a class="course-tab-item" data-toggle="tab" href="#review">Reviews</a></li>
                    <li class="pr-0"><a class="course-tab-item" data-toggle="tab" href="#teacher">Teacher</a></li>
                </ul>
            </div>
            <div class="bg-white container-fluid border rounded py-4 px-0 p-md-4 my-3">
                <div class="col-md-8">
                    <div class="tab-content">
                        <div class="tab-pane show active" id="about" role="tabpanel">
                            <div class="border rounded mb-3 p-3 bg-grey read-more">
                                <h3 class="course-info-heading">What you'll learn</h3>
                                <ul class="learn-goal-list">
                                    <c:forEach items="${fn:split(requestScope.course.learnGoals,newLineChar)}"
                                               var="learnGoal">
                                        <li>${learnGoal}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <hr/>
                            <div class="mb-3">
                                <h3 class="course-info-heading read-more">Requirements</h3>
                                <ul>
                                    <c:forEach items="${fn:split(requestScope.course.requirements,newLineChar)}"
                                               var="requirement">
                                        <li>${requirement}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <hr/>
                            <div>
                                <h3 class="course-info-heading">Description</h3>
                                <div id="description" class="read-more">
                                </div>
                            </div>
                            <hr/>
                            <div class="mb-3">
                                <h3 class="course-info-heading read-more">Who this course is for</h3>
                                <ul>
                                    <c:forEach items="${fn:split(requestScope.course.targetStudents,newLineChar)}"
                                               var="target">
                                        <li>${target}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                        <div class="tab-pane" id="content" role="tabpanel">
                            <h3 class="course-info-heading">Course content</h3>
                            <hr/>
                            <div class="my-3 rounded border">
                                <c:choose>
                                    <c:when test="${requestScope.course.sections.size() == 0}">
                                        <h6 class="bg-grey p-3 mb-0 font-italic">
                                            This course doesn't have any content.
                                        </h6>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${requestScope.course.sections}" var="section">
                                            <div>
                                                <button data-toggle="collapse" data-target="#section${section.id}"
                                                        class="btn btn-block border-bottom p-2 pl-3 text-left font-weight-bold bg-grey">
                                                    <i class="fas fa-book mr-2"></i> ${section.name}
                                                </button>
                                                <div id="section${section.id}" class="pl-4 collapse">
                                                    <ul class="list-unstyled px-2 pt-2 m-0 border-top">
                                                        <c:forEach items="${section.lessons}" var="lesson">
                                                            <li class="p-1 mb-1">
                                                                <i class="fas fa-video mr-2"></i>
                                                                <c:choose>
                                                                    <c:when test="${requestScope.enrolled ||
                                                            requestScope.course.teacher.id.equals(sessionScope.authUser.id)}">
                                                                        <a href="<c:url value="/course/${requestScope.course.id}/learn/${lesson.id}" />">
                                                                                ${lesson.name}
                                                                        </a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ${lesson.name}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </li>
                                                        </c:forEach>
                                                    </ul>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="tab-pane" id="review" role="tabpanel">
                            <h3 class="course-info-heading">Student feedbacks</h3>
                            <c:forEach items="${requestScope.course.enrollments}" var="comment">
                                <c:if test="${comment.rating != 0}">
                                    <c:set var="hasComment" value="${true}"/>
                                    <hr/>
                                    <div class="d-flex">
                                        <div class="comment-user-icon">
                                            <i class="fa fa-user"></i>
                                        </div>
                                        <div class="mt-2">
                                            <div class="mb-1 font-weight-bold">${comment.user.name}
                                                <small class="mr-1">${comment.updatedAt.toLocaleString()}</small>
                                            </div>
                                            <div class="mb-2 rating">
                                                <div class="starrr" data-rating="${comment.rating}"></div>
                                            </div>
                                            <div style="white-space: pre-line" class="mb-3">${comment.comment}</div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                            <c:if test="${!hasComment}">
                                <p>This course doesn't have any reviews yet.</p>
                            </c:if>
                        </div>
                        <div class="tab-pane" id="teacher" role="tabpanel">
                            <h3 class="course-info-heading">About me</h3>
                            <hr/>
                            <div>
                                <div class="teacher-icon">
                                    <i class="fa fa-user-circle"></i>
                                </div>
                                <div class="teacher-name">
                                        ${requestScope.course.teacher.name}
                                </div>
                                <p class="teacher-job">
                                        ${requestScope.course.teacher.job}
                                </p>
                                <p class="teacher-bio read-more">${requestScope.course.teacher.bio}</p>
                            </div>
                        </div>
                    </div>
                </div>
                <c:if test="${requestScope.recommendation.size() != 0}">
                    <hr/>
                    <h3 class="course-info-heading px-3">Recommendation</h3>
                    <div class="multiple-carousel">
                        <c:forEach items="${requestScope.recommendation}" var="recommendation">
                            <t:multicourseunit course="${recommendation}"/>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </main>
    </jsp:body>
</t:genericpage>