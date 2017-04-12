<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.io.*,java.sql.*,java.sql.Connection,java.sql.Statement,java.util.Formatter,java.text.ParseException,java.text.SimpleDateFormat,java.util.Calendar,java.util.Date,java.text.DecimalFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>forward测试实例</title>
</head>
<jsp:useBean id="connect" class="com.xfzhang.bean.connection" />
	<jsp:useBean id="DBcon" class="com.xfzhang.bean.DBConnection" />
<%  
    request.setCharacterEncoding("utf-8");  
    String useraccount = request.getParameter("useraccount");  
    String userpassword = request.getParameter("userpassword");
    String username = request.getParameter("username");  
    String usertelephone = request.getParameter("usertelephone");
    String sql = "insert into info_op_man values('"+useraccount+"','"+userpassword+"','"+username+"','"+usertelephone+"');"; 
    System.out.println(sql);
    int flag=0;
    try {  
        Statement state = DBcon.getConnection().createStatement();    //创建用于执行静态sql语句的Statement对象，st属局部变量     
        flag = state.executeUpdate(sql);    //执行sql查询语句，返回查询数据的结果集 
    } catch (SQLException e) {  
        System.out.println("数据库中查数据失败");  
    }   
    String ss=null;
    if(flag!= 0)  
    {  
        ss="插入成功";
    }  
    else  
    {  
        ss="插入失败";
    }  
    PrintWriter pw=response.getWriter();
		response.setContentType("html/text");
		pw.write("插入成功！");
		pw.close();
%>  
</html>