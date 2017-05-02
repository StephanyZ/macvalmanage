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
/*String test="select * from checkorder";
ResultSet rs_getacceptno=connect.query(test);
while(rs_getacceptno.next()){
	if(rs_getacceptno.getString("valnumber").substring(0, 1).equals("g")){
		String upacceptno="update val_information set acceptno='"+rs_getacceptno.getString("acceptno")+"'where groupnum='"+rs_getacceptno.getString("valnumber")+"'";
		int flag=connect.addquery(upacceptno);
		if(flag==0){
			System.out.println(upacceptno);
		}
	}else{
		String upacceptno="update val_information set acceptno='"+rs_getacceptno.getString("acceptno")+"'where valnumber='"+rs_getacceptno.getString("valnumber")+"'";
		int flag=connect.addquery(upacceptno);
		if(flag==0){
			System.out.println(upacceptno);
		}
	}
}*/
String select="select * from valsavestatusinfo where valstatus='O'";
ResultSet rs=connect.query(select);
String setvalid=null;
while(rs.next()){
if(rs.getString("valnumber").substring(0, 1).equals("g")){
	setvalid="update val_information set isvalid='no' where groupnum='"+rs.getString("valnumber")+"'";
}else{
	setvalid="update val_information set isvalid='no' where valnumber='"+rs.getString("valnumber")+"'";
}
int flag=connect.addquery(setvalid);
if(flag==0){
	System.out.println(setvalid);
}
}

%>

</body>
</html>