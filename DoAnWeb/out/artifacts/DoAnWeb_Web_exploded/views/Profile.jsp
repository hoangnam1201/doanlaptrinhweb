<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<style>
    main {
        background-image: url("../static/images/register.png");
    }

    .container {
        display: flex;
        justify-content: center;
    }
</style>
<t:genericpage>
    <jsp:body>
        <main>
            <div class="container">
                <div class="w-100 bg-white">
                    <c:choose>
                    <c:when test="${auth}">
                    <div>
                        <div class="card">
                            <div class="card-body">
                                <h4>Your Profile</h4>
                                <hr>
                            </div>
                        </div>
                        <div class="w-100">
                            <div class="col-md-12">
                                <form method="post"
                                      action="${pageContext.request.contextPath}/account/profile?id=${authUser.id}">
                                    <div class="form-group row">
                                        <label for="txtUsername" class="col-4 col-form-label">User
                                            Name</label>
                                        <div class="col-8">
                                            <input id="txtUsername" name="username"
                                                   placeholder="Username"
                                                   class="form-control here" required="required"
                                                   type="text" value="${authUser.username}">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="txtName" class="col-4 col-form-label">Nick
                                            Name*</label>
                                        <div class="col-8">
                                            <input id="txtName" name="name" placeholder="Nick Name"
                                                   class="form-control here" required="required"
                                                   type="text" value="${authUser.name}">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="txtEmail"
                                               class="col-4 col-form-label">Email*</label>
                                        <div class="col-8">
                                            <input id="txtEmail" name="email" placeholder="Email"
                                                   class="form-control here" required="required"
                                                   type="text" value="${authUser.email}">
                                        </div>
                                    </div>
                                    <c:if test="${sessionScope.authUser.role.equals('teacher')}">
                                        <div class="form-group row">
                                            <label for="job" class="col-4 col-form-label">Job*</label>
                                            <div class="col-8">
                                                <input id="job" name="job" required
                                                       value="${sessionScope.authUser.job}"
                                                       class="form-control here" type="text">
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label for="bio" class="col-4 col-form-label">Bio*</label>
                                            <div class="col-8">
                                                <textarea id="bio" name="bio" cols="40" rows="4" required
                                                          class="form-control">${sessionScope.authUser.bio}</textarea>
                                            </div>
                                        </div>
                                    </c:if>
                                    <div class="form-group row">
                                        <label for="txtpassword" class="col-4 col-form-label">New
                                            Password</label>
                                        <div class="col-8">
                                            <input id="txtpassword" name="password"
                                                   placeholder="New Password"
                                                   class="form-control here" type="password">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <div class="offset-4 col-8">
                                            <button name="submit" type="submit"
                                                    class="btn btn-primary text-white">
                                                Update My Profile
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        </c:when>
                        </c:choose>
                    </div>
                </div>
        </main>
    </jsp:body>
</t:genericpage>