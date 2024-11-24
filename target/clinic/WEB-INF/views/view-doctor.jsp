<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.clinic.model.Doctor" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Doctor</title>
    <!-- MDB CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet">
    <!-- MDB JS -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.js"></script>
    <!-- Custom CSS -->
    <style>
        .details {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .qr-code {
            max-width: 200px;
            max-height: 200px;
        }
    </style>
</head>
<body>
    <div class="container my-5">
        <h1>View Doctor</h1>
        <%
            Doctor doctor = (Doctor) request.getAttribute("doctor");
            if (doctor != null) {
        %>
        <div class="card">
            <div class="card-body details">
                <div>
                    <h5 class="card-title">Doctor Details</h5>
                    <p><strong>ID:</strong> <%= doctor.getId() %></p>
                    <p><strong>Name:</strong> <%= doctor.getName() %></p>
                    <p><strong>Speciality:</strong> <%= doctor.getSpeciality() %></p>
                    <p><strong>Phone:</strong> <%= doctor.getPhone() %></p>
                    <p><strong>Email:</strong> <%= doctor.getEmail() %></p>
                    <a href="AddDoctorServlet" class="btn btn-primary">Back to List</a>
                </div>
                <div>
                    <h5>QR Code:</h5>
                    <img class="qr-code" src="QRCodeServlet?id=<%= doctor.getId() %>&name=<%= doctor.getName() %>&speciality=<%= doctor.getSpeciality() %>&phone=<%= doctor.getPhone() %>&email=<%= doctor.getEmail() %>" alt="QR Code">
                </div>
            </div>
        </div>
        <% } else { %>
        <p>No doctor details found.</p>
        <% } %>
    </div>
</body>
</html>
