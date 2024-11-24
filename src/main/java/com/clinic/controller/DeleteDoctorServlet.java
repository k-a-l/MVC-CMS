package com.clinic.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.clinic.dao.DoctorDAO;
import com.clinic.util.DBConnect;

public class DeleteDoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int doctorId = Integer.parseInt(request.getParameter("id"));
        Connection connection = null;
        try {
            connection = DBConnect.getConnection();
            DoctorDAO doctorDAO = new DoctorDAO(connection);
            doctorDAO.deleteDoctor(doctorId);
            response.sendRedirect("AddDoctorServlet");
            
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
