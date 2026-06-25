<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Examination & Results - College ERP</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; background: #f4f6f9; display: flex; }
        .main-content { margin-left: 260px; padding: 40px; width: calc(100% - 260px); box-sizing: border-box; }
        .header { border-bottom: 2px solid #e5e7eb; padding-bottom: 20px; margin-bottom: 30px; }
        .header h1 { margin: 0; color: #111827; }
        .form-section { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border-top: 4px solid #a855f7; }
        .form-section h2 { margin-top: 0; color: #1f2937; padding-bottom: 10px; border-bottom: 1px solid #e5e7eb; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 20px; }
        .form-group { display: flex; flex-direction: column; }
        .form-group label { font-weight: 600; color: #4b5563; margin-bottom: 8px; font-size: 14px; }
        .form-group input, .form-group select { padding: 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; }
        .btn-submit { grid-column: span 2; padding: 14px; background: #a855f7; color: white; border: none; border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer; margin-top: 10px; }
        .btn-submit:hover { background: #9333ea; }
    </style>
</head>
<body>

    <jsp:include page="sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>📝 Examination & Result Processing</h1>
        </div>

        <div class="form-section">
            <h2>➕ Enter Student Marks</h2>
            <form action="processExam" method="POST">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Student ID (Roll Number)</label>
                        <input type="text" name="studentId" placeholder="e.g., STU302" required>
                    </div>
                    <div class="form-group">
                        <label>Exam Term</label>
                        <select name="examTerm" required>
                            <option value="">-- Select Term --</option>
                            <option value="Mid-Term">Mid-Term</option>
                            <option value="End-Term">End-Term</option>
                            <option value="Practical/Viva">Practical / Viva</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Subject / Course Name</label>
                        <input type="text" name="subjectName" placeholder="e.g., Object Oriented Programming" required>
                    </div>
                    <div class="form-group">
                        <div style="display: flex; gap: 10px;">
                            <div style="flex: 1;">
                                <label>Marks Obtained</label>
                                <input type="number" name="marksObtained" min="0" placeholder="85" required>
                            </div>
                            <div style="flex: 1;">
                                <label>Total Marks</label>
                                <input type="number" name="totalMarks" min="1" value="100" required>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn-submit">Publish Result Record</button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>