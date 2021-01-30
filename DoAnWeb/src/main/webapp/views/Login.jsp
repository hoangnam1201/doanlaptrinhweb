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
        <c:if test="${requestScope.hasError}">
            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                <strong>Login failed!</strong> ${requestScope.errorMessage}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
            <div id="form_wrapper">
                <div id="form_left">
                    <img src="../static/images/iconlap.png" alt="computer icon"/>
                </div>
                <form method="post">
                    <div id="form_right">
                        <h1>Member Login</h1>
                        <div class="input_container">
                            <i class="fas fa-user"></i>
                            <input
                                    placeholder="Username"
                                    type="text"
                                    name="username"
                                    id="field_email"
                                    class="input_field"
                            />
                        </div>
                        <div class="input_container">
                            <i class="fas fa-lock"></i>
                            <input
                                    placeholder="Password"
                                    type="password"
                                    name="password"
                                    id="field_password"
                                    class="input_field"
                            />
                        </div>
                        <input
                                type="submit"
                                value="Login"
                                id="input_submit"
                                class="input_field"
                        />
                        <span>Forgot <a href="#"> Username / Password ?</a></span>
                        <span id="create_account">
                    <a href="#">Create your account ➡ </a>
                  </span>
                    </div>
                </form>
            </div>
<%--        <div class="container">--%>
<%--            <div class="d-flex justify-content-center h-100">--%>
<%--                <div class="card">--%>
<%--                    <div class="card-header">--%>
<%--                        <h3>Sign In</h3>--%>
<%--                        <div class="d-flex justify-content-end social_icon">--%>
<%--                            <span><i class="fab fa-facebook-square"></i></span>--%>
<%--                            <span><i class="fab fa-google-plus-square"></i></span>--%>
<%--                            <span><i class="fab fa-twitter-square"></i></span>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="card-body">--%>
<%--                        <c:if test="${requestScope.hasError}">--%>
<%--                            <div class="alert alert-warning alert-dismissible fade show" role="alert">--%>
<%--                           <strong>Login failed!</strong> ${requestScope.errorMessage}--%>
<%--                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">--%>
<%--                           <span aria-hidden="true">&times;</span>--%>
<%--                            </button>--%>
<%--                             </div>--%>
<%--                            </c:if>--%>
<%--                        <form method="post">--%>
<%--                            <div class="input-group form-group">--%>
<%--                                <div class="input-group-prepend">--%>
<%--                                    <span class="input-group-text"><i class="fas fa-user"></i></span>--%>
<%--                                </div>--%>
<%--                                <input type="text" class="form-control" placeholder="Username" name="username" autofocus>--%>

<%--                            </div>--%>
<%--                            <div class="input-group form-group">--%>
<%--                                <div class="input-group-prepend">--%>
<%--                                    <span class="input-group-text"><i class="fas fa-key"></i></span>--%>
<%--                                </div>--%>
<%--                                <input type="password" class="form-control" placeholder="Password" name="password">--%>
<%--                            </div>--%>
<%--                            <div class="row align-items-center remember">--%>
<%--                                <input type="checkbox">Remember Me--%>
<%--                            </div>--%>
<%--                            <div class="form-group">--%>
<%--                                <input type="submit" value="Login" class="btn btn-warning float-right login_btn">--%>
<%--                            </div>--%>
<%--                        </form>--%>
<%--                    </div>--%>
<%--                    <div class="card-footer">--%>
<%--                        <div class="d-flex justify-content-center links">--%>
<%--                            Don't have an account?<a href="#">Sign Up</a>--%>
<%--                        </div>--%>
<%--                        <div class="d-flex justify-content-center">--%>
<%--                            <a href="#">Forgot your password?</a>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>

    </jsp:body>
</t:genericpage>