<%@page import="java.util.ArrayList"%>
<%@ page import="com.clinic.util.EncryptUtil"%>
<%@ page import="java.util.List, java.util.Map, java.util.HashMap"%>
<%@ page import="java.sql.Connection, java.sql.SQLException"%>
<%@ page
	import="com.clinic.model.Patient, com.clinic.model.User, com.clinic.model.Message"%>
<%@ page
	import="com.clinic.dao.PatientDAO, com.clinic.dao.UserDAO, com.clinic.dao.MessageDAO"%>
<%@ page import="com.clinic.util.DBConnect"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- Required meta tags and CSS/JS includes -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dashboard</title>
<!-- Include MDB UI Kit CSS -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css"
	rel="stylesheet">
<!-- Include MDB UI Kit JS -->
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

.message-box {
	max-height: 300px;
	overflow-y: auto;
}
</style>
</head>

<body>

	<!-- Sidebar -->
	<div class="d-flex">
		<div class="bg-dark text-white p-3" id="sidebar">
			<h4>Clinic Management</h4>
			<h4>Clinic Management</h4>
			<ul class="nav flex-column">
				<li class="nav-item"><a class="nav-link text-white"
					href="DashboardServlet">Dashboard</a></li>
				<li class="nav-item"><a class="nav-link text-white"
					href="AddDoctorServlet">Manage Doctors</a></li>
				<li class="nav-item"><a class="nav-link text-white"
					href="AddPatientServlet">Manage Patients</a></li>
				<li class="nav-item"><a class="nav-link text-white"
					href="AddInventoryServlet">Manage Inventory</a></li>
				<li class="nav-item"><a class="nav-link text-white"
					href="UserServlet">Manage Users</a></li>
				<li class="nav-item"><a class="nav-link text-white"
					href="NotificationServlet">Notifications <span
						class="badge badge-light" id="notificationCount"></span>
				</a></li>
			</ul>
			<div class="mt-4">
				<a href="LogoutServlet" class="btn btn-danger">Logout</a>
			</div>
		</div>
			<!-- Sidebar content (unchanged) -->
		

		<!-- Main content -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-12 p-3">
					<h1 class="mt-4">Dashboard</h1>
