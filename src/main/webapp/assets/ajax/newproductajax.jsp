<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../requiredfiles/connection.jsp" %>
<%
String productname = request.getParameter("productname");
String productcount = request.getParameter("productcount");
String stockcount = request.getParameter("stockcount");
String outputString = "";
String addproductsql = "INSERT INTO product_table (product_name, product_cost, product_quantity) VALUES (?, ?, ?)";
PreparedStatement addproductres = con.prepareStatement(addproductsql);
addproductres.setString(1, productname);
addproductres.setString(2, productcount);
addproductres.setString(3, stockcount);
int rowsAffected = addproductres.executeUpdate();

if (rowsAffected > 0) {
	outputString = "{\"status\": \"success\"}";
	out.print(outputString);
}else{
	outputString = "{\"status\": \"failed\"}";
	out.print(outputString);
}

%>