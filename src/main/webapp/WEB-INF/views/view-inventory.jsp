<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.clinic.model.Inventory" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Inventory</title>
    <!-- MDB CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet">
    <!-- MDB JS -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.js"></script>
</head>
<body>
    <div class="container my-5">
        <h1>View Inventory</h1>
        <%
            Inventory inventory = (Inventory) request.getAttribute("inventory");
            if (inventory != null) {
        %>
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Inventory Details</h5>
                <p><strong>ID:</strong> <%= inventory.getId() %></p>
                <p><strong>Name:</strong> <%= inventory.getName() %></p>
                <p><strong>Quantity:</strong> <%= inventory.getQuantity() %></p>
                <p><strong>Manufacture Date:</strong> <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(inventory.getManufactureDate()) %></p>
                <p><strong>Expiry Date:</strong> <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(inventory.getExpiryDate()) %></p>
                <a href="AddInventoryServlet" class="btn btn-primary">Back to List</a>
            </div>
        </div>
        <% } else { %>
        <p>No inventory details found.</p>
        <% } %>
    </div>
</body>
</html>
