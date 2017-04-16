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
request.setCharacterEncoding("UTF-8");
String s[]=request.getParameterValues("checkedid");
String ss="";
for(int i=0;i<s.length;i++){
	ss+=s[i];
}
PrintWriter pw=response.getWriter();
response.setContentType("text");
pw.write(ss);
pw.close();
/*ResultSet rs=null;
String locationstatus="select * from locationinfo where locationstatus=1";
out.println(locationstatus);
String sql="";
ResultSet rs_select_location=connect.query(locationstatus);
String valorgroupnummber=null;
out.println(locationstatus);
while(rs_select_location.next()){
	valorgroupnummber=rs_select_location.getString("valorgroupnumber");
	sql="select * from valsavestatusinfo where valorgroupnumber='"+valorgroupnummber+"'";
	
}*/
%>

</body>
</html>