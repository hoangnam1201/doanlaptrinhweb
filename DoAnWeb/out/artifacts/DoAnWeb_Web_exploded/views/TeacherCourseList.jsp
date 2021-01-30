<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<t:genericpage>
    <jsp:attribute name="js">
        <script src="<c:url value="/static/scripts/main.js"/>"></script>
    </jsp:attribute>
    <jsp:body>
        <main>
            <h2 class="text-center font-weight-bold my-5">My courses</h2>
            <div class="bg-white border shadow-sm container-fluid py-3 mb-5">
                <a href="<c:url value="/teacher/create" />"
                   class="btn btn-info text-white font-weight-bold float-right">New
                    course</a>
                <ul class="nav nav-tabs w-100 pt-3 my-3 mr-0">
                    <li class="nav-item"><a href="#" class="nav-link active">All courses</a></li>
                </ul>
                <c:choose>
                    <c:when test="${requestScope.courseList.isEmpty()}">
                        <div class="p-3 text-center bg-grey rounded">
                            <h4 class="font-weight-bold">Nothing to see here</h4>
                            <p class="text-secondary">Your course list is empty!</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div>
                            <c:forEach items="${requestScope.courseList}" var="course">
                                <t:mycourse course="${course}"/>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </jsp:body>
</t:genericpage>
