<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page
	import="java.sql.*,java.sql.Connection,java.sql.Statement,java.util.Formatter,javax.servlet.http.HttpServlet"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="connect" class="com.xfzhang.bean.connection"></jsp:useBean>
<%
String sql="select * from info_op_man";
ResultSet rs=null;
rs=connect.query(sql);
%>
 <input type="text" name="useraccount" placeholder="请输入账号" list="inputlist">
 <datalist id="inputlist">
 <%while(rs.next()){ %>
 <option value="<%=rs.getString("useraccount")%>"></option>
 <%}%>
 </datalist>
       <input type="text" name="userpassword" placeholder="请输入密码">  
       <input type="submit" value="提交">
</body>
</html>