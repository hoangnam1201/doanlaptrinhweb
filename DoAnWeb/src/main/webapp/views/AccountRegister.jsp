<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<style>
    body {
        background-image: url("../static/images/bg-paper-texture.jpg");
        background-repeat: no-repeat;
        background-size: cover;
        height: 100%;
    }

    .card {
        width: 500px;
        margin: 15px 0px 15px 30%;
        box-shadow: 10px 10px gray;

    }
</style>
<t:genericpage>
    <jsp:body>
        <main>
            <script>
                $('#frmRegister').on('submit', function (e) {
                    e.preventDefault();
                    const username = $('#txtUsername').val();
                    if (username.length === 0) {
                        alert('Invalid username.');
                        return;
                    }
                    $.getJSON('${pageContext.request.contextPath}/account/isAvailable?user=' + username, function (data) {
                        if (data === true) {
                            $('#frmRegister').off('submit').submit();
                        } else {
                            alert('Not available.');
                        }
                    });
                });

                $('#txtUsername').select();
            </script>
            <form method="post" id="frmRegister">
                <div class="card">
                    <div class="card-header">
                        <h4>Account Registration</h4>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <label for="txtUsername">Username</label>
                            <input required type="text" class="form-control" id="txtUsername" name="username"placeholder="Username">
                        </div>
                        <div class="form-group">
                            <label for="txtPassword">Password</label>
                            <input required type="password" class="form-control" id="txtPassword" name="password" placeholder="Password">
                        </div>
                        <div class="form-group">
                            <label for="txtConfirm">Confirm password</label>
                            <input required type="password" class="form-control" id="txtConfirm" name="confirm" placeholder="Confirm password">
                        </div>
                        <div class="form-group">
                            <label for="txtName">Name</label>
                            <input required type="text" class="form-control" id="txtName" name="name" placeholder="Name">
                        </div>
                        <div class="form-group">
                            <label for="txtEmail">Email</label>
                            <input required type="text" class="form-control" id="txtEmail" name="email" placeholder="Email">
                        </div>
                    </div>
                    <div class="card-footer">
                        <button type="submit" class="btn btn-success">
                            <i class="fa fa-check" aria-hidden="true"></i>
                            Register
                        </button>
                    </div>
                </div>
            </form>
        </main>
    </jsp:body>
</t:genericpage>