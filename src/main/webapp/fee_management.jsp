<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Fee Management - College ERP</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; background: #f4f6f9; display: flex; }
        .main-content { margin-left: 260px; padding: 40px; width: calc(100% - 260px); box-sizing: border-box; }
        .header { border-bottom: 2px solid #e5e7eb; padding-bottom: 20px; margin-bottom: 30px; }
        .header h1 { margin: 0; color: #111827; }
        .form-section { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border-top: 4px solid #06b6d4; }
        .form-section h2 { margin-top: 0; color: #1f2937; padding-bottom: 10px; border-bottom: 1px solid #e5e7eb; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 20px; }
        .form-group { display: flex; flex-direction: column; }
        .form-group label { font-weight: 600; color: #4b5563; margin-bottom: 8px; font-size: 14px; }
        .form-group input, .form-group select { padding: 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; }
        .btn-submit { grid-column: span 2; padding: 14px; background: #06b6d4; color: white; border: none; border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer; margin-top: 10px; }
        .btn-submit:hover { background: #0891b2; }
    </style>
</head>
<body>

    <jsp:include page="sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>💳 Fee & Finance Management</h1>
        </div>

        <div class="form-section">
            <h2>➕ Record Student Fee Payment</h2>
            <form action="processFee" method="POST">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Student ID (Roll Number)</label>
                        <input type="text" name="studentId" placeholder="e.g., STU302" required>
                    </div>
                    <div class="form-group">
                        <label>Amount Paid (INR)</label>
                        <input type="number" step="0.01" name="amount" placeholder="e.g., 45000" required>
                    </div>
                    <div class="form-group">
                        <label>Fee Category Type</label>
                        <select name="feeType" required>
                            <option value="">-- Select Category --</option>
                            <option value="Tuition Fee">Tuition Fee</option>
                            <option value="Examination Fee">Examination Fee</option>
                            <option value="Hostel & Mess Fee">Hostel & Mess Fee</option>
                            <option value="Library/Placement Fee">Library & Placement Fee</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Payment Mode</label>
                        <select name="paymentMode" required>
                            <option value="">-- Select Mode --</option>
                            <option value="UPI / NetBanking">UPI / NetBanking</option>
                            <option value="Credit / Debit Card">Credit / Debit Card</option>
                            <option value="Demand Draft / Cheque">Demand Draft / Cheque</option>
                            <option value="Cash Counter">Cash Counter</option>
                        </select>
                    </div>
                    <button type="submit" class="btn-submit">Submit Transaction Record</button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>