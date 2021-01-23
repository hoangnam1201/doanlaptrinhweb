<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<t:genericpage>
    <jsp:attribute name="js">
        <script src="<c:url value="/static/scripts/main.js"/>"></script>
    </jsp:attribute>
    <jsp:body>
        <section class="hero">
            <div class="container">
                <div class="row">
                    <div class="col-xl-6 col-lg-6 col-md-9 px-4">
                        <h5 class="active-color font-weight-bold">Welcome to Udemy</h5>
                        <h1 class="font-weight-bold">More than 100 online courses</h1>
                        <form class="slider-search-form" method="get" action="search">
                            <input name="q" type="text" class="outline-none" placeholder="Search Courses">
                            <button type="submit" class="outline-none"><i class="fa fa-search"></i></button>
                        </form>
                    </div>
                </div>
            </div>
        </section>
        <main>
                <%-- khoa hoc noi bat --%>
            <section id="feature-courses" class="pb-4">
                <div class="container-fluid">
                    <h2 class="section-featured-title">
                        Featured courses
                    </h2>
                    <div class="single-carousel">
                        <c:forEach items="${requestScope.featuredCourses}" var="course">
                            <div>
                                <t:singlecourseunit course="${course}"/>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>
                <%-- Top category --%>
            <section id="feature-categories">
                <div class="container-fluid">
                    <div class="section-title">
                        Trending Categories
                    </div>
                    <div class="category-carousel">
                        <c:forEach items="${requestScope.trendingCategories}" var="category">
                            <a class="d-block border-active rounded font-weight-bold text-center p-2"
                               href="<c:url value="/courses/${category.parent.slug}/${category.slug}" />">
                                    ${category.name}
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </section>
                <%-- Khoa hoc pho bien --%>
            <section id="popular-courses" class="py-3">
                <div class="container-fluid">
                    <div class="section-title">
                        Popular Courses
                    </div>
                    <div class="mb-30">
                        <div class="multiple-carousel">
                            <c:forEach items="${requestScope.popularCourses}" var="course">
                                <t:multicourseunit course="${course}"/>
                            </c:forEach>
                        </div>
                    </div>
                    <hr/>
                </div>
            </section>
                <%-- Khoa hoc moi nhat --%>
            <section id="newest-courses" class="pb-3">
                <div class="container-fluid">
                    <div class="section-title mt-0">
                        Newest Courses
                    </div>
                    <div class="mb-30">
                        <div class="multiple-carousel">
                            <c:forEach items="${requestScope.latestCourses}" var="course">
                                <t:multicourseunit course="${course}"/>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </jsp:body>
</t:genericpage>
