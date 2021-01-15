<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="common/head.jsp" />
<body>
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
                    <li>
                        <a href="#" class="primary-category-item category-item text-inherit text-decoration-none">
                            <div class="category-content">
                                Development
                            </div>
                            <i class="fas fa-chevron-right"></i>
                        </a>
                        <div class="header-dropdown-menu sub-category">
                            <ul class="list-unstyled m-0">
                                <li>
                                    <a href="#" class="category-item text-inherit text-decoration-none">
                                        <div class="category-content">
                                            All Development
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" class="category-item text-inherit text-decoration-none">
                                        <div class="category-content">
                                            Web Development
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" class="category-item text-inherit text-decoration-none">
                                        <div class="category-content">
                                            Data Sciene
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li>
                        <a href="#" class="primary-category-item category-item text-inherit text-decoration-none">
                            <div class="category-content">
                                Business
                            </div>
                            <i class="fas fa-chevron-right"></i>
                        </a>
                        <div class="header-dropdown-menu sub-category">
                            <ul class="list-unstyled m-0">
                                <li>
                                    <a href="#" class="category-item text-inherit text-decoration-none">
                                        <div class="category-content">
                                            All Business
                                        </div>
                                    </a>
                                </li>
                                <li>
                                    <a href="#" class="category-item text-inherit text-decoration-none">
                                        <div class="category-content">
                                            Sales
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </li>
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
                        Business</a>
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
                        Turn what you know into an opportunity and reach millions around the world. </div>
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
        <button class="header-button btn header-login-button d-none d-md-block">Log in</button>
        <button class="header-button btn header-signup-button d-none d-md-block">Sign up</button>
    </div>
</header>
<section class="hero">
    <div class="container">
        <div class="row">
            <div class="col-xl-6 col-lg-6 col-md-9 px-4">
                <h5 class="active-color font-weight-bold">Welcome to H&N</h5>
                <h1 class="font-weight-bold">More than 100 online courses</h1>
                <form class="slider-search-form">
                    <input type="text" class="outline-none" placeholder="Search Courses">
                    <button type="submit" class="outline-none"><i class="fa fa-search"></i></button>
                </form>
            </div>
        </div>
    </div>
