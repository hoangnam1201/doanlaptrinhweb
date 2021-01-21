<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<t:genericpage>
    <jsp:attribute name="head">
        <link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <link href="//cdn.quilljs.com/1.3.6/quill.bubble.css" rel="stylesheet">
    </jsp:attribute>
    <jsp:attribute name="js">
        <script>
            <c:if test="${!requestScope.create}">
            editor.setContents(${requestScope.course.description});
            $("#create-course #language").val('${requestScope.course.language}')
            $("#create-course #level").val('${requestScope.course.level}')
            $("#create-course #category").attr("subcategory-id", ${requestScope.course.category.id});
            $("#create-course #category").val('${requestScope.course.category.parent.id}').trigger('change');
            </c:if>
        </script>
    </jsp:attribute>
    <jsp:body>
        <main class="${requestScope.create ?"": "d-flex mb-5"}">
            <c:if test="${!requestScope.create}">
                <div class="teacher-nav m-3 flex-grow-1 flex-shrink-0">
                    <ul class="list-unstyled m-0 my-3">
                        <li class="active-color mb-3">
                            <a href="#" class="font-weight-bold a-unstyled">
                                <i style="width: 20px;"
                                   class="fas fa-info mr-2"></i> Basic Information</a>
                        </li>
                        <li>
                            <a href="<c:url value="/teacher/manage/${requestScope.course.id}/curriculum" />"
                               class="font-weight-bold a-unstyled"><i style="width: 20px;" class=" fas
                                                                               fa-book-open mr-2"></i> Curriculum</a>
                        </li>
                    </ul>
                    <hr/>
                    <c:if test="${!requestScope.course.complete}">
                        <form method="post"
                              action="<c:url value="/teacher/submit?courseId=${requestScope.course.id}"/>">
                            <button id="publish-button" class="w-100 btn btn-info text-white font-weight-bold">
                                Publish course
                            </button>
                        </form>
                    </c:if>
                    <form method="post" action="<c:url value="/teacher/delete?courseId=${requestScope.course.id}"/>">
                        <button id="delete-button" class="w-100 btn btn-danger text-white font-weight-bold">
                            Delete course
                        </button>
                    </form>
                    <a class="font-weight-bold text-secondary text-decoration-none"
                       href="<c:url value="/teacher/courses" />">
                        <i class="fas fa-angle-left mr-2"></i> Back to courses</a>
                </div>
            </c:if>
            <div class="container-fluid my-3 w-100 h-fit">
                <c:choose>
                <c:when test="${requestScope.create}">
                <form method="post" id="create-course" enctype="multipart/form-data">
                    </c:when>
                    <c:otherwise>
                    <form method="post" id="create-course" enctype="multipart/form-data"
                          action="<c:url value="/teacher/update-details" />">
                        <input type="hidden" name="courseId" value="${requestScope.course.id}">
                        </c:otherwise>
                        </c:choose>
                        <div class="bg-white shadow-sm p-3 mb-3">
                            <h5 class="active-color font-weight-bold mb-0">
                                <c:choose>
                                    <c:when test="${requestScope.create}">Create new course</c:when>
                                    <c:otherwise>Edit course
                                        <small class="mt-2 text-secondary font-weight-bold d-block">${requestScope.course.name}</small></c:otherwise>
                                </c:choose>
                            </h5>
                        </div>
                        <c:if test="${requestScope.success}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                Successfully ${requestScope.create?"created":"saved"}!
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </c:if>
                        <div class="bg-white shadow-sm mb-3">
                            <div class="border-bottom p-3">
                                <h5 class="mb-0">Course Details</h5>
                            </div>
                            <div class="card-body mb-3">
                                <div class="row">
                                    <div class="col-12 col-md mb-3">
                                        <label for="name">Course name</label>
                                        <input value="${requestScope.create ? "" : requestScope.course.name}"
                                               class="form-control outline-none"
                                               maxlength="50" name="name" id="name"
                                               type="text">
                                    </div>
                                    <div class="col-12 col-md-3 mb-3">
                                        <label for="price">Course price (USD)</label>
                                        <input value="${requestScope.create ? "" : requestScope.course.price}"
                                               class="form-control outline-none" name="price" id="price"
                                               type="number" step="0.01">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="short-description">Short description</label>
                                    <input value="${requestScope.create ? "" : requestScope.course.shortDescription}"
                                           class="form-control outline-none" maxlength="150"
                                           placeholder="Maximum 150 characters..."
                                           name="short-description"
                                           id="short-description" type="text">
                                </div>
                                <div class="form-group">
                                    <label for="description">Course description</label>
                                    <div>
                                        <input type="hidden" id="description" name="description">
                                        <div id="quill"></div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-4">
                                        <label>Language</label>
                                        <select class="form-control outline-none" id="language" name="language">
                                            <option>English</option>
                                            <option>Tiếng Việt</option>
                                        </select>
                                    </div>
                                    <div class="col-4">
                                        <label>Level</label>
                                        <select class="form-control outline-none" id="level" name="level">
                                            <option>Beginner Level</option>
                                            <option>Intermediate Level</option>
                                            <option>Expert Level</option>
                                            <option>All Levels</option>
                                        </select>
                                    </div>
                                    <div class="col-4">
                                        <div class="form-group">
                                            <label>Category</label>
                                            <select id="category" class="form-control outline-none" name="category">
                                                <c:forEach items="${requestScope.categoryList}" var="category">
                                                    <option value="${category.id}">${category.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <select id="subcategory" class="form-control outline-none"
                                                    name="subcategory">
                                                <option selected disabled value="">-- Subcategory --</option>
                                                <c:if test="${!requestScope.categoryList.isEmpty()}">
                                                    <c:forEach items="${requestScope.categoryList.get(0).children}"
                                                               var="category">
                                                        <option value="${category.id}">${category.name}</option>
                                                    </c:forEach>
                                                </c:if>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="learn-goal">What will students learn in your course?</label>
                                    <textarea class="form-control outline-none" rows="3" name="learn-goal"
                                              id="learn-goal">${requestScope.create?"":requestScope.course.learnGoals}</textarea>
                                </div>
                                <div class="form-group">
                                    <label for="requirements">Are there any course requirements or
                                        prerequisites?</label>
                                    <textarea class="form-control outline-none" rows="3" name="requirements"
                                              id="requirements">${requestScope.create?"":requestScope.course.requirements}</textarea>
                                </div>
                                <div class="form-group">
                                    <label for="target-students">Who are your target students?</label>
                                    <textarea class="form-control outline-none" rows="3" name="target-students"
                                              id="target-students">${requestScope.create?"":requestScope.course.targetStudents}</textarea>
                                </div>
                                <div class="form-group">
                                    <label for="image">Image</label>
                                    <div class="border rounded p-2">
                                        <input accept=".png,.jpg,.jpeg" type="file"
                                               id="image" name="image"></div>
                                </div>
                                <hr/>
                                <div class="text-right">
                                    <button class="btn btn-info font-weight-bold text-white">
                                            ${requestScope.create?"Create course":"Save"}
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
            </div>
        </main>
    </jsp:body>
</t:genericpage>
