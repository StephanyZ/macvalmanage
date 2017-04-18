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
ResultSet rs=null;
String sql="select * from valsavestatusinfo order by optime desc";
rs=connect.query(sql);
JsonObject object=new JsonObject();
JsonArray array=new JsonArray();
while(rs.next()){
	JsonObject ob=new JsonObject();
	ob.addProperty("valnumber",rs.getString("valnumber"));
	ob.addProperty("valvolume",rs.getString("valvolume"));
	ob.addProperty("storagelocationnum",rs.getString("storagelocationnum"));
	ob.addProperty("opaction", rs.getString("opaction"));
	ob.addProperty("manindex",rs.getString("manindex"));
	ob.addProperty("useraccount", rs.getString("useraccount"));
	ob.addProperty("optime", rs.getString("optime"));
	ob.addProperty("valstatus", rs.getString("valstatus"));
	ob.addProperty("exlocationnum", rs.getString("exlocationnum"));
	array.add(ob);	
}
PrintWriter pw=response.getWriter();
response.setContentType("text／json");
pw.write(array.toString());
pw.close();
%>

</body>
</html>