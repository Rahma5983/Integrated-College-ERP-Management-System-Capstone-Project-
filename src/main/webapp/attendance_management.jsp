<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Attendance Management - College ERP</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; background: #f4f6f9; display: flex; }
        .main-content { margin-left: 260px; padding: 40px; width: calc(100% - 260px); box-sizing: border-box; }
        .header { border-bottom: 2px solid #e5e7eb; padding-bottom: 20px; margin-bottom: 30px; }
        .header h1 { margin: 0; color: #111827; }
        .form-section { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border-top: 4px solid #f59e0b; }
        .form-section h2 { margin-top: 0; color: #1f2937; padding-bottom: 10px; border-bottom: 1px solid #e5e7eb; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px; margin-top: 20px; }
        .form-group { display: flex; flex-direction: column; }
        .form-group label { font-weight: 600; color: #4b5563; margin-bottom: 8px; font-size: 14px; }
        .form-group input, .form-group select { padding: 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; }
        .btn-submit { grid-column: span 3; padding: 14px; background: #f59e0b; color: white; border: none; border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer; margin-top: 10px; }
        .btn-submit:hover { background: #d97706; }
        .alert-success { background: #d1e7dd; color: #0f5132; padding: 15px; border-radius: 6px; margin-bottom: 20px; font-weight: 600; border: 1px solid #badbcc; }
    </style>
</head>
<body>

    <jsp:include page="sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>📅 Attendance Management</h1>
        </div>

        <%-- Check if redirected back with success state flag --%>
        <% if("att_success".equals(request.getParameter("status"))) { %>
            <div class="alert-success">✓ Attendance record saved successfully in the database!</div>
        <% } %>

        <div class="form-section">
            <h2>📅 Log Student Attendance</h2>
            <form action="logAttendance" method="POST">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Student ID (Roll Number)</label>
                        <input type="text" name="studentId" placeholder="e.g., STU301" required>
                    </div>
                    <div class="form-group">
                        <label>Attendance Status</label>
                        <select name="status" required>
                            <option value="">-- Choose Status --</option>
                            <option value="Present">Present  🟢</option>
                            <option value="Absent">Absent  🔴</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Marked By (Faculty/Admin ID)</label>
                        <input type="text" name="markedBy" value="ADMIN101" required>
                    </div>
                    <button type="submit" class="btn-submit">Save Attendance Record</button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>