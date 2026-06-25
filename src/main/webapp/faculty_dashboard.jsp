<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Security layer to keep students out of faculty records
    if (session.getAttribute("user") == null || !"FACULTY".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    String facultyId = (String) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Faculty Hub - ERP Central</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f4f6f9; margin: 0; display: flex; }
        .sidebar { width: 260px; background: #1e293b; color: white; height: 100vh; padding: 20px; box-sizing: border-box; }
        .sidebar h2 { color: #f59e0b; font-size: 22px; margin-bottom: 30px; border-bottom: 2px solid #334155; padding-bottom: 10px; }
        .sidebar-menu { list-style: none; padding: 0; margin: 0; }
        .sidebar-menu li { padding: 12px 15px; margin-bottom: 8px; border-radius: 6px; cursor: pointer; background: #334155; }
        .sidebar-menu li:hover { background: #f59e0b; }
        .logout-btn { background: #ef4444 !important; margin-top: 50px; text-align: center; color: white; font-weight: bold; }
        .main-content { flex: 1; padding: 40px; box-sizing: border-box; }
        .welcome-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e5e7eb; padding-bottom: 15px; margin-bottom: 30px; }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2>👨‍🏫 Faculty Hub</h2>
        <ul class="sidebar-menu">
            <li>Dashboard</li>
            <li>Manage Attendance</li>
            <li>Submit Grades</li>
            <li class="logout-btn" onclick="location.href='login.jsp'">Logout</li>
        </ul>
    </div>

    <div class="main-content">
        <div class="welcome-header">
            <h1>Welcome Back, Professor!</h1>
            <span style="background: #fef3c7; color: #92400e; padding: 6px 12px; border-radius: 20px; font-weight: 600; font-size: 14px;">Faculty Account: <%= facultyId %></span>
        </div>
        <p style="color: #4b5563;">Select an option from the sidebar menu to update student grades or track daily attendance classes.</p>
    </div>

</body>
</html>