package com.clinic.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.clinic.dao.PatientDAO;
import com.clinic.util.DBConnect;

public class DeletePatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try (Connection connection = DBConnect.getConnection()) {
            PatientDAO patientDAO = new PatientDAO(connection);
            patientDAO.deletePatient(id);
            response.sendRedirect("AddPatientServlet");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("WEB-INF/views/error.jsp").forward(request, response);
        }
    }
}
