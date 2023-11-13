<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%
if(session.getAttribute("userid") != null){
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <jsp:include page="./requiredfiles/tags.jsp"></jsp:include>
    <style>
        .tab {
            font-size: 18px;
            margin-top: 15px;
            color: #86878C;
            cursor: pointer;
            padding: 10px 10px 10px 20px;
            font-weight: 400;
            transition: background-color 0.3s ease, border-radius 0.3s ease;
        }
        
        .tab:hover {
            background-color: #e2e3e6;
            border-radius: 5px;
        }
        
        .active {
            background-color: #9A5738 !important;
            border-radius: 5px;
            color: white;
            box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
        }
        
        .content {
        	padding-bottom: 40px;
            color: #86878C;
            overflow-y: scroll;
            height: 100vh;
            display: none;
        }
        
        .content-active {
            display: block;
        }
    </style>
</head>

<body>
    <div class="container-fluid">
        <div class="row" style="height: 100vh;">
            <div class="col-3" style="background-color: white;">
                <p align="center" style="padding-top: 20px;color: #4C312C;font-size: 18px;text-transform: uppercase;font-weight: 500;">Inventory Manager</p>
                <hr>
                <div class="tab active" data-tab="dashboard"><i class="fa-solid fa-dumpster-fire"></i>&nbsp;&nbsp;&nbsp;Dashboard</div>
                <div class="tab" data-tab="billing"><i class="fa-solid fa-file-invoice-dollar"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Billing</div>
                <div class="tab" data-tab="stock"><i class="fa-solid fa-cubes"></i>&nbsp;&nbsp;&nbsp;Stock</div>
                <div class="tab" data-tab="account"><i class="fa-solid fa-user"></i>&nbsp;&nbsp;&nbsp;&nbsp;Account</div>
                <div class="tab" onclick="logout()"><i class="fa-solid fa-arrow-right-from-bracket"></i>&nbsp;&nbsp;&nbsp;&nbsp;Logout</div>
            </div>
            <div class="col-9" style="background-color: #F5F3ED;box-shadow: rgba(50, 50, 93, 0.25) 0px 0px 60px 0px inset, rgba(0, 0, 0, 0.3) 0px 0px 0px 0px inset;">
                <div class="row content dashboard content-active">
                    <div class="col-12">
                        <div class="row mt-3">
                            <div class="col-6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dashboard</div>
                            <div align="end" class="col-6">
                                <% out.print(session.getAttribute("name")); %>&nbsp;&nbsp;
                                <i class="fa-solid fa-user"></i> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </div>
                        </div>
                        <div class="row mt-5">
                            <div class="col-1"></div>
                            <div class="col-10" style="display: flex;flex-direction: row;gap: 50px;">
                                <div style="width: 150px;height: 150px;background-color: white;border-radius: 5px;box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;">
                                    <div class="row">
                                        <div class="col-12">
                                            <div style="width: 50px;height: 50px;background-color: #ee921e;margin-left: 20px;display: flex;align-items: center;justify-content: center;color: white;font-size: 20px;margin-top: -10px;border-radius: 5px;">
                                                <i class="fa-solid fa-layer-group"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div align="center" class="col-12" style="padding: 20px;font-size: 20px;font-weight: 700;" id="stocktotal"></div>
                                    <div align="center" class="col-12" style="font-size: 18px;font-weight: 400;">Available Stock</div>
                                </div>
                                <div style="width: 150px;height: 150px;background-color: white;border-radius: 5px;box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;">
                                    <div class="row">
                                        <div class="col-12">
                                            <div style="width: 50px;height: 50px;background-color: #66bb6a;margin-left: 20px;display: flex;align-items: center;justify-content: center;color: white;font-size: 20px;margin-top: -10px;border-radius: 5px;">
                                                <i class="fa-solid fa-house"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div align="center" class="col-12" style="padding: 20px;font-size: 20px;font-weight: 700;" id="ammounttotal"></div>
                                    <div align="center" class="col-12" style="font-size: 18px;font-weight: 400;">Total Revenue</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row content billing">
                    <div class="col-12">
                        <div class="row mt-3">
                            <div class="col-6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Billing</div>
                            <div align="end" class="col-6">
                                <% out.print(session.getAttribute("name")); %>&nbsp;&nbsp;
                                <i class="fa-solid fa-user"></i> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </div>
                        </div>
                        <div class="row mt-4">
                            <div class="col-1"></div>
                            <div class="col-10">
                                <div class="row">
                                    <div class="col-12">
                                        <button class="btn" style="background-color: #66bb6a;color:white" data-bs-toggle="modal" data-bs-target="#addbill"><i class="fa-solid fa-plus"></i>&nbsp;&nbsp;New Bill</button>
                                    </div>
                                </div>
                                <div class="modal fade" id="addbill" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="addbilllabel" aria-hidden="true">
                                    <div class="modal-dialog modal-xl">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="addbilllabel">Generate New Bill&nbsp;&nbsp;<i class="fa-solid fa-file-circle-plus"></i></h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="loadnewbill()"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div align="center" style="font-size: 20px;font-weight:700">Total Selected Product:
                                                    <span id="totalvaluebill" value="0">0</span>
                                                </div>
                                                <br>
                                                <div id="newbillvalue">
                                                <!-- <table style="width: 100%;" class="myTable table-bodered">
                                                    <thead>
                                                        <tr style="font-weight: 700;">
                                                            <td>Product ID</td>
                                                            <td>Product Name</td>
                                                            <td>Product Cost</td>
                                                            <td>Available Count</td>
                                                            <td>Quantity</td>
                                                            <td>Select Order</td>
                                                        </tr>
                                                    </thead>
                                                    <tbody align="center">
                                                    
                                                       <tr>
                                                        
                                                            <td>3434</td>
                                                            <td>Milk</td>
                                                            <td>₹ 30</td>
                                                            <td align="center">20
                                                                <p style="color: #66bb6a;">(Available)</p>
                                                            </td>
                                                            <td align="center"><input id="3434quantity" class="form-control" style="width: 30%;" type="number" min="1" value="1"></td>
                                                            <td id="3434order"><button value="3434" class="btn addbill" style="background-color: #66bb6a;color:white;width:90%"><i class="fa-solid fa-cart-plus"></i>&nbsp;&nbsp;&nbsp;Add</button></td>
                                                        </tr>
                                                        <tr>
                                                        
                                                            <td>8345</td>
                                                            <td>Egg</td>
                                                            <td>₹ 5</td>
                                                            <td align="center">20
                                                                <p style="color: #66bb6a;">(Available)</p>
                                                            </td>
                                                            <td align="center"><input id="8345quantity" class="form-control" style="width: 30%;" type="number" min="1" value="1"></td>
                                                            <td id="8345order"><button value="8345" class="btn addbill" style="background-color: #66bb6a;color:white;width:90%"><i class="fa-solid fa-cart-plus"></i>&nbsp;&nbsp;&nbsp;Add</button></td>
                                                        </tr>
                                                    </tbody>
                                                </table> -->
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="loadnewbill()">Close</button>
                                                <button type="button" class="btn" style="color: white;background-color: #ee921e;" id="billsave" onclick="generatenewbill()">Save</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row mt-5">
                                    <div class="col-12">
                                        <h4>Bill Details</h4>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-12" style="background-color: white;padding:30px;border-radius: 5px;box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;" id="billtable">
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row content stock">
                    <div class="col-12">
                        <div class="row mt-3">
                            <div class="col-6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Stock</div>
                            <div align="end" class="col-6">
                                <% out.print(session.getAttribute("name")); %>&nbsp;&nbsp;
                                <i class="fa-solid fa-user"></i> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </div>
                        </div>
                        <div class="row mt-4">
                            <div class="col-1"></div>
                            <div class="col-10">
                                <div class="row">
                                    <div class="col-12">
                                        <button class="btn" style="background-color: #66bb6a;color:white" data-bs-toggle="modal" data-bs-target="#addproduct"><i class="fa-solid fa-plus"></i>&nbsp;&nbsp;Add New Product</button>
                                    </div>
                                </div>
                                <form id="newproductfrm">
                                <div class="modal fade" id="addproduct" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="addproductlabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="addproductlabel">Create New Product&nbsp;&nbsp;<i class="fa-solid fa-file-circle-plus"></i></h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <div class="col-1"></div>
                                                    <div class="col-10">
                                                        <div class="row">
                                                            <div class="col-12">
                                                                <label style="color: #4C312C;font-size: 18px;font-weight: 700;" for="productname">Product Name</label>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-2">
                                                            <div class="col-12">
                                                                <input class="form-control" placeholder="Enter the Product Name" id="productname" name="productname" type="text" required>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-4 ">
                                                            <div class="col-12 ">
                                                                <label style="color: #4C312C;font-size: 18px;font-weight: 700; " for="productcount">Product Cost</label>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-2 ">
                                                            <div class="col-12 ">
                                                                <input class="form-control " placeholder="Enter the Product cost" id="productcount" name="productcount" type="number" required>
                                                            </div>
                                                        </div>
                                                         <div class="row mt-4 ">
                                                            <div class="col-12 ">
                                                                <label style="color: #4C312C;font-size: 18px;font-weight: 700; " for="stockcount ">Product Stock Available</label>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-2 ">
                                                            <div class="col-12 ">
                                                                <input class="form-control " placeholder="Enter the Stock Count" id="stockcount" name="stockcount" type="number" required>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                <button type="submit" class="btn" style="color: white;background-color: #ee921e;"><i class="fa-solid fa-plus"></i>&nbsp;&nbsp;&nbsp;Add</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </form>
                                <div class="row mt-5">
                                    <div class="col-12">
                                        <h4>Product Details</h4>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-12" style="background-color: white;padding:30px;border-radius: 5px;box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;" id="stocktable">
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row content account">
                    <div class="col-12">
                        <div class="row mt-3">
                            <div class="col-6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Account</div>
                            <div align="end" class="col-6">
                                <% out.print(session.getAttribute("name")); %>&nbsp;&nbsp;
                                <i class="fa-solid fa-user"></i> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </div>
                        </div>
                        <div class="row mt-4">
                            <div class="col-1"></div>
                            <div class="col-10">
                                <div class="row mt-5">
                                    <div class="col-12" align="center">
                                        <h4>Account Details</h4>
                                    </div>
                                </div>
                                <form id="accountfrm">
                                <div class="row mt-2">
                                    <div class="col-3"></div>
                                    <div class="col-6" style="background-color: white;padding:30px;border-radius: 5px;box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;">
                                        <div class="row">
                                            <div class="col-12">
                                                <label style="color: #4C312C;font-size: 18px;font-weight: 700;" for="username">Name</label>
                                            </div>
                                        </div>
                                        <div class="row mt-2">
                                            <div class="col-12">
                                                <input class="form-control" value="<% out.print(session.getAttribute("name")); %>" id="username" name="name" type="text">
                                            </div>
                                        </div>
                                        <div class="row mt-4">
                                            <div class="col-12">
                                                <label style="color: #4C312C;font-size: 18px;font-weight: 700;" for="username">Username</label>
                                            </div>
                                        </div>
                                        <div class="row mt-2">
                                            <div class="col-12">
                                                <input class="form-control" value="<% out.print(session.getAttribute("username")); %>" id="accountusername" type="text" readonly>
                                            </div>
                                        </div>
                                        <div class="row mt-4 ">
                                            <div class="col-12 ">
                                                <label style="color: #4C312C;font-size: 18px;font-weight: 700; " for="password ">Password</label>
                                            </div>
                                        </div>
                                        <div class="row mt-2 mb-4">
                                            <div class="col-12 ">
                                                <input class="form-control " value="<% out.print(session.getAttribute("password")); %>" id="password" name="password" type="password">
                                                <input type="hidden" value="<% out.print(session.getAttribute("password")); %>" id="defaultpass">
                                            </div>
                                        </div>
                                        <div class="row mt-4 ">
                                            <div class="col-12 ">
                                                <button class="btn" type="submit" style="width:100%;background-color: #66bb6a;color:white;font-size: 18px;font-weight: 700;">
                                                    Update
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
<script>
    const logout = () => {
        location.replace("logout.jsp");
    }

    let table = new DataTable('.myTable');
    
    

    $('.tab').on('click', function() {
        $('.tab').removeClass('active');
        $(this).addClass('active');
        var tabName = $(this).data('tab');
        $('.content').removeClass('content-active');
        $('.' + tabName).addClass('content-active')
    });


    let billarray = [];
    
    

    $(document).on("click", ".addbill", function() {
        var id = $(this).val();
        $("#" + id + "order").html('<button value="' + id + '" class="btn removebill" style="background-color: #f55a4e;color:white;width:90%"><i class="fa-solid fa-trash"></i></i>&nbsp;&nbsp;&nbsp;Remove</button>');
        var totalcount = ($("#totalvaluebill").val());
        totalcount++;
        $("#totalvaluebill").val(totalcount);
        $("#totalvaluebill").html(totalcount);
        billarray.push(
           id
        )
    });
    
    $(document).on("click", ".removebill", function() {
    	 var id = $(this).val();
    	 $("#" + id + "order").html('<button value="' + id + '" class="btn addbill" style="background-color: #66bb6a;color:white;width:90%"><i class="fa-solid fa-cart-plus"></i></i>&nbsp;&nbsp;&nbsp;Add</button>');
    	 var totalcount = ($("#totalvaluebill").val());
         totalcount--;
         $("#totalvaluebill").val(totalcount);
         $("#totalvaluebill").html(totalcount);
    	 var index = billarray.indexOf(id);
  	     if (index !== -1) {
  	        billarray.splice(index, 1);
   	     }
    });
    
</script>
<script src="./assets/js/dashboard.js"></script>
</html>

<%
}else{
%>

<html>
<head>
<title>Try Again</title>
   <jsp:include page="./requiredfiles/tags.jsp"></jsp:include>
</head>
<body>
  <div class="mt-5 pt-5" align="center">
    <h1>Login Again</h1>
    <br>
    <a href="index.jsp"><button class="btn btn-outline-success">GO BACK</button></a>
  </div>
</body>
</html>

<%
}%>