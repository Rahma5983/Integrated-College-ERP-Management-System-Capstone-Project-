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

@WebServlet("/registerStudent")
public class RegisterStudentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String studentId = request.getParameter("studentId");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String course = request.getParameter("course");

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            // Turn off auto-commit to execute BOTH statements as a single secure transaction
            conn.setAutoCommit(false);

            // Statement 1: Insert into core users authentication credentials table
            String userQuery = "INSERT INTO users (user_id, password, role) VALUES (?, ?, 'STUDENT')";
            PreparedStatement psUser = conn.prepareStatement(userQuery);
            psUser.setString(1, studentId);
            psUser.setString(2, password);
            psUser.executeUpdate();

            // Statement 2: Insert into descriptive student records profile table
            String studentQuery = "INSERT INTO students (student_id, first_name, last_name, email, course) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psStudent = conn.prepareStatement(studentQuery);
            psStudent.setString(1, studentId);
            psStudent.setString(2, firstName);
            psStudent.setString(3, lastName);
            psStudent.setString(4, email);
            psStudent.setString(5, course);
            psStudent.executeUpdate();

            // Commit transaction if both succeeded perfectly
            conn.commit();
            
            // Redirect back to dashboard with a visual success marker parameter
            response.sendRedirect("admin_dashboard.jsp?status=success");

        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                try { conn.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
            }
            response.sendRedirect("admin_dashboard.jsp?status=error");
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
            }
        }
    }
}