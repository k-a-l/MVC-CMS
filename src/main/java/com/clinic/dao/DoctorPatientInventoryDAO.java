package com.clinic.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.clinic.util.DBConnect;

public class DoctorPatientInventoryDAO {
    
    public void recordMedicineGiven(int doctorId, int patientId, int inventoryId, int quantityGiven) throws SQLException {
        String insertQuery = "INSERT INTO doctor_patient_inventory (doctor_id, patient_id, inventory_id, quantity_given) VALUES (?, ?, ?, ?)";
        String updateInventoryQuery = "UPDATE inventory SET quantity = quantity - ? WHERE id = ?";

        try (Connection connection = DBConnect.getConnection()) {
            try {
                connection.setAutoCommit(false);
                
                // Insert record of medicine given
                try (PreparedStatement insertStatement = connection.prepareStatement(insertQuery)) {
                    insertStatement.setInt(1, doctorId);
                    insertStatement.setInt(2, patientId);
                    insertStatement.setInt(3, inventoryId);
                    insertStatement.setInt(4, quantityGiven);
                    insertStatement.executeUpdate();
                }
                
                // Update inventory quantity
                try (PreparedStatement updateStatement = connection.prepareStatement(updateInventoryQuery)) {
                    updateStatement.setInt(1, quantityGiven);
                    updateStatement.setInt(2, inventoryId);
                    updateStatement.executeUpdate();
                }
                
                connection.commit();
            } catch (SQLException e) {
                connection.rollback();
                throw e;
            }
        }
    }
}
