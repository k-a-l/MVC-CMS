package com.clinic.dao;

import com.clinic.model.Message;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO {
    private Connection connection;

    public MessageDAO(Connection connection) {
        this.connection = connection;
    }

    public void sendMessage(Message message) throws SQLException {
        String sql = "INSERT INTO messages (sender_id, receiver_id, original_message, encrypted_message, timestamp) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, message.getSenderId());
            statement.setInt(2, message.getReceiverId());
            statement.setString(3, message.getOriginalMessage());
            statement.setString(4, message.getEncryptedMessage());
            statement.setTimestamp(5, message.getTimestamp());
            statement.executeUpdate();
        }
    }

    public List<Message> getMessagesForPatient(int patientId) throws SQLException {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM messages WHERE receiver_id = ? OR sender_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, patientId);
            statement.setInt(2, patientId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Message message = new Message();
                    message.setId(resultSet.getInt("id"));
                    message.setSenderId(resultSet.getInt("sender_id"));
                    message.setReceiverId(resultSet.getInt("receiver_id"));
                    message.setOriginalMessage(resultSet.getString("original_message"));
                    message.setEncryptedMessage(resultSet.getString("encrypted_message"));
                    message.setTimestamp(resultSet.getTimestamp("timestamp"));
                    messages.add(message);
                }
            }
        }
        return messages;
    }
    
    public List<Message> getMessagesForUser(int userId) throws SQLException {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT * FROM messages WHERE sender_id = ? OR receiver_id = ? ORDER BY timestamp ASC";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            statement.setInt(2, userId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Message message = new Message();
                    message.setId(resultSet.getInt("id"));
                    message.setSenderId(resultSet.getInt("sender_id"));
                    message.setReceiverId(resultSet.getInt("receiver_id"));
                    message.setOriginalMessage(resultSet.getString("original_message"));
                    message.setEncryptedMessage(resultSet.getString("encrypted_message"));
                    message.setTimestamp(resultSet.getTimestamp("timestamp"));
                    messages.add(message);
                }
            }
        }
        return messages;
    }
}
