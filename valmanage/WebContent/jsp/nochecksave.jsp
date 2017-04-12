<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.io.*,java.sql.*,java.sql.Connection,java.sql.Statement,java.util.Formatter,java.text.ParseException,java.text.SimpleDateFormat,java.util.Calendar,java.util.Date,java.text.DecimalFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>安全阀管理系统</title>
</head>
<body>
	<jsp:useBean id="connect" class="com.xfzhang.bean.connection" />
	<% 
try {
request.setCharacterEncoding("UTF-8");
ResultSet rs=null;
String groupnum=null;
String opaction="S";
String productno=request.getParameter("productno");
String manufacture=request.getParameter("manufacture");
String manindex=request.getParameter("manindex");
String valvolume=request.getParameter("valvolume");
String storagelocationnum=request.getParameter("storagelocationnum");
String lo="select * from val_information where productno=\""+productno+"\" and manufacture=\""+manufacture+"\"";
out.print(lo);
rs=connect.query(lo);
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
Date d=new Date();
String optime = sdf.format(d);
String useraccount = (String)session.getAttribute("useraccount");
String valstatus="N";
int f=0;
int ff=0;
while(rs.next()){
	f=1;
	String valnumber=rs.getString("valnumber");
	String lo1="select * from locationinfo where storagelocationnum=\""+storagelocationnum+"\"";
	rs=connect.query(lo1);
	while(rs.next()){
		ff=1;
		if(rs.getInt("locationstatus")==0){
			String modify="update locationinfo set locationstatus=1,valorgroupnumber=\""+valnumber+"\" where storagelocationnum=\""+storagelocationnum+"\"";
			String insert="insert into valsavestatusinfo values('"+valnumber+"','"+valvolume+"','"+storagelocationnum+"','"+groupnum+"','"+opaction+"','"+manindex+"','"+useraccount+"',"+optime+",'"+valstatus+"')";		
			int flag_modify=connect.addquery(modify);
			int flad_insert=connect.addquery(insert);
			if(flag_modify!=0&&flad_insert!=0){	
				String delete="delete from willbesaved where valnumber='"+valnumber+"'";
				int flag_delete=connect.addquery(delete);
				if(flag_delete!=0){
					out.print("存储成功！！");
				}
			}else if(flad_insert!=0&&flag_modify==0){
				out.print("修改locationstatus失败！");
			}else if(flad_insert==0&&flag_modify!=0){
				out.print("插入存储状态失败！");
			}else{
				out.print("存储失败！");
			}
			}
		}
	if(ff==0){
		out.print("存储位置信息不存在，请核实或使用推荐位置！");
		return;
		}
	}
if(f==0){
	out.print("系统未录入该安全阀信息，请录入后再进行存储！");
	return;
}
}catch (Exception e) {
	System.out.print("get data error!");
    e.printStackTrace();
    }
%>
	<%-- jsp:include page="connection.jsp" flush="true"></jsp:include>--%>

	<%-- <jsp:forward page="test.jsp"></jsp:forward>--%>
</body>
</html>