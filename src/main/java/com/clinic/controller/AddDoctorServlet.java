package com.clinic.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import com.clinic.dao.DoctorDAO;
import com.clinic.model.Doctor;
import com.clinic.util.DBConnect;

public class AddDoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        listDoctors(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        addDoctor(request, response);
    }

    private void listDoctors(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnection();
            DoctorDAO doctorDAO = new DoctorDAO(connection);
            List<Doctor> doctors = doctorDAO.getAllDoctors();
            request.setAttribute("doctors", doctors);
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/doctor.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/error.jsp");
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

    private void addDoctor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String speciality = request.getParameter("speciality");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        Connection connection = null;
        try {
            connection = DBConnect.getConnection();
            DoctorDAO doctorDAO = new DoctorDAO(connection);
            Doctor doctor = new Doctor();
            doctor.setName(name);
            doctor.setSpeciality(speciality);
            doctor.setPhone(phone);
            doctor.setEmail(email);
            if (!name.matches("[a-zA-Z ]+")) {
                request.setAttribute("errorMessage", "Name must only contain alphabets.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/add-doctor.jsp");
                dispatcher.forward(request, response);
                return;
            }
            doctorDAO.addDoctor(doctor);
            response.sendRedirect("AddDoctorServlet");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/error.jsp");
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
