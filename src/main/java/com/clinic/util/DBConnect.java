package com.clinic.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DBConnect {

    private static final String DB_URL = "jdbc:mysql://localhost/cms_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = ""; 

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC Driver Registered!");
        } catch (ClassNotFoundException e) {
            System.err.println("Error: MySQL JDBC Driver not found.");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        System.out.println("Connecting to the database...");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

	public static void close(Connection conn, PreparedStatement pstmt, Object object) {
		
	}
}
