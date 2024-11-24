package com.clinic.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.TimerTask;

public class ExpireCheckTask extends TimerTask {
    @Override
    public void run() {
        System.out.println("Running ExpireCheckTask...");

        try (Connection connection = DBConnect.getConnection()) {
            if (connection == null) {
                System.out.println("Failed to establish a database connection.");
                return;
            }

            String query = "SELECT id, name FROM inventory WHERE expiry_date <= ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setDate(1, java.sql.Date.valueOf(LocalDate.now()));
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String message = "The medicine " + name + " has expired.";

                System.out.println("Found expired medicine: " + name);

                String insertNotificationQuery = "INSERT INTO notifications (message) VALUES (?)";
                PreparedStatement insertStatement = connection.prepareStatement(insertNotificationQuery);
                insertStatement.setString(1, message);
                insertStatement.executeUpdate();

                System.out.println("Inserted notification: " + message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
