<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.clinic.model.*"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, shrink-to-fit=no">
<title>Manage Users</title>
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
}

.container-fluid {
	margin-left: 250px;
}
</style>
</head>

<body>
	<!-- Include Sidebar -->
	<div class="d-flex">
		<%@ include file="sidebar.jsp"%>

		<!-- Main content -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-12 p-3">
					<h1 class="mt-4">Manage Users</h1>
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">User Data</h5>
							<table class="table table-striped">
								<thead>
									<tr>
																			<th>ID</th>
									
										<th>Username</th>
										<th>Role</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody>
									<%
                                        @SuppressWarnings("unchecked")
                                        List<User> users = (List<User>) request.getAttribute("users");
                                        if (users != null) {
                                            for (User user : users) {
                                    %>
									<tr>
																			<td><%= user.getId() %></td>
									
										<td><%= user.getUsername() %></td>
										<td><%= user.getRole() %></td>
										<td><a href="ViewUserServlet?id=<%= user.getId() %>"
											class="btn btn-info btn-sm">View</a> <a
											href="EditUserServlet?id=<%= user.getId() %>"
											class="btn btn-warning btn-sm">Edit</a> <a
											href="DeleteUserServlet?id=<%= user.getId() %>"
											class="btn btn-danger btn-sm"
											onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
										</td>
									</tr>
									<%
                                            }
                                        } else {
                                    %>
									<tr>
										<td colspan="3">No users found</td>
									</tr>
									<%
                                        }
                                    %>
								</tbody>
							</table>
						</div>
					</div>
					<div class="mt-3">
						<a href="AddUserServlet" class="btn btn-primary">Add User</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

</html>
