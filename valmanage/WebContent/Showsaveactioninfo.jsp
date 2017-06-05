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
<script src='js/jquery.dataTables.min.js'></script>
<link rel="shortcut icon" href="img/favicon.ico">
<script type="text/javascript">

$(document).ready(function show(){
	var tbody=window.document.getElementById("oneinput");
	$.ajax({
		cache: false,
		type: "POST",
		url:"jsp/showsaveactioninfo.jsp",//把表单数据发送到ajax.jsp
		dataType:'json',
		timeout:3000,
		async: false,
		error: function(request) {
			alert("获取数据请求失败！");
		},
		success: function(data) {
			//var datas=eval('('+data+')');
			var N=new Array();
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
				insert+="";
				insert+="</tr>";
				//alert(insert);
				
				}
			insert+="<script>order()<//script>";
			tbody.innerHTML =insert;
		}
		});
        
});
$(document).ready(function() {
    /*
     * Insert a 'details' column to the table
     */
    var nCloneTh = document.createElement( 'th' );
    var nCloneTd = document.createElement( 'td' );
    nCloneTh.innerHTML = "更多";
    nCloneTd.innerHTML = "<a class=\"btn btn-success\">"
		+"<i class=\"glyphicon glyphicon-zoom-in icon-white\"></i> 浏览"
		+"</a>";
    nCloneTd.className = "center";   
    
    var nCloneTh1 = document.createElement( 'th' );
    var nCloneTd1 = document.createElement( 'td' );
    nCloneTh1.innerHTML = "进度";
    nCloneTd1.innerHTML = "<a1 class=\"btn btn-success\">"
		+"<i class=\"glyphicon glyphicon-zoom-in icon-white\"></i> 浏览"
		+"</a1>";
    nCloneTd.className = "center";   
    $('#ddtable thead tr').each( function () {
        this.insertBefore(nCloneTh, this.childNodes[12]);
        this.insertBefore(nCloneTh1, this.childNodes[14]);
    });
     
    $('#ddtable tbody tr').each( function () {
        this.insertBefore(  nCloneTd.cloneNode( true ), this.childNodes[6] );
        this.insertBefore(  nCloneTd1.cloneNode( true ), this.childNodes[7] );
    } );
    var oTable = $('#ddtable').dataTable( {
    	"sDom": "<'row'<'col-md-6'l><'col-md-6'f>r>t<'row'<'col-md-12'i><'col-md-12 center-block'p>>",
        "sPaginationType": "bootstrap",
        "aoColumnDefs": [
                         { "bSortable": false, "aTargets": [6] }
                     ],
        "aaSorting": [[3, "desc"]],
        "oLanguage": {
            "sLengthMenu": "_MENU_ records per page"
        }
    });
     
    /* Add event listener for opening and closing details
     * Note that the indicator for showing which row is open is not controlled by DataTables,
     * rather it is done here
     */
    $('#ddtable tbody').on('click','tr td a',function () {
        var nTr = $(this).parents('tr')[0];
        if ( oTable.fnIsOpen(nTr) )
        {
            /* This row is already open - close it */
            this.className = "btn btn-success";
            oTable.fnClose( nTr );
        }
        else
        {
            /* Open this row */
            this.className = "btn btn-danger";
            oTable.fnOpen( nTr, fnFormatDetails(oTable, nTr), 'details' );
        }
    });
    $('#ddtable tbody').on('click','tr td a1',function () {
        var nTr = $(this).parents('tr')[0];
        if ( oTable.fnIsOpen(nTr) )
        {
            /* This row is already open - close it */
            this.className = "btn btn-success";
            oTable.fnClose( nTr );
        }
        else
        {
            /* Open this row */
            this.className = "btn btn-danger";
            oTable.fnOpen( nTr, fnFormatDetails1(oTable, nTr), 'details' );
        }
    });
});

