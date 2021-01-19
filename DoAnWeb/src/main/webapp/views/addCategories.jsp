<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="common/head.jsp"/>
<body>
<jsp:include page="common/navbar.jsp"/>
<main>
    <script>
        $('#frmRegister').on('submit', function (e) {
            e.preventDefault();
        });
    </script>
    <form method="post" id="frmRegister">
        <div class="card">
            <div class="card-header">
                <h4>ADD Categoris</h4>
            </div>
            <div class="card-body">
                <div class="form-group">
                    <label for="txtName">Name</label>
                    <input type="text" class="form-control" id="txtName" name="name">
                </div>
                <div class="form-group">
                    <label for="txtImage">Image</label>
                    <input type="text" class="form-control" id="txtImage" name="image">
                </div>
            <div class="card-footer">
                <button type="submit" class="btn btn-outline-success">
                    <i class="fa fa-check" aria-hidden="true"></i>
                    ADD
                </button>
            </div>
        </div>
        </div>
    </form>

</main>
<jsp:include page="common/footer.jsp"/>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</body>
</html>