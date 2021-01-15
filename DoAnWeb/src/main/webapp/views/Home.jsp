<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="common/head.jsp"/>
<body>
<jsp:include page="common/navbar.jsp"/>
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
                                <img class="course-card--image" src="<c:url value="static/images/angular.jpg" />"
                                     alt="Card image cap">
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
                                <img class="course-card--image" src="<c:url value="static/images/angular.jpg" />"
                                     alt="Card image cap">
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
                                <img class="course-card--image" src="<c:url value="static/images/angular.jpg" />"
                                     alt="Card image cap">
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
                                <img class="course-card--image" src="<c:url value="static/images/angular.jpg" />"
                                     alt="Card image cap">
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
<jsp:include page="common/footer.jsp"/>

</body>

</html>