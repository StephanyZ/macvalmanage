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
String option = request.getParameter("option");
String opnumber = request.getParameter("opnumber");
if(option.equals("delpre")){
	String delete_pre="delete from preparetochangeinfo where valorgroupnumber='"+opnumber+"'";
	int flag_delete=connect.addquery(delete_pre);
	if(flag_delete!=0){
		PrintWriter pw = response.getWriter();
		response.setContentType("text");
		pw.write("sucess");
		pw.close();
		return;
	}else{
		PrintWriter pw = response.getWriter();
		response.setContentType("text");
		pw.write("failed");
		pw.close();
		return;
	}
	}
%>
</body>
</html>