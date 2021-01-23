<%@tag description="Overall Page template" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@attribute name="js" fragment="true" required="false" %>
<%@attribute name="head" fragment="true" required="false" %>
<%@attribute name="beforeMainJs" fragment="true" required="false" %>

<html>
<head>
    <jsp:include page="common/head.jsp"/>
    <jsp:invoke fragment="head"/>
</head>
<body>
<jsp:include page="common/navbar.jsp"/>
<jsp:doBody/>
<jsp:include page="common/footer.jsp"/>
<jsp:include page="common/script.jsp"/>
<jsp:invoke fragment="beforeMainJs"/>
<script type="text/javascript" src="<c:url value="/static/scripts/main.js"/>"></script>
<jsp:invoke fragment="js"/>
</body>
</html>
