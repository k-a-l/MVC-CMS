package com.clinic.dao;

import com.clinic.model.User;
import com.clinic.util.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Method to add a new user
    public void addUser(String username, String password, String role) throws SQLException {
        String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, password); // Password should be hashed before this point
            pstmt.setString(3, role);
            pstmt.executeUpdate();
        }
    }

    // Method to get all users
    public List<User> getAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, username, password, role FROM users";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password")); // Hashed password
                user.setRole(rs.getString("role"));
                users.add(user);
            }
        }
        return users;
    }

    // Method to get a user by username and hashed password
    public User getUserByUsernameAndPassword(String username, String hashedPassword) throws SQLException {
        String sql = "SELECT id, username, role FROM users WHERE username = ? AND password = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            pstmt.setString(2, hashedPassword); // Compare with hashed password
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }
        }
        return null;
    }
    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
        		PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setRole(rs.getString("role"));
                    // Set other user fields as needed
                    return user;
                }
            }
        }
        return null;
    }
}
