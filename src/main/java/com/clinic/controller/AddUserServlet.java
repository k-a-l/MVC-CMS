package com.clinic.controller;

import com.clinic.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class AddUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to addUser.jsp
        request.getRequestDispatcher("WEB-INF/views/addUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Hash the password
        String hashedPassword = hashPassword(password);

        UserDAO userDAO = new UserDAO();
        try {
            userDAO.addUser(username, hashedPassword, role);
            //response.sendRedirect("WEB-INF/views/manageUsers.jsp"); 
            request.getRequestDispatcher("WEB-INF/views/manageUsers.jsp").forward(request, response);
// Redirect to dashboard or any other page
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error adding user: " + e.getMessage());
            request.getRequestDispatcher("WEB-INF/views/addUser.jsp").forward(request, response);
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
