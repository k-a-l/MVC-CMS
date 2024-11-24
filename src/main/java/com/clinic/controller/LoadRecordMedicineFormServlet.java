package com.clinic.controller;

import com.clinic.dao.DoctorDAO;
import com.clinic.dao.PatientDAO;
import com.clinic.dao.InventoryDAO;
import com.clinic.model.Doctor;
import com.clinic.model.Patient;
import com.clinic.model.Inventory;
import com.clinic.util.DBConnect; // Assuming DBConnect is a utility class for managing database connections

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class LoadRecordMedicineFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = DBConnect.getConnection()) { // Get connection from utility class
            DoctorDAO doctorDAO = new DoctorDAO(connection);
            PatientDAO patientDAO = new PatientDAO(connection);
            InventoryDAO inventoryDAO = new InventoryDAO(connection);

            List<Doctor> doctors = doctorDAO.getAllDoctors();
            List<Patient> patients = patientDAO.getAllPatients();
            List<Inventory> inventories = inventoryDAO.getAllInventory();

            request.setAttribute("doctors", doctors);
            request.setAttribute("patients", patients);
            request.setAttribute("inventories", inventories);

            request.getRequestDispatcher("WEB-INF/views/recordMedicine.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
