<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../../requiredfiles/connection.jsp" %>
<%  
String username = request.getParameter("username");
String password = request.getParameter("password");
String outputString = "";
String checksql = "SELECT * FROM user_table WHERE username=?";
PreparedStatement checkres = con.prepareStatement(checksql);
checkres.setString(1, username);

// Execute the query using executeQuery() for SELECT statements
ResultSet checkresultset = checkres.executeQuery();

if (checkresultset.next()) {
    if (checkresultset.getString("password").equals(password)) {
    	session.setAttribute("userid",checkresultset.getString("user_id"));  
    	session.setAttribute("name",checkresultset.getString("name"));  
    	session.setAttribute("username",username);  
    	session.setAttribute("password",password); 
    	outputString = "{\"status\": \"success\"}";
   	 	out.print(outputString);
    } else {
        outputString = "{\"status\": \"checkpass\"}";
   	 	out.print(outputString);
    }
} else {
    outputString = "{\"status\": \"notvalid\"}";
	out.print(outputString);
}


%>
