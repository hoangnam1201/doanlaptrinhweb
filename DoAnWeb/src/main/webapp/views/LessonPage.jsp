<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<html>
<head>
    <jsp:include page="common/head.jsp"/>
    <link href="https://vjs.zencdn.net/7.10.2/video-js.css" rel="stylesheet"/>
</head>
<body>
<div class="d-flex min-vh-100">
    <form method="post" action="<c:url value="/course/rating" />"
          id="rating-form" role="dialog" class="modal fade pr-0">
        <div class="modal-dialog" role="document">
            <div class="modal-content border rounded bg-white">
                <div id="message"></div>
                <input type="hidden" name="courseId" value="${param.id}">
                <div class="bg-grey p-4 border-bottom">Review this course</div>
                <div class="p-3">
                    <input required min="0" step="1" value="${requestScope.enrollment.rating}" class="form-control mb-2"
                           type="number"
                           name="rating">
                    <textarea required class="form-control" type="text" name="comment" placeholder="comment"
                              rows="6">${requestScope.enrollment.comment}</textarea>
                </div>
                <div class="p-4 text-right">
                    <button data-toggle="modal" data-target="#rating-form"
                            type="button" class="btn text-active font-weight-bold mr-2">Cancel
                    </button>
                    <button class="btn btn-info text-white font-weight-bold">Submit</button>
                </div>
            </div>
        </div>
    </form>
    <div class="d-none d-lg-block">
        <nav class="lesson-sidebar position-sticky">
            <jsp:include page="common/lessonsidebar.jsp"/>
        </nav>
    </div>
    <main class="lesson-wrapper">
        <nav id="top-bar">
            <div class="d-none d-lg-block"></div>
            <div class="d-block d-lg-none">
                <input id="header-mobile-toggle" class="header-mobile-toggle" type="checkbox">
                <label id="drawer-toggle" for="header-mobile-toggle"></label>
                <label class="text-white" id="icon" for="header-mobile-toggle">
                    <i class="fas fa-bars"></i>
                </label>
                <div class="drawer">
                    <nav class="sidebar--mobile d-block lesson-sidebar">
                        <jsp:include page="common/lessonsidebar.jsp"/>
                    </nav>
                </div>
            </div>
            <a href="<c:url value="/"/>">
                <img alt="logo" src="https://www.udemy.com/staticx/udemy/images/v6/logo-coral-light.svg" width="110"
                     height="32">
            </a>
            <c:choose>
                <c:when test="${requestScope.enrolled}">
                    <button data-toggle="modal" data-target="#rating-form"
                            class="d-none d-md-block btn text-white font-weight-bold outline-none">
                            ${requestScope.enrollment.rating == 0 ? "Leave a rating":"Edit your rating"}
                    </button>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value="/teacher/manage/${requestScope.course.id}/details" />"
                       class="d-none d-md-block btn text-white font-weight-bold outline-none">Edit course</a>
                </c:otherwise>
            </c:choose>
            <div class="d-block d-md-none"></div>
        </nav>
        <div class="lesson-content-area">
            <h5 class="lesson-title">Lesson: <strong>${requestScope.lesson.name}</strong></h5>
            <div class="p-1 p-md-3 mx-2 mx-lg-4 mx-xl-5">
                <video
                        id="my-video"
                        class="video-js"
                        controls
                        preload="auto"
                        data-setup='{"fluid": true}'
                >
                    <source src="${requestScope.lesson.videoUrl}" type="video/mp4"/>
                    <p class="vjs-no-js">
                        To view this video please enable JavaScript, and consider upgrading to a
                        web browser that
                        <a href="https://videojs.com/html5-video-support/" target="_blank"
                        >supports HTML5 video</a
                        >
                    </p>
                </video>
            </div>
            <div id="description">
                <h5 class="course-info-heading">Description</h5>
                <hr/>
            </div>
        </div>
    </main>
</div>
<script src="https://vjs.zencdn.net/7.10.2/video.min.js"></script>
<jsp:include page="common/script.jsp"/>
<script type="text/javascript" src="<c:url value="/static/scripts/main.js"/>"></script>
<script>
    $("#description").append(quillGetHTML('${requestScope.lesson.description}'))
</script>
</body>
</html>