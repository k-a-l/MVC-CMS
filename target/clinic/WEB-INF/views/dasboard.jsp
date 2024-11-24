<%@ page import="com.clinic.util.EncryptUtil"%>
<%@ page import="java.util.List, java.util.Map, java.util.HashMap"%>
<%@ page import="java.sql.Connection, java.sql.SQLException"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.clinic.model.Patient, com.clinic.model.Message"%>
<%@ page import="com.clinic.dao.PatientDAO"%>
<%@ page import="com.clinic.dao.UserDAO"%>
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
    <!-- Custom Styles -->
    <style>
        /* Sidebar styles */
        #sidebar {
            min-width: 250px;
            max-width: 250px;
            height: 100vh;
            position: fixed;
        }

        .container-fluid {
            margin-left: 250px;
        }

        /* Messaging styles */
        .message-box {
            max-height: 500px;
            overflow-y: auto;
        }

        .message-list {
            list-style: none;
            padding: 0;
        }

        .message-item {
            margin-bottom: 15px;
        }

        .message-item .card {
            margin: 0;
        }

        .reply-button {
            margin-top: 10px;
        }

        /* Quick Access styles */
        .quick-access .card-body {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .quick-access .btn {
            margin-bottom: 10px;
            width: 100%;
        }

        /* Manage Sections styles */
        .manage-section .card {
            height: 100%;
        }
    </style>
</head>

<body>
    <!-- Sidebar -->
    <div class="d-flex">
        <div class="bg-dark text-white p-3" id="sidebar">
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

        <!-- Main content -->
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 p-3">
                    <!-- Display logged-in user's name -->
                    <%
                        com.clinic.model.User loggedInUser = (com.clinic.model.User) session.getAttribute("user");
                        Patient loggedInPatient = (Patient) session.getAttribute("patient");
                    %>
                    <% if (loggedInUser != null) { %>
                        <h1 class="mt-4">Welcome, <%= loggedInUser.getUsername() %>!</h1>
                    <% } else if (loggedInPatient != null) { %>
                        <h1 class="mt-4">Welcome, <%= loggedInPatient.getName() %>!</h1>
                    <% } else { %>
                        <h1 class="mt-4">Welcome to the Dashboard</h1>
                    <% } %>

                    <!-- Quick Access -->
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <div class="card quick-access">
                                <div class="card-body text-center">
                                    <h5 class="card-title">Quick Access</h5>
                                    <a href="DoctorServlet" class="btn btn-primary mt-2">Add Doctor</a>
                                    <a href="PatientServlet" class="btn btn-primary mt-2">Add Patient</a>
                                    <a href="InventoryServlet" class="btn btn-primary mt-2">Add Inventory</a>
                                    <a href="AddUserServlet" class="btn btn-primary mt-2">Add User</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-9 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Take Charge</h5>
                                    <ul class="list-group">
                                        <li class="list-group-item">
                                            <a href="LoadRecordMedicineFormServlet" class="btn btn-primary mt-2">Treatment</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Manage Sections -->
                    <div class="row mt-4 manage-section">
                        <div class="col-md-4 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Manage Doctors</h5>
                                    <p class="card-text">View, edit, and manage doctor details.</p>
                                    <a href="AddDoctorServlet" class="btn btn-primary">Manage Doctors</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Manage Patients</h5>
                                    <p class="card-text">View, edit, and manage patient details.</p>
                                    <a href="AddPatientServlet" class="btn btn-primary">Manage Patients</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="card">
                                <div class="card-body">
                                    <h5 class="card-title">Manage Inventory</h5>
                                    <p class="card-text">View, edit, and manage inventory items.</p>
                                    <a href="AddInventoryServlet" class="btn btn-primary">Manage Inventory</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Messaging Section -->
                    <div class="row mt-4">
                        <!-- Send Message Form -->
                        <div class="col-md-6">
                            <h3>Send Message</h3>
                            <%
                                String replyTo = request.getParameter("replyTo");
                                String receiverName = "";
                                String receiverIdValue = "";
                                if (replyTo != null && !replyTo.isEmpty()) {
                                    receiverIdValue = replyTo;
                                    Connection conn = null;
                                    try {
                                        conn = DBConnect.getConnection();
                                        PatientDAO patientDAO = new PatientDAO(conn);
                                        Patient receiverPatient = patientDAO.getPatientById(Integer.parseInt(replyTo));
                                        if (receiverPatient != null) {
                                            receiverName = receiverPatient.getName();
                                        } else {
                                            // If not a patient, check if it's a user (staff)
                                            UserDAO userDAO = new UserDAO();
                                            com.clinic.model.User receiverUser = userDAO.getUserById(Integer.parseInt(replyTo));
                                            if (receiverUser != null) {
                                                receiverName = receiverUser.getUsername();
                                            } else {
                                                receiverName = "Unknown Receiver";
                                            }
                                        }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                        receiverName = "Unknown Receiver";
                                    } finally {
                                        if (conn != null) {
                                            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                                        }
                                    }
                                }
                            %>
                            <form action="SendMessageServlet" method="post">
                                <div class="form-group">
                                    <% if (!receiverIdValue.isEmpty()) { %>
                                        <label for="receiverName">Replying to:</label>
                                        <input type="text" id="receiverName" class="form-control" value="<%= receiverName %>" disabled>
                                        <input type="hidden" id="receiverId" name="receiverId" value="<%= receiverIdValue %>">
                                    <% } else { %>
                                        <label for="receiverId">Receiver ID:</label>
                                        <input type="text" id="receiverId" name="receiverId" class="form-control" required>
                                    <% } %>
                                </div>
                                <div class="form-group">
                                    <label for="message">Message:</label>
                                    <textarea id="message" name="message" class="form-control" rows="4" required></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Send</button>
                            </form>
                        </div>

                        <!-- Received Messages -->
                        <div class="col-md-6">
                            <h3>Received Messages</h3>
                            <div class="message-box">
                                <ul class="message-list">
                                    <% 
                                        List<Message> messages = (List<Message>) request.getAttribute("messages");
                                        if (messages != null && !messages.isEmpty()) {
                                            // Map to store sender IDs and names to avoid duplicate DB calls
                                            Map<Integer, String> senderIdToName = new HashMap<>();
                                            Connection conn = null;
                                            try {
                                                conn = DBConnect.getConnection();
                                                PatientDAO patientDAO = new PatientDAO(conn);
                                                UserDAO userDAO = new UserDAO();

                                                for (Message message : messages) {
                                                    int senderId = message.getSenderId();
                                                    String senderName = senderIdToName.get(senderId);
                                                    if (senderName == null) {
                                                        // Fetch sender name from database
                                                        Patient senderPatient = patientDAO.getPatientById(senderId);
                                                        if (senderPatient != null) {
                                                            senderName = senderPatient.getName();
                                                        } else {
                                                            // If not a patient, check if it's a user (staff)
                                                            com.clinic.model.User senderUser = userDAO.getUserById(senderId);
                                                            if (senderUser != null) {
                                                                senderName = senderUser.getUsername();
                                                            } else {
                                                                senderName = "Unknown Sender";
                                                            }
                                                        }
                                                        senderIdToName.put(senderId, senderName);
                                                    }
                                    %>
                                    <li class="message-item">
                                        <div class="card">
                                            <div class="card-body">
                                                <h5 class="card-title">From: <%= senderName %></h5>
                                                <p class="card-text"><%= EncryptUtil.decryptMessage(message.getEncryptedMessage()) %></p>
                                                <form action="DashboardServlet" method="get" class="reply-button">
                                                    <input type="hidden" name="replyTo" value="<%= senderId %>" />
                                                    <button type="submit" class="btn btn-sm btn-primary">Reply</button>
                                                </form>
                                            </div>
                                        </div>
                                    </li>
                                    <%
                                                }
                                            } catch (SQLException e) {
                                                e.printStackTrace();
                                    %>
                                                <li class="list-group-item">Error loading messages.</li>
                                    <%
                                            } finally {
                                                if (conn != null) {
                                                    try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                                                }
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

                    <!-- JavaScript to fetch notifications count -->
                    <script>
                        // Fetch notifications count from the server and update the badge
                        function updateNotificationCount() {
                            fetch('NotificationServlet')
                                .then(response => response.json())
                                .then(data => {
                                    document.getElementById('notificationCount').textContent = data.count;
                                });
                        }

                        updateNotificationCount();
                    </script>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
