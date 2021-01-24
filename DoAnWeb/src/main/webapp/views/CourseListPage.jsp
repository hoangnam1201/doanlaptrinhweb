<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<c:set var="uri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
<c:set var="pageInfo" value="${requestScope.courseListPageInfo}"/>

<t:genericpage>
    <jsp:attribute name="js">
        <script>
            $('#sort').val("${!empty param.order?param.order:"popular"}");
            $('#sort').change(() => {
                $('#sort-form').submit();
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <main>
            <div class="category-hero shadow-sm${!empty pageInfo.category?"":" bg-white"}">
                <div class="container-fluid">
                    <c:choose>
                        <c:when test="${!empty pageInfo.category}">
                            <div class="course-list-heading category text-center">${pageInfo.category.name} courses
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${pageInfo.resultCount != 0}">
                                    <div class="course-list-heading">
                                            ${pageInfo.resultCount} results found for "${pageInfo.searchString}"
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="course-list-heading mb-4">
                                        Sorry, we couldn't find "${pageInfo.searchString}"
                                    </div>
                                    <p>Please modify your search.</p>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="course-table--container">
                <div class="d-flex justify-content-between px-3 mx-2 align-items-center mb-2">
                    <div class="result-count-text"><c:choose>
                        <c:when test="${empty pageInfo.category}"> </c:when>
                        <c:otherwise>${pageInfo.resultCount} results</c:otherwise>
                    </c:choose>
                    </div>
                    <div class="ml-3">
                        <form id="sort-form" class="mb-0" method="get">
                            <input type="hidden" name="p" value="1">
                            <c:if test="${not empty param.q}">
                                <input type="hidden" name="q" value="${pageInfo.searchString}">
                            </c:if>
                            Sort by:
                            <select id="sort" name="order" onchange="this.form.submit()"
                                    class="form-control bg-white border rounded-0 d-inline w-auto active-color sort-by--control">
                                <option selected value="popular">Most popular</option>
                                <option value="highest_rated">Highest Rated</option>
                                <option value="lowest_price">Lowest Price</option>
                                <option value="recently_updated">Most Recently Updated</option>
                                <option value="newest">Newest</option>
                            </select>
                        </form>
                    </div>
                </div>
                <div class="course-list--container flex-fill">
                    <c:choose>
                        <c:when test="${requestScope.courseList.size() == 0}">
                            <div class="no-course">
                                <i class="far fa-minus-square"></i>
                                <h4>No course</h4>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${requestScope.courseList}" var="course">
                                <t:courselistunit course="${course}"/>
                            </c:forEach>
                            <nav class="custom-pagination">
                                <form id="paging" class="mb-0" method="get">
                                    <input type="hidden" name="p">
                                    <c:if test="${not empty param.order}">
                                        <input type="hidden" name="order" value="${param.order}">
                                    </c:if>
                                    <c:if test="${not empty param.q}">
                                        <input type="hidden" name="q" value="${param.q}">
                                    </c:if>
                                    <button
                                            <c:if test="${pageInfo.currentPage == 1}">disabled</c:if>
                                            class="next-prev btn" data-page="${pageInfo.currentPage-1}"><i
                                            class="fas fa-chevron-left"></i>
                                    </button>
                                    <c:forEach items="${pageInfo.pagination}" var="page">
                                        <c:choose>
                                            <c:when test="${page.equals('0')}">
                                                <span class="active">${pageInfo.currentPage}</span>
                                            </c:when>
                                            <c:when test="${page.equals('.')}">
                                                <span><i class="fas fa-ellipsis-h"></i></span>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn" data-page="${page}">${page}</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <button
                                            <c:if test="${pageInfo.currentPage == pageInfo.totalPage}">disabled</c:if>
                                            class="next-prev btn" data-page="${pageInfo.currentPage+1}"><i
                                            class="fas fa-chevron-right"></i>
                                    </button>
                                </form>
                            </nav>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </jsp:body>
</t:genericpage>