</section>
<main>
    <div class="mb-5">
        <section class="section-featured-title">
            Featured courses
        </section>
    </div>
    <div>
        <a href="#" class="bg-grey border rounded a-unstyled single-course--container flex-column flex-sm-row">
            <div>
                <img src="<c:url value="static/images/nodejs.jpg" />" class="mw-100 h-auto" width="500" height="250">
            </div>
            <div class="featured-course-content mt-3 ml-1 ml-sm-3 mt-sm-0">
                <div>
                    <div class="single-course--category">NodeJs</div>
                    <h5 class="font-weight-bold">Advanced Stock Trading Course + Strategies</h5>
                    <p class="m-0">
                        Insider Swing Trading, Stock Trading, Day Trading, & Technical Analysis w/ Hedge Fund CEO:
                        Genuine Learning + Mentorship</p>
                    <small>by <span class="active-color">Calvin Lee</span></small>
                    <div class="mt-1 d-flex align-items-center">
                            <span class="rating">
                                <span class="font-weight-bold">4.5</span>
                                <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                    class="fas fa-star"></i><i class="fas fa-star-half-alt"></i>
                            </span>
                        <small>(12,456)</small>
                    </div>
                    <small class="d-block">
                        <ul class="list-dot p-0">
                            <li>All Levels</li>
                            <li>290,359 students</li>
                        </ul>
                    </small>
                </div>
                <p class="price">
                    $9.99
                </p>
            </div>
        </a>
    </div>
    </section>
    </div>
    <section>
        <div class="section-title">
            Popular Courses
        </div>
        <div class="mb-30">
            <div class="row">
                <div class="col-3">
                    <div class="a-unstyled bg-grey course-card--container">
                        <div>
                            <a href="#">
                                <img class="course-card--image" src="<c:url value="static/images/angular.jpg" />" alt="Card image cap">
                            </a>
                            <div class="card-body py-2 px-3">
                                <div class="mb-1">
                                    <a href="#" class="course-card--category">Angular</a>
                                </div>
                                <div>
                                    <a href="#" class="a-unstyled course-card--title">Angular - The Complete Guide
                                        (2021 Edition)</a>
                                </div>
                                <div>
                                    <small class="text-muted">by <a href="#">Maximilian Schwarzmüller</a></small>
                                </div>
                                <div class="mt-1 d-flex align-items-center">
                                        <span class="rating">
                                            <span class="font-weight-bold">4.5</span>
                                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star-half-alt"></i>
                                        </span>
                                    <small>(12,456)</small>
                                </div>
                                <div class="mt-1">
                                    <small class="d-block">
                                        <ul class="list-dot p-0">
                                            <li>All Levels</li>
                                            <li>290,359 students</li>
                                        </ul>
                                    </small>
                                </div>
                                <div class="mt-3 d-flex justify-content-between align-items-center">
                                    <p class="price">$9.99</p>
                                    <button class="btn p-0  outline-none"><i class="fas fa-cart-plus"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-3">
                    <div class="a-unstyled bg-grey course-card--container">
                        <div>
                            <a href="#">
                                <img class="course-card--image" src="<c:url value="static/images/angular.jpg" />" alt="Card image cap">
                            </a>
                            <div class="card-body py-2 px-3">
                                <div class="mb-1">
                                    <a href="#" class="course-card--category">Angular</a>
                                </div>
                                <div>
                                    <a href="#" class="a-unstyled course-card--title">Angular - The Complete Guide
                                        (2021 Edition)</a>
                                </div>
                                <div>
                                    <small class="text-muted">by <a href="#">Maximilian Schwarzmüller</a></small>
                                </div>
                                <div class="mt-1 d-flex align-items-center">
                                        <span class="rating">
                                            <span class="font-weight-bold">4.5</span>
                                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star-half-alt"></i>
                                        </span>
                                    <small>(12,456)</small>
                                </div>
                                <div class="mt-1">
                                    <small class="d-block">
                                        <ul class="list-dot p-0">
                                            <li>All Levels</li>
                                            <li>290,359 students</li>
                                        </ul>
                                    </small>
                                </div>
                                <div class="mt-3 d-flex justify-content-between align-items-center">
                                    <p class="price">$9.99</p>
                                    <button class="btn p-0  outline-none"><i class="fas fa-cart-plus"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-3">
                    <div class="a-unstyled bg-grey course-card--container">
                        <div>
                            <a href="#">
                                <img class="course-card--image" src="<c:url value="static/images/angular.jpg" />" alt="Card image cap">
                            </a>
                            <div class="card-body py-2 px-3">
                                <div class="mb-1">
                                    <a href="#" class="course-card--category">Angular</a>
                                </div>
                                <div>
                                    <a href="#" class="a-unstyled course-card--title">Angular - The Complete Guide
                                        (2021 Edition)</a>
                                </div>
                                <div>
                                    <small class="text-muted">by <a href="#">Maximilian Schwarzmüller</a></small>
                                </div>
                                <div class="mt-1 d-flex align-items-center">
                                        <span class="rating">
                                            <span class="font-weight-bold">4.5</span>
                                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star-half-alt"></i>
                                        </span>
                                    <small>(12,456)</small>
                                </div>
                                <div class="mt-1">
                                    <small class="d-block">
                                        <ul class="list-dot p-0">
                                            <li>All Levels</li>
                                            <li>290,359 students</li>
                                        </ul>
                                    </small>
                                </div>
                                <div class="mt-3 d-flex justify-content-between align-items-center">
                                    <p class="price">$9.99</p>
                                    <button class="btn p-0  outline-none"><i class="fas fa-cart-plus"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-3">
                    <div class="a-unstyled bg-grey course-card--container">
                        <div>
                            <a href="#">
                                <img class="course-card--image" src="<c:url value="static/images/angular.jpg" />" alt="Card image cap">
                            </a>
                            <div class="card-body py-2 px-3">
                                <div class="mb-1">
                                    <a href="#" class="course-card--category">Angular</a>
                                </div>
                                <div>
                                    <a href="#" class="a-unstyled course-card--title">Angular - The Complete Guide
                                        (2021 Edition)</a>
                                </div>
                                <div>
                                    <small class="text-muted">by <a href="#">Maximilian Schwarzmüller</a></small>
                                </div>
                                <div class="mt-1 d-flex align-items-center">
                                        <span class="rating">
                                            <span class="font-weight-bold">4.5</span>
                                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                class="fas fa-star-half-alt"></i>
                                        </span>
                                    <small>(12,456)</small>
                                </div>
                                <div class="mt-1">
                                    <small class="d-block">
                                        <ul class="list-dot p-0">
                                            <li>All Levels</li>
                                            <li>290,359 students</li>
                                        </ul>
                                    </small>
                                </div>
                                <div class="mt-3 d-flex justify-content-between align-items-center">
                                    <p class="price">$9.99</p>
                                    <button class="btn p-0  outline-none"><i class="fas fa-cart-plus"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>
<jsp:include page="common/footer.jsp" />

</body>

</html>