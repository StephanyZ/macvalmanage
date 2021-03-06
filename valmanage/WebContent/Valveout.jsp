<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<title>Free HTML5 Bootstrap Admin Template</title>
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

<!-- jQuery -->
<script src="bower_components/jquery/jquery.min.js"></script>

<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<!-- The fav icon -->
<link rel="shortcut icon" href="img/favicon.ico">
<script type="text/javascript">
$(document).ready(function show(){
	var tbody=window.document.getElementById("oneinput");
	$.ajax({
		cache: false,
		type: "POST",
		url:"jsp/getlocationsavedinfo.jsp",//把表单数据发送到ajax.jsp
		dataType:'json',
		timeout:3000,
		async: false,
		error: function(request) {
			alert("获取数据请求失败！");
		},
		success: function(data) {
			//alert(data);
			var i=0;
			var insert="";
			for(var n=0;n<data.length;n++){
				insert+="<tr>";
				insert+="<td calss=\"center\">";
				insert+=data[n].valnumber;
				insert+="</td>";
				insert+="<td calss=\"center\">";
				insert+=data[n].acceptno;
				insert+="</td>";
				insert+="<td calss=\"center\">";
				insert+=data[n].storagelocationnum;
				if(data[n].exlocationnum!=null){
					insert+="&"+data[n].exlocationnum;
				}
				insert+="</td>";	
				insert+="<td calss=\"center\">";
				insert+=data[n].optime;
				insert+="</td>";		
				if(data[n].opaction=='S'){
				insert+="<td class=\"center\"><span class=\"label-success label label-default\">存入</span></td>";
				}
				if(data[n].opaction=='T'){
				insert+="<td class=\"center\"><span class=\"label-danger label label-default\">取出</span></td>";
				}
				if(data[n].opaction=='X'){
					insert+="<td class=\"center\"><span class=\"label-info label label-default\">修改</span></td>";
				}
				insert+="<td calss=\"center\">";
				if(data[n].valstatus=="N"){
					insert+="未检在库";
				}else if(data[n].valstatus=="Y"){
					insert+="已检在库";
				}else if(data[n].valstatus=="C"){
					insert+="备检出库";
				}else if(data[n].valstatus=="O"){
					insert+="检毕出库";
				}
				insert+="</td>";
				insert+="<td class=\"center\"><a class=\"btn btn-danger\" onclick=\"deleteRow(this)\"> <i"
				+"class=\"glyphicon glyphicon-trash icon-white\"></i> 出库</a> <a1 class=\"btn btn-success\" onclick=\"showval(this)\"> <i"
				+"class=\"glyphicon glyphicon-trash icon-white\"></i> 浏览"
				+"</a1></td>";
				insert+="</tr>";
				//alert(insert);
				
				}	
			tbody.innerHTML =insert;
		}
		});
	//setInterval('show()', 5000);
});
function showval(r){
	var rows=r.parentNode.parentNode.rowIndex;
	var valorgroupnumber=document.getElementById('table').rows[rows].cells[0].innerText;
	var tbody=window.document.getElementById("valinput");
	$.ajax({
		cache: false,
		type: "POST",
		url:"jsp/getlocationsavedinfosingle.jsp?valorgroupnumber="+valorgroupnumber,//把表单数据发送到ajax.jsp
		dataType:'json',
		timeout:3000,
		async: false,
		error: function(request) {
			alert("获取数据请求失败！");
		},
		success: function(data) {
			//alert(data);
			var i=0;
			var insert="";
			for(var n=0;n<data.length;n++){
				insert+="<tr>";
				insert+="<td calss=\"center\">";
				insert+="<input type=\"checkbox\" value=\""+data[n].valnumber+"\" name=\"checkisqualify\"/>"
				insert+="</td>";
				insert+="<td calss=\"center\">";
				insert+=data[n].valnumber;
				insert+="</td>";
				insert+="<td calss=\"center\">";
				insert+=data[n].acceptno;
				insert+="</td>";
				insert+="<td calss=\"center\">";
				insert+=data[n].storagelocationnum;
				if(data[n].exlocationnum!=null){
					insert+="&"+data[n].exlocationnum;
				}
				insert+="</td>";			
				
				if(data[n].isqualify=='yes'){
					insert+="<td class=\"center\"><span class=\"label-success label label-default\">合格</span></td>";
				}else if(data[n].isqualify=='no'){
					insert+="<td class=\"center\"><span class=\"label-danger label label-default\">不合格</span></td>";
				}else{
					insert+="<td class=\"center\"><span class=\"label-info label label-default\">未检</span></td>";
				}
				insert+="<td class=\"center\"><a class=\"btn btn-danger\" onclick=\"deletechecked(this)\"> <i"
				+"class=\"glyphicon glyphicon-trash icon-white\"></i> 出库"
				+"</a></td>";
				insert+="</tr>";
				//alert(insert);
				
				}	
			tbody.innerHTML =insert;
		}
		});
	//setInterval('show()', 5000);
}
function deletechecked(r){
	var checked = []; 
	var checkedcount=0;
	$('input:checkbox:checked').each(function() {
    	checkedcount++;
    	checked.push($(this).val());
    	});
	var str=prompt("对接出库员工ID：","请核实后输入，如:lzhang");
	$.ajax({
		cache: false,
		type: "POST",
		url:"jsp/valveoutsingle.jsp?manindex="+str+"&&option=pc", 
		traditional :true,
		data:{"checkedid":checked}, 
		async: false,
		error: function(request) {
		alert("发送请求失败！");
		},
		success: function(data) {
			alert(data);
			location.replace("Valveout.jsp");
		}
	});
}
function deleteRow(r){
	 var rows=r.parentNode.parentNode.rowIndex;
	 var valorgroupnumber=document.getElementById('table').rows[rows].cells[0].innerText;
	 var status=document.getElementById('table').rows[rows].cells[5].innerText;	 
	 if(status=="未检在库"){
		 status="N";
	 }else if(status=="已检在库"){
		 status="Y";
	 }
	// alert(status); 
	 var str=prompt("对接出库员工ID：","请核实后输入，如:lzhang");
	 if(str==null){
		 
	 }else{
	 $.ajax({
			cache: false,
			type: "POST",
			url:"jsp/valveout.jsp?opnumber="+valorgroupnumber+"&&manindex="+str+"&&status="+status+"&&option=pc", 
			data:$('#addinformation').serialize(), 
			async: false,
			error: function(request) {
			alert("发送请求失败！");
			},
			success: function(data) {
			alert(data); 
			location.replace("Valveout.jsp");
			}
			});
	 }
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
			<a class="navbar-brand" href="index.html"> <img
				alt="Charisma Logo" src="img/logo20.png" class="hidden-xs" /> <span>Fast Valve</span></a>

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
						<li><a href="Valveout.jsp">出库</a></li>
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
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-user"></i>表单安全阀存储信息
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
							<div class="box-content">
								<table id="table"
									class="table table-striped table-bordered bootstrap-datatable datatable responsive">
									<thead>
										<tr>
											<th>安全阀编号</th>
											<th>委托单号</th>
											<th>存储位置</th>
											<th>操作时间</th>
											<th>存入／取出</th>
											<th>状态</th>
											<th>更多</th>
										</tr>
									</thead>
									<tbody id="oneinput">
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!--/span-->

				</div>
				
				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-user"></i>单个安全阀出库信息
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
							<div class="box-content">
								<table id="valtable"
									class="table table-striped table-bordered bootstrap-datatable datatable responsive">
									<thead>
										<tr>
											<th>check</th>
											<th>安全阀编号</th>
											<th>委托单号</th>
											<th>存储位置</th>
											<th>合格状态</th>
											<th>更多</th>
										</tr>
									</thead>
									<tbody id="valinput">
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!--/span-->

				</div>
				<!--/row-->
		

	</div>
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
