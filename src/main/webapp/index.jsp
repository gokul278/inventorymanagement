<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="icon" type="image/x-icon" href="">
<jsp:include page="./requiredfiles/tags.jsp"></jsp:include>
<style>
.form__group {
  position: relative;
  padding: 15px 0 0;
  margin-top: 10px;
  width: 100%;
}

.form__field {
  font-family: inherit;
  width: 100%;
  border: 0;
  border-bottom: 2px solid #F5F3ED;
  outline: 0;
  font-size: 18px;
  color: #F5F3ED;
  padding: 9px 0;
  background: transparent;
  transition: border-color 0.2s;
}
.form__field::placeholder {
  color: transparent;
}
.form__field:placeholder-shown ~ .form__label {
  font-size: 18px;
  cursor: text;
  top: 20px;
}

.form__label {
  position: absolute;
  top: 0;
  display: block;
  transition: 0.2s;
  font-size: 18px;
  color: #9A5738;
}

.form__field:focus {
  padding-bottom: 6px;
  font-weight: 700;
  border-width: 3px;
  border-image: #F5F3ED;
  border-image-slice: 1;
}
.form__field:focus ~ .form__label {
  position: absolute;
  top: 0;
  display: block;
  transition: 0.2s;
  font-size: 1rem;
  color: #9A5738;
  font-weight: 700;
}

/* reset input */
.form__field:required, .form__field:invalid {
  box-shadow: none;
}
</style>
</head>
<body style="background-color:#4C312C">
	<div class="container-fluid">
		<div class="row" style="display:flex;height:100vh;justify-content: center; align-items: center;width:100%">
			<div class="col-lg-4 col-md-3 col-sm-1 col-1"></div>
			<div class="col-lg-4 col-md-6 col-sm-10 col-10">
				 <div class="row">
				 	<div class="col-12" style="background-color:#C4965B;border-radius:5px;box-shadow: rgba(0, 0, 0, 0.25) 0px 54px 55px, rgba(0, 0, 0, 0.12) 0px -12px 30px, rgba(0, 0, 0, 0.12) 0px 4px 6px, rgba(0, 0, 0, 0.17) 0px 12px 13px, rgba(0, 0, 0, 0.09) 0px -3px 5px;">
				 		<div class="row mt-4" align="center">
				 			<div class="col-12" style="font-size:25px;color:#F5F3ED;font-weight:700">
				 				<i class="fa-solid fa-user"></i>&nbsp;&nbsp;Login
				 			</div>
				 		</div>
				 		<form id="loginfrm">
					 		<div class="row mt-3">
						 		<div class="col-1"></div>
						 		<div class="col-10">
						 			<div class="form__group field">
									  <input type="text" class="form__field" placeholder="Username" name="username" id='username' onclick="clearmsg()" required />
									  <label for="name" class="form__label">Username</label>
									</div>
						 		</div>
					 		</div>
					 		<div class="row mt-1">
						 		<div class="col-1"></div>
						 		<div class="col-10">
						 			<div class="form__group field">
									  <input type="password" class="form__field" placeholder="Password" name="password" id='password'  onclick="clearmsg()" required />
									  <label for="password" class="form__label">Password</label>
									</div>
						 		</div>
					 		</div>
					 		<br>
					 		<div class="row " align="center">
					 			<div class="col-12">
					 				<p id="errormsg" style="color:white"></p>
					 			</div>
					 		</div>
					 		<br>
					 		<div class="row mb-4" align="center">
					 			<div class="col-12">
					 				<button type="submit" class="btn" style="width:50%;background-color:#F5F3ED;color:#86878C;font-size:18px;font-weight:700">Login</button>
					 			</div>
					 		</div>
				 		</form>
				 	</div>
				 </div>
			</div>
			<div class="col-lg-4 col-md-3 col-sm-1 col-1"></div>
		</div>
	</div>
</body>
<script src="./assets/js/index.js"></script>
</html>