package com.clinic.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.clinic.dao.DoctorPatientInventoryDAO;

public class RecordMedicineServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        int inventoryId = Integer.parseInt(request.getParameter("inventoryId"));
        int quantityGiven = Integer.parseInt(request.getParameter("quantityGiven"));
        
        DoctorPatientInventoryDAO dao = new DoctorPatientInventoryDAO();
        
        try {
            dao.recordMedicineGiven(doctorId, patientId, inventoryId, quantityGiven);
            //request.getRequestDispatcher("WEB-INF/views/dashboard.jsp").forward(request, response);
            response.sendRedirect("WEB-INF/views/patient.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error recording medicine given: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
