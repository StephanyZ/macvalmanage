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
String locationstatus="select * from locationinfo where locationstatus=1 group by valorgroupnumber";
out.println(locationstatus);
String sql="";
ResultSet rs_select_location=connect.query(locationstatus);
String valorgroupnummber=null;
JsonObject object=new JsonObject();
JsonArray array=new JsonArray();
String acceptno=null;
while(rs_select_location.next()){
	valorgroupnummber=rs_select_location.getString("valorgroupnumber");
	sql="select * from valsavestatusinfo where valnumber='"+valorgroupnummber+"'order by optime desc limit 1";
	rs=connect.query(sql);
	String select="select * from preparetochangeinfo where valorgroupnumber='"+valorgroupnummber+"'";
	ResultSet rs1=connect.query(select);
	if(rs.next()&&!rs1.next()){
		String checkorder="select * from checkorder where valnumber='"+rs.getString("valnumber")+"'";
		ResultSet rs_check=connect.query(checkorder);
		if(rs_check.next()){
			acceptno=rs_check.getString("acceptno");
		}
		System.out.println(rs.getString("valnumber").substring(0,1));
		if(rs.getString("valnumber").substring(0,1).equals("g")){
			String getvalnumber="select * from val_information where groupnum='"+rs.getString("valnumber")+"'";
			System.out.println(getvalnumber);
			ResultSet rs_val=connect.query(getvalnumber);
			while(rs_val.next()){
				String select1="select * from preparetochangeinfo where valorgroupnumber='"+rs_val.getString("valnumber")+"'";
				ResultSet rs2=connect.query(select1);
				if(!rs2.next()&&!rs_val.getString("isvalid").equals("no")){
				JsonObject ob=new JsonObject();
				ob.addProperty("valnumber",rs_val.getString("valnumber"));
				ob.addProperty("valvolume",rs.getString("valvolume"));
				ob.addProperty("storagelocationnum",rs.getString("storagelocationnum"));
				ob.addProperty("opaction", rs.getString("opaction"));
				ob.addProperty("manindex",rs.getString("manindex"));
				ob.addProperty("useraccount", rs.getString("useraccount"));
				ob.addProperty("optime", rs.getString("optime"));
				ob.addProperty("valstatus", rs.getString("valstatus"));
				ob.addProperty("exlocationnum", rs.getString("exlocationnum"));
				ob.addProperty("acceptno",acceptno);
				array.add(ob);
				}
			}
		}else{
			JsonObject ob=new JsonObject();
			ob.addProperty("valnumber",rs.getString("valnumber"));
			System.out.println("111111111");
			ob.addProperty("valvolume",rs.getString("valvolume"));
			ob.addProperty("storagelocationnum",rs.getString("storagelocationnum"));
			ob.addProperty("opaction", rs.getString("opaction"));
			ob.addProperty("manindex",rs.getString("manindex"));
			ob.addProperty("useraccount", rs.getString("useraccount"));
			ob.addProperty("optime", rs.getString("optime"));
			ob.addProperty("valstatus", rs.getString("valstatus"));
			ob.addProperty("exlocationnum", rs.getString("exlocationnum"));
			ob.addProperty("acceptno",acceptno);
			array.add(ob);
		}	
	}
}
PrintWriter pw=response.getWriter();
response.setContentType("text／json");
pw.write(array.toString());
pw.close();
%>

</body>
</html>