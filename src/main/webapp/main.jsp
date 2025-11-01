<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String userId = (String) session.getAttribute("userId");
    String branchCode = (String) session.getAttribute("branchCode");
    String branchName = "";

    if (userId == null || branchCode == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement("SELECT NAME FROM BRANCHES WHERE BRANCH_CODE=?")) {
        ps.setString(1, branchCode);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            branchName = rs.getString("NAME");
        }
    } catch (Exception e) {
        branchName = "Unknown Branch";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Main Dashboard</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body>

<div class="sidebar">
    <div class="profile-section">
        <img src="profile.jpg" alt="Profile" class="profile-pic">
        <div class="branch-name"><%= branchName %></div>
    </div>

    <ul class="menu">
        <li onclick="loadPage('dashboard.jsp', 'Dashboard')" class="active">🏠 Dashboard</li>
        <li onclick="loadPage('customers.jsp', 'Customers')">👥 Customers</li>
        
    </ul>

    <div class="logout">
        <a href="logout.jsp">⏻ Log Out</a>
    </div>
</div>

<div class="main-content">
    <header>
        <h1 id="pageTitle">Dashboard</h1>
        <div id="liveDate"></div>
    </header>

    <iframe id="contentFrame" src="dashboard.jsp" frameborder="0"></iframe>
</div>

<script>
function loadPage(page, title) {
    document.getElementById("contentFrame").src = page;
    document.getElementById("pageTitle").innerText = title;

    document.querySelectorAll(".menu li").forEach(li => li.classList.remove("active"));
    event.target.classList.add("active");
}

// Live date updater
function updateDate() {
    const now = new Date();
    const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
    document.getElementById("liveDate").innerText = now.toLocaleDateString('en-US', options);
}
setInterval(updateDate, 1000);
updateDate();
</script>

</body>
</html>
