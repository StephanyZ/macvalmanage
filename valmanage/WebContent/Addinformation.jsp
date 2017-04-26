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
	$.ajax({
	cache: false,
	type: "POST",
	url:"jsp/addinformation.jsp", //把表单数据发送到ajax.jsp
	data:$('#groupaddinfo').serialize(), //要发送的是ajaxFrm表单中的数据
	async: false,
	error: function(request) {
	alert("发送请求失败！");
	},
	success: function(data) {
		if(data=="插入失败"){
			alert(data);//将返回的结果显示到ajaxDiv中
		}else{
			var name=document.getElementById("factory").value;
			name=encodeURI(name);
			//alert(name);
			var a=data.split("&");
			var path=a[0];
			var acceptno=a[1];
			alert(path);
			alert(acceptno);
			window.open("/valmanage/CheckOrderPDF.html?name="+name+"&path="+path+"&acceptno="+acceptno,"","modal=yes,width=500,height=500,resizable=no,scrollbars=no");
		}
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
							<li><a class="ajax-link" href="Addinformation.jsp"><i
									class="glyphicon glyphicon-eye-open"></i><span> 委托单信息录入</span></a></li>
							<li><a class="ajax-link" href="Savevalve.jsp"><i
									class="glyphicon glyphicon-edit"></i><span> 开始存储</span></a></li>
							<li><a class="ajax-link" href="Showsaveactioninfo.jsp"><i
									class="glyphicon glyphicon-eye-open"></i><span> 查看存储信息</span></a></li>
							<li><a class="ajax-link" href="form.html"><i
									class="glyphicon glyphicon-edit"></i><span> Forms</span></a></li>
							<li><a class="ajax-link" href="chart.html"><i
									class="glyphicon glyphicon-list-alt"></i><span> Charts</span></a></li>
							<li><a class="ajax-link" href="typography.html"><i
									class="glyphicon glyphicon-font"></i><span> Typography</span></a></li>
							<li><a class="ajax-link" href="gallery.html"><i
									class="glyphicon glyphicon-picture"></i><span> Gallery</span></a></li>
							<li class="nav-header hidden-md">Sample Section</li>
							<li><a class="ajax-link" href="table.html"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Tables</span></a></li>
							<li class="accordion"><a href="#"><i
									class="glyphicon glyphicon-plus"></i><span> Accordion
										Menu</span></a>
								<ul class="nav nav-pills nav-stacked">
									<li><a href="#">Child Menu 1</a></li>
									<li><a href="#">Child Menu 2</a></li>
								</ul></li>
							<li><a class="ajax-link" href="calendar.html"><i
									class="glyphicon glyphicon-calendar"></i><span> Calendar</span></a>
							</li>
							<li><a class="ajax-link" href="grid.html"><i
									class="glyphicon glyphicon-th"></i><span> Grid</span></a></li>
							<li><a href="tour.html"><i
									class="glyphicon glyphicon-globe"></i><span> Tour</span></a></li>
							<li><a class="ajax-link" href="icon.html"><i
									class="glyphicon glyphicon-star"></i><span> Icons</span></a></li>
							<li><a href="error.html"><i
									class="glyphicon glyphicon-ban-circle"></i><span> Error
										Page</span></a></li>
							<li><a href="login.html"><i
									class="glyphicon glyphicon-lock"></i><span> Login Page</span></a></li>
						</ul>
						<label id="for-is-ajax" for="is-ajax"><input id="is-ajax"
							type="checkbox"> Ajax on menu</label>
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
						<li><a href="#">首页</a></li>
						<li><a href="#">委托单信息录入</a></li>
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
									<form id="groupaddinfo">
									<h2>
										<small class="space-left-2">= = = = = = = = = = 安全阀信息 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = </small>
									</h2>
										<div class="box-content">
												<div class="form-group space-left-4">
													<label for="productno">安全阀厂商ID：</label> <input type="text"
														id="productno" name="productno" placeholder="" value="TK2718934561">
													<label class="space-left-3" for="manufacture">安全阀制造单位：</label> <input
														type="text" id="manufacture" name="manufacture"
														placeholder="" value="苏安有限公司">
													<label class="space-left-2" for="manucode">制造单位许可证编号:</label> <input type="text"
														id="manucode" name="manucode" placeholder="" value="XF5671 672">
													
												</div>
												<div class="form-group space-left-4">
													<label for="valvecate">安全阀型号：</label> <input type="text"
														id="valvecate" name="valvecate" placeholder="" value="A42Y-40">
													<label class="space-left-5" for="diapress">公称压力：</label> <input type="text"
														id="diapress" name="diapress" placeholder="" value="2.0">MPa
													<label class="space-left-4" for="requiredpress">要求整定压力:</label> <input
														type="text" id="requiredpress" name="requiredpress" placeholder="" value="1.90">MPa
												</div>
												<div class="form-group space-left-4">
													<label for="diameter">公称通径：</label> <input type="text"
														id="diameter" name="diameter" placeholder="" value="80">mm
													<label class="space-left-4" for="valdiameter">阀座口径:</label> <input type="text"
														id="valdiameter" name="valdiameter" placeholder="" value="70">mm
													<label class="space-left-6" for="pressgrade">压力级别范围:</label> <input type="text"
														id="pressgrade" name="pressgrade" placeholder="" value="1.0-1.3">
												</div>
												<div class="form-group space-left-4">
													<label for="revise">背压修正系数:</label> <input type="text"
														id="revise" name="revise" placeholder="" value="0.1">
													<label class="space-left-5" for="reseatpress">回座压力:</label> <input type="text"
														id="reseatpress" name="reseatpress" placeholder="" value="1.80">MPa
													<label class="space-left-8" for="media">工作介质：</label> <input type="text"
														id="media" name="media" placeholder="" value="液氮">
													
												</div>
												<div class="form-group space-left-4">
													<label for="designpress">设计压力:</label> <input type="text"
														id="designpress" name="designpress" placeholder="" value="2.10">MPa
													<label class="space-left-8" for="designtemper">设计温度:</label> <input type="text"
														id="designtemper" name="designtemper" placeholder="" value="200">度
													<label class="space-left-8" for="valvepno">阀门位号:</label> <input type="text"
														id="valvepno" name="valvepno" placeholder="" value="2">
												</div>
												<div class="form-group space-left-4">
												<label for="outputtime">出厂日期:</label> <input type="text"
														id="outputtime" name="outputtime" placeholder="" value="20160911">
													
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
										<small class="space-left-2">= = = = = = = = = = 使用单位信息 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = </small>
										</h2>
											<div class="form-group space-left-4">
													<label for="factory">使用单位名称：</label> <input
														type="text" id="factory" name="factory" placeholder="" value="锡工业有限公司">
													<label class="space-left-3" for="address">使用单位地址:</label> <input type="text"
														id="address" name="address" placeholder="" value="江苏无锡">	
													<label class="space-left-3" for="postcode">使用单位邮编：</label> <input
														type="text" id="postcode" name="postcode" placeholder="" value="214000">											
											</div>
											<div class="form-group space-left-4">
													<label for="contact">使用单位联系人：</label> <input type="text"
														id="contact" name="contact" placeholder="" value="张邵明">
													<label class="space-left-3" for="telephone">使用单位联系电话：</label> <input
														type="text" id="telephone" name="telephone" placeholder="" value="18861827812">	
																								
											</div>
											<h2>
										<small class="space-left-2">= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = </small>
										</h2>
											<div class="form-group space-left-4">
											
													<label class="space-left-3" for="requireddrawtime">要求取件日期：</label> <input
														type="date" id="requireddrawtime" name="requireddrawtime" placeholder="" value="20170416">	
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

				<div class="row">
					<div class="box col-md-4">
						<div class="box-inner homepage-box">
							<div class="box-header well">
								<h2>
									<i class="glyphicon glyphicon-th"></i> Tabs
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
								<ul class="nav nav-tabs" id="myTab">
									<li class="active"><a href="#info">Info</a></li>
									<li><a href="#custom">Custom</a></li>
									<li><a href="#messages">Messages</a></li>
								</ul>

								<div id="myTabContent" class="tab-content">
									<div class="tab-pane active" id="info">
										<h3>
											Charisma <small>a full featured template</small>
										</h3>
										<p>It's a full featured, responsive template for your
											admin panel. It's optimized for tablets and mobile phones.</p>

										<p>Check how it looks on different devices:</p>
										<a
											href="http://www.responsinator.com/?url=usman.it%2Fthemes%2Fcharisma"
											target="_blank"><strong>Preview on iPhone size.</strong></a>
										<br> <a
											href="http://www.responsinator.com/?url=usman.it%2Fthemes%2Fcharisma"
											target="_blank"><strong>Preview on iPad size.</strong></a>
									</div>
									<div class="tab-pane" id="custom">
										<h3>
											Custom <small>small text</small>
										</h3>
										<p>Sample paragraph.</p>

										<p>Your custom text.</p>
									</div>
									<div class="tab-pane" id="messages">
										<h3>
											Messages <small>small text</small>
										</h3>
										<p>Sample paragraph.</p>

										<p>Your custom text.</p>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--/span-->

					<div class="box col-md-4">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-user"></i> Member Activity
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
										class="btn btn-close btn-round btn-default"><i
										class="glyphicon glyphicon-remove"></i></a>
								</div>
							</div>
							<div class="box-content">
								<div class="box-content">
									<ul class="dashboard-list">
										<li><a href="#"> <img class="dashboard-avatar"
												alt="Usman"
												src="http://www.gravatar.com/avatar/f0ea51fa1e4fae92608d8affee12f67b.png?s=50"></a>
											<strong>Name:</strong> <a href="#">Usman </a><br> <strong>Since:</strong>
											17/05/2014<br> <strong>Status:</strong> <span
											class="label-success label label-default">Approved</span></li>
										<li><a href="#"> <img class="dashboard-avatar"
												alt="Sheikh Heera"
												src="http://www.gravatar.com/avatar/3232415a0380253cfffe19163d04acab.png?s=50"></a>
											<strong>Name:</strong> <a href="#">Sheikh Heera </a><br>
											<strong>Since:</strong> 17/05/2014<br> <strong>Status:</strong>
											<span class="label-warning label label-default">Pending</span>
										</li>
										<li><a href="#"> <img class="dashboard-avatar"
												alt="Abdullah"
												src="http://www.gravatar.com/avatar/46056f772bde7c536e2086004e300a04.png?s=50"></a>
											<strong>Name:</strong> <a href="#">Abdullah </a><br> <strong>Since:</strong>
											25/05/2014<br> <strong>Status:</strong> <span
											class="label-default label label-danger">Banned</span></li>
										<li><a href="#"> <img class="dashboard-avatar"
												alt="Sana Amrin" src="http://www.gravatar.com/avatar/hash"></a>
											<strong>Name:</strong> <a href="#">Sana Amrin</a><br> <strong>Since:</strong>
											17/05/2014<br> <strong>Status:</strong> <span
											class="label label-info">Updates</span></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<!--/span-->

					<div class="box col-md-4">
						<div class="box-inner homepage-box">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-list-alt"></i> Keep in touch
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
										class="btn btn-close btn-round btn-default"><i
										class="glyphicon glyphicon-remove"></i></a>
								</div>
							</div>
							<div class="box-content">
								<h3>Stay updated with my projects and blog posts</h3>
								<!-- Begin MailChimp Signup Form -->
								<div class="mc_embed_signup">
									<form
										action="//halalit.us3.list-manage.com/subscribe/post?u=444b176aa3c39f656c66381f6&amp;id=eeb0c04e84"
										method="post" id="mc-embedded-subscribe-form"
										name="mc-embedded-subscribe-form" class="validate"
										target="_blank" novalidate>
										<div>
											<label>Please enter your email</label> <input type="email"
												value="" name="EMAIL" class="email"
												placeholder="Email address" required>

											<div class="power_field">
												<input type="text"
													name="b_444b176aa3c39f656c66381f6_eeb0c04e84" tabindex="-1"
													value="">
											</div>
											<div class="clear">
												<input type="submit" value="Subscribe" name="subscribe"
													class="button">
											</div>
										</div>
									</form>
								</div>

								<!--End mc_embed_signup-->
								<br />

								<p>
									You may like my other open source work, check my profile on <a
										href="http://github.com/usmanhalalit" target="_blank">GitHub</a>.
								</p>

							</div>
						</div>
					</div>
					<!--/span-->
				</div>
				<!--/row-->

				<div class="row">
					<div class="box col-md-4">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-list"></i> Buttons
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
							<div class="box-content buttons">
								<p class="btn-group">
									<button class="btn btn-default">Left</button>
									<button class="btn btn-default">Middle</button>
									<button class="btn btn-default">Right</button>
								</p>
								<p>
									<button class="btn btn-default btn-sm">
										<i class="glyphicon glyphicon-star"></i> Icon button
									</button>
									<button class="btn btn-primary btn-sm">Small button</button>
									<button class="btn btn-danger btn-sm">Small button</button>
								</p>
								<p>
									<button class="btn btn-warning btn-sm">Small button</button>
									<button class="btn btn-success btn-sm">Small button</button>
									<button class="btn btn-info btn-sm">Small button</button>
								</p>
								<p>
									<button class="btn btn-inverse btn-default btn-sm">Small
										button</button>
									<button class="btn btn-primary btn-round btn-lg">Round
										button</button>
									<button class="btn btn-round btn-default btn-lg">
										<i class="glyphicon glyphicon-ok"></i>
									</button>
									<button class="btn btn-primary">
										<i class="glyphicon glyphicon-edit glyphicon-white"></i>
									</button>
								</p>
								<p>
									<button class="btn btn-default btn-xs">Mini button</button>
									<button class="btn btn-primary btn-xs">Mini button</button>
									<button class="btn btn-danger btn-xs">Mini button</button>
									<button class="btn btn-warning btn-xs">Mini button</button>
								</p>
								<p>
									<button class="btn btn-info btn-xs">Mini button</button>
									<button class="btn btn-success btn-xs">Mini button</button>
									<button class="btn btn-inverse btn-default btn-xs">Mini
										button</button>
								</p>
							</div>
						</div>
					</div>
					<!--/span-->

					<div class="box col-md-4">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-list"></i> Buttons
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
							<div class="box-content  buttons">
								<p>
									<button class="btn btn-default btn-lg">Large button</button>
									<button class="btn btn-primary btn-lg">Large button</button>
								</p>
								<p>
									<button class="btn btn-danger btn-lg">Large button</button>
									<button class="btn btn-warning btn-lg">Large button</button>
								</p>
								<p>
									<button class="btn btn-success btn-lg">Large button</button>
									<button class="btn btn-info btn-lg">Large button</button>
								</p>
								<p>
									<button class="btn btn-inverse btn-default btn-lg">Large
										button</button>
								</p>
								<div class="btn-group">
									<button class="btn btn-default btn-lg">Large Dropdown</button>
									<button class="btn dropdown-toggle btn-default btn-lg"
										data-toggle="dropdown">
										<span class="caret"></span>
									</button>
									<ul class="dropdown-menu">
										<li><a href="#"><i class="glyphicon glyphicon-star"></i>
												Action</a></li>
										<li><a href="#"><i class="glyphicon glyphicon-tag"></i>
												Another action</a></li>
										<li><a href="#"><i
												class="glyphicon glyphicon-download-alt"></i> Something else
												here</a></li>
										<li class="divider"></li>
										<li><a href="#"><i class="glyphicon glyphicon-tint"></i>
												Separated link</a></li>
									</ul>
								</div>

							</div>
						</div>
					</div>
					<!--/span-->

					<div class="box col-md-4">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-list"></i> Weekly Stat
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
								<ul class="dashboard-list">
									<li><a href="#"> <i
											class="glyphicon glyphicon-arrow-up"></i> <span class="green">92</span>
											New Comments
									</a></li>
									<li><a href="#"> <i
											class="glyphicon glyphicon-arrow-down"></i> <span class="red">15</span>
											New Registrations
									</a></li>
									<li><a href="#"> <i class="glyphicon glyphicon-minus"></i>
											<span class="blue">36</span> New Articles
									</a></li>
									<li><a href="#"> <i
											class="glyphicon glyphicon-comment"></i> <span class="yellow">45</span>
											User reviews
									</a></li>
									<li><a href="#"> <i
											class="glyphicon glyphicon-arrow-up"></i> <span class="green">112</span>
											New Comments
									</a></li>
									<li><a href="#"> <i
											class="glyphicon glyphicon-arrow-down"></i> <span class="red">31</span>
											New Registrations
									</a></li>
									<li><a href="#"> <i class="glyphicon glyphicon-minus"></i>
											<span class="blue">93</span> New Articles
									</a></li>
									<li><a href="#"> <i
											class="glyphicon glyphicon-comment"></i> <span class="yellow">254</span>
											User reviews
									</a></li>
								</ul>
							</div>
						</div>
					</div>
					<!--/span-->
				</div>
				<!--/row-->
				<!-- content ends -->
			</div>
			<!--/#content.col-md-0-->
		</div>
		<!--/fluid-row-->

	

		<hr>

		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">

			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h3>Settings</h3>
					</div>
					<div class="modal-body">
						<p>Here settings can be configured...</p>
					</div>
					<div class="modal-footer">
						<a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
						<a href="#" class="btn btn-primary" data-dismiss="modal">Save
							changes</a>
					</div>
				</div>
			</div>
		</div>

		<footer class="row">
			<p class="col-md-9 col-sm-9 col-xs-12 copyright">
				&copy; <a href="http://usman.it" target="_blank">Muhammad Usman</a>
				2012 - 2015
			</p>

			<p class="col-md-3 col-sm-3 col-xs-12 powered-by">
				Powered by: <a href="http://usman.it/free-responsive-admin-template">Charisma</a>
			</p>
		</footer>

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
