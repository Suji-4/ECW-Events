<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Event Registration Processing</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    String name = request.getParameter("name");
    String college = request.getParameter("college");
    String department = request.getParameter("department");
    String year = request.getParameter("year");
    String eventName = request.getParameter("event");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");

    String jdbcURL = "jdbc:mysql://localhost:3306/event_portal";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement stmt = null;
    boolean success = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        String sql = "INSERT INTO registrations (name, college, department, year, event, phone, email) VALUES (?, ?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, name);
        stmt.setString(2, college);
        stmt.setString(3, department);
        stmt.setString(4, year);
        stmt.setString(5, eventName);
        stmt.setString(6, phone);
        stmt.setString(7, email);

        int result = stmt.executeUpdate();
        if (result > 0) {
            success = true;
        }
    } catch (Exception e) {
%>
        <script>
            alert("❌ Registration failed: <%= e.getMessage() %>");
            window.history.back(); // Go back to form
        </script>
<%
        e.printStackTrace();
    } finally {
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }

    if (success) {
%>
    <script>
        alert("✅ Registration successful!");
        window.location.href = "thankyou.html"; // Go back to home or form
    </script>
<%
    }
%>
</body>
</html>