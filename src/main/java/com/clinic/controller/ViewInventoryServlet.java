package com.clinic.controller;

import com.clinic.dao.InventoryDAO;
import com.clinic.model.Inventory;
import com.clinic.util.DBConnect;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

public class ViewInventoryServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection connection = DBConnect.getConnection()) {
            InventoryDAO inventoryDAO = new InventoryDAO(connection);
            Inventory inventory = inventoryDAO.getInventoryById(id);
            request.setAttribute("inventory", inventory);
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/view-inventory.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/views/error.jsp");
            dispatcher.forward(request, response);
        }
    }
}
