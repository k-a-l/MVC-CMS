<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.clinic.model.Patient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Patient</title>
    <!-- MDB CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet">
    <!-- MDB JS -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.js"></script>
</head>
<body>
    <div class="container my-5">
        <h1>View Patient</h1>
        <%
            Patient patient = (Patient) request.getAttribute("patient");
            if (patient != null) {
        %>
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Patient Details</h5>
                <p><strong>ID:</strong> <%= patient.getId() %></p>
                <p><strong>Name:</strong> <%= patient.getName() %></p>
                <p><strong>Date of Birth:</strong> <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(patient.getDob()) %></p>
                <p><strong>Age:</strong> <%= patient.getAge() %></p>
                <p><strong>Gender:</strong> <%= patient.getGender() %></p>
                <p><strong>Phone:</strong> <%= patient.getPhone() %></p>
                <p><strong>Email:</strong> <%= patient.getEmail() %></p>
                <p><strong>Password:</strong> <%= patient.getPassword() %></p>
                <p><strong>Medical History:</strong> <%= patient.getMedicalHistory() %></p>
                <p><strong>Address:</strong> <%= patient.getAddress() %></p>
                <a href="AddPatientServlet" class="btn btn-primary">Back to List</a>
            </div>
        </div>
        <% } else { %>
        <p>No patient details found.</p>
        <% } %>
    </div>
</body>
</html>
