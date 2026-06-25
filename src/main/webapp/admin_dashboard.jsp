<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.college.util.DBConnection" %>
<%
    // Setup fallback defaults in case the database tables are empty
    int totalStudents = 0;
    int totalFaculty = 0;
    double attendanceRate = 0.0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DBConnection.getConnection()) {
            
            // 1. Calculate Total Registered Students
            String studentQuery = "SELECT COUNT(*) FROM students";
            PreparedStatement psStu = conn.prepareStatement(studentQuery);
            ResultSet rsStu = psStu.executeQuery();
            if(rsStu.next()) {
                totalStudents = rsStu.getInt(1);
            }
            
            // 2. Calculate Total Registered Faculty Members
            String facultyQuery = "SELECT COUNT(*) FROM faculty";
            PreparedStatement psFac = conn.prepareStatement(facultyQuery);
            ResultSet rsFac = psFac.executeQuery();
            if(rsFac.next()) {
                totalFaculty = rsFac.getInt(1);
            }
            
            // 3. Calculate Overall System Attendance Success Rate Percentage
            String attendanceQuery = "SELECT " +
                                     "COUNT(CASE WHEN status = 'PRESENT' THEN 1 END) * 100.0 / COUNT(*) " +
                                     "FROM attendance";
            PreparedStatement psAtt = conn.prepareStatement(attendanceQuery);
            ResultSet rsAtt = psAtt.executeQuery();
            if(rsAtt.next()) {
                attendanceRate = rsAtt.getDouble(1);
                // Round off down to 1 decimal place cleanly
                attendanceRate = Math.round(attendanceRate * 10.0) / 10.0;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - College ERP</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; background: #f4f6f9; display: flex; }
        .main-content { margin-left: 260px; padding: 40px; width: calc(100% - 260px); box-sizing: border-box; }
        .header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e5e7eb; padding-bottom: 20px; }
        .header h1 { margin: 0; color: #111827; }
        .stats-container { display: flex; gap: 20px; margin-top: 30px; }
        .card { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); flex: 1; border-top: 4px solid #3b82f6; }
        .card h3 { margin: 0; color: #6b7280; font-size: 14px; text-transform: uppercase; }
        .card p { margin: 10px 0 0 0; font-size: 32px; font-weight: bold; color: #1f2937; }
    </style>
</head>
<body>

    <jsp:include page="sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>Welcome Admin Control Center</h1>
            <a href="login.jsp" style="text-decoration: none; color: #ef4444; font-weight: bold;">Logout ❌</a>
        </div>

        <div class="stats-container">
            <div class="card">
                <h3>Total Students</h3>
                <p><%= totalStudents %></p>
            </div>
            <div class="card" style="border-top-color: #10b981;">
                <h3>Active Faculty</h3>
                <p><%= totalFaculty %></p>
            </div>
            <div class="card" style="border-top-color: #f59e0b;">
                <h3>Daily Attendance Rate</h3>
                <p><%= (Double.isNaN(attendanceRate) || attendanceRate == 0.0) ? "0.0%" : attendanceRate + "%" %></p>
            </div>
        </div>
    </div>

</body>
</html>