package com.clinic.controller;

import com.clinic.dao.PatientDAO;
import com.clinic.dao.UserDAO;
import com.clinic.model.Patient;
import com.clinic.model.User;
import com.clinic.util.DBConnect;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to login.jsp
        request.getRequestDispatcher("WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Hash the password only for non-patient users
        String hashedPassword = hashPassword(password);

        PatientDAO patientDAO = null;
        UserDAO userDAO = null;
        Connection connection = null;

        try {
            connection = DBConnect.getConnection(); // Get database connection
            patientDAO = new PatientDAO(connection);
            userDAO = new UserDAO();

            // Check if the username and plain password match a patient
            Patient patient = patientDAO.getPatientByEmailAndPassword(username, password);
            if (patient != null) {
                // Create session and redirect to patient dashboard
                HttpSession session = request.getSession();
                session.setAttribute("patient", patient);
                response.sendRedirect("PatientDashboardServlet"); // Redirect to patient dashboard
                return;
            }

            // Check if the username and hashed password match a user
            User user = userDAO.getUserByUsernameAndPassword(username, hashedPassword);
            if (user != null) {
                // Create session and redirect to user dashboard
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                //response.sendRedirect("DashboardServlet"); // Redirect to user dashboard
                request.getRequestDispatcher("WEB-INF/views/dasboard.jsp").forward(request, response);
                return;
            }

            // Authentication failed for both patient and user
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("WEB-INF/views/login.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("WEB-INF/views/login.jsp").forward(request, response);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}
