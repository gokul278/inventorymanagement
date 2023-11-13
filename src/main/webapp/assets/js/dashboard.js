$(document).ready(()=>{
	dashboardvalue();
	stockvalue();
	billvalue();
	newbillvalue();
})

const dashboardvalue = () =>{
	$.ajax({
		type: "POST",
        url: "./assets/ajax/dashboardajax.jsp",
        data: {"way":"dashboardvalue"},
        success: function(res) {
            var response = JSON.parse(res);
            $("#stocktotal").html(response.stock);
            $("#ammounttotal").html("₹ "+response.totalamount);
        }
	})
}

const stockvalue = () => {
  $.ajax({
    type: "POST",
    url: "./assets/ajax/dashboardajax.jsp",
    data: { "way": "stockvalue" },
    success: function (res) {
      var response = JSON.parse(res);
      $("#stocktable").html(response.content);
      let table = new DataTable('.myTable');
    }
  });
}

const billvalue = () =>{
	$.ajax({
    type: "POST",
    url: "./assets/ajax/dashboardajax.jsp",
    data: { "way": "billvalue" },
    success: function (res) {
      var response = JSON.parse(res);
      $("#billtable").html(response.content);
      let table = new DataTable('.myTable');
    }
  });
}

const newbillvalue = () =>{
	$.ajax({
    type: "POST",
    url: "./assets/ajax/dashboardajax.jsp",
    data: { "way": "newbillvalue" },
    success: function (res) {
      var response = JSON.parse(res);
      $("#newbillvalue").html(response.content);
      let table = new DataTable('.myTable');
    }
  });
}

const loadnewbill = () =>{
	console.log("Hello")
	newbillvalue();
	 totalcount = 0;
     $("#totalvaluebill").val(totalcount);
     $("#totalvaluebill").html(totalcount);
     billarray = [];
     console.log(billarray);
}

$("#newproductfrm").submit((event) => {
  event.preventDefault();
  var formData = $("#newproductfrm").serialize();
  $.ajax({
    type: "POST",
    url: "./assets/ajax/newproductajax.jsp",
    data: formData,
    success: function (res) {
		var response = JSON.parse(res);
		if(response.status == "success"){
			$("#addproduct").modal("hide");
			$("#productname").val("");
			$("#productcount").val("");
			$("#stockcount").val("");
			new Notify({
                        status: 'success',
                        title: 'Success !',
                        text: 'Successfully Added',
                        effect: 'slide',
                        speed: 300,
                        customClass: '',
                        customIcon: '',
                        showIcon: true,
                        showCloseButton: true,
                        autoclose: true,
                        autotimeout: 3000,
                        gap: 20,
                        distance: 20,
                        type: 1,
                        position: 'right top',
                        customWrapper: '',
                    })
			dashboardvalue();
			stockvalue();
			billvalue();
			newbillvalue();
		}
    }
  });
});


$("#accountfrm").submit((event) => {
  event.preventDefault();
     var formData = $("#accountfrm").serialize();
	  $.ajax({
	    type: "POST",
	    url: "./assets/ajax/changeaccountajax.jsp",
	    data: formData,
	    success: function (res) {
			var response = JSON.parse(res);
			if(response.status == "success"){
				location.reload();
			}
	    }
	  });
});

const removestock = (button) =>{
	var id = $(button).val();
	 $.ajax({
	    type: "POST",
	    url: "./assets/ajax/managestockajax.jsp",
	    data: {"way":"removestock","id":id},
	    success: function (res) {
			var response = JSON.parse(res)
			if(response.status == "success"){
				dashboardvalue();
				stockvalue();
				billvalue();
				newbillvalue();
			}
	    }
	  });
}

const updatestock = (button) =>{
	var id = $(button).val();
	var productname = $("#productname"+id).val();
	var productcost = $("#productcost"+id).val();
	var stockcount = $("#stockcount"+id).val();
	 $.ajax({
	    type: "POST",
	    url: "./assets/ajax/managestockajax.jsp",
	    data: {"way":"updatestock","id":id,"productname":productname,"productcost":productcost,"stockcount":stockcount},
	    success: function (res) {
			var response = JSON.parse(res)
			if(response.status == "success"){
				$("#stockedit"+id).modal("hide");
				dashboardvalue();
				stockvalue();
				billvalue();
				newbillvalue();
			}
	    }
	  });
}

const generatenewbill = () =>{
	$("#billsave").html("Loading");
	if(billarray.length > 0){
		let billsetarray = [];
		billarray.forEach((billvalue)=>{
			var product_id = billvalue;
			var product_quantity = $("#"+billvalue+"quantity").val();
			billsetarray.push({
				"product_id":product_id,
				"product_quantity":product_quantity
			})
		})
		$.ajax({
	    type: "POST",
	    url: "./assets/ajax/newbillajax.jsp",
	    data: {"billsetarray":JSON.stringify(billsetarray)},
	    success: function (res) {
   			if (res.status == "success") {
				billarray= [];
				$("#addbill").modal("hide");
				$("#billsave").html("Save");
				new Notify({
                        status: 'success',
                        title: 'Success !',
                        text: 'Successfully Generated',
                        effect: 'slide',
                        speed: 300,
                        customClass: '',
                        customIcon: '',
                        showIcon: true,
                        showCloseButton: true,
                        autoclose: true,
                        autotimeout: 3000,
                        gap: 20,
                        distance: 20,
                        type: 1,
                        position: 'right top',
                        customWrapper: '',
                    })
				dashboardvalue();
				stockvalue();
				billvalue();
				newbillvalue();
			}
	    }
	  });
	}else{
		new Notify({
            status: 'error',
            title: 'Warning !',
            text: 'Please Add Atleast one Product',
            effect: 'slide',
            speed: 300,
            customClass: '',
            customIcon: '',
            showIcon: true,
            showCloseButton: true,
            autoclose: true,
            autotimeout: 3000,
            gap: 20,
            distance: 20,
            type: 1,
            position: 'right top',
            customWrapper: '',
        })
	}
	
}


const newprint = (button) => {
    var billid = button.value;
    var billdate = button.dataset.billdate;
    window.open("./assets/ajax/printbillajax.jsp?billid=" + billid+"&billdate="+billdate, "_blank");
}