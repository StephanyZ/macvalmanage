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
String acceptno=null;
String select_checkorder=null;
JsonObject object=new JsonObject();
JsonArray array=new JsonArray();
while(rs.next()){
	if(rs.getString("valnumber").substring(0,1).equals("g")){
		select_checkorder="select * from val_information where groupnum='"+rs.getString("valnumber")+"'";	
	}else{
		String isgroup="select * from val_information where valnumber='"+rs.getString("valnumber")+"'";
		ResultSet rs_isgroup=connect.query(isgroup);
		if(rs_isgroup.next()){
			if(rs_isgroup.getString("groupnum")==null){
				select_checkorder="select * from checkorder where valnumber='"+rs.getString("valnumber")+"'";
			}else{
				select_checkorder="select * from checkorder where valnumber='"+rs_isgroup.getString("groupnum")+"'";
			}
		}
	}
	ResultSet rs_checkorder=connect.query(select_checkorder);
	if(rs_checkorder.next()){
		acceptno=rs_checkorder.getString("acceptno");
	}
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
	ob.addProperty("acceptno", acceptno);
	array.add(ob);	
}
System.out.println(array.toString());
PrintWriter pw=response.getWriter();
response.setContentType("text／json");
pw.write(array.toString());
pw.close();
%>

</body>
</html>