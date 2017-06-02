<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>  
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">  
<html>  
  <head>  
    <base href="<%=basePath%>">  
    <title>POI</title>  
    <meta http-equiv="pragma" content="no-cache">  <span id="transmark"></span>
    <meta http-equiv="cache-control" content="no-cache">  
    <meta http-equiv="expires" content="0">      
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">  
    <meta http-equiv="description" content="This is my page">  
    <!-- 
    <link rel="stylesheet" type="text/css" href="styles.css"> 
    -->  
<script type="text/javascript" src="js/jquery.js"></script>  
<script type="text/javascript" src="js/jquery.table2excel.js"></script>  
<script type="text/javascript">  
function toexcel(){
	alert("开始");
    $(".table2excel").table2excel({
        exclude: ".noExl",
        name: "Excel Document Name",
        filename: "myFileName",
        exclude_img: true,
        exclude_links: true,
        exclude_inputs: true
    });
}
    function exportExcel(){  
    	filename="ceshi";
        var table = tableToJson("#test");  
        console.log(table);  
        var json = JSON.stringify(table);  
        alert(json);
        
        var nodes = $("#"+tableId+" thead tr").children();  
        
        var headers = "";  
        $.each(nodes,function(i,item){  
            headers += item.innerHTML+",";  
        })  
       //调用post方法  
      /* $.ajax({
    	   cache: false,
    	   type: "POST",
    	   url:"jsp/exportExcel.jsp", //把表单数据发送到ajax.jsp
    	   data:{"fileName":fileName,"headers":headers,"json":json}, //要发送的是ajaxFrm表单中的数据
    	   async: false,
    	   error: function(request) {
    		   alert("发送请求失败！");
    	   },
    	   success: function(data) {
    		   }
    	   });
			post('${ctx}/user/p2pUserInformation/exportExcel', {fileName :fileName,headers:headers,json:json});*/
	}
    
    function tableToJson(table) {
        var data = [];

        // first row needs to be headers
        var headers = [];
        var cell=table.rows[0].cells.length;
        alert(cell);
        for (var i=0; i<cell; i++) {
            headers[i] = table.rows[0].cells[i].innerHTML.toLowerCase().replace(/ /gi,'');
        }

        // go through cells
        for (var i=1; i<table.rows.length; i++) {

            var tableRow = table.rows[i];
            var rowData = {};

            for (var j=0; j<tableRow.cells.length; j++) {

                rowData[ headers[j] ] = tableRow.cells[j].innerHTML;

            }

            data.push(rowData);
        }       

        return data;
    }
	function post(url, params) {
		var temp = document.createElement("form");
		temp.action = url;
		temp.method = "post";
		temp.style.display = "none";
		for (var x in params) {
			var opt = document.createElement("input");
			opt.name = x;
			opt.value = params[x];
			temp.appendChild(opt);
		}
		document.body.appendChild(temp);
		temp.submit();
		return temp;
	}        
  
</script>  
  
  </head>  
  <body>  
    <table id="test" class="table2excel">  
	<thead>
	<tr><td>序号</td><td>姓名</td><td>name</td></tr>  
	</thead>
        <tr><td>1</td><td>张三</td><td>zhangsan</td></tr>  
        <tr><td>2</td><td>李四</td><td>lisi</td></tr>  
        <tr><td>3</td><td>王五</td><td>wangwu</td></tr>  
    </table>  
     <button onClick="toexcel()">Export excel 2</button><br><br>  
  </body>  
</html>  