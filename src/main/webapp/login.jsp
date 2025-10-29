<%@ page import="java.sql.*,java.text.*,java.util.*" %>
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
            Class.forName("oracle.jdbc.driver.OracleDriver");
            String dbURL = "jdbc:oracle:thin:@203.129.218.98:1521:mlcb";
            String dbUser = "system";
            String dbPass = "info123";
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String sql = "SELECT NAME, IS_ACCOUNT_ACTIVE, STATUS " +
                         "FROM ACL.USERREGISTER " +
                         "WHERE USER_ID=? AND PASSWORD=? AND BRANCH_CODE=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, password);
            pstmt.setString(3, branchCode);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String name = rs.getString("NAME");
                String active = rs.getString("IS_ACCOUNT_ACTIVE");
                String status = rs.getString("STATUS");

                if ("Y".equalsIgnoreCase(active) && "A".equalsIgnoreCase(status)) {
                    session.setAttribute("userId", userId);
                    session.setAttribute("branch", branchCode);
                    session.setAttribute("userName", name);
                    response.sendRedirect("dashboard.jsp");
                    showForm = false;
                } else {
                    out.println("<script>alert('User account inactive or not authorized');</script>");
                }
            } else {
                out.println("<script>alert('Invalid User ID or Password');</script>");
            }
        } catch (Exception e) {
            out.println("<script>alert('Database Error: " + e.getMessage() + "');</script>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ex) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception ex) {}
            if (conn != null) try { conn.close(); } catch (Exception ex) {}
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
<style>
    html, body {
        height: 100%;
        margin: 0;
        font-family: 'Segoe UI', Roboto, 'Helvetica Neue', Arial;
        background: linear-gradient(rgba(10,40,80,0.75), rgba(0,0,0,0.75)),
                    url('assets/bg-bank.jpg') no-repeat center center fixed;
        background-size: cover;
    }

    /* Fully centered layout */
   .login-container {
    display: flex;
    flex-direction: column;
    justify-content: flex-start; /* 👈 start from top instead of full center */
    align-items: center;
    height: 100vh;
    width: 100%;
    color: #fff;
    padding-top: 100px; /* 👈 ensures full logo visibility */
    padding-left: 20px;
    padding-right: 20px;
    box-sizing: border-box;
    text-align: center;
    overflow-y: auto; /* in case of smaller screens */
}


   .bank-brand {
    margin-bottom: 40px;
    text-align: center;
}

.bank-logo {
    width: 160px; /* Slightly larger for better visibility */
    height: auto; /* Keeps proper aspect ratio */
    object-fit: contain;
    margin-bottom: 20px;
    display: block;
    margin-left: auto;
    margin-right: auto;
    animation: fadeIn 1.5s ease-in-out; /* Optional: smooth fade-in effect */
}

/* Optional smooth logo animation */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-15px); }
    to { opacity: 1; transform: translateY(0); }
}

    .brand-title { font-size: 28px; font-weight: 700; margin-bottom: 5px; }
    .brand-sub { font-size: 16px; color: #dbe2ec; margin-bottom: 30px; }

    form {
        width: 100%;
        max-width: 400px;
        background: rgba(255, 255, 255, 0.1);
        padding: 30px 25px;
        border-radius: 10px;
        box-shadow: 0 0 20px rgba(255,255,255,0.15);
    }

    label { color: #dbe2ec; font-weight: 500; display: block; text-align: left; }
    .form-control {
        background: rgba(255,255,255,0.2);
        border: none;
        color: #fff;
        border-radius: 5px;
        height: 45px;
        margin-bottom: 15px;
    }
    .form-control:focus {
        background: rgba(255,255,255,0.3);
        box-shadow: 0 0 8px #2196F3;
    }

    .btn-login {
        width: 100%;
        height: 45px;
        background: linear-gradient(45deg, #1a73e8, #004aad);
        border: none;
        color: #fff;
        font-weight: 600;
        border-radius: 5px;
        transition: 0.3s;
        margin-top: 10px;
    }
    .btn-login:hover {
        background: linear-gradient(45deg, #004aad, #002f6c);
        box-shadow: 0 0 12px rgba(33,150,243,0.6);
    }

    .help-row {
        margin-top: 10px;
        font-size: 13px;
        display: flex;
        justify-content: space-between;
    }
    .help-row a {
        color: #90caf9;
        text-decoration: none;
    }
    .help-row a:hover { text-decoration: underline; }

    .login-footer {
        margin-top: 25px;
        font-size: 13px;
        color: #cfd8dc;
    }

    /* Dropdown styling */
    select.form-control {
        color: #fff;
        background: rgba(255,255,255,0.2);
    }
    select.form-control option {
        color: #000;
        background-color: #fff;
    }
</style>
</head>
<body>
<div class="login-container">
    <div class="bank-brand">
        <img src="img/logo/logo.gif" alt="Bank Logo" class="bank-logo">
        <div class="brand-title">MERCHANTS LIBERAL CO-OP BANK LTD, GADAG</div>
        <div class="brand-sub">Core Banking System - Secure Access</div>
    </div>

    <form action="login.jsp" method="post" autocomplete="off">
        <label for="branch">Branch Code</label>
        <select id="branch" name="branch" class="form-control" required>
            <option value="">-- Select Branch --</option>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet branchRS = null;
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    String dbURL = "jdbc:oracle:thin:@203.129.218.98:1521:mlcb";
                    String dbUser = "system";
                    String dbPass = "info123";
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
                    stmt = conn.createStatement();
                    branchRS = stmt.executeQuery("SELECT BRANCH_CODE, NAME FROM HEADOFFICE.BRANCH ORDER BY BRANCH_CODE");
                    while(branchRS.next()) {
                        String bCode = branchRS.getString("BRANCH_CODE");
                        String bName = branchRS.getString("NAME");
            %>
                        <option value="<%=bCode%>"><%=bCode%> - <%=bName%></option>
            <%
                    }
                } catch(Exception ex) {
                    out.println("<option>Error loading branches</option>");
                } finally {
                    if(branchRS!=null) try{branchRS.close();}catch(Exception e){}
                    if(stmt!=null) try{stmt.close();}catch(Exception e){}
                    if(conn!=null) try{conn.close();}catch(Exception e){}
                }
            %>
        </select>

        <label for="username">User ID</label>
        <input id="username" name="username" class="form-control" placeholder="Enter your user ID" required>

        <label for="password">Password</label>
        <div class="input-group">
            <input id="password" name="password" type="password" class="form-control" placeholder="Password" required>
            <span class="input-group-btn">
                <button class="btn btn-default" type="button" id="togglePwd">Show</button>
            </span>
        </div>

        <div class="help-row">
            <span>Last login: <em>--</em></span>
            <a href="#" onclick="alert('Contact admin to reset password');return false;">Forgot password?</a>
        </div>

        <button type="submit" class="btn btn-login">Sign In</button>
    </form>

    <div class="login-footer">
        Authorized access only. All activities are monitored.
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>
(function(){
    var btn = document.getElementById('togglePwd');
    var pwd = document.getElementById('password');
    btn.addEventListener('click', function(){
        if(pwd.type === 'password'){ pwd.type='text'; btn.textContent='Hide'; }
        else { pwd.type='password'; btn.textContent='Show'; }
    });
})();
</script>
</body>
</html>
<% } %>