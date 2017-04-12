<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.sql.*,java.sql.Connection,java.sql.Statement,java.util.Formatter"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>安全阀管理系统</title>
</head>
<body>
	<jsp:useBean id="connect" class="com.xfzhang.bean.connection"></jsp:useBean>
	<jsp:useBean id="user" class="com.xfzhang.bean.userinfo" ></jsp:useBean>
	<%
	try {
		ResultSet rs=null;
		String account=request.getParameter("useraccount");
		String passwd=request.getParameter("password");
		String lo="select * from info_op_man where useraccount=\""+account+"\"";
		rs=connect.query(lo);
		
		while (rs.next()) {
			String pd=rs.getString("userpassword");
		System.out.println(pd);
		if(rs.getString("userpassword").equals(passwd)){
			String useraccount=rs.getString("useraccount");
			String username=rs.getString("username");
			String usertelephone=rs.getString("usertelephone");
			String usepassword=rs.getString("userpassword");
			session.setAttribute("useraccount",useraccount);
			session.setAttribute("username",username);
			session.setAttribute("usertelephone",usertelephone);%>
	<jsp:forward page="homepage.jsp"></jsp:forward>
	<%
		}else{%>
	<jsp:forward page="index.html"></jsp:forward>
	<%
		}
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