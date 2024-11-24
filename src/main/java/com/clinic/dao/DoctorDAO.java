package com.clinic.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.clinic.model.Doctor;

public class DoctorDAO {
    private Connection connection;

    public DoctorDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean addDoctor(Doctor doctor) throws SQLException {
        String query = "INSERT INTO doctors (name, speciality, phone, email) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, doctor.getName());
            ps.setString(2, doctor.getSpeciality());
            ps.setString(3, doctor.getPhone());
            ps.setString(4, doctor.getEmail());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public List<Doctor> getAllDoctors() throws SQLException {
        List<Doctor> doctors = new ArrayList<>();
        String sql = "SELECT * FROM doctors";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Doctor doctor = new Doctor();
                doctor.setId(rs.getInt("id"));
                doctor.setName(rs.getString("name"));
                doctor.setSpeciality(rs.getString("speciality"));
                doctor.setPhone(rs.getString("phone"));
                doctor.setEmail(rs.getString("email"));
                doctors.add(doctor);
            }
        }
        return doctors;
    }

    public Doctor getDoctorById(int id) throws SQLException {
        Doctor doctor = null;
        String query = "SELECT * FROM doctors WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    doctor = new Doctor();
                    doctor.setId(rs.getInt("id"));
                    doctor.setName(rs.getString("name"));
                    doctor.setSpeciality(rs.getString("speciality"));
                    doctor.setPhone(rs.getString("phone"));
                    doctor.setEmail(rs.getString("email"));
                }
            }
        }
        return doctor;
    }

    public boolean updateDoctor(Doctor doctor) throws SQLException {
        String query = "UPDATE doctors SET name = ?, speciality = ?, phone = ?, email = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, doctor.getName());
            ps.setString(2, doctor.getSpeciality());
            ps.setString(3, doctor.getPhone());
            ps.setString(4, doctor.getEmail());
            ps.setInt(5, doctor.getId());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public boolean deleteDoctor(int id) throws SQLException {
        String query = "DELETE FROM doctors WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }
}
