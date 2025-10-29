<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Prevent back navigation after logout
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires", 0);

    // Get session variables
    String userId = (String) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String branch = (String) session.getAttribute("branch");

    // Redirect if not logged in
    if (userId == null || userName == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Dashboard - Bank CBS</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css">
<style>
.dashboard-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: rgba(0,0,0,0.4);
    padding: 15px 30px;
    border-radius: 8px;
    margin-bottom: 30px;
    color: #fff;
}

.dashboard-content {
    background: rgba(255,255,255,0.1);
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 0 20px rgba(255,255,255,0.15);
    max-width: 800px;
    margin: 0 auto;
    color: #fff;
}

.logout-btn {
    background: linear-gradient(45deg, #f44336, #c62828);
    color: #fff;
    border: none;
    padding: 8px 20px;
    border-radius: 5px;
    font-weight: 600;
    transition: 0.3s;
}
.logout-btn:hover {
    background: linear-gradient(45deg, #c62828, #8e0000);
    box-shadow: 0 0 10px rgba(255,0,0,0.5);
}

.welcome-text {
    font-size: 22px;
    font-weight: 600;
    margin-bottom: 15px;
}

.branch-info {
    font-size: 16px;
    color: #d0e1ff;
}
</style>
</head>
<body>
<div class="login-container">
    <div class="dashboard-header">
        <div>
            <h3 style="margin:0;">🏦 Merchants Liberal Co-op Bank Ltd</h3>
            <small>Core Banking System</small>
        </div>
        <form action="logout.jsp" method="post" style="margin:0;">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>

    <div class="dashboard-content">
        <div class="welcome-text">Welcome, <%= userName %>!</div>
        <div class="branch-info">Branch Code: <strong><%= branch %></strong></div>
        <hr>
        <p>You are now logged in to the secure core banking dashboard.</p>
        <p>From here, you can access customer accounts, transactions, reports, and more (modules can be added later).</p>
    </div>

    <div class="login-footer">
        © 2025 Merchants Liberal Co-op Bank Ltd. All rights reserved.
    </div>
</div>
</body>
</html>
