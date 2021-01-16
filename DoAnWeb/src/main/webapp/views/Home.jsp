<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<t:genericpage>
    <jsp:body>
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
                <%-- khoa hoc noi bat --%>
            <section id="feature-courses">
                <div class="mb-5">
                    <section class="section-featured-title">
                        Featured courses
                    </section>
                </div>
                <div>
                    <c:forEach items="${requestScope.featuredCourses}" var="course">
                        <t:singlecourseunit course="${course}"/>
                    </c:forEach>
                </div>
            </section>
                <%-- Khoa hoc pho bien --%>
            <section id="popular-courses">
                <div class="section-title">
                    Popular Courses
                </div>
                <div class="mb-30">
                    <div class="row">
                        <c:forEach items="${requestScope.featuredCourses}" var="course">
                            <t:multicourseunit course="${course}"></t:multicourseunit>
                        </c:forEach>
                    </div>
                </div>
            </section>
        </main>
    </jsp:body>
</t:genericpage>