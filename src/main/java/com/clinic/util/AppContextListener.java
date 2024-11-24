package com.clinic.util; 


import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.SQLException;

@WebListener
public class AppContextListener implements ServletContextListener {
    private Connection connection;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            connection = DBConnect.getConnection(); // Initialize the connection
            sce.getServletContext().setAttribute("dbConnection", connection); // Set the connection in the servlet context
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize database connection", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close(); // Close the connection
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
