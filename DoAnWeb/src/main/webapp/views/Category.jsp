<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<t:genericpage>
    <jsp:body>
        <main>
            <div class="category-hero">
                <div class="container-fluid">
                    <h1 class="font-weight-bold">${requestScope.category.name} courses</h1>
                </div>
            </div>
            <div class="course-table--container">
                <div class="d-flex justify-content-between pr-3 mx-2 align-items-center">
                    <div>
                        Sort by:
                        <select id="sort-by" class="form-control d-inline w-auto active-color sort-by--control">
                            <option selected>POPULAR</option>
                            <option>ALPHABETICALLY, A-Z</option>
                            <option>ALPHABETICALLY, Z-A</option>
                            <option>PRICE, LOW TO HIGH</option>
                            <option>PRICE, HIGH TO LOW</option>
                            <option>RATING, LOW TO HIGH</option>
                            <option>RATING, HIGH TO LOW</option>
                        </select>
                    </div>
                    <h5 class="text-secondary font-weight-bold m-0">123 results</h5>
                </div>
                <div class="d-flex">
                    <div class="course-filter--container">
                        <h4>Filters</h4>
                        <form method="post">
                            <div class="border-top mt-2">
                                <button class="filter-collapse--button outline-none"
                                        data-toggle="collapse" data-target="#rating-filter" type="button">
                                    <span>Ratings</span>
                                    <i class="fas fa-chevron-up"></i>
                                </button>
                                <ul id="rating-filter" class="list-unstyled mb-0 show">
                                    <li class="d-flex align-items-center mb-2">
                                        <input type="checkbox" class="mr-3" name="asd" id="asd">
                                        <label for="asd" class="mb-0">asd</label>
                                    </li>
                                    <li class="d-flex align-items-center mb-2">
                                        <input type="checkbox" class="mr-3" name="asd" id="asd">
                                        <label for="asd" class="mb-0">asd</label>
                                    </li>
                                    <li class="d-flex align-items-center mb-2">
                                        <input type="checkbox" class="mr-3" name="asd" id="asd">
                                        <label for="asd" class="mb-0">asd</label>
                                    </li>
                                </ul>
                            </div>
                            <div class="border-top mt-2">
                                <button class="filter-collapse--button outline-none"
                                        data-toggle="collapse" data-target="#level-filter" type="button">
                                    <span>Levels</span>
                                    <i class="fas fa-chevron-up"></i>
                                </button>
                                <ul id="level-filter" class="list-unstyled mb-0 show">
                                    <li class="d-flex align-items-center mb-2">
                                        <input type="checkbox" class="mr-3" name="asd" id="asd">
                                        <label for="asd" class="mb-0">asd</label>
                                    </li>
                                    <li class="d-flex align-items-center mb-2">
                                        <input type="checkbox" class="mr-3" name="asd" id="asd">
                                        <label for="asd" class="mb-0">asd</label>
                                    </li>
                                    <li class="d-flex align-items-center mb-2">
                                        <input type="checkbox" class="mr-3" name="asd" id="asd">
                                        <label for="asd" class="mb-0">asd</label>
                                    </li>
                                </ul>
                            </div>
                            <div class="border-top mt-2">
                                <button class="filter-collapse--button outline-none"
                                        data-toggle="collapse" data-target="#language-filter" type="button">
                                    <span>Language</span>
                                    <i class="fas fa-chevron-up"></i>
                                </button>
                                <ul id="language-filter" class="list-unstyled mb-0 show">
                                    <li class="d-flex align-items-center mb-2">
                                        <input type="checkbox" class="mr-3" name="asd" id="asd">
                                        <label for="asd" class="mb-0">asd</label>
                                    </li>
                                    <li class="d-flex align-items-center mb-2">
                                        <input type="checkbox" class="mr-3" name="asd" id="asd">
                                        <label for="asd" class="mb-0">asd</label>
                                    </li>
                                    <li class="d-flex align-items-center mb-2">
                                        <input type="checkbox" class="mr-3" name="asd" id="asd">
                                        <label for="asd" class="mb-0">asd</label>
                                    </li>
                                </ul>
                            </div>
                            <div class="border-top mt-2">
                                <button class="filter-collapse--button outline-none"
                                        data-toggle="collapse" data-target="#price-filter" type="button">
                                    <span>Price</span>
                                    <i class="fas fa-chevron-up"></i>
                                </button>
                                <ul id="price-filter" class="list-unstyled mb-0 show">
                                    <li class="d-flex align-items-center mb-2">
                                        <input type="checkbox" class="mr-3" name="asd" id="asd">
                                        <label for="asd" class="mb-0">asd</label>
                                    </li>
                                    <li class="d-flex align-items-center mb-2">
                                        <input type="checkbox" class="mr-3" name="asd" id="asd">
                                        <label for="asd" class="mb-0">asd</label>
                                    </li>
                                    <li class="d-flex align-items-center mb-2">
                                        <input type="checkbox" class="mr-3" name="asd" id="asd">
                                        <label for="asd" class="mb-0">asd</label>
                                    </li>
                                </ul>
                            </div>
                        </form>
                    </div>
                    <div class="course-list--container flex-fill">
                        <c:forEach items="${requestScope.courseList}" var="course">
                            <t:courselistunit course="${course}"/>
                        </c:forEach>
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">Previous</a>
                                </li>
                                <li class="page-item"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </main>
    </jsp:body>
</t:genericpage>