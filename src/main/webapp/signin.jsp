<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bank CBS - Secure Sign In</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="css/LoginStyle.css">
</head>
<body>
<div class="login-container">
    <div class="bank-brand">
        <img src="idsspl_logo.gif" alt="Bank Logo" class="bank-logo">
        <div class="brand-title">MERCHANTS LIBERAL CO-OP BANK LTD, GADAG</div>
        <div class="brand-sub">Core Banking System - Secure Sign In</div>
    </div>

    <form action="SignInServlet" method="post" autocomplete="off">
        <label for="branch">Branch Code</label>
        <select id="branch" name="branch" class="form-control" required>
            <option value="">-- Select Branch --</option>
            <option value="101">101 - Main Branch</option>
            <option value="102">102 - Gadag</option>
            <option value="103">103 - Hubli</option>
        </select>

        <label for="username">User ID</label>
        <input type="text" id="username" name="username" class="form-control" required>

        <label for="password">Password</label>
        <input type="password" id="password" name="password" class="form-control" required>

        <button type="submit" class="btn-login">Sign In</button>

        <div class="help-row">
            <a href="#">Forgot Password?</a>
            <a href="login.jsp">Login ?</a>
        </div>
    </form>

    <div class="login-footer">
        © 2025 Merchants Liberal Co-Op Bank Ltd. All rights reserved.
    </div>
</div>
</body>
</html>
