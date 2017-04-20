<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>登入</title>
<link rel="stylesheet" href="css/style.css">
<script src="bower_components/jquery/jquery.min.js"></script>
<script type="text/javascript">
function doFind(){
	$.ajax({
	cache: false,
	type: "POST",
	url:"jsp/login.jsp", //把表单数据发送到ajax.jsp
	data:$('#loginmessage').serialize(), //要发送的是ajaxFrm表单中的数据
	async: false,
	error: function(request) {
	alert("发送请求失败！");
	},
	success: function(data) {
	if(data=="sucess"){
		location.replace("homepage.jsp");
	}else if(data=="failed"){
		location.reload();
	}
	
	}
	});
	}
</script>
</head>

<body>
<body>
	<form id="loginmessage">
		<div class="login">
			<div class="login-screen">
				<div class="app-title">
					<h1>Login</h1>
				</div>

				<div class="login-form">
					<div class="control-group">
						<input type="text" class="login-field" value=""
							placeholder="username" name="useraccount" id="login-name">
						<label class="login-field-icon fui-user" for="login-name"></label>
					</div>

					<div class="control-group">
						<input type="password" class="login-field" value=""
							placeholder="password" name="password" id="login-pass"> <label
							class="login-field-icon fui-lock" for="login-pass"></label>
					</div>

					<input class="btn btn-primary btn-large btn-block" type="button"
						value="login"  onClick="doFind()"/> <input class="login-link" type="reset"
						value="reset" />
				</div>
			</div>
		</div>
	</form>
</body>


</body>
</html>
