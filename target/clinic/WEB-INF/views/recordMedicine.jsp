<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.clinic.model.Doctor"%>
<%@page import="com.clinic.model.Patient"%>
<%@page import="com.clinic.model.Inventory"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Record Medicine Given</title>

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
        <h2 class="text-center">Record Medicine Given</h2>
        <form id="recordMedicineForm" action="RecordMedicineServlet" method="post" class="needs-validation" novalidate>
            <!-- Doctor -->
            <div class="md-form">
                <select id="doctorId" name="doctorId" class="form-control" required>
                    <option value="" disabled selected>Select Doctor</option>
                    <% 
                        List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");
                        for (Doctor doctor : doctors) {
                            out.println("<option value='" + doctor.getId() + "'>" + doctor.getName() + "</option>");
                        }
                    %>
                </select>
                <label for="doctorId" class="active">Doctor</label>
                <div class="invalid-feedback">Please select a doctor.</div>
            </div>
            <!-- Patient -->
            <div class="md-form">
                <select id="patientId" name="patientId" class="form-control" required>
                    <option value="" disabled selected>Select Patient</option>
                    <% 
                        List<Patient> patients = (List<Patient>) request.getAttribute("patients");
                        for (Patient patient : patients) {
                            out.println("<option value='" + patient.getId() + "'>" + patient.getName() + "</option>");
                        }
                    %>
                </select>
                <label for="patientId" class="active">Patient</label>
                <div class="invalid-feedback">Please select a patient.</div>
            </div>
            <!-- Medicine -->
            <div class="md-form">
                <select id="inventoryId" name="inventoryId" class="form-control" required>
                    <option value="" disabled selected>Select Medicine</option>
                    <% 
                        List<Inventory> inventories = (List<Inventory>) request.getAttribute("inventories");
                        for (Inventory inventory : inventories) {
                            out.println("<option value='" + inventory.getId() + "'>" + inventory.getName() + "</option>");
                        }
                    %>
                </select>
                <label for="inventoryId" class="active">Medicine</label>
                <div class="invalid-feedback">Please select a medicine.</div>
            </div>
            <!-- Quantity Given -->
            <div class="md-form">
                <input type="number" id="quantityGiven" name="quantityGiven" class="form-control" required>
                <label for="quantityGiven">Quantity Given</label>
                <div class="invalid-feedback">Please provide the quantity given.</div>
            </div>
            <!-- Submit Button -->
            <div class="text-center">
                <button type="submit" class="btn btn-primary btn-md">Submit</button>
                <a href="DashboardServlet" class="btn btn-secondary btn-md">Back</a>
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
