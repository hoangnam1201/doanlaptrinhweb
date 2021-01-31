<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<c:set var="page" value="${requestScope.page}"/>
<c:set var="user" value="${sessionScope.authUser}"/>
<c:set var="userWithWishlist" value="${requestScope.user}"/>

<t:genericpage>
    <jsp:attribute name="js">
        <script src="<c:url value="/static/scripts/main.js"/>"></script>
    </jsp:attribute>
    <jsp:body>
        <main>
            <h2 class="text-center font-weight-bold my-5">${requestScope.page}</h2>
            <div class="bg-white border shadow-sm container-fluid py-3 mb-5">
                <ul class="nav nav-tabs w-100 pt-3 my-3 mr-0">
                    <c:choose>
                        <c:when test='${requestScope.page == "My learning"}'>
                            <li class="nav-item"><a href="#" class="active nav-link">My Courses</a></li>
                            <li class="nav-item"><a href="<c:url value="/account/wishlist" />"
                                                    class="nav-link">Wishlist</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a href="<c:url value="/account/learning" />" class="nav-link">My
                                Courses</a></li>
                            <li class="nav-item "><a href="#" class="nav-link active">Wishlist</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
                <c:choose>
                    <c:when test="${(page.equals('Wishlist')&&userWithWishlist.wishlist.size()==0)||
            (page.equals('My learning')&&requestScope.user.enrollments.size()==0)}">
                        <div class="p-3 text-center bg-grey rounded">
                            <h4 class="font-weight-bold">Nothing to see here</h4>
                            <p class="text-secondary">
                                Your ${page.equals("Wishlist") ? "wishlist" : "enrolled course list"} is
                                empty!</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="d-flex flex-wrap">
                            <c:choose>
                                <c:when test="${page.equals('Wishlist')}">
                                    <c:forEach items="${userWithWishlist.wishlist}" var="wishlist">
                                        <div class="col-3 my-list mb-3">
                                            <t:multicourseunit course="${wishlist.course}"/>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${requestScope.user.enrollments}" var="enrollment">
                                        <div class="col-3 my-list mb-3">
                                            <t:multicourseunit course="${enrollment.course}"/>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </jsp:body>
</t:genericpage>
