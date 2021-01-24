<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<style>
    .sidenav {
        height: 100%;
        width: 0;
        position: fixed;
        z-index: 1;
        top: 0;
        left: 0;
        background-color: white;
        overflow-x: hidden;
        transition: 0.5s;
    }

    .sidenav a {
        padding: 8px 8px 8px 32px;
        text-decoration: none;
        font-size: 20px;
        color: black;
        display: block;
        transition: 0.3s;
    }

    .sidenav a:hover {
        color: #f1f1f1;
    }

    .sidenav .closebtn {
        font-size: 36px;
        text-align: right;
        line-height: 40px;
    }

    @media screen and (max-height: 450px) {
        .sidenav a {
            font-size: 18px;
        }
    }
</style>
<header class="position-sticky" style="top:0;z-index: 999;">
    <div class="header">
        <div class="position-relative d-block d-md-none ml-2 mr-2">
            <span style="position: sticky;  font-size:30px;cursor:pointer" onclick="openNav()">&#9776;</span>
        </div>
        <div id="mySidenav" class="sidenav">
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
            <div class="dropdown show">
                <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Categories
                </a>

                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                    <c:forEach items="${requestScope.categoryList}" var="cat">
                        <a class="dropdown-item text-inherit text-decoration-none"
                           href="${pageContext.request.contextPath}/courses/${cat.slug}">${cat.name}</a>
                    </c:forEach>
                </div>
                <c:choose>
                    <c:when test="${sessionScope.auth}">
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
                    </c:when>
                    <c:otherwise>
                        <div class="border-bottom">
                            <a class="a-unstyled" href="${pageContext.request.contextPath}/account/login">Login</a>
                            <a class="a-unstyled" href="${pageContext.request.contextPath}/account/register">Sign up</a>
                        </div>
                    </c:otherwise>
                </c:choose>
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
            <form class="h-100 d-flex align-items-center border rounded" method="get" action="<c:url value="/search"/>">
                <c:if test="${!empty requestScope.courseListPageInfo}">
                    <c:set var="pageInfo" value="${requestScope.courseListPageInfo}"/>
                    <c:if test="${not empty param.p}">
                        <input type="hidden" name="p" value="${pageInfo.currentPage}">
                    </c:if>
                    <c:if test="${not empty param.order}">
                        <input type="hidden" name="order" value="${pageInfo.searchString}">
                    </c:if>
                </c:if>
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
                    <button class="d-none d-md-block btn border-left dropdown-toggle user-btn h-100 outline-none"
                            type="button"
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
    <script>
        function openNav() {
            document.getElementById("mySidenav").style.width = "250px";
        }

        function closeNav() {
            document.getElementById("mySidenav").style.width = "0";
        }
    </script>
</header>