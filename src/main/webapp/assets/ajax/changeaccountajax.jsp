<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../requiredfiles/connection.jsp" %>
<%
String name = request.getParameter("name");
String password = request.getParameter("password");
String outputString = "";
String passsql = "UPDATE user_table SET password=(?),name=(?)";
PreparedStatement passres = con.prepareStatement(passsql);
passres.setString(1, password);
passres.setString(2, name);
int rowsAffected = passres.executeUpdate();
if (rowsAffected > 0) {
	session.setAttribute("password",password); 
	session.setAttribute("name",name);
	outputString = "{\"status\": \"success\"}";
	out.print(outputString);	
}else{
	outputString = "{\"status\": \"failed\"}";
	out.print(outputString);
}

%>