<div class="row">
						<div class="col-md-3 mb-3">
							<div class="card">
								<div class="card-body text-center">
									<h5 class="card-title">Quick Access</h5>
									<a href="DoctorServlet" class="btn btn-primary mt-2">Add
										Doctor</a> <a href="PatientServlet" class="btn btn-primary mt-2">Add
										Patient</a> <a href="InventoryServlet"
										class="btn btn-primary mt-2">Add Inventory</a> <a
										href="AddUserServlet" class="btn btn-primary mt-2">Add
										User</a>
								</div>
							</div>
						</div>
						<div class="col-md-9 mb-3">
							<div class="card">
								<div class="card-body">
									<h5 class="card-title">Take Charge</h5>
									<ul class="list-group">
										<li class="list-group-item"><a
											href="LoadRecordMedicineFormServlet"
											class="btn btn-primary mt-2">Treatment</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>

					<!-- Manage Sections -->
					<div class="row mt-4">
						<div class="col-md-4 mb-3">
							<div class="card">
								<div class="card-body">
									<h5 class="card-title">Manage Doctors</h5>
									<p class="card-text">View, edit, and manage doctor details.</p>
									<a href="AddDoctorServlet" class="btn btn-primary">Manage
										Doctors</a>
								</div>
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<div class="card">
								<div class="card-body">
									<h5 class="card-title">Manage Patients</h5>
									<p class="card-text">View, edit, and manage patient
										details.</p>
									<a href="AddPatientServlet" class="btn btn-primary">Manage
										Patients</a>
								</div>
							</div>
						</div>
						<div class="col-md-4 mb-3">
							<div class="card">
								<div class="card-body">
									<h5 class="card-title">Manage Inventory</h5>
									<p class="card-text">View, edit, and manage inventory
										items.</p>
									<a href="AddInventoryServlet" class="btn btn-primary">Manage
										Inventory</a>
								</div>
							</div>
						</div>
					</div>

					<!-- Quick Access (Unchanged) -->

					<!-- Manage Sections (Unchanged) -->

					<!-- Messaging Section -->
					<div class="row mt-4">
						<!-- Send Message Form -->
						<div class="col-md-6">
							<h3>Send Message</h3>
							<%
                                // Retrieve logged-in user
                                User loggedInUser = (User) session.getAttribute("user");
                                if (loggedInUser == null) {
                                    response.sendRedirect("login.jsp");
                                    return;
                                }
                                int loggedInUserId = loggedInUser.getId();

                                // Get list of patients and users
                                List<Patient> patients = new ArrayList<>();
                                List<User> users = new ArrayList<>();
                                Connection conn = null;
                                try {
                                    conn = DBConnect.getConnection();
                                    PatientDAO patientDAO = new PatientDAO(conn);
                                    UserDAO userDAO = new UserDAO();
                                    patients = patientDAO.getAllPatients();
                                    users = userDAO.getAllUsers();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } finally {
                                    if (conn != null) {
                                        try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                                    }
                                }
                            %>
							<form action="SendMessageServlet" method="post">
								<div class="form-group">
									<label for="receiverId">Select Receiver:</label> <select
										id="receiverId" name="receiverId" class="form-control"
										required>
										<option value="" disabled selected>Select a receiver</option>
										<optgroup label="Patients">
											<% for (Patient patient : patients) { %>
											<% if (patient.getId() != loggedInUserId) { %>
											<option value="<%= patient.getId() %>"><%= patient.getName() %>
												(ID:
												<%= patient.getId() %>)
											</option>
											<% } %>
											<% } %>
										</optgroup>
										<optgroup label="Staff">
											<% for (User userItem : users) { %>
											<% if (userItem.getId() != loggedInUserId) { %>
											<option value="<%= userItem.getId() %>"><%= userItem.getUsername() %>
												(ID:
												<%= userItem.getId() %>)
											</option>
											<% } %>
											<% } %>
										</optgroup>
									</select>
								</div>
								<div class="form-group">
									<label for="message">Message:</label>
									<textarea id="message" name="message" class="form-control"
										rows="4" required></textarea>
								</div>
								<button type="submit" class="btn btn-primary">Send</button>
							</form>
						</div>

						<!-- Messages -->
						<div class="col-md-6">
							<h3>Messages</h3>
							<%
                                // Retrieve messages and prepare ID-to-Name mapping
                                List<Message> messages = new ArrayList<>();
                                Map<Integer, String> idToName = new HashMap<>();
                                conn = null;
                                try {
                                    conn = DBConnect.getConnection();
                                    MessageDAO messageDAO = new MessageDAO(conn);
                                    PatientDAO patientDAO = new PatientDAO(conn);
                                    UserDAO userDAO = new UserDAO();

                                    // Fetch messages where the logged-in user is either sender or receiver
                                    messages = messageDAO.getMessagesForUser(loggedInUserId);

                                    for (Message message : messages) {
                                        int senderId = message.getSenderId();
                                        int receiverId = message.getReceiverId();

                                        // Get sender name
                                        if (!idToName.containsKey(senderId)) {
                                            User senderUser = userDAO.getUserById(senderId);
                                            if (senderUser != null) {
                                                idToName.put(senderId, senderUser.getUsername());
                                            } else {
                                                Patient senderPatient = patientDAO.getPatientById(senderId);
                                                if (senderPatient != null) {
                                                    idToName.put(senderId, senderPatient.getName());
                                                } else {
                                                    idToName.put(senderId, "Unknown User");
                                                }
                                            }
                                        }

                                        // Get receiver name
                                        if (!idToName.containsKey(receiverId)) {
                                            User receiverUser = userDAO.getUserById(receiverId);
                                            if (receiverUser != null) {
                                                idToName.put(receiverId, receiverUser.getUsername());
                                            } else {
                                                Patient receiverPatient = patientDAO.getPatientById(receiverId);
                                                if (receiverPatient != null) {
                                                    idToName.put(receiverId, receiverPatient.getName());
                                                } else {
                                                    idToName.put(receiverId, "Unknown User");
                                                }
                                            }
                                        }
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } finally {
                                    if (conn != null) {
                                        try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                                    }
                                }
                            %>
							<div class="message-box">
								<ul class="list-group">
									<% 
                                        if (messages != null && !messages.isEmpty()) {
                                            for (Message message : messages) {
                                                boolean isSent = message.getSenderId() == loggedInUserId;
                                    %>
									<li class="list-group-item">
										<p>
											<% if (isSent) { %>
											<strong>To:</strong>
											<%= idToName.get(message.getReceiverId()) %>
											(ID:
											<%= message.getReceiverId() %>)
											<% } else { %>
											<strong>From:</strong>
											<%= idToName.get(message.getSenderId()) %>
											(ID:
											<%= message.getSenderId() %>)
											<% } %>
										</p>
										<p>
											<strong>Message:</strong>
											<%= EncryptUtil.decryptMessage(message.getEncryptedMessage()) %>
										</p>
									</li>
									<% 
                                            }
                                        } else {
                                    %>
									<li class="list-group-item">No messages found.</li>
									<% 
                                        }
                                    %>
								</ul>
							</div>
						</div>
					</div>

					<!-- Additional Content (Unchanged) -->
				</div>
			</div>
		</div>
	</div>
</body>

</html>
