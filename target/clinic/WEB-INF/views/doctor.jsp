<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List"%>
<%@ page import="com.clinic.model.Doctor"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, shrink-to-fit=no">
<title>Manage Doctors</title>
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
					<h1 class="mt-4">Manage Doctors</h1>
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Doctor Data</h5>
							<table class="table table-striped">
								<thead>
									<tr>
										<th>ID</th>
										<th>Name</th>
										<th>Speciality</th>
										<th>Phone</th>
										<!-- <th>Email</th> -->
										<th>Actions</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${not empty doctors}">
											<c:forEach var="doctor" items="${doctors}">
												<tr>
													<td>${doctor.id}</td>
													<td>${doctor.name}</td>
													<td>${doctor.speciality}</td>
													<td>${doctor.phone}</td>
													<!-- <td>${doctor.email}</td> -->
													<td><a href="ViewDoctorServlet?id=${doctor.id}"
														class="btn btn-info btn-sm">View</a> <a
														href="EditDoctorServlet?id=${doctor.id}"
														class="btn btn-warning btn-sm">Edit</a> <a
														href="DeleteDoctorServlet?id=${doctor.id}"
														class="btn btn-danger btn-sm"
														onclick="return confirm('Are you sure you want to delete this doctor?');">Delete</a>
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr>
												<td colspan="5">No doctors found</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

</html>
 --%>
 
 
 
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.clinic.model.Doctor" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, shrink-to-fit=no">
<title>Manage Doctors</title>
<!-- MDB CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet">
<!-- MDB JS -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.js"></script>
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
        <%@ include file="sidebar.jsp" %>

        <!-- Main content -->
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 p-3">
                    <h1 class="mt-4">Manage Doctors</h1>
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Doctor Data</h5>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Speciality</th>
                                        <th>Phone</th>
                                        <!-- <th>Email</th> -->
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        @SuppressWarnings("unchecked")
                                        List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");
                                        if (doctors != null) {
                                            for (Doctor doctor : doctors) {
                                    %>
                                        <tr>
                                            <td><%= doctor.getId() %></td>
                                            <td><%= doctor.getName() %></td>
                                            <td><%= doctor.getSpeciality() %></td>
                                            <td><%= doctor.getPhone() %></td>
                                            <!-- <td><%= doctor.getEmail() %></td> -->
                                            <td>
                                                <a href="ViewDoctorServlet?id=<%= doctor.getId() %>" class="btn btn-info btn-sm">View</a>
                                                <a href="EditDoctorServlet?id=<%= doctor.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                                                <a href="DeleteDoctorServlet?id=<%= doctor.getId() %>" class="btn btn-danger btn-sm"
                                                    onclick="return confirm('Are you sure you want to delete this doctor?');">Delete</a>
                                            </td>
                                        </tr>
                                        
                                    <%
                                            }%>
                                            <tr>
                                            <td colspan="5"><a href="DoctorServlet" class="btn btn-primary mt-2">Add Doctor</a></td>
                                        </tr>
                                            <%
                                        } else {
                                    %>
                                        <tr>
                                            <td colspan="5">No doctors found</td>
                                        </tr>
                                        
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>

</html>
 