package com.clinic.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.clinic.util.DBConnect;

public class NotificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = DBConnect.getConnection()) {
            String query = "SELECT * FROM Notifications ORDER BY created_at DESC";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            List<String> notifications = new ArrayList<>();
            while (resultSet.next()) {
                String message = resultSet.getString("message");
                notifications.add(message);
                System.out.println("Fetched notification: " + message);
            }

            request.setAttribute("notifications", notifications);
            request.setAttribute("notificationCount", notifications.size());

            request.getRequestDispatcher("WEB-INF/views/notifications.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
