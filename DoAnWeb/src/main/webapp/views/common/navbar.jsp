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
        <a class="flex-shrink-0" href="/">
            <img alt="logo" width="100" src="https://www.udemy.com/staticx/udemy/images/v6/logo-coral.svg">
        </a>
        <nav class="header-dropdown-wrapper d-none d-md-flex">
            <button class="header-dropdown-button">
                Categories
            </button>
            <div class="header-dropdown-menu">
                <ul class="list-unstyled m-0">
                    <c:forEach items="${requestScope.categoryList}" var="cat">
                        <li>
                            <a href="/courses/${cat.slug}"
                               class="primary-category-item category-item text-inherit text-decoration-none">
                                <div class="category-content">
                                        ${cat.name}
                                </div>
                                <i class="fas fa-chevron-right"></i>
                            </a>
                            <div class="header-dropdown-menu sub-category">
                                <ul class="list-unstyled m-0">
                                    <li>
                                        <a href="/courses/${cat.slug}"
                                           class="category-item text-inherit text-decoration-none">
                                            <div class="category-content">
                                                All ${cat.name}
                                            </div>
                                        </a>
                                    </li>
                                    <c:forEach items="${cat.children}" var="subCat">
                                        <li>
                                            <a href="/courses/${subCat.slug}"
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
        <div class="flex-fill header-search rounded-pill d-none d-md-block">
            <form class="h-100 d-flex align-items-center">
                <button class="ml-2 btn outline-none">
                    <i class="fas fa-search"></i>
                </button>
                <input placeholder="Search for anything" type="text" class="header-search-input flex-fill pr-3">
            </form>
        </div>
        <div class="header-dropdown-wrapper d-none d-xl-flex">
            <a href="#" class="header-dropdown-button text-decoration-none">
                Udemy for business
            </a>
            <div class="header-dropdown-menu right">
                <div class="px-3 py-2">
                    <div class="header-dropdown-menu-heading">
                        Get your team access to over 5,000 top Udemy courses, anytime, anywhere.
                    </div>
                    <a href="#" class="btn btn-info btn-block mt-2 font-weight-bold text-white">Try Udemy for
                        Business
                    </a>
                </div>
            </div>
        </div>
        <div class="header-dropdown-wrapper d-none d-lg-flex">
            <a href="#" class="header-dropdown-button text-decoration-none">
                Teach on Udemy
            </a>
            <div class="header-dropdown-menu right">
                <div class="px-3 py-2">
                    <div class="header-dropdown-menu-heading">
                        Turn what you know into an opportunity and reach millions around the world.
                    </div>
                    <a href="#" class="btn btn-info btn-block mt-2 font-weight-bold text-white">Learn more</a>
                </div>
            </div>
        </div>
        <div class="header-dropdown-wrapper">
            <button class="header-dropdown-button">
                <i style="font-size: 22px;" class="fas fa-shopping-cart"></i>
            </button>
            <div class="header-dropdown-menu right">
                <div class="px-3 py-2">
                    <div class="text-center">
                        Your cart is empty.
                        <a href="#" class="btn text-info btn-block mt-2 font-weight-bold text-white">Keep
                            shopping</a>
                    </div>
                </div>
            </div>
        </div>
        <a class="header-button btn header-login-button d-none d-md-block" href="${pageContext.request.contextPath}/Account/Login" role="button">Log in</a>
        <a class="header-button btn header-signup-button d-none d-md-block" href="${pageContext.request.contextPath}/Account/Register" role="button">Sign up</a>
    </div>
</header>