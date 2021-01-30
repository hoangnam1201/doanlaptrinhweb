<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<t:genericpage>
    <jsp:body>
        <div class="error-page-container">
            <h1 class="error-page-header">Oops!</h1>
            <div class="error-page-body">
                <h6 class="font-weight-bold">404 - PAGE NOT FOUND!</h6>
                <p>The page you are looking for doesn't exist or an other error occured.</p>
                <a href="<c:url value="/"/>" class="btn btn-primary rounded-pill shadow text-white">GO TO HOMEPAGE</a>
            </div>
        </div>
    </jsp:body>
</t:genericpage>