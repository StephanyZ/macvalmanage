<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page
	import="java.sql.*,java.sql.Connection,java.sql.Statement,java.util.Formatter,javax.servlet.http.HttpServlet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<title>安全阀存储</title>
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

<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<!-- The fav icon -->
<link rel="shortcut icon" href="img/favicon.ico">
<script type="text/javascript">
function doFind(){
	$.ajax({
	cache: false,
	type: "POST",
	url:"jsp/checkedsave.jsp", //把表单数据发送到ajax.jsp
	data:$('#checkedsave').serialize(), //要发送的是ajaxFrm表单中的数据
	async: false,
	error: function(request) {
	alert("发送请求失败！");
	},
	success: function(data) {
	alert(data); //将返回的结果显示到ajaxDiv中
	}
	});
	}
function showmessage(){
	//var valorgroupnum=document.getElementById("valorgroupnum").value;
	$.ajax({
		cache: false,
		type: "POST",
		url:"jsp/show.jsp?option=checkvalorgroup", //把表单数据发送到ajax.jsp
		data:$('#checkedsave').serialize(), //要发送的是ajaxFrm表单中的数据
		async: false,
		error: function(request) {
		alert("发送请求失败！");
		},
		success: function(data) {
			data+="<button type=\"button\" class=\"btn btn-primary btn-sm space-left-4\" onClick=\"addcheckgroup()\">确认</button>";
			document.getElementById("showmessage").innerHTML=data; //将返回的结果显示到ajaxDiv中
		}
		});
	$.ajax({
		cache: false,
		type: "POST",
		url:"jsp/show.jsp?option=getvolume", //把表单数据发送到ajax.jsp
		data:$('#checkedsave').serialize(), //要发送的是ajaxFrm表单中的数据
		async: false,
		error: function(request) {
		alert("发送请求失败！");
		},
		success: function(data) {
			if(data=="S"){
				$("input[name='valvolume'][value='S']").attr("checked",true);
			}else if(data=="L"){
				$("input[name='valvolume'][value='L']").attr("checked",true);
			}
			//document.getElementById("showmessage").innerHTML=data; //将返回的结果显示到ajaxDiv中
		}
		});
	
}
function addcheckgroup(){
	var flag = 1;  
	var checked = [];  
    flag = 0;  
    var valorgroupnumber=document.getElementById("valorgroupnumber").value;
    var volume=$('input:radio:checked').val();
    var checkedcount=0;
    $('input:checkbox:checked').each(function() {
    	checkedcount++;
    	checked.push($(this).val());  
    	});
    $.ajax({
		cache: false,
		type: "POST",
		url:"jsp/show.jsp?option=getcheckedgroup&&valorgroupnumber="+valorgroupnumber+"&&volume="+volume, //把表单数据发送到ajax.jsp
		traditional :true,
		data:{"checkedid":checked}, //要发送的是ajaxFrm表单中的数据
		dataType:'json',
		async: false,
		error: function(request) {
		alert("发送请求失败！");
		},
		success: function(data) {
			document.getElementById("location").value=null;
			document.getElementById("exlocation").value=null;
			var fdStart = valorgroupnumber.indexOf("g");
			if(fdStart == 0){
				if(data.qlocation==""){
					document.getElementById("location").value=data.ulocation;
				}else if(data.ulocation==""){
					document.getElementById("location").value=data.qlocation;
				}else{
					document.getElementById("location").value=data.qlocation;
					document.getElementById("exlocation").value=data.ulocation;
				}
			}else if(fdStart == -1){
				if(checkedcount!=0){
					document.getElementById("location").value=data.qlocation;
				}else if(checkedcount==0){
					document.getElementById("location").value=data.ulocation;
				}
			}
			 //将返回的结果显示到ajaxDiv中
		}
		});
    /*$(checked).each(function(index){
        alert(this);
    });*/
    
    } 

</script>
</head>

<script type="text/javascript">
function testhaha(){
	document.getElementById("storagelocationnum").value="test";
}
function nochecklocation(){
	var xmlhttp;
	var volume;
	var vol=document.getElementsByName("valvolume");
	if(!(vol[0].checked||vol[1].checked)){
		alert("请选择安全阀体积！");
		return 0;
	}
	else if(vol[0].checked){
		volume=vol[0].value;
	}
	else if(vol[1].checked){
		volume=vol[1].value;
	}
	//alert(volume);
	if(window.XMLHttpRequest)
		xmlhttp=new XMLHttpRequest();
	else
		xmlhttp=new ActiveXObjice("Microsoft.XMLHTTP");
	xmlhttp.onreadystatechange=function(){
		if(xmlhttp.readyState==4&&xmlhttp.status==200){
			
			document.getElementById("storagelocationnum").value=xmlhttp.responseText;
			//alert(xmlhttp.responseText);
		}
	}
	xmlhttp.open("GET","jsp/getlocation.jsp?volume="+encodeURIComponent(volume),true);
    xmlhttp.send(null);
    }

	
