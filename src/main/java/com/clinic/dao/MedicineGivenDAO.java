//package com.clinic.dao;
//
//import com.clinic.model.MedicineGiven;
//import com.clinic.util.DBConnect;
//
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//
//public class MedicineGivenDAO {
//
//    public List<MedicineGiven> getMedicinesGivenToPatient(int patientId) {
//        List<MedicineGiven> medicinesGiven = new ArrayList<>();
//        String query = "SELECT m.id, d.name AS doctor_name, i.name AS medicine_name, mg.quantity_given, mg.date_given " +
//                       "FROM medicine_given mg " +
//                       "JOIN doctors d ON mg.doctor_id = d.id " +
//                       "JOIN inventory i ON mg.inventory_id = i.id " +
//                       "WHERE mg.patient_id = ?";
//        try (Connection connection = DBConnect.getConnection();
//             PreparedStatement statement = connection.prepareStatement(query)) {
//            statement.setInt(1, patientId);
//            ResultSet resultSet = statement.executeQuery();
//
//            while (resultSet.next()) {
//                MedicineGiven medicineGiven = new MedicineGiven();
//                medicineGiven.setId(resultSet.getInt("id"));
//                medicineGiven.setDoctorName(resultSet.getString("doctor_name"));
//                medicineGiven.setMedicineName(resultSet.getString("medicine_name"));
//                medicineGiven.setQuantityGiven(resultSet.getInt("quantity_given"));
//                medicineGiven.setDateGiven(resultSet.getTimestamp("date_given"));
//                medicinesGiven.add(medicineGiven);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return medicinesGiven;
//    }
//}
