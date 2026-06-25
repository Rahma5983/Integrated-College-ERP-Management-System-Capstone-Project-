package com.college.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.college.util.DBConnection;

@WebServlet("/processFee")
public class ProcessFeeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String studentId = request.getParameter("studentId");
        double amount = Double.parseDouble(request.getParameter("amount"));
        String feeType = request.getParameter("feeType");
        String paymentMode = request.getParameter("paymentMode");

        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO fees (student_id, amount, fee_type, payment_mode) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, studentId);
            ps.setDouble(2, amount);
            ps.setString(3, feeType);
            ps.setString(4, paymentMode);
            
            ps.executeUpdate();
            
            response.sendRedirect("fee_management.jsp?status=fee_success");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("fee_management.jsp?status=fee_error");
        }
    }
}