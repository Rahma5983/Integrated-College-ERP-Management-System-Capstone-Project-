package com.college.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.college.util.DBConnection;

@WebServlet("/logAttendance")
public class LogAttendanceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String studentId = request.getParameter("studentId");
        String status = request.getParameter("status");
        String markedBy = request.getParameter("markedBy");

        if (markedBy == null || markedBy.trim().isEmpty()) {
            markedBy = "ADMIN101"; 
        }

        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DBConnection.getConnection()) {
                String query = "INSERT INTO attendance (student_id, status, marked_by) VALUES (?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, studentId.trim());
                ps.setString(2, status.trim());
                ps.setString(3, markedBy.trim());
                
                int rowsInserted = ps.executeUpdate();
                
                if (rowsInserted > 0) {
                    
                    response.sendRedirect("attendance_management.jsp?status=att_success");
                    return;
                } else {
                    throw new Exception("The database accepted the query but zero rows were written.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace(); // Check your Eclipse console logs for this!
            
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body style='font-family:sans-serif; padding:50px; text-align:center;'>");
            out.println("<h2 style='color:#ef4444;'>⚠️ Database Submission Error</h2>");
            out.println("<p style='background:#fee2e2; color:#991b1b; padding:15px; display:inline-block; border-radius:5px;'>");
            out.println("Reason: " + e.getMessage());
            out.println("</p><br><br>");
            out.println("<a href='attendance_management.jsp' style='color:#3b82f6; text-decoration:none; font-weight:bold;'>← Go Back to Form</a>");
            out.println("</body></html>");
        }
    }
}
