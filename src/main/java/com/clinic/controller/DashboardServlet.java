package com.clinic.controller;

import com.clinic.model.Patient;
import com.clinic.model.Message;
import com.clinic.dao.MessageDAO;
import com.clinic.util.DBConnect;
import com.clinic.util.EncryptUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MessageDAO messageDAO;

    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DBConnect.getConnection();
            messageDAO = new MessageDAO(connection);
        } catch (SQLException e) {
            throw new ServletException("Database connection error", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Patient patient = (Patient) request.getSession().getAttribute("patient");

        // Redirect to login if patient is not logged in
      

        try {
            // Get messages for the logged-in patient
            List<Message> messages = messageDAO.getMessagesForPatient(patient.getId());
            request.setAttribute("messages", messages);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving messages", e);
        }

        // Forward to dashboard.jsp
        request.getRequestDispatcher("/WEB-INF/views/dasboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Patient patient = (Patient) request.getSession().getAttribute("patient");

      
        try {
            // Retrieve receiver ID and message content
            int receiverId = Integer.parseInt(request.getParameter("receiverId"));
            String originalMessage = request.getParameter("message");

            // Encrypt message
            String encryptedMessage = EncryptUtil.encryptMessage(originalMessage);

            // Create and send the message
            Message message = new Message();
            message.setSenderId(patient.getId());
            message.setReceiverId(receiverId);
            message.setOriginalMessage(originalMessage);
            message.setEncryptedMessage(encryptedMessage);
            messageDAO.sendMessage(message);

            // Redirect to dashboard
            response.sendRedirect("DashboardServlet");
        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Error sending message", e);
        }
    }
}
