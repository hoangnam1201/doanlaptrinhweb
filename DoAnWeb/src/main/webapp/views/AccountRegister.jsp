<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<style>
    body{
        background-color: #6f42c1;
    }
    .card{
        display: flex;
        justify-content: center;
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
                            <input type="text" class="form-control" id="txtUsername" name="username">
                        </div>
                        <div class="form-group">
                            <label for="txtPassword">Password</label>
                            <input type="password" class="form-control" id="txtPassword" name="password">
                        </div>
                        <div class="form-group">
                            <label for="txtConfirm">Confirm password</label>
                            <input type="password" class="form-control" id="txtConfirm" name="confirm">
                        </div>
                        <div class="form-group">
                            <label for="txtName">Name</label>
                            <input type="text" class="form-control" id="txtName" name="name">
                        </div>
                        <div class="form-group">
                            <label for="txtEmail">Email</label>
                            <input type="text" class="form-control" id="txtEmail" name="email">
                        </div>
                    </div>
                    <div class="card-footer">
                        <button type="submit" class="btn btn-outline-success">
                            <i class="fa fa-check" aria-hidden="true"></i>
                            Register
                        </button>
                    </div>
                </div>
            </form>
        </main>
    </jsp:body>
</t:genericpage>