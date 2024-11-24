package com.clinic.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import com.clinic.dao.PatientDAO;
import com.clinic.model.Patient;
import com.clinic.util.DBConnect;

public class ViewPatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DBConnect.getConnection()) {
            PatientDAO patientDAO = new PatientDAO(connection);
            Patient patient = patientDAO.getPatientById(id);

            if (patient != null) {
                request.setAttribute("patient", patient);
                RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/view-patient.jsp");
                dispatcher.forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Patient not found.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/error.jsp");
                dispatcher.forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/error.jsp");
            dispatcher.forward(request, response);
        }
    }
}
