<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.io.*,java.sql.*,java.sql.Connection,java.sql.Statement,java.util.Formatter,java.text.ParseException,java.text.SimpleDateFormat,java.util.Calendar,java.util.Date,java.text.DecimalFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<jsp:useBean id="connect" class="com.xfzhang.bean.connection" />
	<% 
request.setCharacterEncoding("UTF-8");
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
String sendtime=null;
String valnumber=null;
String reportno=null;
String standard=null;
String appearance=null;
String equipindex=null;
String acceptno=null;
String groupnum=null;


requireddrawtime = requireddrawtime.replaceAll("-","");
//get valnumber
String select_valinformation="select * from val_information";
ResultSet rs_select_valinformation=connect.query(select_valinformation);
int valinfocount=0;
while(rs_select_valinformation.next()){
	valinfocount=valinfocount+1;
}
valinfocount++;
ResultSet rs_select_valnum=connect.query("select * from val_information where valnumber=\""+valnumber+"\"");
while(rs_select_valnum.next()){
	valinfocount++;
	rs_select_valnum=connect.query("select * from val_information where valnumber=\""+valnumber+"\"");
}
String STR_FORMAT = "00000000";
DecimalFormat df = new DecimalFormat(STR_FORMAT);
valnumber=df.format(valinfocount);
//get acceptno
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
Date d=new Date();
acceptno = sdf.format(d);
//get factryindex
String select_factoryinfo="select * from userfactory";
ResultSet rs_select_factoryinfo=null;
rs_select_factoryinfo=connect.query(select_factoryinfo);
int factoryinfocount=0;
while(rs_select_factoryinfo.next()){
	factoryinfocount++;
}
factoryinfocount++;
ResultSet rs_select_factoryindex=connect.query("select * from userfactory where factoryindex=\""+factoryindex+"\"");
while(rs_select_valnum.next()){
	factoryinfocount++;
	rs_select_factoryindex=connect.query("select * from userfactory where factoryindex=\""+factoryindex+"\"");
}
factoryindex=df.format(factoryinfocount);
sendtime=acceptno;
String add_valinformation="insert into val_information values('"+productno+"','"+manufacture+"','"+valnumber+"','"+valvecate+"','"+media+"',"+diapress+","+diameter+","+valdiameter+","+requiredpress+",'"+pressgrade+"',"+outputtime+",'"+revise+"','"+manucode+"',"+designpress+","+designtemper+","+valvepno+","+reseatpress+",'"+inportvalve+"','"+svalve+"','"+groupnum+"')";
String add_userfactory="insert into userfactory values('"+factoryindex+"','"+factory+"','"+address+"','"+postcode+"','"+contact+"','"+telephone+"')";
String add_checkorder="insert into checkorder values('"+acceptno+"','"+valnumber+"','"+factoryindex+"','"+equipindex+"','"+appearance+"',"+sendtime+",'"+standard+"','"+reportno+"',"+requireddrawtime+")";
String add_willbesaved="insert into willbesaved values('"+productno+"','"+manufacture+"','"+valnumber+"')";

out.println(factoryindex);
out.println(valnumber);
out.println(acceptno);
out.println(add_valinformation);
out.println(add_userfactory);
out.println(add_checkorder);

int flag_add_valinformation=0;
int flag_add_userfactory=0;
int flag_add_checkorder=0;
int flag_add_willbesaved=0;
ResultSet rs_select_factory=connect.query("select * from userfactory where factory=\""+factory+"\"");
int f=0;
while(rs_select_factory.next()){
	f=1;
	%><script>alert("数据库已存在该使用单位")</script><%
	break;
	}
int flag=0;
String ss=null;
if(f==0){
	flag_add_userfactory=connect.addquery(add_userfactory);
	}
flag_add_valinformation=connect.addquery(add_valinformation);
flag_add_checkorder=connect.addquery(add_checkorder);
flag_add_willbesaved=connect.addquery(add_willbesaved);
if((flag_add_userfactory+flag_add_valinformation+flag_add_checkorder+flag_add_willbesaved)!=0)  
{ 
	ss="插入成功";  
}else{  
	ss="插入失败";  
	}
PrintWriter pw=response.getWriter();
response.setContentType("html/text");
pw.write(ss);
pw.close();

%>

</body>
</html>