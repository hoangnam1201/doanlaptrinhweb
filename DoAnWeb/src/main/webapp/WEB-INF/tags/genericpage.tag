<%@tag description="Overall Page template" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@attribute name="js" fragment="true" required="false" %>

<html>
<jsp:include page="common/head.jsp" />
<body>
<jsp:include page="common/navbar.jsp" />
<jsp:doBody/>
<jsp:include page="common/footer.jsp" />
<jsp:include page="common/script.jsp" />
<jsp:invoke fragment="js" />
</body>
</html>
