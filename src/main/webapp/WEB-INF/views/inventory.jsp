<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.clinic.model.Inventory"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Manage Inventory</title>
<!-- MDB CSS -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css"
	rel="stylesheet">
<!-- MDB JS -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.js"></script>
<!-- Custom Styles for Sidebar -->
<style>
#sidebar {
	min-width: 250px;
	max-width: 250px;
	height: 100vh;
	position: fixed;
	top: 0;
	left: 0;
	background-color: #343a40;
	color: white;
	padding: 1rem;
	overflow-y: auto;
}

.container-fluid {
	margin-left: 250px;
	padding: 1rem;
}

.table-container {
	overflow-x: auto; /* Allow horizontal scrolling */
}

table {
	width: 100%;
	table-layout: auto; /* Adjust table layout to fit content */
}

.card {
	margin-bottom: 1rem;
}
/* Responsive adjustments */
@media ( max-width : 768px) {
	.container-fluid {
		margin-left: 0;
	}
	#sidebar {
		width: 100%;
		position: static;
	}
}
</style>
</head>

<body>
	<!-- Include Sidebar -->
	<div id="sidebar">
		<%@include file="sidebar.jsp" %>
		
	</div>

	<!-- Main content -->
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12 p-3">
				<h1 class="mt-4">Manage Inventory</h1>
				<div class="card">
					<div class="card-body table-container">
						<h5 class="card-title">Inventory Data</h5>
						<table class="table table-striped">
							<thead>
								<tr>
<!-- 									<th>ID</th>
 -->									<th>Name</th>
									<th>Quantity</th>
<!-- 									<th>Manufacture Date</th>
 -->									<th>Expiry Date</th>
									<th>Actions</th>
								</tr>
							</thead>
							<tbody>
								<%
									@SuppressWarnings("unchecked")
                                    List<Inventory> inventoryList = (List<Inventory>) request.getAttribute("inventoryList");
                                    if (inventoryList != null) {
                                        for (Inventory inventory : inventoryList) {
                                %>
								<tr>
<%-- 									<td><%= inventory.getId() %></td>
 --%>									<td><%= inventory.getName() %></td>
									<td><%= inventory.getQuantity() %></td>
<%-- 									<td><%= inventory.getManufactureDate() %></td>
 --%>									<td><%= inventory.getExpiryDate() %></td>
									<td><a
										href=" ViewInventoryServlet?id=<%= inventory.getId() %>"
										class="btn btn-info btn-sm">View</a> <a
										href="EditInventoryServlet?id=<%= inventory.getId() %>"
										class="btn btn-warning btn-sm">Edit</a> <a
										href="DeleteInventoryServlet?id=<%= inventory.getId() %>"
										class="btn btn-danger btn-sm"
										onclick="return confirm('Are you sure you want to delete this inventory item?');">Delete</a>
									</td>
								</tr>
								<%
                                        }
                                    }
                                %>
                                <tr>
                                            <td colspan="5"><a href="InventoryServlet" class="btn btn-primary mt-2">Add Inventory</a></td>
                                        </tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>
