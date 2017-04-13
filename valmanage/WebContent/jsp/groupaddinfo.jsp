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
String option=request.getParameter("option");

String productno=request.getParameter("productno");
String manufacture=request.getParameter("manufacture");
String manucode=request.getParameter("manucode");

String valvecate=request.getParameter("valvecate");
String diapress=request.getParameter("diapress");
String requiredpress=request.getParameter("requiredpress");

String diameter=request.getParameter("diameter");
String valdiameter=request.getParameter("valdiameter");
String pressgrade=request.getParameter("pressgrade");

String revise=request.getParameter("revise");
String reseatpress=request.getParameter("reseatpress");
String media=request.getParameter("media");

String designpress=request.getParameter("designpress");
String designtemper=request.getParameter("designtemper");
String valvepno=request.getParameter("valvepno");

String outputtime=request.getParameter("outputtime");
String inportvalve=request.getParameter("inportvalve");
String svalve=request.getParameter("svalve");

String factoryindex=request.getParameter("factoryindex");
String factory=request.getParameter("factory");
String address=request.getParameter("address");

String contact=request.getParameter("contact");
String telephone=request.getParameter("telephone");
String postcode=request.getParameter("postcode");

String requireddrawtime=request.getParameter("requireddrawtime");
String checkisgroup=request.getParameter("checkisgroup");

String groupnum=null;
String sendtime=null;
String valnumber=null;
String reportno=null;
String standard=null;
String appearance=null;
String equipindex=null;
String acceptno=null;

if(option.equals("groupnum")){
//get valnumber
	int groupcount=0;
	String select_group="select * from val_information where groupnum is not null group by groupnum";
	ResultSet rs_group=connect.query(select_group);
	while(rs_group.next()){
		groupcount++;
	}
	groupcount++;
	ResultSet rs_select_groupnum=connect.query("select * from val_information where groupnum=\""+groupcount+"\"");
	while(rs_select_groupnum.next()){
		groupcount++;
		rs_select_groupnum=connect.query("select * from val_information where groupnum=\""+groupcount+"\"");
	}
	String STR_FORMAT = "g0000000";
	DecimalFormat df = new DecimalFormat(STR_FORMAT);
	groupnum=df.format(groupcount);
	PrintWriter pw=response.getWriter();
	response.setContentType("html/text");
	pw.write(groupnum);
	pw.close();
	}



if(option.equals("valnum")){
	groupnum=request.getParameter("groupnum");
	if(groupnum.equals("")){
		%><script>alert("分组id为空！")</script><%
		return;
	}else{
	String select_valinformation="select * from val_information";
	ResultSet rs_select_valinformation=connect.query(select_valinformation);
	int valinfocount=0;
	while(rs_select_valinformation.next()){
		valinfocount=valinfocount+1;
	}
	valinfocount++;
	ResultSet rs_select_valnum=connect.query("select * from val_information where valnumber=\""+valnumber+"\"");
	String select_valprono="select * from val_information where productno='"+productno+"'";
	ResultSet rs_select_valprono=connect.query(select_valprono);
	while(rs_select_valprono.next()){
		PrintWriter pw=response.getWriter();
		response.setContentType("html/text");
		pw.write("该安全阀已存在！id为:"+rs_select_valprono.getString("valnumber"));
		pw.close();
		return;
	}
	while(rs_select_valnum.next()){
		valinfocount++;
		rs_select_valnum=connect.query("select * from val_information where valnumber=\""+valnumber+"\"");
	}
	String STR_FORMAT = "00000000";
	DecimalFormat df = new DecimalFormat(STR_FORMAT);
	valnumber=df.format(valinfocount);
	String add_valinformation="insert into val_information values('"+productno+"','"+manufacture+"','"+valnumber+"','"+valvecate+"','"+media+"',"+diapress+","+diameter+","+valdiameter+","+requiredpress+",'"+pressgrade+"',"+outputtime+",'"+revise+"','"+manucode+"',"+designpress+","+designtemper+","+valvepno+","+reseatpress+",'"+inportvalve+"','"+svalve+"','"+groupnum+"')";
	int flag_add_valinformation=0;
	flag_add_valinformation=connect.addquery(add_valinformation);
	if(flag_add_valinformation!=0){
		PrintWriter pw=response.getWriter();
		response.setContentType("text");
		pw.write("安全阀添加成功！");
		pw.close();
	}else{
		%><script>alert("安全阀存储入组失败")</script><%
	}
	}
}

if(option.equals("showgroupval")){
	groupnum=request.getParameter("groupnum");
	String select_valgroup="select * from val_information where groupnum='"+groupnum+"'";
	ResultSet rs_select_valgroup=connect.query(select_valgroup);
	JsonArray array=new JsonArray();
	while(rs_select_valgroup.next()){
		JsonObject ob=new JsonObject();
		ob.addProperty("valnumber",rs_select_valgroup.getString("valnumber"));
		array.add(ob);
	}
	PrintWriter pw=response.getWriter();
	response.setContentType("text／json");
	pw.write(array.toString());
	pw.close();
}

if(option.equals("addinformation")){
	int flag_add_userfactory=0;
	int flag_add_checkorder=0;
	int flag_add_groupwillbesaved=0;
	if(checkisgroup.equals("yes")){
		groupnum=request.getParameter("groupnum");
		String select_valgroup="select * from val_information where groupnum='"+groupnum+"'";
		ResultSet rs_select_valgroup=connect.query(select_valgroup);
		int count=0;
		if(rs_select_valgroup.next()){
			count++;
			while(rs_select_valgroup.next()){
				count++;
			}
			ResultSet rs_select_factory=connect.query("select * from userfactory where factory=\""+factory+"\"");
			int f=0;
			
			while(rs_select_factory.next()){
				f=1;
				%><script>alert("数据库已存在该使用单位")</script><%
				break;
				}
			int flag=0;
			String ss=null;
			String add_userfactory="insert into userfactory values('"+factoryindex+"','"+factory+"','"+address+"','"+postcode+"','"+contact+"','"+telephone+"')";
			String add_checkorder="insert into checkorder values('"+acceptno+"','"+groupnum+"','"+factoryindex+"','"+equipindex+"','"+appearance+"',"+sendtime+",'"+standard+"','"+reportno+"',"+requireddrawtime+")";
			String add_groupwillbesaved="insert into groupwillbesaved values('"+groupnum+"','"+acceptno+"','"+count+"')";
			
			if(f==0){
				flag_add_userfactory=connect.addquery(add_userfactory);
				}
			flag_add_checkorder=connect.addquery(add_checkorder);
			flag_add_groupwillbesaved=connect.addquery(add_groupwillbesaved);
			
		}else{
			PrintWriter pw=response.getWriter();
			response.setContentType("text／json");
			pw.write("未加入任何安全阀入组！");
			pw.close();
		}
	}
}

%>
</body>
</html>