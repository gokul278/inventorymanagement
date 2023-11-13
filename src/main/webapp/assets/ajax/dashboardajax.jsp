<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../requiredfiles/connection.jsp" %>
<%
String way = request.getParameter("way");

if(way.equals("dashboardvalue")){
	String outputString="";
	int totalstock = 0;
	int availablestock = 0;
	String stocksql = "SELECT * FROM product_table";
	PreparedStatement stockres = con.prepareStatement(stocksql);
	ResultSet stockresultset = stockres.executeQuery();
	while(stockresultset.next()){
		if(Integer.parseInt(stockresultset.getString("product_id"))>0){
			totalstock++;
			if(Integer.parseInt(stockresultset.getString("product_quantity"))>0){
				availablestock++;
			}
		}
	}
	
	String totalamount = "";
	String amountsql = "SELECT SUM(product_table.product_cost * bill_table.bill_quantity) AS total_cost FROM bill_table JOIN product_table ON bill_table.product_id = product_table.product_id";
	PreparedStatement amountres = con.prepareStatement(amountsql);
	ResultSet amountresultset = amountres.executeQuery();
	while(amountresultset.next()){
		totalamount=amountresultset.getString("total_cost");
	}
	if(totalamount == null){
		totalamount = "0";
	}
	outputString = "{\"stock\": \""+availablestock+"/"+totalstock+"\",\"totalamount\": \""+totalamount+"\"}";
	out.print(outputString);
}else if(way.equals("stockvalue")){
	String outputString = "";
	String content = "";
	String tablesql = "SELECT * FROM product_table";
	PreparedStatement tableres = con.prepareStatement(tablesql);
	ResultSet tableresultset = tableres.executeQuery();
	content+="<table style='width: 100%;' class='myTable table-bodered'>";
	content+="<thead><tr style='font-weight: 700;'>";
	content+="<td>Product ID</td>";
	content+="<td>Product Name</td>";
	content+="<td>Product Cost</td>";
	content+="<td>Stock Count</td>";
	content+="<td>Edit</td><td>Remove</td></tr></thead><tbody align='center'>";
	while(tableresultset.next()){
		content+="<tr> <td>"+tableresultset.getString("product_id")+"</td>";
		content+="<td>"+tableresultset.getString("product_name")+"</td>";
		content+="<td>₹ "+tableresultset.getString("product_cost")+"</td>";
		if(Integer.parseInt(tableresultset.getString("product_quantity")) > 0){
			content+="<td>"+tableresultset.getString("product_quantity")+" <p style='color: #66bb6a;'>(Available)</p></td>";
		}else{
			content+="<td>"+tableresultset.getString("product_quantity")+"  <p style='color: #f55a4e;'>(Out of Stock)</p></td>";
		}
		content+="<td><button class='btn' style='background-color: #70a967;color:white' data-bs-toggle='modal' data-bs-target='#stockedit"+tableresultset.getString("product_id")+"'><i class='fa-regular fa-pen-to-square'></i>&nbsp;&nbsp;&nbsp;Edit</button>";
		content+="<div class='modal fade' id='stockedit"+tableresultset.getString("product_id")+"' data-bs-backdrop='static' data-bs-keyboard='false' tabindex='-1' aria-labelledby='stockedit"+tableresultset.getString("product_id")+"label' aria-hidden='true'>";
		content+="<div class='modal-dialog'><div class='modal-content'><div class='modal-header'><h5 class='modal-title' id='addproductlabel'>Edit Product&nbsp;&nbsp;<i class='fa-solid fa-pen-to-square'></i></h5><button type='button' class='btn-close' data-bs-dismiss='modal' aria-label='Close'></button></div>";
		content+="<div class='modal-body'><div class='row'><div class='col-1'></div><div class='col-10'><div class='row'><div class='col-12' align='start'><label style='color: #4C312C;font-size: 18px;font-weight: 700;' for='productname'>Product Name</label></div></div<div class='row mt-2'><div class='col-12'>";
		content+="<input class='form-control' placeholder='Enter the Product Name' value='"+tableresultset.getString("product_name")+"' id='productname"+tableresultset.getString("product_id")+"' type='text' required>";
		content+="</div></div><div class='row mt-4 '><div class='col-12 ' align='start'><label style='color: #4C312C;font-size: 18px;font-weight: 700; ' for='productcount'>Product Cost</label></div></div><div class='row mt-2 '><div class='col-12 '>";
		content+="<input class='form-control ' placeholder='Enter the Product cost' value='"+tableresultset.getString("product_cost")+"' id='productcost"+tableresultset.getString("product_id")+"' type='number' required>";
		content+="</div></div><div class='row mt-4 '><div class='col-12 ' align='start'><label style='color: #4C312C;font-size: 18px;font-weight: 700; ' for='stockcount '>Product Stock Available</label></div></div><div class='row mt-2 '><div class='col-12 '>";
		content+="<input class='form-control ' placeholder='Enter the Stock Count' value='"+tableresultset.getString("product_quantity")+"' id='stockcount"+tableresultset.getString("product_id")+"' type='number' required>";
		content+="</div></div></div></div></div><div class='modal-footer'><button type='button' class='btn btn-secondary' data-bs-dismiss='modal'>Close</button><button type='button' class='btn' style='color: white;background-color: #ee921e;' onclick='updatestock(this)' value='"+tableresultset.getString("product_id")+"'>Update</button></div></div></div></div></td>";
		content+="<td><button class='btn' style='background-color: #f55a4e;color:white' value='"+tableresultset.getString("product_id")+"' onclick='removestock(this)'><i class='fa-solid fa-trash'></i></i>&nbsp;&nbsp;&nbsp;Remove</button></td></tr>";
		
	}
	content+="</tbody></table>";
	outputString = "{\"content\": \""+content+"\"}";
	out.print(outputString);
}else if(way.equals("billvalue")){
	String outputString = "";
	String content = "";
	String tablesql = "SELECT bill_table.bill_identity,bill_table.bill_date,SUM(product_table.product_cost * bill_table.bill_quantity) AS total_cost FROM bill_table JOIN product_table ON bill_table.product_id = product_table.product_id GROUP BY bill_table.bill_identity";
	PreparedStatement tableres = con.prepareStatement(tablesql);
	ResultSet tableresultset = tableres.executeQuery();
	content+="<table style='width: 100%;' class='myTable table-bodered'>";
	content+="<thead><tr style='font-weight: 700;'>";
	content+="<td>Bill No</td>";
	content+="<td>Bill Date</td>";
	content+="<td>Total Cost</td>";
	content+="<td>Print</td>";
	content+="</tr></thead><tbody align='center'>";
	while(tableresultset.next()){
		content+="<tr> <td>"+tableresultset.getString("bill_identity")+"</td>";
		content+="<td>"+tableresultset.getString("bill_date")+"</td>";
		content+="<td>₹ "+tableresultset.getString("total_cost")+"</td>";
		content+="<td><button class='btn' value='"+tableresultset.getString("bill_identity")+"' data-billdate='" + tableresultset.getString("bill_date") + "' onclick='newprint(this)' style='background-color: #9A5738;color:white'><i class='fa-solid fa-print'></i>&nbsp;&nbsp;&nbsp;Print</button></td></tr>";
	}
	content+="</tbody></table>";
	outputString = "{\"content\": \""+content+"\"}";
	out.print(outputString);
}else if(way.equals("newbillvalue")){
	String outputString = "";
	String content = "";
	String tablesql = "SELECT * FROM product_table";
	PreparedStatement tableres = con.prepareStatement(tablesql);
	ResultSet tableresultset = tableres.executeQuery();
	content+="<table style='width: 100%;' class='myTable table-bodered'>";
	content+="<thead><tr style='font-weight: 700;'>";
	content+="<td>Product ID</td>";
	content+="<td>Product Name</td>";
	content+="<td>Product Cost</td>";
	content+="<td>Available Stock</td>";
	content+="<td>Quantity</td>";
	content+="<td>Select Order</td>";
	content+="</tr></thead><tbody align='center'>";
	while(tableresultset.next()){
		content+="<tr> <td>"+tableresultset.getString("product_id")+"</td>";
		content+="<td>"+tableresultset.getString("product_name")+"</td>";
		content+="<td>₹ "+tableresultset.getString("product_cost")+"</td>";
		if(Integer.parseInt(tableresultset.getString("product_quantity")) > 0){
			content+="<td>"+tableresultset.getString("product_quantity")+" <p style='color: #66bb6a;'>(Available)</p></td>";
		}else{
			content+="<td>"+tableresultset.getString("product_quantity")+"  <p style='color: #f55a4e;'>(Out of Stock)</p></td>";
		}
		content+="<td><input id='"+tableresultset.getString("product_id")+"quantity' class='form-control' style='width: 30%;' type='number' min='1' value='1'></td>";
		if(Integer.parseInt(tableresultset.getString("product_quantity")) > 0){
			content+="<td id='"+tableresultset.getString("product_id")+"order'><button value='"+tableresultset.getString("product_id")+"' class='btn addbill' style='background-color: #66bb6a;color:white;width:90%'><i class='fa-solid fa-cart-plus'></i>&nbsp;&nbsp;&nbsp;Add</button></td>";
		}else{
			content+="<td id='"+tableresultset.getString("product_id")+"order'><button value='"+tableresultset.getString("product_id")+"' class='btn' style='background-color: #f55a4e;color:white;width:100%'><i class='fa-regular fa-circle-xmark'></i>&nbsp;&nbsp;&nbsp;Out of Stock</button></td>";
		}
	}
	content+="</tbody></table>";
	outputString = "{\"content\": \""+content+"\"}";
	out.print(outputString);
}
%>