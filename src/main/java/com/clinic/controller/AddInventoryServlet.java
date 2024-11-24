package com.clinic.controller;

import com.clinic.dao.InventoryDAO;
import com.clinic.model.Inventory;
import com.clinic.util.DBConnect;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

public class AddInventoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection connection = DBConnect.getConnection()) {
            InventoryDAO inventoryDAO = new InventoryDAO(connection);
            List<Inventory> inventoryList = inventoryDAO.getAllInventory();
            request.setAttribute("inventoryList", inventoryList);
            request.getRequestDispatcher("WEB-INF/views/inventory.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("inventoryError.jsp"); 
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Date manufactureDate = Date.valueOf(request.getParameter("manufacture_date"));
        Date expiryDate = Date.valueOf(request.getParameter("expiry_date"));
        
        if (expiryDate.toLocalDate().isBefore(LocalDate.now()) || manufactureDate.toLocalDate().isAfter(LocalDate.now())) {
            request.setAttribute("errorDate", "Invalid dates: Expiry date cannot be in the past, and manufacture date cannot be in the future.");
            request.getRequestDispatcher("WEB-INF/views/add-inventory.jsp").forward(request, response);
            return;
        }

        Inventory inventory = new Inventory();
        inventory.setName(name);
        inventory.setQuantity(quantity);
        inventory.setManufactureDate(manufactureDate);
        inventory.setExpiryDate(expiryDate);

        try (Connection connection = DBConnect.getConnection()) {
            InventoryDAO inventoryDAO = new InventoryDAO(connection);
            inventoryDAO.addInventory(inventory);
            response.sendRedirect("AddInventoryServlet"); // Redirect to the inventory list
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("inventoryError.jsp"); // Redirect to an error page
        }
    }
}
