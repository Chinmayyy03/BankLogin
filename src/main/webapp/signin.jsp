<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bank CBS - Secure Sign In</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to bottom, #071a3d, #0e295e);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            font-family: "Segoe UI", sans-serif;
            color: white;
        }

        .signin-box {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(12px);
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.6);
            width: 380px;
        }

        .signin-box h4 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .form-label {
            font-weight: 500;
            margin-bottom: 6px;
        }

        .form-control {
            background-color: rgba(255, 255, 255, 0.12);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
        }

        .form-control:focus {
            background-color: rgba(255, 255, 255, 0.18);
            color: white;
            border-color: #007bff;
            box-shadow: none;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        .btn-signin {
            background-color: #007bff;
            color: white;
            font-weight: bold;
            border-radius: 8px;
            transition: background 0.3s ease;
        }

        .btn-signin:hover {
            background-color: #0056b3;
        }

        .footer-links {
            display: flex;
            justify-content: space-between;
            font-size: 0.9em;
            margin-top: 15px;
        }

        .footer-links a {
            color: #9cc3ff;
            text-decoration: none;
        }

        .footer-links a:hover {
            text-decoration: underline;
        }

        .logo {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 25px;
        }

        .logo img {
            width: 150px;
        }

        .footer {
            margin-top: 30px;
            color: #b9c8e3;
            font-size: 0.85em;
        }

        select option {
            color: black;
        }
    </style>
</head>

<body>
    <div class="logo">
        <img src="idsspl_logo.gif" alt="Bank Logo">
        <h5 class="mt-3 fw-bold">MERCHANTS LIBERAL CO-OP BANK LTD, GADAG</h5>
        <p class="text-light opacity-75">Core Banking System – Secure Sign In</p>
    </div>

    <div class="signin-box">
        <h4>Sign In to Your Account</h4>
        <form action="SignInServlet" method="post">
            <div class="mb-3">
                <label for="branch" class="form-label">Branch Code</label>
                <select id="branch" name="branch" class="form-control" required>
                    <option value="">-- Select Branch --</option>
                    <option value="101">101 - Main Branch</option>
                    <option value="102">102 - Gadag</option>
                    <option value="103">103 - Hubli</option>
                </select>
            </div>

            <div class="mb-3">
                <label for="userid" class="form-label">User ID</label>
                <input type="text" id="userid" name="username" class="form-control" placeholder="Enter User ID" required>
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="Enter Password" required>
            </div>

            <button type="submit" class="btn btn-signin w-100">Sign In</button>

            <div class="footer-links">
                <a href="#">Forgot Password?</a>
                <a href="login.jsp">login ?</a>
            </div>
        </form>
    </div>

    <div class="footer text-center mt-4">
        © 2025 Merchants Liberal Co-Op Bank Ltd. All Rights Reserved.
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
