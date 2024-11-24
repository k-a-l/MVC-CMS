package com.clinic.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.clinic.model.Patient;

public class PatientDAO {
    private Connection connection;

    public PatientDAO(Connection connection) {
        this.connection = connection;
    }

    public void addPatient(Patient patient) throws SQLException {
        String sql = "INSERT INTO patients (name, dob, age, gender, phone, email, address, password, medical_history) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, patient.getName());
            stmt.setDate(2, new java.sql.Date(patient.getDob().getTime())); // Convert java.util.Date to java.sql.Date
            stmt.setInt(3, patient.getAge());
            stmt.setString(4, patient.getGender());
            stmt.setString(5, patient.getPhone());
            stmt.setString(6, patient.getEmail());
            stmt.setString(7, patient.getAddress());
            stmt.setString(8, patient.getPassword()); // New field for password
            stmt.setString(9, patient.getMedicalHistory()); // New field for medical history
            stmt.executeUpdate();
        }
    }

    public List<Patient> getAllPatients() throws SQLException {
        List<Patient> patients = new ArrayList<>();
        String sql = "SELECT * FROM patients";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Patient patient = new Patient();
                patient.setId(rs.getInt("id"));
                patient.setName(rs.getString("name"));
                patient.setDob(new java.util.Date(rs.getDate("dob").getTime())); // Convert java.sql.Date to java.util.Date
                patient.setAge(rs.getInt("age"));
                patient.setGender(rs.getString("gender"));
                patient.setPhone(rs.getString("phone"));
                patient.setEmail(rs.getString("email"));
                patient.setAddress(rs.getString("address"));
                patient.setPassword(rs.getString("password")); // Set password field
                patient.setMedicalHistory(rs.getString("medical_history")); // Set medical history field
                patients.add(patient);
            }
        }
        return patients;
    }

    public Patient getPatientById(int id) throws SQLException {
        Patient patient = null;
        String sql = "SELECT * FROM patients WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    patient = new Patient();
                    patient.setId(rs.getInt("id"));
                    patient.setName(rs.getString("name"));
                    patient.setDob(new java.util.Date(rs.getDate("dob").getTime())); // Convert java.sql.Date to java.util.Date
                    patient.setAge(rs.getInt("age"));
                    patient.setGender(rs.getString("gender"));
                    patient.setPhone(rs.getString("phone"));
                    patient.setEmail(rs.getString("email"));
                    patient.setAddress(rs.getString("address"));
                    patient.setPassword(rs.getString("password")); // Set password field
                    patient.setMedicalHistory(rs.getString("medical_history")); // Set medical history field
                }
            }
        }
        return patient;
    }

    public boolean updatePatient(Patient patient) throws SQLException {
        String sql = "UPDATE patients SET name = ?, dob = ?, age = ?, gender = ?, phone = ?, email = ?, address = ?, password = ?, medical_history = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, patient.getName());
            stmt.setDate(2, new java.sql.Date(patient.getDob().getTime())); // Convert java.util.Date to java.sql.Date
            stmt.setInt(3, patient.getAge());
            stmt.setString(4, patient.getGender());
            stmt.setString(5, patient.getPhone());
            stmt.setString(6, patient.getEmail());
            stmt.setString(7, patient.getAddress());
            stmt.setString(8, patient.getPassword()); // Update password field
            stmt.setString(9, patient.getMedicalHistory()); // Update medical history field
            stmt.setInt(10, patient.getId());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean deletePatient(int id) throws SQLException {
        String sql = "DELETE FROM patients WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
    public Patient getPatientByEmailAndPassword(String email, String password) throws SQLException {
        Patient patient = null;
        String sql = "SELECT * FROM patients WHERE email = ? AND password = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password); // Assuming password is hashed
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    patient = new Patient();
                    patient.setId(rs.getInt("id"));
                    patient.setName(rs.getString("name"));
                    patient.setEmail(rs.getString("email"));
                    patient.setDob(rs.getDate("dob")); // Date of Birth
                    patient.setAge(rs.getInt("age")); // Age
                    patient.setGender(rs.getString("gender")); // Gender
                    patient.setPhone(rs.getString("phone")); // Phone
                    patient.setMedicalHistory(rs.getString("medical_history")); // Medical History
                    patient.setAddress(rs.getString("address")); // Address
                    // You can add more fields as needed
                }
            }
        }
        return patient;
    }


}
