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
String manindex=request.getParameter("manindex");
String opnumber=request.getParameter("opnumber");
String status=request.getParameter("status");
out.println(status);

String valstatus="";


ResultSet rs=null;
String STR_FORMAT = "00000000";
DecimalFormat df = new DecimalFormat(STR_FORMAT);
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
Date d=new Date();
String optime= sdf.format(d);
String opaction="T";
String valvolume=null;
String storagelocationnum=null;
String useraccount = (String)session.getAttribute("useraccount");
String savevalve="select * from locationinfo where locationstatus=1 and valorgroupnumber='"+opnumber+"'";
String getinfo="select * from valsavestatusinfo where valnumber='"+opnumber+"' order by optime desc";
ResultSet rs_select_getinfo=connect.query(getinfo);
if(rs_select_getinfo.next()){
	valvolume=rs_select_getinfo.getString("valvolume");
	storagelocationnum=rs_select_getinfo.getString("storagelocationnum");
	ResultSet rs_select_save=connect.query(savevalve);
	if(status.equals("N")){
		valstatus="C";
	}else if(status.equals("Q")||status.equals("U")){
		valstatus="O";
	}
	if(rs_select_save.next()){
		String location=rs_select_save.getString("storagelocationnum");
		String modify="update locationinfo set locationstatus=0,valorgroupnumber=null where storagelocationnum='"+location+"'";
		int flag=0;
		flag=connect.addquery(modify);
		if(flag!=0){
			String insert_out_info="insert into valsavestatusinfo values('"+opnumber+"','"+valvolume+"','"+storagelocationnum+"','"+opaction+"','"+manindex+"','"+useraccount+"',"+optime+",'"+valstatus+"')";
			String add_checkedwillbesaved="insert into checkedwillbesaved values('"+opnumber+"','"+valvolume+"')";
			
			int j=-1;
			if(valstatus.equals("C")){
				j=connect.addquery(add_checkedwillbesaved);
				if(j==0){
					PrintWriter pw=response.getWriter();
					response.setContentType("text");
					pw.write("出库插入备存队列失败！！"+add_checkedwillbesaved);
					pw.close();
				}
			}
			
			int i=connect.addquery(insert_out_info);
			if(i!=0&&j!=0){
				PrintWriter pw=response.getWriter();
				response.setContentType("text");
				pw.write("出库成功！");
				pw.close();
			}else{
				PrintWriter pw=response.getWriter();
				response.setContentType("text");
				pw.write("信息插入失败！"+insert_out_info+add_checkedwillbesaved);
				pw.close();
			}
		}
	
}
}else{
	PrintWriter pw=response.getWriter();
	response.setContentType("text");
	pw.write("出库失败！");
	pw.close();
}

%>

</body>
</html>