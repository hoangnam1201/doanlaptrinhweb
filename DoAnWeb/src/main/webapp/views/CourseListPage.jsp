<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<c:set var="uri" value="${requestScope['javax.servlet.forward.request_uri']}"/>
<c:set var="currentPage" value="${requestScope.courseListPageInfo.currentPage}"/>
<c:set var="totalPage" value="${requestScope.courseListPageInfo.totalPage}"/>


<t:genericpage>
    <jsp:attribute name="js">
        <script>
            $('#sort').val(${param.order});
            $('#sort').change(() => {
                $('#sort-form').submit();
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <main>
            <div class="category-hero">
                <div class="container-fluid">
                    <h1 class="font-weight-bold">${requestScope.category.name} courses</h1>
                </div>
            </div>
            <div class="course-table--container">
                <div class="d-flex justify-content-between pr-3 mx-2 align-items-center">
                    <div class="ml-3">
                        <form id="sort-form" class="mb-0" method="get">
                            Sort by:
                            <select id="sort" name="order"
                                    class="form-control d-inline w-auto active-color sort-by--control">
                                <option value="1">POPULAR</option>
                                <option value="2">ALPHABETICALLY, A-Z</option>
                                <option value="3">ALPHABETICALLY, Z-A</option>
                                <option value="4">PRICE, LOW TO HIGH</option>
                                <option>PRICE, HIGH TO LOW</option>
                                <option>RATING, LOW TO HIGH</option>
                                <option>RATING, HIGH TO LOW</option>
                            </select>
                        </form>
                    </div>
                    <h5 class="text-secondary font-weight-bold m-0">${requestScope.courseListPageInfo.resultCount}
                        results</h5>
                </div>
                <div class="course-list--container flex-fill">
                    <c:forEach items="${requestScope.courseList}" var="course">
                        <t:courselistunit course="${course}"/>
                    </c:forEach>
                    <nav>
                        <ul class="pagination justify-content-center">
                            <c:if test="${currentPage != 1}">
                                <li class="page-item">
                                    <a class="page-link" href="${uri}?p=${currentPage-1}" aria-label="Previous">
                                        <span aria-hidden="true">⏴</span>
                                        <span class="sr-only">Previous</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:if test="${currentPage-1 > 2}">
                                <li class="page-item"><a class="page-link" href="${uri}">1</a></li>
                            </c:if>
                            <c:if test="${currentPage-1 > 1}">
                                <li>
                                    ...
                                </li>
                            </c:if>
                            <c:if test="${currentPage-1>0}">
                                <li class="page-item">
                                    <a class="page-link"
                                       href="${uri}?p=${currentPage -1}">${currentPage-1}</a>
                                </li>
                            </c:if>
                            <li class="page-item"><a class="page-link" href="${uri}?p=2">${currentPage}</a></li>
                            <c:if test="${currentPage+1<totalPage}">
                                <li class="page-item"><a class="page-link" href="${uri}">${currentPage+1}</a></li>
                            </c:if>
                            <c:if test="${currentPage+2<totalPage}">
                                <li>...</li>
                            </c:if>
                            <c:if test="${currentPage+3<totalPage}">
                                <li class="page-item"><a class="page-link" href="${uri}">${totalPage}</a></li>
                            </c:if>
                            <c:if test="${currentPage != totalPage}">
                                <li class="page-item">
                                    <a class="page-link" href="${uri}?p=${currentPage+1}" aria-label="Next">
                                        <span aria-hidden="true">⏵</span>
                                        <span class="sr-only">Next</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </main>
    </jsp:body>
</t:genericpage>