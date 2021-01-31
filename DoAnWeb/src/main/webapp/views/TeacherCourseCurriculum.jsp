<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<t:genericpage>
    <jsp:attribute name="head">
        <link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <link href="//cdn.quilljs.com/1.3.6/quill.bubble.css" rel="stylesheet">
    </jsp:attribute>
    <jsp:attribute name="beforeMainJs">
        <script>
            <c:forEach items="${requestScope.course.sections}" var="section">
            initEditors.push({selector: '#new-lesson-quill${section.id}'})
            <c:forEach items="${section.lessons}" var="lesson">
            initEditors.push({selector: '#quill${lesson.id}', value: '${lesson.description}'})
            </c:forEach>
            </c:forEach>
        </script>
    </jsp:attribute>
    <jsp:body>
        <main class="d-flex">
            <div class="teacher-nav m-3 flex-grow-1 flex-shrink-0">
                <ul class="list-unstyled m-0 my-3">
                    <li class="mb-3">
                        <a href="<c:url value="/teacher/manage/${requestScope.course.id}/details" />"
                           class="font-weight-bold a-unstyled">
                            <i style="width: 20px;"
                               class="fas fa-info mr-2"></i> Basic Information</a>
                    </li>
                    <li class="active-color">
                        <a href="#"
                           class="font-weight-bold a-unstyled"><i style="width: 20px;" class=" fas
                                                                               fa-book-open mr-2"></i> Curriculum</a>
                    </li>
                </ul>
                <hr/>
                <c:if test="${!requestScope.course.complete}">
                    <form method="post" action="<c:url value="/teacher/submit"/>">
                        <input type="hidden" name="courseId" value="${requestScope.course.id}">
                        <button id="publish-button" class="w-100 btn btn-info text-white font-weight-bold">
                            Publish course
                        </button>
                    </form>
                </c:if>
                <form method="post" action="<c:url value="/teacher/delete"/>">
                    <input type="hidden" name="courseId" value="${requestScope.course.id}">
                    <button id="delete-button" class="w-100 btn btn-danger text-white font-weight-bold">
                        Delete course
                    </button>
                </form>
                <a class="font-weight-bold text-secondary text-decoration-none"
                   href="<c:url value="/teacher/courses" />">
                    <i class="fas fa-angle-left mr-2"></i> Back to courses</a>
            </div>
            <div class="container-fluid my-3 w-100 h-fit">
                <div class="bg-white shadow-sm p-3 mb-3">
                    <h5 class="active-color font-weight-bold mb-0">
                        Edit course
                        <small class="mt-2 text-secondary font-weight-bold d-block">${requestScope.course.name}</small>
                    </h5>
                </div>
                <div class="bg-white shadow-sm mb-3" id="curriculum">
                    <div class="border-bottom p-3">
                        <div class="d-flex align-items-center justify-content-between">
                            <h5 class="mb-0">Course Curriculum</h5>
                            <button type="button"
                                    id="new-section-btn"
                                    class="btn btn-info text-white font-weight-bold rounded-pill"
                                    data-toggle="collapse" data-target="#new-section--form" aria-expanded="false"
                                    aria-controls="new-section--form">
                                New section
                            </button>
                        </div>
                        <form data-parent="#curriculum" method="post" action="<c:url value="/teacher/add-section" />"
                              id="new-section--form" class="mt-2 collapse">
                            <input type="hidden" name="courseId" value="${requestScope.course.id}">
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label for="name">Section name</label>
                                        <input required class="form-control outline-none" name="name" id="name"
                                               type="text">
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="form-group">
                                        <label for="row-order">Row order</label>
                                        <input required class="form-control outline-none" name="row-order"
                                               id="row-order"
                                               type="number" step="1">
                                    </div>
                                </div>
                            </div>
                            <div class="text-right">
                                <button class="btn save btn-outline-info font-weight-bold">Save</button>
                            </div>
                        </form>
                    </div>
                    <div class="card-body mb-3 p-4">
                        <p>Start putting together your course by creating sections, lectures and practice (quizzes,
                            coding exercises and assignments).</p>
                        <c:choose>
                            <c:when test="${requestScope.course.sections.isEmpty()}">
                                <div class="p-3 text-center bg-grey rounded">
                                    <h4 class="font-weight-bold">Nothing to see here</h4>
                                    <p class="text-secondary">Your section list is empty!</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${requestScope.course.sections}" var="section">
                                    <div class="p-3 bg-grey mb-4">
                                        <div>
                                            <strong>Section:</strong> ${section.name} (order: ${section.rowOrder})
                                            <button class="btn outline-none" data-toggle="collapse"
                                                    data-target="#section${section.id}">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <form class="d-inline" method="post"
                                                  action="<c:url value="/teacher/delete-section" />">
                                                <input type="hidden" name="courseId"
                                                       value="${requestScope.course.id}">
                                                <input type="hidden" name="sectionId" value="${section.id}">
                                                <button class="btn outline-none">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </form>
                                        </div>
                                        <form data-parent="#curriculum" method="post"
                                              action="<c:url value="/teacher/update-section" />"
                                              id="section${section.id}" class="mt-2 collapse">
                                            <input type="hidden" name="courseId" value="${requestScope.course.id}">
                                            <input type="hidden" name="sectionId" value="${section.id}">
                                            <div class="row">
                                                <div class="col">
                                                    <div class="form-group">
                                                        <label for="name${section.id}">Section name</label>
                                                        <input required class="form-control outline-none" name="name"
                                                               id="name${section.id}"
                                                               type="text" value="${section.name}">
                                                    </div>
                                                </div>
                                                <div class="col-3">
                                                    <div class="form-group">
                                                        <label for="row-order${section.id}">Row order</label>
                                                        <input required class="form-control outline-none"
                                                               name="row-order"
                                                               id="row-order${section.id}"
                                                               type="number" value="${section.rowOrder}" step="1">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="text-right">
                                                <button class="btn save btn-outline-info font-weight-bold">Save</button>
                                            </div>
                                        </form>
                                        <c:forEach items="${section.lessons}" var="lesson">
                                            <div class="my-2 p-3 bg-white border">
                                                <strong>Lesson:</strong> ${lesson.name} (order: ${lesson.rowOrder})
                                                <button class="btn outline-none" data-toggle="collapse"
                                                        data-target="#lesson${lesson.id}">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <form class="d-inline" method="post"
                                                      action="<c:url value="/teacher/delete-lesson" />">
                                                    <input type="hidden" name="courseId"
                                                           value="${requestScope.course.id}">
                                                    <input type="hidden" name="sectionId" value="${section.id}">
                                                    <input type="hidden" name="lessonId" value="${lesson.id}">
                                                    <button class="btn outline-none">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </form>
                                            </div>
                                            <form data-parent="#curriculum" method="post"
                                                  action="<c:url value="/teacher/update-lesson" />"
                                                  id="lesson${lesson.id}"
                                                  class="lesson mt-2 mb-0 bg-white border collapse">
                                                <div class="p-2">
                                                    <input type="hidden" name="courseId"
                                                           value="${requestScope.course.id}">
                                                    <input type="hidden" name="sectionId" value="${section.id}">
                                                    <input type="hidden" name="lessonId" value="${lesson.id}">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label for="name${lesson.id}">Lesson name</label>
                                                                <input required
                                                                       class="form-control bg-light outline-none"
                                                                       name="name"
                                                                       id="name${lesson.id}"
                                                                       type="text" value="${lesson.name}">
                                                            </div>
                                                        </div>
                                                        <div class="col-3">
                                                            <div class="form-group">
                                                                <label for="row-order${lesson.id}">Row order</label>
                                                                <input required
                                                                       class="form-control bg-light outline-none"
                                                                       name="row-order" value="${lesson.rowOrder}"
                                                                       id="row-order${lesson.id}"
                                                                       type="number" step="1">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="lesson-video-url${lesson.id}">Video (.mp4)</label>
                                                        <div>
                                                            <label class="btn btn-info text-white font-weight-bold"
                                                                   for="lesson-video${lesson.id}">Browse</label>
                                                            <span>${empty lesson.videoUrl ? "Not uploaded yet" : "Uploaded"}</span>
                                                        </div>
                                                        <input type="hidden" value="${lesson.videoUrl}"
                                                               name="video-url"
                                                               id="lesson-video-url${lesson.id}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="description${lesson.id}">Course description</label>
                                                        <div>
                                                            <input type="hidden" id="description${lesson.id}"
                                                                   name="description">
                                                            <div id="quill${lesson.id}" class="quill"></div>
                                                        </div>
                                                    </div>
                                                    <div class="text-right">
                                                        <button class="btn save btn-outline-info font-weight-bold">Save
                                                        </button>
                                                    </div>
                                                </div>
                                            </form>
                                            <form id="lesson-video-form${lesson.id}" class="d-none lesson-video"
                                                  enctype="multipart/form-data" method="post"
                                                  action="<c:url value="/upload" />">
                                                <input type="file" name="video" class="video-upload"
                                                       id="lesson-video${lesson.id}">
                                            </form>
                                        </c:forEach>
                                        <button data-toggle="collapse" data-target="#new-lesson${section.id}"
                                                class="btn btn-block new-lesson active-color outline-none mt-2">
                                            ＋ Add new lesson
                                        </button>
                                        <form data-parent="#curriculum" method="post"
                                              action="<c:url value="/teacher/add-lesson" />"
                                              id="new-lesson${section.id}"
                                              class="lesson mt-2 mb-0 bg-white border collapse">
                                            <div class="p-2">
                                                <input type="hidden" name="courseId" value="${requestScope.course.id}">
                                                <input type="hidden" name="sectionId" value="${section.id}">
                                                <div class="row">
                                                    <div class="col">
                                                        <div class="form-group">
                                                            <label for="new-lesson-name${section.id}">Lesson
                                                                name</label>
                                                            <input required class="form-control bg-light outline-none"
                                                                   name="name"
                                                                   id="new-lesson-name${section.id}"
                                                                   type="text">
                                                        </div>
                                                    </div>
                                                    <div class="col-3">
                                                        <div class="form-group">
                                                            <label for="new-lesson-row-order${section.id}">Row
                                                                order</label>
                                                            <input required class="form-control bg-light outline-none"
                                                                   name="row-order"
                                                                   id="new-lesson-row-order${section.id}"
                                                                   type="number" step="1">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="new-lesson-video-url${section.id}">Video (.mp4)</label>
                                                    <div>
                                                        <label class="btn btn-info text-white font-weight-bold mr-2"
                                                               for="new-lesson-video${section.id}">Browse</label>
                                                        <span>No video selected</span>
                                                    </div>
                                                    <input type="hidden"
                                                           name="video-url"
                                                           id="new-lesson-video-url${section.id}">
                                                </div>
                                                <div class="form-group">
                                                    <label for="description${section.id}">Course description</label>
                                                    <div>
                                                        <input type="hidden" id="description${section.id}"
                                                               name="description">
                                                        <div id="new-lesson-quill${section.id}" class="quill"></div>
                                                    </div>
                                                </div>
                                                <div class="text-right">
                                                    <button class="btn save btn-outline-info font-weight-bold">Save
                                                    </button>
                                                </div>
                                            </div>
                                        </form>
                                        <form id="new-lesson-video-form${section.id}" class="d-none lesson-video"
                                              enctype="multipart/form-data" method="post"
                                              action="<c:url value="/upload" />">
                                            <input type="file" name="video" class="video-upload"
                                                   id="new-lesson-video${section.id}">
                                        </form>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </main>
    </jsp:body>
</t:genericpage>