</script>

<body>
<jsp:useBean id="connect" class="com.xfzhang.bean.connection"></jsp:useBean>
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
						class="hidden-sm hidden-xs"> <%String useraccount = (String)session.getAttribute("useraccount");%><%=useraccount %></span> <span class="caret"></span>
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
						<li><a href="Nochecksave.jsp">未检存储</a></li>
					</ul>
				</div>
				<div class=" row">
					<div class="col-md-3 col-sm-3 col-xs-6">
						<a data-toggle="tooltip" title="6 new members."
							class="well top-block" href="Opconfirm.jsp"> <i
							class="glyphicon glyphicon-envelope red"></i> <span>移动操作确认</span>
						</a>
					</div>

					<div class="col-md-3 col-sm-3 col-xs-6">
						<a data-toggle="tooltip" title="4 new pro members."
							class="well top-block" href="Nochecksave.jsp"> <i
							class="glyphicon glyphicon-star green"></i> <span>未检入库</span>
						</a>
					</div>
					<div class="col-md-3 col-sm-3 col-xs-6">
						<a data-toggle="tooltip" title="$34 new sales."
							class="well top-block" href="Ischeckedsave.jsp"> <i
							class="glyphicon glyphicon-shopping-cart yellow"></i> <span>已检入库</span>
						</a>
					</div>

					<div class="col-md-3 col-sm-3 col-xs-6">
						<a data-toggle="tooltip" title="12 new messages."
							class="well top-block" href="Valveout.jsp"> <i
							class="glyphicon glyphicon-user blue"></i> <span>出库</span>
						</a>
					</div>
				</div>
				<div class="row">
					<div class="box col-md-8">
						<div class="box-inner">
							<div class="box-header well">
								<h2>
									<i class="glyphicon glyphicon-info-sign"></i>存储选择
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-setting btn-round btn-default"><i
										class="glyphicon glyphicon-cog"></i></a> <a href="#"
										class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
										class="btn btn-close btn-round btn-default"><i
										class="glyphicon glyphicon-remove"></i></a>
								</div>
							</div>
							<div class="box-content row">
								<div class="col-lg-12 col-md-12">
									<h2>存储信息输入</h2>
									<div class="alert alert-info">
									请确保您现在已为操作员登入状态
									</div>
									<form id="checkedsave">
										<div class="box-content">
											<div class="form-group space-left-2">
												<label for="valorgroupnumber">安全阀或分组编号ID：</label> <input type="text"
													id="valorgroupnumber" name="valorgroupnumber" placeholder="valorgroupnumber" list="idlist" onBlur="showmessage()">
													<% 
													String sql="select * from checkedwillbesaved";
														ResultSet rs=null;
														rs=connect.query(sql);
													%>
													<datalist id="idlist">
													<%while(rs.next()){ %>
													<option value="<%=rs.getString("acceptno")%>"></option>
													<%}%>
													</datalist>
												<label class="space-left-2" for="manindex">交接工人ID：</label> <input type="text"
													id="factoryindex" name="manindex" placeholder="" list="workerlist"> 
													<% 
													String sql1="select * from workman";
														ResultSet rs1=null;
														rs1=connect.query(sql1);
													%>
													<datalist id="workerlist">
													<%while(rs1.next()){ %>
													<option value="<%=rs1.getString("manindex")%>"></option>
													<%}%>
													</datalist>
											</div>
											<div class="form-group space-left-2">
												<label for="media">安全阀体积：</label> <label
													class="radio-inline"> <input type="radio"
													 id="small" value="S" name="valvolume">Small
												</label> <label class="radio-inline"> <input type="radio"
													 id ="large" value="L"  name="valvolume">Large
												</label>
												</div>

											<div class="form-group space-left-2">
												<label for="location">存储位置:</label> <input
													type="text" id="location" name="location" placeholder="">
												<label class="space-left-2" for="exlocation">备选存储位置:</label> <input
													type="text" id="exlocation" name="exlocation" placeholder="">
												
											</div>

											<button type="button"
												class="btn btn-primary btn-lg space-left-4" onClick="doFind();">提交信息</button>
										</div>

									</form>
								</div>
							</div>
						</div>
					</div>
				
				<div class="box col-md-4">
					<div class="box-inner homepage-box">
						<div class="box-header well">
							<h2>
								<i class="glyphicon glyphicon-th"></i> 安全阀合格确认
							</h2>

							<div class="box-icon">
								<a href="#" class="btn btn-setting btn-round btn-default"><i
									class="glyphicon glyphicon-cog"></i></a> <a href="#"
									class="btn btn-minimize btn-round btn-default"><i
									class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
									class="btn btn-close btn-round btn-default"><i
									class="glyphicon glyphicon-remove"></i></a>
							</div>
						</div>
						<div id="showmessage" class="box-content">
						
						</div>
						
						</div>
					</div>
				</div>
			</div>
		</div>
	</div><!-- end row -->

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
