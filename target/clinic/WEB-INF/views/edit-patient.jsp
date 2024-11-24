<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.clinic.model.Patient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Patient</title>
    <!-- MDB CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet">
    <!-- MDB JS -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.js"></script>
</head>
<body>
    <div class="container my-5">
        <h1>Edit Patient</h1>
        <%
            Patient patient = (Patient) request.getAttribute("patient");
            if (patient != null) {
        %>
        <form action="EditPatientServlet" method="post">
            <input type="hidden" name="id" value="<%= patient.getId() %>">
            
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= patient.getName() %>" required>
            </div>
            
            <div class="form-group">
                <label for="dob">Date of Birth</label>
                <input type="date" class="form-control" id="dob" name="dob" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(patient.getDob()) %>" required>
            </div>
            
            <div class="form-group">
                <label for="age">Age</label>
                <input type="number" class="form-control" id="age" name="age" value="<%= patient.getAge() %>" required>
            </div>
            
            <div class="form-group">
                <label for="gender">Gender</label>
                <select class="form-control" id="gender" name="gender" required>
                    <option value="Male" <%= "Male".equals(patient.getGender()) ? "selected" : "" %>>Male</option>
                    <option value="Female" <%= "Female".equals(patient.getGender()) ? "selected" : "" %>>Female</option>
                    <option value="Other" <%= "Other".equals(patient.getGender()) ? "selected" : "" %>>Other</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="text" class="form-control" id="phone" name="phone" value="<%= patient.getPhone() %>" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= patient.getEmail() %>" required>
            </div>
            
            <div class="form-group">
                <label for="address">Address</label>
                <textarea class="form-control" id="address" name="address" rows="3" required><%= patient.getAddress() %></textarea>
            </div>
            
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="AddPatientServlet" class="btn btn-secondary">Cancel</a>
        </form>
        <% } else { %>
        <p>No patient details found.</p>
        <% } %>
    </div>
</body>
</html>
