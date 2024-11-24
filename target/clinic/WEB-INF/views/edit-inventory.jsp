<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.clinic.model.Inventory" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Edit Inventory</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Material Design Bootstrap -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/css/mdb.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1>Edit Inventory</h1>
        <%
            Inventory inventory = (Inventory) request.getAttribute("inventory");
            if (inventory != null) {
        %>
        <form action="EditInventoryServlet" method="post">
            <input type="hidden" name="id" value="<%= inventory.getId() %>">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= inventory.getName() %>" required>
            </div>
            <div class="form-group">
                <label for="quantity">Quantity</label>
                <input type="number" class="form-control" id="quantity" name="quantity" value="<%= inventory.getQuantity() %>" required>
            </div>
            <div class="form-group">
                <label for="manufacture_date">Manufacture Date</label>
                <input type="date" class="form-control" id="manufacture_date" name="manufacture_date" value="<%= inventory.getManufactureDate() %>" required>
            </div>
            <div class="form-group">
                <label for="expiry_date">Expiry Date</label>
                <input type="date" class="form-control" id="expiry_date" name="expiry_date" value="<%= inventory.getExpiryDate() %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Save</button>
            <a href="InventoryServlet" class="btn btn-secondary">Cancel</a>
        </form>
        <% } else { %>
        <p>No inventory details found.</p>
        <% } %>
    </div>

    <!-- Bootstrap and MDB scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.19.1/js/mdb.min.js"></script>
</body>
</html>
