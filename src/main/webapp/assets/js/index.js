const clearmsg = () =>{
	$("#errormsg").html("");
}

$("#loginfrm").submit((event)=>{
	event.preventDefault();
	var formData = $("#loginfrm").serialize();
    $.ajax({
		type: "POST",
        url: "./assets/ajax/indexajax.jsp",
        data: formData,
        success: function(res) {
            var response = JSON.parse(res);
            if(response.status =="success"){
				location.replace("dashboard.jsp");
			}else if(response.status == "checkpass"){
				$("#errormsg").html("Check Password");
			}else if(response.status == "notvalid"){
				$("#errormsg").html("Check Username & Password");
			}
        }
	})
})