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
String number=request.getParameter("opnumber");
String acceptno=request.getParameter("acceptno");
ResultSet rs=null;
String test="select * from checkorder where valnumber='"+number+"'and acceptno='"+acceptno+"'";
System.out.println(test);
ResultSet rs_test=connect.query(test);
String valorgroupnummber=null;
if(rs_test.next()){
	PrintWriter pw = response.getWriter();
	response.setContentType("text");
	pw.write("notgroupsingle");
	pw.close();
}else{
	PrintWriter pw = response.getWriter();
	response.setContentType("text");
	pw.write("isgroupsingle");
	pw.close();
}
%>

</body>
</html>