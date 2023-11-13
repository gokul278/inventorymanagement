<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../requiredfiles/connection.jsp" %>
<%
String way = request.getParameter("way");
if(way.equals("removestock")){
	String outputString = "";
	String removeID = request.getParameter("id");
	String removesql = "DELETE FROM product_table WHERE product_id =(?)";
	PreparedStatement removeres = con.prepareStatement(removesql);
	removeres.setString(1, removeID);
	int rowsAffected = removeres.executeUpdate();
	if (rowsAffected > 0) {
		outputString = "{\"status\": \"success\"}";
		out.print(outputString);	
	}else{
		outputString = "{\"status\": \"failed\"}";
		out.print(outputString);
	}
}else if(way.equals("updatestock")){
	String outputString = "";
	String updateID = request.getParameter("id");
	String productname = request.getParameter("productname");
	String productcost = request.getParameter("productcost");
	String stockcount = request.getParameter("stockcount");
	String updatesql = "UPDATE product_table SET product_name=(?),product_cost=(?),product_quantity=(?) WHERE product_id=(?)";
	PreparedStatement updateres = con.prepareStatement(updatesql);
	updateres.setString(1, productname);
	updateres.setString(2, productcost);
	updateres.setString(3, stockcount);
	updateres.setString(4, updateID);
	int rowsAffected = updateres.executeUpdate();
	if (rowsAffected > 0) {
		outputString = "{\"status\": \"success\"}";
		out.print(outputString);	
	}else{
		outputString = "{\"status\": \"failed\"}";
		out.print(outputString);
	}
}
%>