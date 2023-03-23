<%-- 
    Document   : newjsp
    Created on : 23 Mar, 2023, 8:08:33 PM
    Author     : VISHNU KUMAR M.J
--%>
<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer Details</title>
    </head>
    <body>
        
        <%
// Step 1: Set up JDBC connectivity
String url = "jdbc:derby://localhost:1527/Bank";
Connection conn = DriverManager.getConnection(url);
int account=Integer.parseInt(request.getParameter("acc_no"));
String query = "SELECT * FROM transaction_details WHERE acc_no= " + account+"";
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(query);


// Step 3: Calculate current balance, total credits, and total debits
double currentBalance = 0;
double totalCredits = 0;
double totalDebits = 0;
int cusid=0;
String name="";
while (rs.next()) {
    double amount =(double) rs.getInt(3);
    String transactionType = rs.getString(4);
    cusid=rs.getInt(5);
    name=rs.getString(2);
    if (transactionType.equals("credit")) {
        totalCredits += amount;
        currentBalance += amount;
    } else {
        totalDebits += amount;
        currentBalance -= amount;
    }
}

// Step 4: Display output
out.println("<html>");
out.println("<body>");
out.println("<h1>Transaction Details</h1>");

out.println("<p>Customer ID:" + cusid +" </p>");
out.println("<p>Customer Name: " + name + "</p>");

out.println("<p>Current Balance: " + currentBalance + "</p>");
out.println("<p>Total Credits: " + totalCredits + "</p>");
out.println("<p>Total Debits: " + totalDebits + "</p>");
out.println("</body>");
out.println("</html>");

// Step 5: Close database connection
conn.close();
%>

    </body>
</html>
