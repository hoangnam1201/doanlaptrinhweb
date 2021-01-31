<%--
  Created by IntelliJ IDEA.
  User: HNC
  Date: 1/31/2021
  Time: 3:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form method="post" action="${pageContext.request.contextPath}/upload" enctype="multipart/form-data">
    <input name="video" id="video" type="file">
    <button>submit</button>
</form>
</body>
</html>
