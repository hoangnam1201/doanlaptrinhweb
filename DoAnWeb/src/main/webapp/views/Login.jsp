<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<link rel="stylesheet" href="<c:url value="/static/css/login.css" />">
<link
        rel="stylesheet"
        href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"
        integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU"
        crossorigin="anonymous"
/>
<link
        href="https://fonts.googleapis.com/css?family=Roboto:300,400"
        rel="stylesheet"
/>
<t:genericpage>
    <jsp:body>
        <div id="form_wrapper">
            <div id="form_left">
                <img src="../static/images/iconlap.png" alt="computer icon"/>
            </div>
            <form method="post">
                <div id="form_right">
                    <h1>Member Login</h1>
                    <c:if test="${requestScope.hasError}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Login failed!</strong> ${requestScope.errorMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>
                    <div class="input_container">
                        <i class="fas fa-user mr-3"></i>
                        <input
                                placeholder="Username/Email"
                                type="text"
                                name="username"
                                id="field_email"
                                class="input_field"
                        />
                    </div>
                    <div class="input_container">
                        <i class="fas fa-lock mr-3"></i>
                        <input
                                placeholder="Password"
                                type="password"
                                name="password"
                                id="field_password"
                                class="input_field"
                        />
                    </div>
                    <button class="py-3 rounded-pill mt-2 btn btn-info text-white font-weight-bold">LOGIN</button>
                    <hr/>
                    <div class="text-center">
                        <a href="<c:url value="/account/register" />">Create new account ➡ </a>
                    </div>
                  </span>
                </div>
            </form>
        </div>
    </jsp:body>
</t:genericpage>