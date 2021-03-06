<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">

<title>捷力安全阀首页</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">
<meta name="author" content="Muhammad Usman">

<!-- The styles -->
<link id="bs-css" href="css/bootstrap-cerulean.min.css" rel="stylesheet">


<link href="css/charisma-app.css" rel="stylesheet">
<link href='bower_components/fullcalendar/dist/fullcalendar.css'
	rel='stylesheet'>
<link href='bower_components/fullcalendar/dist/fullcalendar.print.css'
	rel='stylesheet' media='print'>
<link href='bower_components/chosen/chosen.min.css' rel='stylesheet'>
<link href='bower_components/colorbox/example3/colorbox.css'
	rel='stylesheet'>
<link href='bower_components/responsive-tables/responsive-tables.css'
	rel='stylesheet'>
<link
	href='bower_components/bootstrap-tour/build/css/bootstrap-tour.min.css'
	rel='stylesheet'>
<link href='css/jquery.noty.css' rel='stylesheet'>
<link href='css/noty_theme_default.css' rel='stylesheet'>
<link href='css/elfinder.min.css' rel='stylesheet'>
<link href='css/elfinder.theme.css' rel='stylesheet'>
<link href='css/jquery.iphone.toggle.css' rel='stylesheet'>
<link href='css/uploadify.css' rel='stylesheet'>
<link href='css/animate.min.css' rel='stylesheet'>
<link href='css/ex.css' rel='stylesheet'>

<!-- jQuery -->
<script src="bower_components/jquery/jquery.min.js"></script>
<link rel="shortcut icon" href="img/favicon.ico">
<script type="text/javascript">
function doFind(){
	var checkArray = document.getElementById("checkisgroup");
	if(checkArray.checked){
		flag="yes";
	}else{
		flag="no";
	}
	//alert(flag);
	$.ajax({
	cache: false,
	type: "POST",
	url:"jsp/groupaddinfo.jsp?option=addinformation&&flag="+flag, //把表单数据发送到ajax.jsp
	data:$('#addinformation').serialize(), //要发送的是ajaxFrm表单中的数据
	async: false,
	error: function(request) {
	alert("发送请求失败！");
	},
	success: function(data) {
	//将返回的结果显示到ajaxDiv中
	if(data=="插入失败"){
		alert(data);//将返回的结果显示到ajaxDiv中
	}else{
		var name=document.getElementById("factory").value;
		name=encodeURI(name);
		//alert(name);
		var a=data.split("&");
		var path=a[0];
		var acceptno=a[1];
		//alert(path);
		//alert(acceptno);
		location.replace("Groupaddinfo.jsp");
		window.open("/valmanage/CheckOrderPDF.html?name="+name+"&path="+path+"&acceptno="+acceptno,"","modal=yes,resizable=no,scrollbars=no");
		
	}
	}
	});
	}
function test(obj){
	 if(obj.checked){
	     $("#groupfield").show();
	     $("#groupnumlabel").show();
	     $("#groupnum").show();
	     $.ajax({
	    		cache: false,
	    		type: "POST",
	    		url:"jsp/groupaddinfo.jsp?option=groupnum", //把表单数据发送到ajax.jsp
	    		data:$('#addinformation').serialize(), //要发送的是ajaxFrm表单中的数据
	    		async: false,
	    		error: function(request) {
	    		alert("发送请求失败！");
	    		},
	    		success: function(data) {
	    			document.getElementById("groupnum").value=data; //将返回的结果显示到ajaxDiv中
	    		}
	    		});
	 }else{
	   $("#groupfield").hide();
	   $("#groupnumlabel").hide();
	   $("#groupnum").hide();
	}
}

function addvaltogroup(){
	$.ajax({
		cache: false,
		type: "POST",
		url:"jsp/groupaddinfo.jsp?option=valnum", //把表单数据发送到groupaddinfo.jsp
		data:$('#addinformation').serialize(), //要发送的是addinformation表单中的数据
		dataType:'text',
		timeout:3000,
		async: false,
		error: function(request) {
		alert("发送请求失败！");
		},
		success: function(data) {
			alert(data);
			showgroupval();
		}
	});
}
function showgroupval(){
	$.ajax({
		cache: false,
		type: "POST",
		url:"jsp/groupaddinfo.jsp?option=showgroupval", //把表单数据发送到ajax.jsp
		data:$('#addinformation').serialize(), //要发送的是ajaxFrm表单中的数据
		dataType:'json',
		timeout:3000,
		async: false,
		error: function(request) {
		alert("发送请求失败！");
		},
		success: function(data){
		var insert="<div class=\"control-group\"><label class=\"control-label\" for=\"selectError1\">已添加安全阀</label><div  class=\"controls\"><select id=\"showgroupval\" multiple class=\"form-control\" width=\"200px\" data-rel=\"chosen\">";
		
		for(var n=0;n<data.length;n++){
			insert+="<option selected>";
			insert+=data[n].valnumber;
			insert+="</option>";
		}
		insert+="</select></div></div>";
		document.getElementById("showgroup").innerHTML=insert;
		}
	});	
}

