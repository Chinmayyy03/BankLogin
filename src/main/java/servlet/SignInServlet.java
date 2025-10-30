package servlet;

import db.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class SignInServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String branchCode = request.getParameter("branch_code");
        String branchName = request.getParameter("branch_name");
        String userId = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();

            // ✅ Step 1: Check if branch already exists
            String checkBranchSQL = "SELECT NAME FROM BRANCHES WHERE BRANCH_CODE = ?";
            pstmt = conn.prepareStatement(checkBranchSQL);
            pstmt.setString(1, branchCode);
            rs = pstmt.executeQuery();

            boolean branchExists = rs.next();
            rs.close();
            pstmt.close();

            // ✅ Step 2: If branch does not exist, create it
            if (!branchExists) {
                String insertBranchSQL = "INSERT INTO BRANCHES (BRANCH_CODE, NAME) VALUES (?, ?)";
                pstmt = conn.prepareStatement(insertBranchSQL);
                pstmt.setString(1, branchCode);
                pstmt.setString(2, branchName);
                pstmt.executeUpdate();
                pstmt.close();
            }

            // ✅ Step 3: Check if user already exists
            String userCheckSQL = "SELECT USER_ID FROM BRANCH_LOGIN WHERE USER_ID = ?";
            pstmt = conn.prepareStatement(userCheckSQL);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                out.println("<script>alert('User ID already exists! Please choose another.');window.location='signin.jsp';</script>");
                return;
            }
            rs.close();
            pstmt.close();

            // ✅ Step 4: Check password match
            if (!password.equals(confirmPassword)) {
                out.println("<script>alert('Passwords do not match! Please try again.');window.location='signin.jsp';</script>");
                return;
            }

            // ✅ Step 5: Insert new user
            String insertUserSQL = "INSERT INTO BRANCH_LOGIN (BRANCH_CODE, USER_ID, PASSWORD) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(insertUserSQL);
            pstmt.setString(1, branchCode);
            pstmt.setString(2, userId);
            pstmt.setString(3, password);

            int rows = pstmt.executeUpdate();

            if (rows > 0) {
                out.println("<script>alert('Registration successful! You can now log in.');window.location='login.jsp';</script>");
            } else {
                out.println("<script>alert('Registration failed. Please try again.');window.location='signin.jsp';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error: " + e.getMessage() + "');window.location='signin.jsp';</script>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
