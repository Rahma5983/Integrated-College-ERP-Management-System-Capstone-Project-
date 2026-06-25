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

@WebServlet("/registerFaculty")
public class RegisterFacultyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String facultyId = request.getParameter("facultyId");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String department = request.getParameter("department");
        String designation = request.getParameter("designation");

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Atomicity safety check

            // Action 1: Create baseline authentication records
            String userQuery = "INSERT INTO users (user_id, password, role) VALUES (?, ?, 'FACULTY')";
            PreparedStatement psUser = conn.prepareStatement(userQuery);
            psUser.setString(1, facultyId);
            psUser.setString(2, password);
            psUser.executeUpdate();

            // Action 2: Populate core professional staff parameters
            String facultyQuery = "INSERT INTO faculty (faculty_id, first_name, last_name, email, department, designation) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement psFaculty = conn.prepareStatement(facultyQuery);
            psFaculty.setString(1, facultyId);
            psFaculty.setString(2, firstName);
            psFaculty.setString(3, lastName);
            psFaculty.setString(4, email);
            psFaculty.setString(5, department);
            psFaculty.setString(6, designation);
            psFaculty.executeUpdate();

            conn.commit(); // Deploy safely to disk
            response.sendRedirect("admin_dashboard.jsp?status=fac_success");

        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try { conn.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
            }
            response.sendRedirect("admin_dashboard.jsp?status=fac_error");
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
    }
}