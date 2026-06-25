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

@WebServlet("/addSchedule")
public class AddScheduleServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String courseName = request.getParameter("courseName");
        String subject = request.getParameter("subject");
        String dayOfWeek = request.getParameter("dayOfWeek");
        String startTime = request.getParameter("startTime");
        String endTime = request.getParameter("endTime");
        String roomNumber = request.getParameter("roomNumber");

        try (Connection conn = DBConnection.getConnection()) {
            String query = "INSERT INTO timetables (course_name, subject, day_of_week, start_time, end_time, room_number) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, courseName);
            ps.setString(2, subject);
            ps.setString(3, dayOfWeek);
            ps.setString(4, startTime);
            ps.setString(5, endTime);
            ps.setString(6, roomNumber);
            
            ps.executeUpdate();
            response.sendRedirect("timetable_management.jsp?status=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("timetable_management.jsp?status=error");
        }
    }
}