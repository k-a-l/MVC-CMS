package com.clinic.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import com.clinic.dao.PatientDAO;
import com.clinic.model.Patient;
import com.clinic.util.DBConnect;

public class AddPatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnection();
            PatientDAO patientDAO = new PatientDAO(connection);
            List<Patient> patients = patientDAO.getAllPatients();

            request.setAttribute("patients", patients);
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/patient.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/add-patient.jsp");
            dispatcher.forward(request, response);
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String dobStr = request.getParameter("dob");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String password = request.getParameter("password"); // New field for password
        String medicalHistory = request.getParameter("medical_history");
        // New field for medical history
        if (age<0) {
            request.setAttribute("errorMessage", "Age Can't be in negative.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/add-patient.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        if (!name.matches("[a-zA-Z ]+")) {
            request.setAttribute("errorMessage", "Name must only contain alphabets.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/add-patient.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Validate DOB: Should be today or in the past
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date utilDate = null;
        try {
            utilDate = dateFormat.parse(dobStr);
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid date format. Use yyyy-MM-dd.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/add-patient.jsp");
            dispatcher.forward(request, response);
            return;
        }

        java.util.Date today = new java.util.Date();
        if (utilDate.after(today)) {
            request.setAttribute("errorMessage", "Date of birth cannot be in the future.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/add-patient.jsp");
            dispatcher.forward(request, response);
            return;
        }
        // Parse the dob string to java.util.Date
        SimpleDateFormat dateFormat1 = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date utilDate1 = null;
        try {
            utilDate1 = dateFormat1.parse(dobStr);
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid date format.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/add-patient.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Convert java.util.Date to java.sql.Date
        Date sqlDate = new Date(utilDate1.getTime());

        Connection connection = null;
        try {
            connection = DBConnect.getConnection();
            PatientDAO patientDAO = new PatientDAO(connection);
            Patient newPatient = new Patient();
            newPatient.setName(name);
            newPatient.setDob(sqlDate); // Set java.sql.Date
            newPatient.setAge(age);
            newPatient.setGender(gender);
            newPatient.setPhone(phone);
            newPatient.setEmail(email);
            newPatient.setAddress(address);
            newPatient.setPassword(password); // Set password
            newPatient.setMedicalHistory(medicalHistory); // Set medical history

            patientDAO.addPatient(newPatient);

            response.sendRedirect("AddPatientServlet");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/add-patient.jsp");
            dispatcher.forward(request, response);
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
}
