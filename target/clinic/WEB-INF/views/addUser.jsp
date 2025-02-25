<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add User</title>

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <style>
        .container {
            margin-top: 50px;
        }
        .was-validated .form-control:invalid {
            border-color: #dc3545;
        }
        .was-validated .form-control:valid {
            border-color: #28a745;
        }
    </style>
</head>

<body>

    <div class="container mt-5">
        <h2 class="text-center">Add User</h2>
        <form id="addUserForm" action="AddUserServlet" method="post" class="needs-validation" novalidate>
            <!-- Username -->
            <div class="md-form">
                <input type="text" id="username" name="username" class="form-control" required>
                <label for="username">Username</label>
                <div class="invalid-feedback">Please provide a username.</div>
            </div>
            <!-- Password -->
            <div class="md-form">
                <input type="password" id="password" name="password" class="form-control" required>
                <label for="password">Password</label>
                <div class="invalid-feedback">Please provide a password.</div>
            </div>
            <!-- Role -->
            <div class="md-form">
                <input type="text" id="role" name="role" class="form-control" required>
                <label for="role">Role (e.g., admin, user)</label>
                <div class="invalid-feedback">Please provide a role.</div>
            </div>
            <!-- Submit Button -->
            <div class="text-center">
                <button type="submit" class="btn btn-primary btn-md">Add User</button>
                <a href="DashboardServlet" class="btn btn-secondary btn-md">Back to Dashboard</a>
            </div>
        </form>
    </div>

    <!-- Bootstrap and MDB scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
    <script>
        // Example starter JavaScript for disabling form submissions if there are invalid fields
        (function () {
            'use strict';
            window.addEventListener('load', function () {
                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                var forms = document.getElementsByClassName('needs-validation');
                // Loop over them and prevent submission
                var validation = Array.prototype.filter.call(forms, function (form) {
                    form.addEventListener('submit', function (event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();
    </script>

</body>

</html>
