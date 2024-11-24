package com.clinic.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.clinic.dao.DoctorDAO;
import com.clinic.model.Doctor;
import com.clinic.util.DBConnect;

public class EditDoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int doctorId = Integer.parseInt(request.getParameter("id"));
        Connection connection = null;
        try {
            connection = DBConnect.getConnection();
            DoctorDAO doctorDAO = new DoctorDAO(connection);
            Doctor doctor = doctorDAO.getDoctorById(doctorId);
            request.setAttribute("doctor", doctor);
            request.getRequestDispatcher("WEB-INF/views/edit-doctor.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("WEB-INF/views/error.jsp").forward(request, response);
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
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String speciality = request.getParameter("speciality");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        Connection connection = null;
        try {
            connection = DBConnect.getConnection();
            DoctorDAO doctorDAO = new DoctorDAO(connection);
            Doctor doctor = new Doctor();
            doctor.setId(id);
            doctor.setName(name);
            doctor.setSpeciality(speciality);
            doctor.setPhone(phone);
            doctor.setEmail(email);

            boolean updated = doctorDAO.updateDoctor(doctor);
            if (updated) {
                response.sendRedirect("AddDoctorServlet");
            } else {
                request.setAttribute("errorMessage", "Failed to update doctor.");
                request.getRequestDispatcher("WEB-INF/views/error.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("WEB-INF/views/error.jsp").forward(request, response);
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
