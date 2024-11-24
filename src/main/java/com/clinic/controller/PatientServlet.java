package com.clinic.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PatientServlet
 */
public class PatientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher rq=req.getRequestDispatcher("WEB-INF/views/add-patient.jsp");
		rq.forward(req, resp);
	}

}
