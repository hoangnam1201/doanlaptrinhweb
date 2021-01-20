<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:genericpage>
    <jsp:body>
        <main>
            <div class="container">
                <div class="row">
                    <div class="col-md-3 ">
                        <div class="list-group ">
                            <a href="#" class="list-group-item list-group-item-action active">Dashboard</a>
                            <a href="#" class="list-group-item list-group-item-action">User Management</a>
                            <a href="#" class="list-group-item list-group-item-action">Used</a>
                            <a href="#" class="list-group-item list-group-item-action">Enquiry</a>
                            <a href="#" class="list-group-item list-group-item-action">Dealer</a>
                            <a href="#" class="list-group-item list-group-item-action">Media</a>
                            <a href="#" class="list-group-item list-group-item-action">Post</a>
                            <a href="#" class="list-group-item list-group-item-action">Category</a>
                            <a href="#" class="list-group-item list-group-item-action">New</a>
                            <a href="#" class="list-group-item list-group-item-action">Comments</a>
                            <a href="#" class="list-group-item list-group-item-action">Appearance</a>
                            <a href="#" class="list-group-item list-group-item-action">Reports</a>
                            <a href="#" class="list-group-item list-group-item-action">Settings</a>


                        </div>
                    </div>
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
                                                <form>
                                                    <div class="form-group row">
                                                        <label for="username" class="col-4 col-form-label">User Name</label>
                                                        <div class="col-8">
                                                            <input id="username" name="username" placeholder="Username"
                                                                   class="form-control here" required="required" type="text" value="${authUser.username}">
                                                        </div>
                                                    </div>

                                                    <div class="form-group row">
                                                        <label for="text" class="col-4 col-form-label">Nick Name*</label>
                                                        <div class="col-8">
                                                            <input id="text" name="text" placeholder="Nick Name"
                                                                   class="form-control here" required="required" type="text" value="${authUser.name}">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="email" class="col-4 col-form-label">Role*</label>
                                                        <div class="col-8">
                                                            <input id="role" name="role" placeholder="Role"
                                                                   class="form-control here" required="required" type="text" value="${authUser.role}">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="email" class="col-4 col-form-label">Email*</label>
                                                        <div class="col-8">
                                                            <input id="email" name="email" placeholder="Email"
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
                                                        <label for="newpass" class="col-4 col-form-label">New Password</label>
                                                        <div class="col-8">
                                                            <input id="newpass" name="newpass" placeholder="New Password"
                                                                   class="form-control here" type="text">
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