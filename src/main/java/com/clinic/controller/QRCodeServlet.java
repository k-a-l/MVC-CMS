package com.clinic.controller;

import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.client.j2se.MatrixToImageWriter;

public class QRCodeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String doctorId = request.getParameter("id");
        String name = request.getParameter("name");
        String speciality = request.getParameter("speciality");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        String qrCodeText ="DOCTOR DETAILS"+ "ID: " + doctorId + "\nName: " + name + "\nSpeciality: " + speciality + "\nPhone: " + phone + "\nEmail: " + email;

        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        try {
            BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeText, BarcodeFormat.QR_CODE, 200, 200);
            response.setContentType("image/png");
            OutputStream outputStream = response.getOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", outputStream);
            outputStream.flush();
            outputStream.close();
        } catch (WriterException e) {
            e.printStackTrace();
        }
    }
}
