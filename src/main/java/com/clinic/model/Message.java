package com.clinic.model;

import java.sql.Timestamp;

public class Message {
    private int id;
    private int senderId;
    private int receiverId;
    private String originalMessage;
    private String encryptedMessage;
    private Timestamp timestamp;

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getSenderId() { return senderId; }
    public void setSenderId(int senderId) { this.senderId = senderId; }

    public int getReceiverId() { return receiverId; }
    public void setReceiverId(int receiverId) { this.receiverId = receiverId; }

    public String getOriginalMessage() { return originalMessage; }
    public void setOriginalMessage(String originalMessage) { this.originalMessage = originalMessage; }

    public String getEncryptedMessage() { return encryptedMessage; }
    public void setEncryptedMessage(String encryptedMessage) { this.encryptedMessage = encryptedMessage; }

    public Timestamp getTimestamp() { return timestamp; }
    public void setTimestamp(Timestamp timestamp) { this.timestamp = timestamp; }
}
