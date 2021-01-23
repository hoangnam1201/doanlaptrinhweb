<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<header class="position-sticky" style="top:0;z-index: 999;">
    <div class="header">
        <div class="position-relative d-block d-md-none ml-2">
            <input id="header-mobile-toggle" class="header-mobile-toggle" type="checkbox">
            <label id="drawer-toggle" for="header-mobile-toggle"></label>
            <label id="icon" for="header-mobile-toggle">
                <i class="fas fa-bars"></i>
            </label>
            <div class="drawer">
                <nav class="sidebar--mobile">
                    <div class="sidebar--mobile-profile">
                    </div>
                </nav>
            </div>
        </div>
        <a class="flex-shrink-0" href="${pageContext.request.contextPath}/">
            <img alt="logo" width="100" src="https://www.udemy.com/staticx/udemy/images/v6/logo-coral.svg">
        </a>
        <nav class="header-dropdown-wrapper d-none d-md-flex">
            <button id="category-button" class="header-dropdown-button btn">
                Categories
            </button>
            <div class="header-dropdown-menu">
                <ul class="list-unstyled m-0">
                    <c:forEach items="${requestScope.categoryList}" var="cat">
                        <li>
                            <a href="${pageContext.request.contextPath}/courses/${cat.slug}"
                               class="primary-category-item category-item text-inherit text-decoration-none">
                                <div class="category-content">
                                        ${cat.name}
                                </div>
                                <i class="fas fa-chevron-right"></i>
                            </a>
                            <div class="header-dropdown-menu sub-category">
                                <ul class="list-unstyled m-0">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/courses/${cat.slug}"
                                           class="category-item text-inherit text-decoration-none">
                                            <div class="category-content">
                                                All ${cat.name}
                                            </div>
                                        </a>
                                    </li>
                                    <c:forEach items="${cat.children}" var="subCat">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/courses/${cat.slug}/${subCat.slug}"
                                               class="category-item text-inherit text-decoration-none">
                                                <div class="category-content">
                                                        ${subCat.name}
                                                </div>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </nav>
        <div class="flex-fill header-search d-none d-md-block">
            <form class="h-100 d-flex align-items-center border rounded" method="get" action="search">
                <input placeholder="Search for anything" name="q"
                       type="text" class="pl-3 header-search-input flex-fill pr-3">
                <button class="ml-2 h-100 btn rounded-0 outline-none bg-active text-white">
                    <i class="fas fa-search"></i>
                </button>
            </form>
        </div>
        <c:choose>
            <c:when test="${sessionScope.auth}">
                <form class="d-none" id="frmLogout" method="post"
                      action="${pageContext.request.contextPath}/account/logout"></form>
                <div class="dropdown h-100">
                    <button class="btn border-left dropdown-toggle user-btn h-100 outline-none" type="button"
                            id="dropdown-user--button"
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fas fa-user mr-3"></i>${authUser.name}
                    </button>
                    <div class="dropdown-menu dropdown-menu-right dropdown-user mt-0"
                         aria-labelledby="dropdown-user--button">
                        <div class="border-bottom">
                            <a class="a-unstyled"
                               href="${pageContext.request.contextPath}/account/profile">Profile</a>
                        </div>
                        <c:if test="${sessionScope.authUser.role != 'admin'}">
                            <div class="border-bottom">
                                <a class="a-unstyled"
                                   href="${pageContext.request.contextPath}/account/learning">My learning</a>
                                <a class="a-unstyled"
                                   href="${pageContext.request.contextPath}/account/wishlist">Wishlist</a>
                            </div>
                        </c:if>
                        <c:if test="${sessionScope.authUser.role.equals('admin')}">
                            <div class="border-bottom">
                                <a class="a-unstyled" href="${pageContext.request.contextPath}/admin/managercat">My
                                    Categories</a>
                                <a class="a-unstyled" href="${pageContext.request.contextPath}/admin/managercourse">My
                                    Courses</a>
                                <a class="a-unstyled"
                                   href="${pageContext.request.contextPath}/admin/manageruser">Users</a>
                            </div>
                        </c:if>
                        <c:if test="${sessionScope.authUser.role.equals('teacher')}">
                            <div class="border-bottom">
                                <a class="a-unstyled" href="${pageContext.request.contextPath}/teacher/courses">My
                                    courses</a>
                                <a class="a-unstyled"
                                   href="${pageContext.request.contextPath}/teacher/create">Create course</a>
                            </div>
                        </c:if>
                        <a class="a-unstyled" href="javascript:$('#frmLogout').submit();">Log Out</a>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="d-none d-md-block">
                    <a class="header-button btn header-login-button"
                       href="${pageContext.request.contextPath}/account/login" role="button">Log in</a>
                    <a class="header-button btn header-signup-button"
                       href="${pageContext.request.contextPath}/account/register" role="button">Sign up</a>
                </div>
                <div class="d-md-none"></div>
            </c:otherwise>
        </c:choose>
    </div>
</header>