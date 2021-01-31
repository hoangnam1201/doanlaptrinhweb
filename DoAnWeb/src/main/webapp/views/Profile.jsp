<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:genericpage>
    <jsp:body>
        <main>
            <div class="container-fluid mx-auto p-3 my-3">
                <h4 class="font-weight-bold">Account Settings</h4>
                <small>Change your profile and account settings</small>
                <hr/>
                <div class="d-flex flex-column flex-md-row bg-white rounded shadow flex-fill">
                    <nav class="profile--navbar flex-row flex-md-column nav-pills border-bottom border-right p-3">
                        <div class="nav nav-tabs border-bottom-0" role="tablist">
                            <a data-toggle="tab" role="tab" href="#profile" class="col col-md-12 active show"><i
                                    class="fas fa-user mr-3"></i>
                                Account</a>
                            <a data-toggle="tab" class="col col-md-12" role="tab" href="#password"><i
                                    class="fas fa-lock mr-3"></i>
                                Password</a>
                        </div>
                    </nav>
                    <div class="flex-fill p-3">
                        <div class="tab-content account-setting">
                            <div class="tab-pane active show" id="profile" role="tabpanel">
                                <h5 class="font-weight-bold active-color">Personal Details</h5>
                                <hr/>
                                <form method="post" id="update-profile"
                                      action="${pageContext.request.contextPath}/account/update-profile">
                                    <div id="account-alert"></div>
                                    <div class="form-group">
                                        <label for="name">FULL NAME</label>
                                        <input id="name" name="name"
                                               class="form-control outline-none" required="required"
                                               type="text" value="${authUser.name}">
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <label for="email">EMAIL ADDRESS</label>
                                            <input id="email" name="email"
                                                   class="form-control outline-none" required="required"
                                                   type="text" value="${authUser.email}">
                                        </div>
                                        <div class="col">
                                            <label for="username">USERNAME</label>
                                            <input id="username" name="username"
                                                   class="form-control outline-none" required="required"
                                                   type="text" value="${authUser.username}">
                                        </div>
                                    </div>
                                    <c:if test="${sessionScope.authUser.role.equals('teacher')}">
                                        <div class="form-group mt-2">
                                            <label for="job">JOB</label>
                                            <input id="job" name="job"
                                                   class="form-control outline-none" required="required"
                                                   type="text" value="${authUser.job}">
                                        </div>
                                        <div class="form-group">
                                            <label for="job">BIO</label>
                                            <textarea id="bio" name="bio" cols="40" rows="4" required
                                                      class="form-control outline-none">${authUser.bio}</textarea>
                                        </div>
                                    </c:if>
                                    <hr/>
                                    <button class="btn btn-info px-5 py-2 text-white font-weight-bold">Update</button>
                                </form>
                            </div>
                            <div class="tab-pane" id="password" role="tabpanel">
                                <h5 class="font-weight-bold active-color">Change your password</h5>
                                <hr/>
                                <form method="post" id="change-password"
                                      action="${pageContext.request.contextPath}/account/change-password">
                                    <div id="password-alert"></div>
                                    <div class="form-group row">
                                        <label class="col-3 d-flex align-items-center" for="current-password">Current
                                            password</label>
                                        <div class="col">
                                            <input id="current-password" name="current-password"
                                                   class="form-control outline-none" required="required"
                                                   type="password">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-3 d-flex align-items-center" for="new-password">New
                                            password</label>
                                        <div class="col">
                                            <input id="new-password" name="new-password"
                                                   class="form-control outline-none" required="required"
                                                   type="password">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-3 d-flex align-items-center" for="confirm-password">Confirm
                                            password</label>
                                        <div class="col">
                                            <input id="confirm-password" name="confirm-password"
                                                   class="form-control outline-none" required="required"
                                                   type="password">
                                        </div>
                                    </div>
                                    <hr/>
                                    <div class="text-center">
                                        <button style="width: 300px"
                                                class="btn btn-outline-info py-2 px-5 font-weight-bold">Save
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </jsp:body>
</t:genericpage>
