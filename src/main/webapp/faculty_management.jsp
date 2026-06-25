<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Faculty Management - College ERP</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; background: #f4f6f9; display: flex; }
        .main-content { margin-left: 260px; padding: 40px; width: calc(100% - 260px); box-sizing: border-box; }
        .header { border-bottom: 2px solid #e5e7eb; padding-bottom: 20px; margin-bottom: 30px; }
        .header h1 { margin: 0; color: #111827; }
        .form-section { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border-top: 4px solid #3b82f6; }
        .form-section h2 { margin-top: 0; color: #1f2937; padding-bottom: 10px; border-bottom: 1px solid #e5e7eb; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 20px; }
        .form-group { display: flex; flex-direction: column; }
        .form-group label { font-weight: 600; color: #4b5563; margin-bottom: 8px; font-size: 14px; }
        .form-group input, .form-group select { padding: 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; }
        .btn-submit { grid-column: span 2; padding: 14px; background: #3b82f6; color: white; border: none; border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer; margin-top: 10px; }
        .btn-submit:hover { background: #2563eb; }
    </style>
</head>
<body>

    <jsp:include page="sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>👨‍🏫 Faculty and Staff Management</h1>
        </div>

        <div class="form-section">
            <h2>➕ Register New Faculty/Staff Member</h2>
            <form action="registerFaculty" method="POST">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Faculty ID (Employee Number)</label>
                        <input type="text" name="facultyId" placeholder="e.g., FAC501" required>
                    </div>
                    <div class="form-group">
                        <label>Initial Login Password</label>
                        <input type="password" name="password" placeholder="Temporary password" required>
                    </div>
                    <div class="form-group">
                        <label>First Name</label>
                        <input type="text" name="firstName" placeholder="Jane" required>
                    </div>
                    <div class="form-group">
                        <label>Last Name</label>
                        <input type="text" name="lastName" placeholder="Smith" required>
                    </div>
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" placeholder="janesmith@college.edu" required>
                    </div>
                    <div class="form-group">
                        <label>Department Assignment</label>
                        <select name="department" required>
                            <option value="">-- Select Department --</option>
                            <option value="Computer Science">Computer Science</option>
                            <option value="Electronics">Electronics</option>
                            <option value="Mechanical">Mechanical</option>
                            <option value="Civil">Civil</option>
                        </select>
                    </div>
                    <div class="form-group" style="grid-column: span 2;">
                        <label>Designation Role</label>
                        <select name="designation" required>
                            <option value="">-- Select Designation --</option>
                            <option value="Professor">Professor</option>
                            <option value="Assistant Professor">Assistant Professor</option>
                            <option value="Lab Instructor">Lab Instructor</option>
                            <option value="Head of Department (HOD)">Head of Department (HOD)</option>
                        </select>
                    </div>
                    <button type="submit" class="btn-submit">Register Faculty Account</button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>