<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Clinic Management System</title>
    <!-- MDB CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
        }
        .login-container {
            margin-top: 50px;
            max-width: 400px;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .login-container h1 {
            font-size: 1.8rem;
            margin-bottom: 30px;
        }
        .form-control {
            border-radius: 30px;
        }
        .btn-primary {
            border-radius: 30px;
            width: 100%;
            padding: 10px;
        }
        .alert-danger {
            border-radius: 30px;
        }
    </style>
</head>

<body>
    <div class="d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="login-container">
            <h1 class="text-center text-primary">Clinic Management System</h1>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger text-center">
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>
            <form action="LoginServlet" method="post">
                <div class="form-group mb-4">
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" class="form-control" required>
                </div>
                <div class="form-group mb-4">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary">Login</button>
            </form>
        </div>
    </div>
    <!-- MDB JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.js"></script>
</body>

</html>
