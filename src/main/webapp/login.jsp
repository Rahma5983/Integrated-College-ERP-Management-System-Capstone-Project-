<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>College ERP Login</title>
    <style>
        body { font-family: sans-serif; background: #f0f2f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .card { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); width: 320px; }
        h2 { text-align: center; color: #1a73e8; margin-bottom: 20px; }
        input { width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #dadce0; border-radius: 4px; box-sizing: border-box; }
        button { width: 100%; padding: 10px; background: #1a73e8; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .error-msg { color: #d93025; font-size: 14px; text-align: center; margin-bottom: 15px; font-weight: 500; }
    </style>
</head>
<body>
    <div class="card">
        <h2>College ERP</h2>
        
        <%-- Optional: Displays a clean error message if login credentials fail --%>
        <% if (request.getParameter("error") != null) { %>
            <div class="error-msg">Invalid User ID or Password!</div>
        <% } %>

        <%-- Change 1: Updated action route to hit our security controller servlet --%>
        <form action="login" method="POST">
            <label>User ID</label>
            <%-- Change 2: Altered name="userId" to name="username" to match LoginServlet --%>
            <input type="text" name="userId" placeholder="e.g., STU301" required>
            
            <label>Password</label>
            <input type="password" name="password" placeholder="Enter Password" required>
            
            <button type="submit">Sign In</button>
        </form>
    </div>
</body>
</html>