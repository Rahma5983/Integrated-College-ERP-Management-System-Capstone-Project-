<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .sidebar { width: 260px; height: 100vh; background: #1f2937; color: white; position: fixed; top: 0; left: 0; }
    .sidebar h2 { text-align: center; padding: 20px 0; border-bottom: 1px solid #374151; margin: 0; font-size: 20px; }
    .sidebar a { display: block; color: #d1d5db; padding: 15px 25px; text-decoration: none; font-size: 16px; }
    .sidebar a:hover, .sidebar a.active { background: #374151; color: white; }
</style>

<div class="sidebar">
    <h2>ERP Central</h2>
    <a href="admin_dashboard.jsp">🏠 Dashboard</a>
    <a href="student_management.jsp">🎓 Student Management</a>
    <a href="faculty_management.jsp">👨‍🏫 Faculty Management</a>
    <a href="attendance_management.jsp">📅 Attendance</a>
    <a href="fee_management.jsp">💳 Fee Module</a>
    <a href="exam_management.jsp">📝 Examination Module</a>
    <a href="timetable_management.jsp">⏳ Timetable and Scheduling</a>
    <a href="notification_management.jsp">🔔 Notification and Communication</a>
</div>