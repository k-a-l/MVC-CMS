<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Patient</title>

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
        h2 {
            font-weight: bold;
            margin-bottom: 30px;
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
        }
        .btn-custom:hover {
            background-color: #0056b3;
        }
        .md-form label {
            color: #000;
        }
    </style>
</head>
<body>

    <div class="container mt-5">
        <h2 class="text-center">Add Patient</h2>
        <form id="addPatientForm" action="AddPatientServlet" method="post" class="needs-validation" novalidate>
            <!-- Name -->
            <div class="md-form">
                <input type="text" id="name" name="name" class="form-control" required>
                <label for="name">Name</label>
                <div class="invalid-feedback">Please provide a name.</div>
            </div>
            <!-- Date of Birth -->
            <div class="md-form">
                <input type="date" id="dob" name="dob" class="form-control" required>
                <label for="dob" class="active">Date of Birth</label>
                <div class="invalid-feedback">Please provide a date of birth.</div>
            </div>
            <!-- Age -->
            <div class="md-form">
                <input type="number" id="age" name="age" class="form-control" required>
                <label for="age">Age</label>
                <div class="invalid-feedback">Please provide an age.</div>
            </div>
            <!-- Gender -->
            <div class="md-form">
                <select id="gender" name="gender" class="form-control" required>
                    <option value="" disabled selected>Choose your option</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
                <label for="gender" class="active" id="labelgender">Gender</label>
                <div class="invalid-feedback">Please select a gender.</div>
            </div>
            <!-- Phone -->
            <div class="md-form">
                <input type="tel" id="phone" name="phone" class="form-control" pattern="^[0-9-+\s()]*$" required>
                <label for="phone">Phone</label>
                <div class="invalid-feedback">Invalid phone number format.</div>
            </div>
            <!-- Email -->
            <div class="md-form">
                <input type="email" id="email" name="email" class="form-control" required>
                <label for="email">Email</label>
                <div class="invalid-feedback">Invalid email format.</div>
            </div>
            <!-- Password -->
            <div class="md-form">
                <input type="password" id="password" name="password" class="form-control" required>
                <label for="password">Password</label>
                <div class="invalid-feedback">Please provide a password.</div>
            </div>
            <!-- Medical History -->
            <div class="md-form">
                <textarea id="medical_history" name="medical_history" class="form-control md-textarea" rows="3" required></textarea>
                <label for="medical_history">Medical History</label>
                <div class="invalid-feedback">Please provide medical history details.</div>
            </div>
            <!-- Address -->
            <div class="md-form">
                <textarea id="address" name="address" class="form-control md-textarea" rows="3" required></textarea>
                <label for="address">Address</label>
                <div class="invalid-feedback">Please provide an address.</div>
            </div>
            <!-- Submit Button -->
            <div class="text-center">
                <button type="submit" class="btn btn-custom btn-md">Submit</button>
                <a href="AddPatientServlet" class="btn btn-secondary btn-md">Back</a>
            </div>
        </form>
    </div>

    <!-- Bootstrap and MDB scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
    <script>
        (function () {
            'use strict';
            window.addEventListener('load', function () {
                var forms = document.getElementsByClassName('needs-validation');
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
