<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<style>
    main{
        background-image: url("../static/images/register.png");
    }
    .container{
        display: flex;
        justify-content: center;
    }
</style>
<t:genericpage>
    <jsp:body>
        <main>
            <div class="container">
                <div class="row">
                    <c:choose>
                        <c:when test="${auth}">
                            <div class="col-md-9">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <h4>Your Profile</h4>
                                                <hr>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <form method="post" action="${pageContext.request.contextPath}/account/profile?id=${authUser.id}">
                                                    <div class="form-group row">
                                                        <label for="txtUsername" class="col-4 col-form-label">User Name</label>
                                                        <div class="col-8">
                                                            <input id="txtUsername" name="username" placeholder="Username"
                                                                   class="form-control here" required="required" type="text" value="${authUser.username}">
                                                        </div>
                                                    </div>

                                                    <div class="form-group row">
                                                        <label for="txtName" class="col-4 col-form-label">Nick Name*</label>
                                                        <div class="col-8">
                                                            <input id="txtName" name="name" placeholder="Nick Name"
                                                                   class="form-control here" required="required" type="text" value="${authUser.name}">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="txtEmail" class="col-4 col-form-label">Email*</label>
                                                        <div class="col-8">
                                                            <input id="txtEmail" name="email" placeholder="Email"
                                                                   class="form-control here" required="required" type="text" value="${authUser.email}">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="website" class="col-4 col-form-label">Website</label>
                                                        <div class="col-8">
                                                            <input id="website" name="website" placeholder="website"
                                                                   class="form-control here" type="text">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="publicinfo" class="col-4 col-form-label">Public Info</label>
                                                        <div class="col-8">
                                                <textarea id="publicinfo" name="publicinfo" cols="40" rows="4"
                                                          class="form-control"></textarea>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="txtpassword" class="col-4 col-form-label">New Password</label>
                                                        <div class="col-8">
                                                            <input id="txtpassword" name="password" placeholder="New Password"
                                                                   class="form-control here" type="password">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="offset-4 col-8">
                                                            <button name="submit" type="submit" class="btn btn-primary">Update
                                                                My
                                                                Profile
                                                            </button>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </main>
    </jsp:body>
</t:genericpage>