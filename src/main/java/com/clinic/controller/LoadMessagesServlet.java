//package com.clinic.controller;
//
//import com.clinic.dao.MessageDAO;
//import com.clinic.model.Message;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//import java.util.List;
//
//public class LoadMessagesServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        int userId = (int) session.getAttribute("userId");
//        int chatWithId = 1; // Replace with logic to determine who the user is chatting with
//
//        MessageDAO messageDAO = new MessageDAO();
//        List<Message> messages = messageDAO.getMessagesBetweenUsers(userId, chatWithId);
//
//        StringBuilder chatHTML = new StringBuilder();
//        for (Message message : messages) {
//            if (message.getSenderId() == userId) {
//                chatHTML.append("<div class='right-align'><strong>You:</strong> " + message.getOriginalMessage() + "</div>");
//            } else {
//                chatHTML.append("<div class='left-align'><strong>Them:</strong> " + message.getOriginalMessage() + "</div>");
//            }
//        }
//
//        response.setContentType("text/html");
//        response.getWriter().write(chatHTML.toString());
//    }
//}
