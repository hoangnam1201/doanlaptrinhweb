<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:genericpage>
    <jsp:body>
        <div class="container-fluid h-100">
            <div class="row h-100 justify-content-center align-items-center">
                <div class="col-sm-4">
                    <c:if test="${requestScope.hasError}">
                        <div class="alert alert-warning alert-dismissible fade show" role="alert">
                            <strong>Login failed!</strong> ${requestScope.errorMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>
                    <form method="post">
                        <div class="form-group">
                            <div class="input-group">
                                <input class="form-control form-control-lg border-right-0 border"
                                       placeholder="User name"
                                       type="text" name="username" autofocus>
                                <span class="input-group-append">
                <div class="input-group-text bg-white">
                  <i class="fa fa-user" aria-hidden="true"></i>
                </div>
                </span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="input-group">
                                <input class="form-control form-control-lg border-right-0 border" placeholder="Password"
                                       type="password" name="password">
                                <span class="input-group-append">
                <div class="input-group-text bg-white">
                  <i class="fa fa-key" aria-hidden="true"></i>
                </div>
              </span>
                            </div>
                        </div>
                        <div class="form-group d-flex">
                            <div>
                                <a class="btn btn-lg btn-outline-info btn-block"
                                   href="${pageContext.request.contextPath}/" role="button">
                                    <i class="fa fa-home" aria-hidden="true"></i>
                                    Home
                                </a>
                            </div>
                            <div class="flex-fill ml-1">
                                <button type="submit" class="btn btn-lg btn-info btn-block text-white">
                                    Sign In
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </jsp:body>
</t:genericpage>