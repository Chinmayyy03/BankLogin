<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // ✅ Prevent back navigation after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // ✅ Get session variables
    String userId = (String) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String branchCode = (String) session.getAttribute("branchCode");

    // ✅ Redirect to login if session expired
    if (userId == null || branchCode == null) {
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
body {
    background: linear-gradient(to bottom right, #071a3d, #0e295e);
    color: white;
    font-family: "Segoe UI", sans-serif;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.dashboard-container {
    max-width: 900px;
    margin: auto;
    padding: 30px;
}

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

.login-footer {
    text-align: center;
    margin-top: 30px;
    color: #b9c8e3;
    font-size: 0.85em;
}
</style>
</head>

<body>
<div class="dashboard-container">
    <!-- Header -->
    <div class="dashboard-header">
        <div>
            <h3 style="margin:0;">🏦 Merchants Liberal Co-op Bank Ltd</h3>
            <small>Core Banking System Dashboard</small>
        </div>
        <form action="logout.jsp" method="post" style="margin:0;">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>

    <!-- Main Content -->
    <div class="dashboard-content">
        <div class="welcome-text">Welcome, <%= userName != null ? userName : userId %> 👋</div>
        <div class="branch-info">Branch Code: <strong><%= branchCode %></strong></div>
        <hr>
        <p>You are now logged in to the secure core banking dashboard.</p>
        <p>From here, you can access customer accounts, transactions, reports, and other modules (to be added later).</p>
    </div>

    <!-- Footer -->
    <div class="login-footer">
        © 2025 Merchants Liberal Co-op Bank Ltd. All rights reserved.
    </div>
</div>
</body>
</html>
