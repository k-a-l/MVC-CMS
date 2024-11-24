<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.clinic.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Edit Doctor</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.js"></script>
</head>
<body>
    <div class="container">
        <h1>Edit Doctor</h1>
        <%
            Doctor doctor = (Doctor) request.getAttribute("doctor");
            if (doctor != null) {
        %>
        <form action="EditDoctorServlet" method="post">
            <input type="hidden" name="id" value="<%= doctor.getId() %>">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= doctor.getName() %>" required>
            </div>
            <div class="form-group">
                <label for="speciality">Speciality</label>
                <input type="text" class="form-control" id="speciality" name="speciality" value="<%= doctor.getSpeciality() %>" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="text" class="form-control" id="phone" name="phone" value="<%= doctor.getPhone() %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= doctor.getEmail() %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="AddDoctorServlet" class="btn btn-secondary">Cancel</a>
        </form>
        <% } else { %>
        <p>No doctor details found.</p>
        <% } %>
    </div>
</body>
</html>
