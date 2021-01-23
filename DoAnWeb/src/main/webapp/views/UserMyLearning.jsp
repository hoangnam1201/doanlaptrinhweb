<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<t:genericpage>
    <jsp:attribute name="js">
        <script src="<c:url value="/static/scripts/main.js"/>"></script>
    </jsp:attribute>
    <jsp:body>
        <style>
            ul li:hover{
                background-color: #00aced;
            }
            body{
                background: cadetblue;
            }
        </style>
        <main>
            <h2 class="text-center font-weight-bold my-5">My learning</h2>
            <div class="bg-white border shadow-sm container-fluid py-3 mb-5">
                <ul class="nav nav-tabs w-100 pt-3 my-3 mr-0">
                    <li class="nav-item"><a href="#" class="nav-link">My Courses</a></li>
                    <li class="nav-item"><a href="#" class="nav-link">WishList</a></li>
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
                                <t:multicourseunit course="${course}"/>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </jsp:body>
</t:genericpage>
