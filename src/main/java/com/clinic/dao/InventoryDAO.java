package com.clinic.dao;

import com.clinic.model.Inventory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class InventoryDAO {
    private Connection connection;

    public InventoryDAO(Connection connection) {
        this.connection = connection;
    }

    public void addInventory(Inventory inventory) throws SQLException {
        String sql = "INSERT INTO inventory (name, quantity, manufacture_date, expiry_date) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, inventory.getName());
            stmt.setInt(2, inventory.getQuantity());
            stmt.setDate(3, inventory.getManufactureDate());
            stmt.setDate(4, inventory.getExpiryDate());
            stmt.executeUpdate();
        }
    }

    public List<Inventory> getAllInventory() throws SQLException {
        List<Inventory> inventoryList = new ArrayList<>();
        String sql = "SELECT * FROM inventory";
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Inventory inventory = new Inventory();
                inventory.setId(rs.getInt("id"));
                inventory.setName(rs.getString("name"));
                inventory.setQuantity(rs.getInt("quantity"));
                inventory.setManufactureDate(rs.getDate("manufacture_date"));
                inventory.setExpiryDate(rs.getDate("expiry_date"));
                inventoryList.add(inventory);
            }
        }
        return inventoryList;
    }

    public Inventory getInventoryById(int id) throws SQLException {
        Inventory inventory = null;
        String sql = "SELECT * FROM inventory WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    inventory = new Inventory();
                    inventory.setId(rs.getInt("id"));
                    inventory.setName(rs.getString("name"));
                    inventory.setQuantity(rs.getInt("quantity"));
                    inventory.setManufactureDate(rs.getDate("manufacture_date"));
                    inventory.setExpiryDate(rs.getDate("expiry_date"));
                }
            }
        }
        return inventory;
    }

    public void updateInventory(Inventory inventory) throws SQLException {
        String sql = "UPDATE inventory SET name = ?, quantity = ?, manufacture_date = ?, expiry_date = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, inventory.getName());
            stmt.setInt(2, inventory.getQuantity());
            stmt.setDate(3, inventory.getManufactureDate());
            stmt.setDate(4, inventory.getExpiryDate());
            stmt.setInt(5, inventory.getId());
            stmt.executeUpdate();
        }
    }

    public void deleteInventory(int id) throws SQLException {
        String sql = "DELETE FROM inventory WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