</script>
</head>

<body>
	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">

		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left animated flip">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.html"> <span
				class="hidden-xs">Fast Valve</span></a>

			<!-- user dropdown starts -->
			<div class="btn-group pull-right">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">
					<i class="glyphicon glyphicon-user"></i><span
						class="hidden-sm hidden-xs"><%String useraccount = (String)session.getAttribute("useraccount");%><%=useraccount %></span> <span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<li><a href="#">Profile</a></li>
					<li class="divider"></li>
					<li><a href="jsp/logout.jsp">Logout</a></li>
				</ul>
			</div>
			<!-- user dropdown ends -->

			<!-- theme selector starts -->
			<div class="btn-group pull-right theme-container animated tada">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">
					<i class="glyphicon glyphicon-tint"></i><span
						class="hidden-sm hidden-xs"> Change Theme / Skin</span> <span
						class="caret"></span>
				</button>
				<ul class="dropdown-menu" id="themes">
					<li><a data-value="classic" href="#"><i class="whitespace"></i>
							Classic</a></li>
					<li><a data-value="cerulean" href="#"><i
							class="whitespace"></i> Cerulean</a></li>
					<li><a data-value="cyborg" href="#"><i class="whitespace"></i>
							Cyborg</a></li>
					<li><a data-value="simplex" href="#"><i class="whitespace"></i>
							Simplex</a></li>
					<li><a data-value="darkly" href="#"><i class="whitespace"></i>
							Darkly</a></li>
					<li><a data-value="lumen" href="#"><i class="whitespace"></i>
							Lumen</a></li>
					<li><a data-value="slate" href="#"><i class="whitespace"></i>
							Slate</a></li>
					<li><a data-value="spacelab" href="#"><i
							class="whitespace"></i> Spacelab</a></li>
					<li><a data-value="united" href="#"><i class="whitespace"></i>
							United</a></li>
				</ul>
			</div>
			<!-- theme selector ends -->

			<ul class="collapse navbar-collapse nav navbar-nav top-menu">
				<li><a href="#"><i class="glyphicon glyphicon-globe"></i>
						Visit Site</a></li>
				<li class="dropdown"><a href="#" data-toggle="dropdown"><i
						class="glyphicon glyphicon-star"></i> Dropdown <span class="caret"></span></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">Action</a></li>
						<li><a href="#">Another action</a></li>
						<li><a href="#">Something else here</a></li>
						<li class="divider"></li>
						<li><a href="#">Separated link</a></li>
						<li class="divider"></li>
						<li><a href="#">One more separated link</a></li>
					</ul></li>
				<li>
					<form class="navbar-search pull-left">
						<input placeholder="Search"
							class="search-query form-control col-md-10" name="query"
							type="text">
					</form>
				</li>
			</ul>

		</div>
	</div>
	<!-- topbar ends -->
	<div class="ch-container">
		<div class="row">

			<!-- left menu starts -->
			<div class="col-sm-2 col-lg-2">
				<div class="sidebar-nav">
					<div class="nav-canvas">
						<div class="nav-sm nav nav-stacked"></div>
						<ul class="nav nav-pills nav-stacked main-menu">
							<li class="nav-header">菜单</li>
							<li><a class="ajax-link" href="homepage.jsp"><i
									class="glyphicon glyphicon-home"></i><span> 首页</span></a></li>
							<li><a class="ajax-link" href="Groupaddinfo.jsp"><i
									class="glyphicon glyphicon-eye-open"></i><span> 委托单信息录入</span></a></li>
							<li><a class="ajax-link" href="Nochecksave.jsp"><i
									class="glyphicon glyphicon-edit"></i><span> 开始存储</span></a></li>
							<li><a class="ajax-link" href="Showsaveactioninfo.jsp"><i
									class="glyphicon glyphicon-eye-open"></i><span> 查看存储信息</span></a></li>
							
						</ul>
						
					</div>
				</div>
			</div>
			<!--/span-->
			<!-- left menu ends -->

			<noscript>
				<div class="alert alert-block col-md-12">
					<h4 class="alert-heading">Warning!</h4>

					<p>
						You need to have <a href="http://en.wikipedia.org/wiki/JavaScript"
							target="_blank">JavaScript</a> enabled to use this site.
					</p>
				</div>
			</noscript>

			<div id="content" class="col-lg-10 col-sm-10">
				<!-- content starts -->
				<div>
					<ul class="breadcrumb">
						<li><a href="homepage.jsp">首页</a></li>
						<li><a href="Groupaddinfo.jsp">委托单信息录入</a></li>
					</ul>
				</div>

				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well">
								<h2>
									<i class="glyphicon glyphicon-info-sign"></i> 委托单信息填写
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-setting btn-round btn-default"><i
										class="glyphicon glyphicon-cog"></i></a>
									<a href="#"
										class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a> 
									<a href="#"
										class="btn btn-close btn-round btn-default"><i
										class="glyphicon glyphicon-remove"></i></a>
								</div>
							</div>
							<div class="box-content row">
								<div class="col-lg-12 col-md-12">			
									<form id="addinformation">
								
									<h2>
										<small class="space-left-2">= = = = = = = = = = 使用单位信息 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = </small>
										</h2>
											<div class="form-group space-left-4">
													<label for="factory">使用单位名称：</label> <input
														type="text" id="factory" name="factory" placeholder="" value="正兴工业有限公司">
													<label class="space-left-3" for="address">使用单位地址:</label> <input type="text"
														id="address" name="address" placeholder="" value="江苏无锡">	
													<label class="space-left-3" for="postcode">使用单位邮编：</label> <input
														type="text" id="postcode" name="postcode" placeholder="" value="214000">											
											</div>
											<div class="form-group space-left-4">
													<label for="contact">使用单位联系人：</label> <input type="text"
														id="contact" name="contact" placeholder="" value="钱伟">
													<label class="space-left-3" for="telephone">使用单位联系电话：</label> <input
														type="text" id="telephone" name="telephone" placeholder="" value="18861825613">	
																								
											</div>
									<h2>
										<small class="space-left-2">= = = = = = = = = = 安全阀信息 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = </small>
									</h2>
										<div class="box-content">
											<div class="form-group space-left-4">
											<input id="checkisgroup" type="checkbox" onchange="test(this)" value="yes" name="checkisgroup" /><label for="svalve">分组存储</label>
											<label id="groupnumlabel" class="space-left-12" for="groupnum">组号：</label><input type="text" id="groupnum" name="groupnum">
											
											<div id="groupfield">
											<div id="showgroup">
											<div class="control-group">	
												<label class="control-label" for="selectError1">已添加安全阀</label>
												
											</div>
											</div>
											<div id="groupbutton" class="space-left-15">
												<button type="button" class="btn btn-primary" onClick="addvaltogroup()">添加入组</button>
											</div>
											</div>
											</div>
								
															
												
												<div class="form-group space-left-4">
													<label for="productno">安全阀厂商ID：</label> <input type="text"
														id="productno" name="productno" placeholder="" value="SL13671246">
													<label class="space-left-3" for="manufacture">安全阀制造单位：</label> <input
														type="text" id="manufacture" name="manufacture"
														placeholder="" value="神乐有限公司">
													<label class="space-left-2" for="manucode">制造单位许可证编号:</label> <input type="text"
														id="manucode" name="manucode" placeholder="" value="XF8934 781">
													
												</div>
												<div class="form-group space-left-4">
													<label for="valvecate">安全阀型号：</label> <input type="text"
														id="valvecate" name="valvecate" placeholder="" value="A42Y-60">
													<label class="space-left-5" for="diapress">公称压力：</label> <input type="text"
														id="diapress" name="diapress" placeholder="" value="1.90">MPa
													<label class="space-left-4" for="requiredpress">要求整定压力:</label> <input
														type="text" id="requiredpress" name="requiredpress" placeholder="" value="1.83">MPa
												</div>
												<div class="form-group space-left-4">
													<label for="diameter">公称通径：</label> <input type="text"
														id="diameter" name="diameter" placeholder="" value="150">mm
													<label class="space-left-4" for="valdiameter">阀座口径:</label> <input type="text"
														id="valdiameter" name="valdiameter" placeholder="" value="130">mm
													<label class="space-left-6" for="pressgrade">压力级别范围:</label> <input type="text"
														id="pressgrade" name="pressgrade" placeholder="" value="1.0-1.3">
												</div>
												<div class="form-group space-left-4">
													<label for="revise">背压修正系数:</label> <input type="text"
														id="revise" name="revise" placeholder="" value="0.1">
													<label class="space-left-5" for="reseatpress">回座压力:</label> <input type="text"
														id="reseatpress" name="reseatpress" placeholder="" value="1.75">MPa
													<label class="space-left-8" for="media">工作介质：</label> <input type="text"
														id="media" name="media" placeholder="" value="蒸汽">
													
												</div>
												<div class="form-group space-left-4">
													<label for="designpress">设计压力:</label> <input type="text"
														id="designpress" name="designpress" placeholder="" value="2.0">MPa
													<label class="space-left-8" for="designtemper">设计温度:</label> <input type="text"
														id="designtemper" name="designtemper" placeholder="" value="300">度
													<label class="space-left-8" for="valvepno">阀门位号:</label> <input type="text"
														id="valvepno" name="valvepno" placeholder="" value="3">
												</div>
												<div class="form-group space-left-4">
												<label for="outputtime">出厂日期:</label> <input type="text"
														id="outputtime" name="outputtime" placeholder="" value="20151011">
													
												</div>
												<div class="form-group space-left-4">
													<div class="radio">
														<label for="inportvalve">是否进口阀:</label> <label
															class="radio-inline"> <input type="radio"
															name="inportvalve" value="yes"> YES
														</label> <label class="radio-inline"> <input type="radio"
															name="inportvalve" value="no"> NO
														</label>
													</div>
												</div>
												<div class="form-group space-left-4">
													<div class="radio">
														<label for="svalve">是否丝口阀:</label> <label
															class="radio-inline"> <input type="radio"
															name="svalve" value="yes"> YES
														</label> <label class="radio-inline"> <input type="radio"
															name="svalve" value="no"> NO
														</label>
													</div>
												</div>
										
											<h2>
										<small class="space-left-2">= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = </small>
										</h2>
											<div class="form-group space-left-4">
											
													<label class="space-left-3" for="requireddrawtime">要求取件日期：</label> <input
														type="date" id="requireddrawtime" name="requireddrawtime" placeholder="" value="2017-04-16">	
											</div>
									
										<button type="button" class="btn btn-primary btn-lg space-left-4" onClick="doFind();">
												提交信息</button>
									</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>	
	</div>
	<!--/.fluid-container-->

	<!-- external javascript -->

	<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

	<!-- library for cookie management -->
	<script src="js/jquery.cookie.js"></script>
	<!-- calender plugin -->
	<script src='bower_components/moment/min/moment.min.js'></script>
	<script src='bower_components/fullcalendar/dist/fullcalendar.min.js'></script>
	<!-- data table plugin -->
	<script src='js/jquery.dataTables.min.js'></script>

	<!-- select or dropdown enhancer -->
	<script src="bower_components/chosen/chosen.jquery.min.js"></script>
	<!-- plugin for gallery image view -->
	<script src="bower_components/colorbox/jquery.colorbox-min.js"></script>
	<!-- notification plugin -->
	<script src="js/jquery.noty.js"></script>
	<!-- library for making tables responsive -->
	<script src="bower_components/responsive-tables/responsive-tables.js"></script>
	<!-- tour plugin -->
	<script
		src="bower_components/bootstrap-tour/build/js/bootstrap-tour.min.js"></script>
	<!-- star rating plugin -->
	<script src="js/jquery.raty.min.js"></script>
	<!-- for iOS style toggle switch -->
	<script src="js/jquery.iphone.toggle.js"></script>
	<!-- autogrowing textarea plugin -->
	<script src="js/jquery.autogrow-textarea.js"></script>
	<!-- multiple file upload plugin -->
	<script src="js/jquery.uploadify-3.1.min.js"></script>
	<!-- history.js for cross-browser state change on ajax -->
	<script src="js/jquery.history.js"></script>
	<!-- application script for Charisma demo -->
	<script src="js/charisma.js"></script>


</body>
</html>
