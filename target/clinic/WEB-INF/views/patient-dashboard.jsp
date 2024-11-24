<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List, java.util.Map, java.text.SimpleDateFormat"%>
<%@ page import="com.clinic.model.Patient, com.clinic.model.User, com.clinic.model.Message"%>
<%@ page import="com.clinic.util.DBConnect"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <!-- Required meta tags and CSS/JS includes -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard</title>
    <!-- Include MDB UI Kit CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.css" rel="stylesheet">
    <!-- Include MDB UI Kit JS -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.js"></script>
    <style>
        /* Message container */
        .message-container {
            display: flex;
            margin-bottom: 15px;
        }

        /* Sent messages */
        .message-container.sent {
            justify-content: flex-end;
        }

        .message-container.sent .message {
            background-color: #d1ecf1;
            text-align: left;
            border-radius: 15px;
            border-top-right-radius: 0;
        }

        /* Received messages */
        .message-container.received {
            justify-content: flex-start;
        }

        .message-container.received .message {
            background-color: #f8d7da;
            text-align: left;
            border-radius: 15px;
            border-top-left-radius: 0;
        }

        /* Message bubble */
        .message {
            max-width: 60%;
            padding: 10px;
            margin-bottom: 5px;
            position: relative;
            word-wrap: break-word;
        }

        /* Message text styling */
        .message p {
            margin: 0;
        }

        /* Message history styling */
        .message-history {
            max-height: 400px;
            overflow-y: auto;
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f5f5f5;
        }

        /* Timestamp styling */
        .message small {
            display: block;
            color: #666;
            font-size: 0.8em;
            margin-top: 5px;
        }

        /* Message bubble tails */
        .message-container.sent .message::after {
            content: '';
            position: absolute;
            top: 10px;
            right: -15px;
            border-width: 10px 0 10px 15px;
            border-style: solid;
            border-color: transparent transparent transparent #d1ecf1;
        }

        .message-container.received .message::before {
            content: '';
            position: absolute;
            top: 10px;
            left: -15px;
            border-width: 10px 15px 10px 0;
            border-style: solid;
            border-color: transparent #f8d7da transparent transparent;
        }

        /* Additional styles for the 'More' button and modal */
        .modal-header {
            background-color: #007bff;
            color: white;
        }

        .btn-more {
            margin-top: 10px;
        }
    </style>
</head>

<body>
    <div class="container my-5">
        <h1>Patient Dashboard</h1>

        <%
            // Retrieve the logged-in patient from the session
            Patient patient = (Patient) session.getAttribute("patient");
            List<User> users = (List<User>) request.getAttribute("users");
            List<Message> messages = (List<Message>) request.getAttribute("messages");
            Map<Integer, String> userMap = (Map<Integer, String>) request.getAttribute("userMap");

            if (patient != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String dobFormatted = patient.getDob() != null ? sdf.format(patient.getDob()) : "Not Provided";
        %>

        <!-- Patient Details -->
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Patient Details</h5>
                <!-- Display basic patient details -->
                <p><strong>ID:</strong> <%= patient.getId() %></p>
                <p><strong>Name:</strong> <%= patient.getName() %></p>
                <!-- 'More' button to show additional details -->
                <button type="button" class="btn btn-info btn-more" data-mdb-toggle="modal"
                    data-mdb-target="#patientDetailsModal">
                    More
                </button>
                <a href="LogoutServlet" class="btn btn-danger float-end">Logout</a>
            </div>
        </div>

        <!-- Modal for displaying additional patient details -->
        <div class="modal fade" id="patientDetailsModal" tabindex="-1" aria-labelledby="patientDetailsModalLabel"
            aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable">
                <!-- Added 'modal-dialog-scrollable' for scrolling -->
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="patientDetailsModalLabel">Patient Information</h5>
                        <button type="button" class="btn-close" data-mdb-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Display all patient details -->
                        <p><strong>ID:</strong> <%= patient.getId() %></p>
                        <p><strong>Name:</strong> <%= patient.getName() %></p>
                        <p><strong>Date of Birth:</strong> <%= dobFormatted %></p>
                        <p><strong>Gender:</strong> <%= patient.getGender() != null ? patient.getGender() : "Not Provided" %></p>
                        <p><strong>Email:</strong> <%= patient.getEmail() != null ? patient.getEmail() : "Not Provided" %></p>
                        <p><strong>Phone:</strong> <%= patient.getPhone() != null ? patient.getPhone() : "Not Provided" %></p>
                        <p><strong>Address:</strong> <%= patient.getAddress() != null ? patient.getAddress() : "Not Provided" %></p>
                        <p><strong>Medical History:</strong> <%= patient.getMedicalHistory() != null ? patient.getMedicalHistory() : "Not Provided" %></p>
                        <!-- Add more fields as necessary -->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-mdb-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Send a Message -->
        <div class="card mt-4">
            <div class="card-body">
                <h5 class="card-title">Send a Message</h5>
                <form action="SendMessageServlet" method="post">
                    <div class="form-group">
                        <label for="receiverId">Select a User to Message</label>
                        <select id="receiverId" name="receiverId" class="form-control" required>
                            <option value="" disabled selected>Select a user</option>
                            <%
                                if (users != null && !users.isEmpty()) {
                                    for (User user : users) {
                                        if (user.getId() != patient.getId()) {
                            %>
                            <option value="<%= user.getId() %>"><%= user.getUsername() %> - <%= user.getRole() %></option>
                            <%
                                        }
                                    }
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" class="form-control" rows="3" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Send Message</button>
                </form>
            </div>
        </div>

        <!-- Message History -->
        <div class="card mt-4">
            <div class="card-body">
                <h5 class="card-title">Message History</h5>
                <div class="message-history">
                    <%
                        if (messages != null && !messages.isEmpty()) {
                            for (Message msg : messages) {
                                boolean isSentByPatient = msg.getSenderId() == patient.getId();
                                String otherPartyUsername = "";

                                if (isSentByPatient) {
                                    // Message sent by patient
                                    if (userMap.containsKey(msg.getReceiverId())) {
                                        otherPartyUsername = userMap.get(msg.getReceiverId());
                                    } else if (msg.getReceiverId() == patient.getId()) {
                                        otherPartyUsername = patient.getName();
                                    } else {
                                        otherPartyUsername = "User ID " + msg.getReceiverId();
                                    }
                                } else {
                                    // Message received by patient
                                    if (userMap.containsKey(msg.getSenderId())) {
                                        otherPartyUsername = userMap.get(msg.getSenderId());
                                    } else if (msg.getSenderId() == patient.getId()) {
                                        otherPartyUsername = patient.getName();
                                    } else {
                                        otherPartyUsername = "User ID " + msg.getSenderId();
                                    }
                                }
                    %>
                    <div class="message-container <%= isSentByPatient ? "sent" : "received" %>">
                        <div class="message">
                            <p>
                                <strong><%= isSentByPatient ? "To: " : "From: " %> <%= otherPartyUsername %></strong>
                            </p>
                            <p><%= msg.getOriginalMessage() %></p>
                            <small><%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(msg.getTimestamp()) %></small>
                        </div>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <p>No messages found.</p>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>

        <%
            } else {
        %>
        <p>No patient details found.</p>
        <%
            }
        %>
    </div>

    <!-- Include MDB JavaScript -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.10.2/mdb.min.js"></script>
</body>

</html>
