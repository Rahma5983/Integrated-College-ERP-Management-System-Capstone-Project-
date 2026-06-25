<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.college.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Timetable Management - College ERP</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; background: #f4f6f9; display: flex; }
        .main-content { margin-left: 260px; padding: 40px; width: calc(100% - 260px); box-sizing: border-box; }
        .header { border-bottom: 2px solid #e5e7eb; padding-bottom: 20px; margin-bottom: 30px; }
        .header h1 { margin: 0; color: #111827; }
        .form-section, .list-section { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); margin-bottom: 30px; }
        .form-section { border-top: 4px solid #3b82f6; }
        .list-section { border-top: 4px solid #10b981; }
        h2 { margin-top: 0; color: #1f2937; padding-bottom: 10px; border-bottom: 1px solid #e5e7eb; }
        .form-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-top: 20px; }
        .form-group { display: flex; flex-direction: column; }
        .form-group label { font-weight: 600; color: #4b5563; margin-bottom: 8px; font-size: 14px; }
        .form-group input, .form-group select { padding: 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; }
        .btn-submit { grid-column: span 3; padding: 14px; background: #3b82f6; color: white; border: none; border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer; margin-top: 10px; }
        .btn-submit:hover { background: #2563eb; }
        .alert-success { background: #d1e7dd; color: #0f5132; padding: 15px; border-radius: 6px; margin-bottom: 20px; font-weight: 600; border: 1px solid #badbcc; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 12px 15px; text-align: left; border-bottom: 1px solid #e5e7eb; }
        th { background-color: #f9fafb; color: #374151; font-weight: 600; }
    </style>
</head>
<body>

    <jsp:include page="sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>📅 Timetable Management</h1>
        </div>

        <% if("success".equals(request.getParameter("status"))) { %>
            <div class="alert-success">✓ Schedule slot successfully added to the timetable repository!</div>
        <% } %>

        <div class="form-section">
            <h2>➕ Add Class Schedule</h2>
            <form action="addSchedule" method="POST">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Course / Semester</label>
                        <input type="text" name="courseName" placeholder="e.g., B.Tech CSE 2nd Year" required>
                    </div>
                    <div class="form-group">
                        <label>Subject Title</label>
                        <input type="text" name="subject" placeholder="e.g., Database Management Systems" required>
                    </div>
                    <div class="form-group">
                        <label>Day of Week</label>
                        <select name="dayOfWeek" required>
                            <option value="">-- Choose Day --</option>
                            <option value="Monday">Monday</option>
                            <option value="Tuesday">Tuesday</option>
                            <option value="Wednesday">Wednesday</option>
                            <option value="Thursday">Thursday</option>
                            <option value="Friday">Friday</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Start Time</label>
                        <input type="time" name="startTime" required>
                    </div>
                    <div class="form-group">
                        <label>End Time</label>
                        <input type="time" name="endTime" required>
                    </div>
                    <div class="form-group">
                        <label>Room Number</label>
                        <input type="text" name="roomNumber" placeholder="e.g., Lab-3 or Room 402" required>
                    </div>
                    <button type="submit" class="btn-submit">Publish Schedule Slot</button>
                </div>
            </form>
        </div>

        <div class="list-section">
            <h2>📋 Master Schedule Registry</h2>
            <table>
                <thead>
                    <tr>
                        <th>Course</th>
                        <th>Subject</th>
                        <th>Day</th>
                        <th>Timings</th>
                        <th>Room</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try (Connection conn = DBConnection.getConnection()) {
                            String query = "SELECT * FROM timetables ORDER BY FIELD(day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'), start_time";
                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery(query);
                            boolean hasData = false;
                            while(rs.next()) {
                                hasData = true;
                    %>
                                <tr>
                                    <td><strong><%= rs.getString("course_name") %></strong></td>
                                    <td><%= rs.getString("subject") %></td>
                                    <td><%= rs.getString("day_of_week") %></td>
                                    <td><%= rs.getTime("start_time") %> - <%= rs.getTime("end_time") %></td>
                                    <td><span style="background: #e0f2fe; color: #0369a1; padding: 4px 8px; border-radius: 4px; font-weight: 600;"><%= rs.getString("room_number") %></span></td>
                                </tr>
                    <%
                            }
                            if(!hasData) {
                                out.println("<tr><td colspan='5' style='text-align:center; color:#6b7280;'>No slots registered yet.</td></tr>");
                            }
                        } catch(Exception e) {
                            out.println("<tr><td colspan='5' style='color:#ef4444;'>Error connecting to timetable registry.</td></tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>