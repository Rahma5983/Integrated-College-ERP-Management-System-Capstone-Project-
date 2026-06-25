<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.college.util.DBConnection" %>
<%
    // Security Interception Layer
    if (session.getAttribute("user") == null || !"STUDENT".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String studentId = (String) session.getAttribute("user");
    
    // Default fallback placeholder values
    String studentName = "Active Student";
    String email = "N/A";
    String branch = "General Engineering";
    double attendanceRate = 0.0;
    
    // DB Fetch logic for personalized user card context
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DBConnection.getConnection()) {
            // Adjust the column names below if your 'students' table uses slightly different variations
            String query = "SELECT first_name, last_name, email, course_branch FROM students WHERE student_id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, studentId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                studentName = rs.getString("first_name") + " " + rs.getString("last_name");
                email = rs.getString("email");
                branch = rs.getString("course_branch");
            }
            
            // Fetch personal aggregate attendance metrics safely
            String attQuery = "SELECT (COUNT(CASE WHEN status='Present' THEN 1 END) * 100.0 / COUNT(*)) as rate FROM attendance WHERE student_id = ?";
            PreparedStatement psAtt = conn.prepareStatement(attQuery);
            psAtt.setString(1, studentId);
            ResultSet rsAtt = psAtt.executeQuery();
            if(rsAtt.next() && rsAtt.getObject("rate") != null) {
                attendanceRate = rsAtt.getDouble("rate");
            }
        }
    } catch(Exception e) {
        // Silent catch fallback to gracefully render UI even if records are missing
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Portal - ERP Central</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f4f6f9; margin: 0; display: flex; }
        .sidebar { width: 260px; background: #1e293b; color: white; height: 100vh; padding: 20px; box-sizing: border-box; }
        .sidebar h2 { color: #3b82f6; font-size: 22px; margin-bottom: 30px; border-bottom: 2px solid #334155; padding-bottom: 10px; }
        .sidebar-menu { list-style: none; padding: 0; margin: 0; }
        .sidebar-menu li { padding: 12px 15px; margin-bottom: 8px; border-radius: 6px; cursor: pointer; background: #334155; }
        .sidebar-menu li:hover { background: #3b82f6; }
        .logout-btn { background: #ef4444 !important; margin-top: 50px; text-align: center; color: white; font-weight: bold; }
        .main-content { flex-1; padding: 40px; box-sizing: border-box; width: 100%; }
        .welcome-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e5e7eb; padding-bottom: 15px; margin-bottom: 30px; }
        .welcome-header h1 { margin: 0; color: #111827; }
        .grid-cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .card { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border-top: 4px solid #3b82f6; }
        .card.attendance { border-top-color: #10b981; }
        .card h3 { margin: 0 0 10px 0; color: #4b5563; font-size: 14px; text-transform: uppercase; }
        .card .metric { font-size: 28px; font-weight: bold; color: #111827; }
        .profile-table { width: 100%; border-collapse: collapse; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .profile-table td { padding: 15px 20px; border-bottom: 1px solid #f3f4f6; color: #374151; font-size: 15px; }
        .profile-table td.label { font-weight: bold; color: #4b5563; width: 30%; background: #f9fafb; }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2>🎓 Student Hub</h2>
        <ul class="sidebar-menu">
            <li>Dashboard</li>
            <li>My Grades</li>
            <li>Fee Receipts</li>
            <li class="logout-btn" onclick="location.href='login.jsp'">Logout</li>
        </ul>
    </div>

    <div class="main-content">
        <div class="welcome-header">
            <h1>Welcome Back, <%= studentName %>!</h1>
            <span style="background: #dbeafe; color: #1e40af; padding: 6px 12px; border-radius: 20px; font-weight: 600; font-size: 14px;">Student Portal</span>
        </div>

        <div class="grid-cards">
            <div class="card">
                <h3>My Roll Number</h3>
                <div class="metric"><%= studentId %></div>
            </div>
            <div class="card attendance">
                <h3>My Attendance Rate</h3>
                <div class="metric"><%= String.format("%.1f", attendanceRate) %>%</div>
            </div>
        </div>

        <h2 style="color: #111827; font-size: 18px; margin-bottom: 15px;">📋 Core Profile Details</h2>
        <table class="profile-table">
            <tr>
                <td class="label">Full Name</td>
                <td><%= studentName %></td>
            </tr>
            <tr>
                <td class="label">Registered Email</td>
                <td><%= email %></td>
            </tr>
            <tr>
                <td class="label">Course Department</td>
                <td><%= branch %></td>
            </tr>
        </table>
    </div>

</body>
</html>