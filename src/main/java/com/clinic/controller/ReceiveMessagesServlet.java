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
import java.util.List;

public class ReceiveMessagesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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

                List<Message> messages = messageDAO.getMessagesForPatient(patient.getId());
                for (Message message : messages) {
                    String decryptedMessage = EncryptUtil.decryptMessage(message.getEncryptedMessage());
                    message.setOriginalMessage(decryptedMessage);  // Replace with decrypted message
                }
 
                req.setAttribute("messages", messages);
                req.getRequestDispatcher("WEB-INF/views/patient-dashboard.jsp").forward(req, resp);
            } catch (SQLException e) {
                e.printStackTrace();
                req.setAttribute("error", "Unable to retrieve messages.");
                req.getRequestDispatcher("WEB-INF/views/patient-dashboard.jsp").forward(req, resp);
            }
        } else {
            resp.sendRedirect("DashboardServlet");
        }
    }
}
