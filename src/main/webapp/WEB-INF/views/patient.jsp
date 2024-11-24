<%@page import="com.clinic.model.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.clinic.model.Patient"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, shrink-to-fit=no">
<title>Manage Patients</title>
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
					<h1 class="mt-4">Manage Patients</h1>
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">Patient Data</h5>
							<table class="table table-striped">
								<thead>
									<tr>
<!-- 										<th>ID</th>
 -->										<th>Name</th>
<!-- 										<th>Date of Birth</th>
 -->										<th>Age</th>
										<th>Gender</th>
										<th>Phone</th>
<!-- 										<th>Email</th>
<!--  -->										<th>Address</th>
 										<th>Actions</th>
									</tr>
								</thead>
								<tbody>
									<%
                                        @SuppressWarnings("unchecked")
                                        List<Patient> patients = (List<Patient>) request.getAttribute("patients");
                                        if (patients != null) {
                                            for (Patient patient : patients) {
                                    %>
									<tr>
<%-- 										<td><%= patient.getId() %></td>
 --%>										<td><%= patient.getName() %></td>
<%-- 										<td><%= patient.getDobAsString() %></td>
 --%>										<td><%= patient.getAge() %></td>
										<td><%= patient.getGender() %></td>
										<td><%= patient.getPhone() %></td>
<%-- 										<td><%= patient.getEmail() %></td>
<%--  --%>										<td><%= patient.getAddress() %></td>
 									<td><a
											href="ViewPatientServlet?id=<%= patient.getId() %>"
											class="btn btn-info btn-sm">View</a> <a
											href="EditPatientServlet?id=<%= patient.getId() %>"
											class="btn btn-warning btn-sm">Edit</a> <a
											href="DeletePatientServlet?id=<%= patient.getId() %>"
											class="btn btn-danger btn-sm"
											onclick="return confirm('Are you sure you want to delete this patient?');">Delete</a>
											
										</td>
										
									</tr>
									<%
                                            }%>
                                            <tr>
                                            <td colspan="7"><a href="PatientServlet" class="btn btn-primary mt-2">Add Patient</a></td>
                                        </tr>
                                            
                                            <%
                                        } else {
                                    %>
									<tr>
										<td colspan="9">No patients found</td>
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

<h2>Send Message</h2>
    <form action="SendMessageServlet" method="post">
        <label for="receiverId">Receiver ID:</label>
        <input type="text" name="receiverId" required><br>
        <label for="message">Message:</label>
        <textarea name="message" required></textarea><br>
        <button type="submit">Send</button>
    </form>

    <h2>Messages</h2>
    <ul>
        <% 
            List<Message> messages = (List<Message>) request.getAttribute("messages");
            if (messages != null) {
                for (Message message : messages) { 
        %>
            <li><strong>From:</strong> <%= message.getSenderId() %> - <strong>To:</strong> <%= message.getReceiverId() %>
                <p><strong>Message:</strong> <%= message.getOriginalMessage() %></p>
                <p><strong>Time:</strong> <%= message.getTimestamp() %></p>
            </li>
        <% 
                } 
            } 
        %>
    </ul>


</body>

</html>
