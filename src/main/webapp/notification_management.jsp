<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.college.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Campus Communications - College ERP</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; background: #f4f6f9; display: flex; }
        .main-content { margin-left: 260px; padding: 40px; width: calc(100% - 260px); box-sizing: border-box; }
        .header { border-bottom: 2px solid #e5e7eb; padding-bottom: 20px; margin-bottom: 30px; }
        .header h1 { margin: 0; color: #111827; }
        .form-section, .list-section { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); margin-bottom: 30px; }
        .form-section { border-top: 4px solid #8b5cf6; }
        .list-section { border-top: 4px solid #ef4444; }
        h2 { margin-top: 0; color: #1f2937; padding-bottom: 10px; border-bottom: 1px solid #e5e7eb; }
        .form-group { display: flex; flex-direction: column; margin-bottom: 20px; }
        .form-group label { font-weight: 600; color: #4b5563; margin-bottom: 8px; font-size: 14px; }
        .form-group input, .form-group select, .form-group textarea { padding: 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; font-family: inherit; }
        .btn-submit { padding: 14px; background: #8b5cf6; color: white; border: none; border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer; }
        .btn-submit:hover { background: #7c3aed; }
        .alert-success { background: #d1e7dd; color: #0f5132; padding: 15px; border-radius: 6px; margin-bottom: 20px; font-weight: 600; border: 1px solid #badbcc; }
        .notice-card { background: #f9fafb; border: 1px solid #e5e7eb; border-radius: 8px; padding: 20px; margin-bottom: 15px; }
        .badge { display: inline-block; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: bold; margin-bottom: 10px; }
        .badge-all { background: #e0f2fe; color: #0369a1; }
        .badge-student { background: #fef3c7; color: #92400e; }
        .badge-faculty { background: #d1fae5; color: #065f46; }
    </style>
</head>
<body>

    <jsp:include page="sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1>📢 Campus Communications Center</h1>
        </div>

        <% if("notif_sent".equals(request.getParameter("status"))) { %>
            <div class="alert-success">✓ Broadcast announcement successfully pushed out to live feeds!</div>
        <% } %>

        <div class="form-section">
            <h2>📣 Broadcast New Notice</h2>
            <form action="publishNotification" method="POST">
                <div class="form-group">
                    <label>Notice Heading / Title</label>
                    <input type="text" name="title" placeholder="e.g., Mid-Term Examination Postponement Notice" required>
                </div>
                <div class="form-group">
                    <label>Target Audience Scope</label>
                    <select name="targetRole" required>
                        <option value="ALL">Broadcast to All Roles (Public)</option>
                        <option value="STUDENT">Students Directory Only</option>
                        <option value="FACULTY">Faculty & Staff Members Only</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Announcement Body Content</label>
                    <textarea name="message" rows="4" placeholder="Type instructions or notice context details here..." required></textarea>
                </div>
                <button type="submit" class="btn-submit">Broadcast Live Bulletin</button>
            </form>
        </div>

        <div class="list-section">
            <h2>📜 Outgoing Broadcast Logs</h2>
            <%
                try (Connection conn = DBConnection.getConnection()) {
                    String query = "SELECT * FROM notifications ORDER BY created_at DESC";
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(query);
                    boolean hasLogs = false;
                    while(rs.next()) {
                        hasLogs = true;
                        String role = rs.getString("target_role");
                        String badgeClass = "badge-all";
                        if("STUDENT".equals(role)) badgeClass = "badge-student";
                        if("FACULTY".equals(role)) badgeClass = "badge-faculty";
            %>
                        <div class="notice-card">
                            <span class="badge <%= badgeClass %>">Target: <%= role %></span>
                            <h3 style="margin: 0 0 10px 0; color: #111827;"><%= rs.getString("title") %></h3>
                            <p style="margin: 0 0 15px 0; color: #4b5563; line-height: 1.5;"><%= rs.getString("message") %></p>
                            <small style="color: #9ca3af; font-weight: 500;">Sent on: <%= rs.getTimestamp("created_at") %></small>
                        </div>
            <%
                    }
                    if(!hasLogs) {
                        out.println("<p style='text-align:center; color:#6b7280;'>No broadcast announcements recorded.</p>");
                    }
                } catch(Exception e) {
                    out.println("<p style='color:#ef4444;'>Error pulling historical circulars.</p>");
                }
            %>
        </div>
    </div>

</body>
</html>