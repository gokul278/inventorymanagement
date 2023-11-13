<%@ page language="java" contentType="application/pdf; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../requiredfiles/connection.jsp" %>
<%@ page import="com.itextpdf.text.Document"%>
<%@ page import="com.itextpdf.text.Paragraph"%>
<%@ page import="com.itextpdf.text.html.simpleparser.HTMLWorker"%>
<%@ page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@ page import="com.itextpdf.text.PageSize"%>
<%@ page import="java.io.StringReader"%>
<%@ page import="java.io.OutputStream"%>
<% 
String billid = request.getParameter("billid");
String billdate = request.getParameter("billdate");
response.setContentType("application/pdf");
response.setHeader("Content-Disposition", "inline; filename=Bill"+billid+".pdf");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

try {
	
	int height = 250;
    String htmlContent = "<h2 align='center' style='font-weight:900'>Bill Details</h2>";
    htmlContent += "<br>";
    htmlContent+="<table><tbody><tr><th align='start'>Bill ID : <b>"+billid+"</b></th><th></th><th align='center' >Date : <b>"+billdate+"</b></th></tr></tbody></table>";
    htmlContent += "<br>";
    htmlContent+="<table style='font-size:10px;' border='1'><thead><tr  align='center'><th><b>S.NO</b></th><th><b>Name</b></th><th><b>Price</b></th><th><b>Quantity</b></th><th><b>Total Price</b></th></tr></thead><tbody>";
    
    String billsql = "SELECT * FROM bill_table JOIN product_table ON bill_table.product_id = product_table.product_id WHERE bill_identity = (?)";
    PreparedStatement billres = con.prepareStatement(billsql);
    billres.setString(1, billid);
    ResultSet billresultset = billres.executeQuery();
    int sno = 0;
    double finval = 0;
    while(billresultset.next()){
    	height+=20;
    	sno++;
    	String name = billresultset.getString("product_name");
    	String price = billresultset.getString("product_cost");
    	String quantity = billresultset.getString("bill_quantity");
    	double totalPriceValue = Double.parseDouble(price) * Double.parseDouble(quantity);
    	finval+=totalPriceValue;
    	String totalPrice = String.valueOf(totalPriceValue);
    	htmlContent+="<tr align='center'><th>"+sno+"</th><th>"+name+"</th><th>Rs."+price+"</th><th>"+quantity+"</th><th>Rs."+totalPrice+"</th></tr>";
    }
    htmlContent+="</tbody></table>";
    htmlContent+="<br>";
    htmlContent+="<table><tbody><tr><th></th><th align='start' >Total Amount : <b>Rs."+finval+"</b></th></tr></tbody></table>";
    
    Document document = new Document();
    document.setPageSize(new com.itextpdf.text.Rectangle(400, height));
    PdfWriter.getInstance(document, response.getOutputStream());
    document.open();
    HTMLWorker htmlWorker = new HTMLWorker(document);
    
    htmlWorker.parse(new StringReader(htmlContent));

    document.close();
} catch (Exception e) {
    e.printStackTrace();
    out.print("Error");
}
%>
