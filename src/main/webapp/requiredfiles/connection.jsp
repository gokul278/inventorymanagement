<%@ page import="java.sql.*" %>
<%
Class.forName("com.mysql.cj.jdbc.Driver"); 
Connection con = DriverManager.getConnection("jdbc:mysql://localhost/inventorymanager", "root", "");
%>