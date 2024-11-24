package com.clinic.controller;

import com.clinic.dao.MessageDAO;
import com.clinic.dao.UserDAO;
import com.clinic.model.Patient;
import com.clinic.model.Message;
import com.clinic.model.User;
import com.clinic.util.DBConnect;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

public class PatientDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false); // Get existing session without creating a new one

        if (session != null) {
            // Retrieve patient from the session
            Patient patient = (Patient) session.getAttribute("patient");

            if (patient != null) {
                Connection connection = null;

                try {
                    // Get database connection
                    connection = DBConnect.getConnection();

                    // Fetch messages for the patient
                    MessageDAO messageDAO = new MessageDAO(connection);
                    List<Message> messages = messageDAO.getMessagesForPatient(patient.getId());

                    // Fetch the list of users
                    UserDAO userDAO = new UserDAO();
                    List<User> users = userDAO.getAllUsers();

                    // Create a map of user IDs to usernames
                    Map<Integer, String> userMap = new HashMap<>();
                    for (User user : users) {
                        userMap.put(user.getId(), user.getUsername());
                    }

                    // Set patient, messages, users, and userMap attributes for the JSP
                    req.setAttribute("patient", patient);
                    req.setAttribute("messages", messages);
                    req.setAttribute("users", users);
                    req.setAttribute("userMap", userMap);

                    // Forward to the JSP with the patient data and messages
                    RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/views/patient-dashboard.jsp");
                    dispatcher.forward(req, resp);
                } catch (SQLException e) {
                    e.printStackTrace();
                    req.setAttribute("error", "Error retrieving data.");
                    RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/views/error.jsp");
                    dispatcher.forward(req, resp);
                } finally {
                    // Close the connection
                    if (connection != null) {
                        try {
                            connection.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            } else {
                // Patient is not in the session, redirect to login page
                resp.sendRedirect("login.jsp");
            }
        } else {
            // No session, redirect to login page
            resp.sendRedirect("login.jsp");
        }
    }
}
