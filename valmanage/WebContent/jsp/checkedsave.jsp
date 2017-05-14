<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.io.*,java.sql.*,java.sql.Connection,java.sql.Statement,java.util.Formatter,java.text.ParseException,java.text.SimpleDateFormat,java.util.Calendar,java.util.Date,java.text.DecimalFormat"%>
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
String opaction="S";
String valorgroupnumber=request.getParameter("valorgroupnumber");
String acceptno=null;
if(valorgroupnumber.length()>10){
	acceptno=valorgroupnumber;
	String get_valorgroupnumber="select * from val_information where acceptno='"+valorgroupnumber+"'";
	ResultSet rs_valorgroupnumber=connect.query(get_valorgroupnumber);
	if(rs_valorgroupnumber.next()){
		valorgroupnumber=rs_valorgroupnumber.getString("valnumber");
		if(rs_valorgroupnumber.next()){
			valorgroupnumber=rs_valorgroupnumber.getString("groupnum");
		}
	}
}
String manindex=request.getParameter("manindex");
String valvolume=request.getParameter("valvolume");
String location=request.getParameter("location");
String exlocation=request.getParameter("exlocation");

//String lo="select * from val_information where valnumber=\""+valorgroupnumber+"\" or groupnum=\""+valorgroupnumber+"\"";
//rs=connect.query(lo);
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
Date d=new Date();
String optime = sdf.format(d);
String useraccount = (String)session.getAttribute("useraccount");
String valstatus="Y";
String lo1="";
String lo2="";
ResultSet rs1=null;
ResultSet rs2=null;
int f=0;
int ff=0;
String modify1="";
String modify2="";
String insert="";
	lo1="select * from locationinfo where storagelocationnum=\""+location+"\" and locationstatus=0";	
	rs1=connect.query(lo1);
	if(rs1.next()){
		modify1="update locationinfo set locationstatus=1,valorgroupnumber=\""+valorgroupnumber+"\" where storagelocationnum=\""+location+"\"";
		if(!exlocation.equals("")){
			lo2="select * from locationinfo where storagelocationnum=\""+exlocation+"\" and locationstatus=0";
			rs2=connect.query(lo2);
			if(rs2.next()){
				modify2="update locationinfo set locationstatus=1,valorgroupnumber=\""+valorgroupnumber+"\" where storagelocationnum=\""+exlocation+"\"";
				insert="insert into valsavestatusinfo values('"+valorgroupnumber+"','"+valvolume+"','"+location+"','"+opaction+"','"+manindex+"','"+useraccount+"',"+optime+",'"+valstatus+"','"+exlocation+"')";
			}
		}else{
			insert="insert into valsavestatusinfo values('"+valorgroupnumber+"','"+valvolume+"','"+location+"','"+opaction+"','"+manindex+"','"+useraccount+"',"+optime+",'"+valstatus+"',"+null+")";
		}
		int flag_modify1=connect.addquery(modify1);
		int flag=0;
		if(!exlocation.equals("")){
			int flag_modify2=connect.addquery(modify2);
			if(flag_modify2==0){
				flag=1;
			}
		}
		int flad_insert=connect.addquery(insert);
		if(flag_modify1!=0&&flad_insert!=0){
			String delete="";
			delete="delete from checkedwillbesaved where acceptno='"+acceptno+"'";
			int flag_delete=connect.addquery(delete);
			if(flag_delete!=0){
				PrintWriter pw=response.getWriter();
				response.setContentType("text");
				pw.write("存储成功！");
				pw.close();
				//return;
			}else{
				PrintWriter pw=response.getWriter();
				response.setContentType("text");
				pw.write("未成功删除备出库列表"+delete);
				pw.close();
				//return;
			}
		}else if(flag==0&&flad_insert!=0&&flag_modify1==0){
			PrintWriter pw=response.getWriter();
			response.setContentType("text");
			pw.write("修改locationstatus失败！");
			pw.close();
			//return;
		}else if(flag==0&&flad_insert==0&&flag_modify1!=0){
			PrintWriter pw=response.getWriter();
			response.setContentType("text");
			pw.write("插入存储状态失败！！"+insert);
			pw.close();
			//return;
		}else if(flag==1){
			PrintWriter pw=response.getWriter();
			response.setContentType("text");
			pw.write("插入备选存储位置失败！！");
			pw.close();
			//return;
		}else{
			PrintWriter pw=response.getWriter();
			response.setContentType("text");
			pw.write("存储失败！");
			pw.close();
			//return;
		}
		}else{
			PrintWriter pw=response.getWriter();
			response.setContentType("text");
			pw.write("该位置不为空！！");
			pw.close();
			//return;
		}
	%>
</body>
</html>