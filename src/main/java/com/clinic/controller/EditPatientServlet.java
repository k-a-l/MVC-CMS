package com.clinic.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import com.clinic.dao.PatientDAO;
import com.clinic.model.Patient;
import com.clinic.util.DBConnect;

public class EditPatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try (Connection connection = DBConnect.getConnection()) {
            PatientDAO patientDAO = new PatientDAO(connection);
            Patient existingPatient = patientDAO.getPatientById(id);
            request.setAttribute("patient", existingPatient);
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/edit-patient.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/error.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String dobStr = request.getParameter("dob");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date sqlDate;
        try {
            java.util.Date utilDate = dateFormat.parse(dobStr);
            sqlDate = new Date(utilDate.getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid date format.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/edit-patient.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try (Connection connection = DBConnect.getConnection()) {
            PatientDAO patientDAO = new PatientDAO(connection);
            Patient patient = new Patient();
            patient.setId(id);
            patient.setName(name);
            patient.setDob(sqlDate);
            patient.setAge(age);
            patient.setGender(gender);
            patient.setPhone(phone);
            patient.setEmail(email);
            patient.setAddress(address);
            patientDAO.updatePatient(patient);
            response.sendRedirect("AddPatientServlet");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/error.jsp");
            dispatcher.forward(request, response);
        }
    }
}
