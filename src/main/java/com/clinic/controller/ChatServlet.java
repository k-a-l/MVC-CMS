//package com.clinic.controller;
//
//import javax.crypto.Cipher;
//import javax.crypto.spec.SecretKeySpec;
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import com.clinic.dao.MessageDAO;
//
//import java.io.IOException;
//import java.util.Base64;
//
//public class ChatServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//    
//    // Key for AES encryption (you can store this securely)
//    private static final String SECRET_KEY = "1234567890123456"; // 16 characters for AES-128
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        try {
//            HttpSession session = request.getSession();
//            int senderId = (int) session.getAttribute("userId");
//            int receiverId = Integer.parseInt(request.getParameter("receiverId"));
//            String originalMessage = request.getParameter("message");
//
//            // Encrypt the message
//            String encryptedMessage = encryptMessage(originalMessage);
//
//            // Save both original and encrypted messages to the database using MessageDAO
//            MessageDAO messageDAO = new MessageDAO();
//            messageDAO.saveMessage(senderId, receiverId, originalMessage, encryptedMessage);
//
//            // Respond with success
//            response.getWriter().write("Message sent successfully!");
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.getWriter().write("Failed to send message!");
//        }
//    }
//
//    private String encryptMessage(String message) {
//        try {
//            SecretKeySpec secretKeySpec = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
//            Cipher cipher = Cipher.getInstance("AES");
//            cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec);
//            byte[] encryptedBytes = cipher.doFinal(message.getBytes());
//            return Base64.getEncoder().encodeToString(encryptedBytes);
//        } catch (Exception e) {
//            throw new RuntimeException("Error while encrypting message", e);
//        }
//    }
//}
