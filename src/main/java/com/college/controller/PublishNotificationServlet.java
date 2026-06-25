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

@WebServlet("/publishNotification")
public class PublishNotificationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String title = request.getParameter("title");
        String message = request.getParameter("message");
        String targetRole = request.getParameter("targetRole");

        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO notifications (title, message, target_role) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, title);
            ps.setString(2, message);
            ps.setString(3, targetRole);
            
            ps.executeUpdate();
            response.sendRedirect("admin_dashboard.jsp?status=notif_sent");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_dashboard.jsp?status=error");
        }
    }
}