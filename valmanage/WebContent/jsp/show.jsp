<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page
	import="java.io.*,java.sql.*,java.sql.Connection,java.sql.Statement,java.util.Formatter,java.text.ParseException,java.text.SimpleDateFormat,java.util.Calendar,java.util.Date,java.text.DecimalFormat"%>
<%@page import="com.google.gson.JsonArray"%>  
<%@page import="com.google.gson.JsonObject"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="connect" class="com.xfzhang.bean.connection" />
<%
String option=request.getParameter("option");
if(option.equals("showvalorgroupinfo")){
	String valorgroupnumber=request.getParameter("valorgroupnumber");
	String select_val="select * from val_information where valnumber='"+valorgroupnumber+"'";
	ResultSet rs_select_val=connect.query(select_val);
	String select_group="select * from val_information where groupnum='"+valorgroupnumber+"'";
	ResultSet rs_select_group=connect.query(select_group);
	String ss="";
	while(rs_select_val.next()){
		ss+="安全阀编制ID："+rs_select_val.getString("valnumber")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀出厂编号："+rs_select_val.getString("productno")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀制造单位："+rs_select_val.getString("manufacture")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀型号："+rs_select_val.getString("valvecate")+"<br>";
	}
	if(rs_select_group.next()){
		int count=0;
		ss+="安全阀组("+valorgroupnumber+"):<br>";
		count++;
		ss+=count+".安全阀编制ID："+rs_select_group.getString("valnumber")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀出厂编号："+rs_select_group.getString("productno")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀制造单位："+rs_select_group.getString("manufacture")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀型号："+rs_select_group.getString("valvecate")+"<br>";
		while(rs_select_group.next()){
			count++;
			ss+=count+".安全阀编制ID："+rs_select_group.getString("valnumber")+"<br>";
			ss+="&nbsp&nbsp&nbsp安全阀出厂编号："+rs_select_group.getString("productno")+"<br>";
			ss+="&nbsp&nbsp&nbsp安全阀制造单位："+rs_select_group.getString("manufacture")+"<br>";
			ss+="&nbsp&nbsp&nbsp安全阀型号："+rs_select_group.getString("valvecate")+"<br>";
		}
		
	}
	PrintWriter pw=response.getWriter();
	response.setContentType("text");
	pw.write(ss);
	pw.close();
}

%>

</body>
</html>