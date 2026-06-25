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

@WebServlet("/processExam")
public class ProcessExamServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String studentId = request.getParameter("studentId");
        String examTerm = request.getParameter("examTerm");
        String subjectName = request.getParameter("subjectName");
        int marksObtained = Integer.parseInt(request.getParameter("marksObtained"));
        int totalMarks = Integer.parseInt(request.getParameter("totalMarks"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            try (Connection conn = DBConnection.getConnection()) {
                String query = "INSERT INTO exams (student_id, subject_name, marks_obtained, total_marks, exam_term) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, studentId);
                ps.setString(2, subjectName);
                ps.setInt(3, marksObtained);
                ps.setInt(4, totalMarks);
                ps.setString(5, examTerm);
                
                ps.executeUpdate();
                
                // Direct redirection on successful post transaction
                response.sendRedirect("exam_management.jsp?status=exam_success");
            }
        } catch (Exception e) {
            e.printStackTrace();
            
            // Pop an alert message box if a foreign key validation constraint catches an incorrect student ID
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('Error saving marks: " + e.getMessage().replace("'", "\\'") + "');");
            out.println("window.location.href='exam_management.jsp';");
            out.println("<script>");
        }
    }
}