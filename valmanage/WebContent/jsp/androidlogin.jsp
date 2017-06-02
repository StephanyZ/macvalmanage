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
	<jsp:useBean id="connect" class="com.xfzhang.bean.connection"></jsp:useBean>
	<%	request.setCharacterEncoding("UTF-8");
		ResultSet rs=null;
		String account=request.getParameter("useraccount");
		String passwd=request.getParameter("password");
		String lo="select * from workman where manindex='"+account+"'";
		rs=connect.query(lo);
		String ss="";
		out.println(lo);
		while(rs.next()) {
			String pd=rs.getString("manpassword");
			if(rs.getString("manpassword").equals(passwd)){
				ss="sucess";
			}else{				
				ss="failed";
			}
		PrintWriter pw=response.getWriter();
		response.setContentType("text");
		pw.write(ss);
		pw.close();
		}%>
	<%-- jsp:include page="connection.jsp" flush="true"></jsp:include>--%>

	<%-- <jsp:forward page="test.jsp"></jsp:forward>--%>
</body>
</html>