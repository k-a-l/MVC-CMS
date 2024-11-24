package com.clinic.controller;

import com.clinic.dao.MessageDAO;
import com.clinic.model.Message;
import com.clinic.model.Patient;
import com.clinic.util.EncryptUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;

public class SendMessageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        Patient patient = (Patient) session.getAttribute("patient");

        if (patient != null) {
            Connection connection = (Connection) getServletContext().getAttribute("dbConnection");

            if (connection == null) {
                req.setAttribute("error", "Database connection is not initialized.");
                req.getRequestDispatcher("WEB-INF/views/error.jsp").forward(req, resp);
                return;
            }

            try {
                MessageDAO messageDAO = new MessageDAO(connection);

                int receiverId = Integer.parseInt(req.getParameter("receiverId"));
                String originalMessage = req.getParameter("message");

                if (originalMessage == null || originalMessage.trim().isEmpty()) {
                    req.setAttribute("error", "Message cannot be empty.");
                    req.getRequestDispatcher("WEB-INF/views/patient-dashboard.jsp").forward(req, resp);
                    return;
                }

                String encryptedMessage = EncryptUtil.encryptMessage(originalMessage);

                Message message = new Message();
                message.setSenderId(patient.getId());
                message.setReceiverId(receiverId);
                message.setOriginalMessage(originalMessage);
                message.setEncryptedMessage(encryptedMessage);
                message.setTimestamp(new Timestamp(System.currentTimeMillis()));

                messageDAO.sendMessage(message);

                resp.sendRedirect("PatientDashboardServlet");
            } catch (NumberFormatException e) {
                e.printStackTrace();
                req.setAttribute("error", "Invalid receiver ID.");
                req.getRequestDispatcher("WEB-INF/views/patient-dashboard.jsp").forward(req, resp);
            } catch (SQLException e) {
                e.printStackTrace();
                req.setAttribute("error", "Unable to send message.");
                req.getRequestDispatcher("WEB-INF/views/patient-dashboard.jsp").forward(req, resp);
            }
        } else {
            resp.sendRedirect("DashboardServlet");
        }
    }
}
