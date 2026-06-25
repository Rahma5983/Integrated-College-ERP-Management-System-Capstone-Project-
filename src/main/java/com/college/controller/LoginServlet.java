package com.college.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.college.util.DBConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String userId = request.getParameter("userId");
        String password = request.getParameter("password");
        
        response.setContentType("text/html");

        try (Connection conn = DBConnection.getConnection()) {
            String query = "SELECT role FROM users WHERE user_id = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, userId);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                // SUCCESS: User found in database
                String userRole = rs.getString("role");
                
                // Initialize HTTP Session to persist user authentication across pages
                HttpSession session = request.getSession();
                session.setAttribute("user", userId);
                session.setAttribute("role", userRole);
                
                // Role-Based Routing Matrix
                if ("ADMIN".equalsIgnoreCase(userRole)) {
                    response.sendRedirect("admin_dashboard.jsp");
                } else if ("STUDENT".equalsIgnoreCase(userRole)) {
                    response.sendRedirect("student_dashboard.jsp");
                } else if ("FACULTY".equalsIgnoreCase(userRole)) {
                    response.sendRedirect("faculty_dashboard.jsp");
                } else {
                    // Fallback case for undefined roles
                    response.getWriter().println("<h1>Access Denied: Role unassigned.</h1>");
                }
                
            } else {
                // FAILURE: No user matched the ID and password
                response.getWriter().println("<h1>Login Failed! Incorrect User ID or Password.</h1>");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h1>Database Error! Did you update your DB password in DBConnection.java?</h1>");
        }
    }
}