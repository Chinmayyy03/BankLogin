<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Disable caching
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires", 0);

    String userId = request.getParameter("username");
    String password = request.getParameter("password");
    String branchCode = request.getParameter("branch");
    boolean showForm = true;

    if (userId != null && password != null && branchCode != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();

            // ✅ Updated query: use BRANCH_LOGIN (no active/status columns)
            String sql = "SELECT NAME " +
                         "FROM BRANCH_LOGIN " +
                         "WHERE USER_ID = ? AND PASSWORD = ? AND BRANCH_CODE = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, password);
            pstmt.setString(3, branchCode);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String name = rs.getString("NAME");

                // ✅ Successful login
                session.setAttribute("userId", userId);
                session.setAttribute("branch", branchCode);
                session.setAttribute("userName", name);
                response.sendRedirect("dashboard.jsp");
                showForm = false;
            } else {
                out.println("<script>alert('Invalid User ID, Password, or Branch Code');</script>");
            }
        } catch (Exception e) {
            out.println("<script>alert('Database Error: " + e.getMessage() + "');</script>");
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
%>

<% if (showForm) { %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bank CBS - Secure Login</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="login-container">
    <div class="bank-brand">
        <img src="idsspl_logo.gif" alt="Bank Logo" class="bank-logo">
        <div class="brand-title">MERCHANTS LIBERAL CO-OP BANK LTD, GADAG</div>
        <div class="brand-sub">Core Banking System - Secure Access</div>
    </div>

    <form action="login.jsp" method="post" autocomplete="off">
        <label for="branch">Branch Code</label>
        <select id="branch" name="branch" class="form-control" required>
            <option value="">-- Select Branch --</option>
            <%
                try (Connection conn = DBConnection.getConnection();
                     Statement stmt = conn.createStatement();
                     ResultSet branchRS = stmt.executeQuery("SELECT BRANCH_CODE, NAME FROM BRANCHES ORDER BY BRANCH_CODE")) {

                    while(branchRS.next()) {
                        String bCode = branchRS.getString("BRANCH_CODE");
                        String bName = branchRS.getString("NAME");
            %>
                        <option value="<%=bCode%>"><%=bCode%> - <%=bName%></option>
            <%
                    }
                } catch(Exception ex) {
                    out.println("<option>Error loading branches</option>");
                }
            %>
        </select>

        <label for="username">User ID</label>
        <input type="text" id="username" name="username" class="form-control" required>

        <label for="password">Password</label>
        <input type="password" id="password" name="password" class="form-control" required>

        <button type="submit" class="btn-login">Login</button>

        <div class="help-row">
            <a href="#">Forgot Password?</a>
            <a href="signin.jsp">Sign in ?</a>
        </div>
    </form>

    <div class="login-footer">
        © 2025 Merchants Liberal Co-op Bank Ltd. All rights reserved.
    </div>
</div>
</body>
</html>
<% } %>
