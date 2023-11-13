<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../requiredfiles/connection.jsp" %>
<%@ page import="org.json.simple.*,
                org.json.simple.parser.*,
                java.util.Date,
                java.text.SimpleDateFormat" %>
<%
String outputString = "";

try {
	int bill_identity = 0;
	String billsql = "SELECT MAX(bill_identity) AS bill_identity FROM bill_table";
	PreparedStatement billres = con.prepareStatement(billsql);
	ResultSet billresultset = billres.executeQuery();

	if (billresultset.next()) {
	    bill_identity = billresultset.getInt("bill_identity");
	    if (bill_identity == 0) {
	        bill_identity = 8000;
	    } else {
	        bill_identity++;
	    }
	}


    Date today = new Date();

    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
    String todaydate = dateFormat.format(today);

    String jsonString = request.getParameter("billsetarray");
    JSONParser parser = new JSONParser();
    JSONArray billsetarray = (JSONArray) parser.parse(jsonString);
    String insertsql = "INSERT INTO bill_table (bill_identity, bill_date, product_id, bill_quantity) VALUES (?, ?, ?, ?)";
    PreparedStatement insertres = con.prepareStatement(insertsql);
    for (Object obj : billsetarray) {
        JSONObject billItem = (JSONObject) obj;
        String product_id = (String) billItem.get("product_id");
        String product_quantity = (String) billItem.get("product_quantity");
        String decreasesql = "UPDATE product_table SET product_quantity = product_quantity - (?) WHERE product_id = (?)";
        PreparedStatement decreaseres = con.prepareStatement(decreasesql);
        decreaseres.setString(1, product_quantity);
        decreaseres.setString(2, product_id);
        decreaseres.executeUpdate();
        insertres.setString(1, Integer.toString(bill_identity));
        insertres.setString(2, todaydate);
        insertres.setString(3, product_id);
        insertres.setString(4, product_quantity);
        insertres.executeUpdate();
    }
    outputString = "{\"status\": \"success\"}";
	out.print(outputString);
} catch (Exception e) {
    e.printStackTrace(); // Print the stack trace for detailed error information
    outputString = "{\"status\": \"failed\", \"error\": \"" + e.getMessage() + "\"}";
    out.print(outputString);
}

%>