function fnFormatDetails ( oTable, nTr )
{
    var aData = oTable.fnGetData( nTr );
    var insert;
    alert("更多");
    $.ajax({
		cache: false,
		type: "POST",
		url:"jsp/show.jsp?valorgroupnumber="+aData[0]+"&&option=pcshowvalinfo",//把表单数据发送到ajax.jsp
		dataType:'json',
		timeout:3000,
		async: false,
		error: function(request) {
			alert("获取数据请求失败！");
		},
		success: function(data) {
			//alert(data);
			var i=0;
			insert='<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
			for(var n=0;n<data.length;n++){
				insert+="<tr>";
				insert+="<td calss=\"center\">";
				insert+=data[n].index;
				insert+="</td>";
				insert+="<td calss=\"center\">";
				insert+=data[n].valnumber;
				insert+="</td>";
				insert+="<td calss=\"center\">";
				insert+=data[n].valproductno;
				insert+="</td>";
				insert+="<td calss=\"center\">";
				insert+=data[n].valvecate;
				insert+="</td>";					
				insert+="<td calss=\"center\">";
				insert+=data[n].manufacture;	
				insert+="</td>";
				insert+="<td calss=\"center\">";
				if(data[n].isqualify=='yes'){
					insert+="<td class=\"center\"><span class=\"label-success label label-default\">合格</span></td>";
				}else if(data[n].isqualify=='no'){
					insert+="<td class=\"center\"><span class=\"label-danger label label-default\">不合格</span></td>";
				}else{
					insert+="<td class=\"center\"><span class=\"label-info label label-default\">未检</span></td>";
				}
				insert+="</td>";
				insert+="</tr>";
				}	
			insert += '</table>';
		}
		});
    return insert;
}
function fnFormatDetails1 ( oTable, nTr )
{
    var aData = oTable.fnGetData( nTr );
    var insert;
    alert("进度");
    $.ajax({
		cache: false,
		type: "POST",
		url:"jsp/show.jsp?acceptno="+aData[1]+"&&option=pcshowschedule",//把表单数据发送到ajax.jsp
		dataType:'json',
		timeout:3000,
		async: false,
		error: function(request) {
			alert("获取数据请求失败！");
		},
		success: function(data) {
			//alert(data);
			var i=0;
			insert='<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">';
			for(var n=0;n<data.length;n++){
				insert+="<tr>";
				insert+="<td calss=\"center\">";
				insert+=data[n].index;
				insert+="</td>";
				insert+="<td calss=\"center\">";
				insert+=data[n].valnumber;
				insert+="</td>";
				insert+="<td calss=\"center\">";
				insert+=data[n].optime;
				insert+="</td>";
				insert+="<td calss=\"center\">";
				insert+=data[n].storagelocationnum;
				if(data[n].exlocationnum!=null){
					insert+="&"+data[n].exlocationnum;
				}
				insert+="</td>";					
				insert+="<td calss=\"center\">";
				if(data[n].valstatus=='N'){
					insert+="<td class=\"center\"><span class=\"label-success label label-default\">未检在库</span></td>";
				}else if(data[n].valstatus=='C'){
					insert+="<td class=\"center\"><span class=\"label-danger label label-default\">备检出库</span></td>";
				}else if(data[n].valstatus=='Y'){
					insert+="<td class=\"center\"><span class=\"label-success label label-default\">已检在库</span></td>";
				}else if(data[n].valstatus=='O'){
					insert+="<td class=\"center\"><span class=\"label-danger label label-default\">检毕出库</span></td>";
				}
				insert+="</td>";
				insert+="</tr>";
				}	
			insert += '</table>';
		}
		});
    return insert;
}
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
function tabletoExcel(mytalbe) {
		    // getExplore()返回1，说明是不是Google Chrome、
		    //Firefox、Opera、Safari，那么就认为是IE了。
			if (getExplorer() == 1) {
			    //是IE的话，就调用toExcel()方法来导出Excel表格，
			    //不依赖微软的Excel产品。(toExcel()方法的定义见下面)
				toExcel(mytable, '');
				return;
			}	
			var table=document.getElementById("ddtable");
			// 克隆（复制）此table元素，这样对复制品进行修改（如添加或改变table的标题等），
			//导出复制品，而不影响原table在浏览器中的展示。
			table = table.cloneNode(true);
			
			var uri = 'data:application/vnd.ms-excel;base64,', 
			template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" '
				  +'xmlns:x="urn:schemas-microsoft-com:office:excel" '
				  +'xmlns=<!--[if gte mso 9]><?xml version="1.0" encoding="UTF-8" '
				+'standalone="yes"?><x:ExcelWorkbook><x:ExcelWorksheets>'
				+'<x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions>'
				+'<x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet>'
				+'</x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head>'
				+'<body><table style="vnd.ms-excel.numberformat:@">{table}</table>'
				+'</body></html>', 
				base64 = function (s) { 
					return window.btoa(unescape(encodeURIComponent(s))); }
				  , format = function (s, c) { 
					  return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }); };
				if (!table.nodeType) table = document.getElementById(table);
				var ctx = { worksheet: name || 'Worksheet', table: table.innerHTML };
				window.location.href = uri + base64(format(template, ctx));
				
		}


		// 判断浏览器类型 返回1表示IE
		function getExplorer() {
			var explorer = window.navigator.userAgent;
			if (explorer.indexOf("MSIE") >= 0) {
				return 1;
			} else if (explorer.indexOf("Firefox") >= 0) {
				return 0;
			} else if (explorer.indexOf("Chrome") >= 0) {
				return 0;
			} else if (explorer.indexOf("Opera") >= 0) {
				return 0;
			} else if (explorer.indexOf("Safari") >= 0) {
				return 0;
			} else {
				return 1;
			}
		}

		// 下面的所有函数代码都是为了在IE上能导出Excel表格（不会出现js栈溢出等eggache的problem。。IE is so eggache!!!!
		function toExcel(inTblId, inWindow) {
			try {
				var allStr = "";
				var curStr = "";
				if (inTblId != null && inTblId != "" && inTblId != "null") {
					curStr = getTblData(inTblId, inWindow);
				}
				if (curStr != null) {
					allStr += curStr;
				} else {
					alert("您要导出的表不存在！");
					return;
				}
				var fileName = getExcelFileName();
				doFileExport(fileName, allStr);
			} catch (e) {
				alert("导出发生异常:" + e.name + "->" + e.description + "!");
			}
		}
		function getTblData(inTbl, inWindow) {
			var caption_str="";
			var rows = 0;
			var tblDocument = document;
			if (!!inWindow && inWindow != "") {
				if (!document.all(inWindow)) {
					return null;
				} else {
					tblDocument = eval(inWindow).document;
				}
			}
			var curTbl = tblDocument.getElementById(inTbl).cloneNode(true);
			if(inTbl=="mytable") {
				curTbl.getElementsByTagName("th")[0].innerHTML="XXX的编号";
				caption_str=$("#cur_title_date").text()+"XXX信息统计表";
			} else if(inTbl=="detail_table") {
				curTbl.getElementsByTagName("th")[0].innerHTML="XXXX";
				caption_str=curTbl.getElementsByTagName("caption")[0].innerHTML.split("<br")[0];
			}
			
			if (curTbl.rows.length > 65000) {
				alert('源行数不能大于65000行');
				return false;
			}
			if (curTbl.rows.length <= 1) {
				alert('数据源没有数据');
				return false;
			}
			var outStr = caption_str+" \n";
			if (curTbl != null) {
				for (var j = 0; j < curTbl.rows.length; j++) {
					for (var i = 0; i < curTbl.rows[j].cells.length; i++) {
						if (i == 0 && rows > 0) {
							outStr += " \t";
							rows -= 1;
						}
						var tc = curTbl.rows[j].cells[i];
						if (j > 0 && tc.hasChildNodes()
								&& tc.firstChild.nodeName.toLowerCase() == "input") {
							if (tc.firstChild.type.toLowerCase() == "checkbox") {
								if (tc.firstChild.checked == true) {
									outStr += "是" + "\t";
								} else {
									outStr += "否" + "\t";
								}
							}
						} else {
							outStr += " " + curTbl.rows[j].cells[i].innerText + "\t";
						}
						if (curTbl.rows[j].cells[i].colSpan > 1) {
							for (var k = 0; k < curTbl.rows[j].cells[i].colSpan - 1; k++) {
								outStr += " \t";
							}
						}
						if (i == 0) {
							if (rows == 0 && curTbl.rows[j].cells[i].rowSpan > 1) {
								rows = curTbl.rows[j].cells[i].rowSpan - 1;
							}
						}
					}
					outStr += "\r\n";
				}
			} else {
				outStr = null;
				alert(inTbl + "不存在!");
			}
			return outStr;
		}
		function getExcelFileName() {
			var d = new Date();
			var curYear = d.getYear();
			var curMonth = "" + (d.getMonth() + 1);
			var curDate = "" + d.getDate();
			var curHour = "" + d.getHours();
			var curMinute = "" + d.getMinutes();
			var curSecond = "" + d.getSeconds();
			if (curMonth.length == 1) {
				curMonth = "0" + curMonth;
			}
			if (curDate.length == 1) {
				curDate = "0" + curDate;
			}
			if (curHour.length == 1) {
				curHour = "0" + curHour;
			}
			if (curMinute.length == 1) {
				curMinute = "0" + curMinute;
			}
			if (curSecond.length == 1) {
				curSecond = "0" + curSecond;
			}
			var fileName = "XX统计" + curYear + curMonth + curDate + curHour + curMinute
					+ curSecond + ".xls";
			return fileName;
		}
		function doFileExport(inName, inStr) {
			var xlsWin = null;
			if (!!document.all("glbHideFrm")) {
				xlsWin = glbHideFrm;
			} else {
				var width = 1;
				var height = 1;
				var openPara = "left=" + (window.screen.width / 2 + width / 2)
						+ ",top=" + (window.screen.height + height / 2)
						+ ",scrollbars=no,width=" + width + ",height=" + height;
				xlsWin = window.open("", "_blank", openPara);
			}
			xlsWin.document.write(inStr);
			xlsWin.document.close();
			xlsWin.document.execCommand('Saveas', true, inName);
			xlsWin.close();
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
						<li><a href="Showsaveactioninfo.jsp">查看信息存储</a></li>
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
									<i class="glyphicon glyphicon-user"></i>存储信息
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
								<table id="ddtable" 
									class="table table-striped table-bordered bootstrap-datatable responsive">
									<thead>
										<tr>
											<th>安全阀编号</th>
											<th>委托单号</th>
											<th>存储位置</th>
											<th>操作时间</th>
											<th>存入／取出</th>
											<th>状态</th>
										</tr>
									</thead>
									<tbody id="oneinput">
									</tbody>
								</table>
								<button onClick="tabletoExcel('test')">export</button>
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
