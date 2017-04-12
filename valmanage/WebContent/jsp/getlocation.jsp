<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page
	import="java.io.*,java.sql.*,java.sql.Connection,java.sql.Statement,java.util.Formatter"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<jsp:useBean id="connect" class="com.xfzhang.bean.connection" />
<% 
String volum=request.getParameter("volume");
//out.println(volum);
try {
ResultSet rs=null;
String lo=new String();
if(volum.equals("S")){
	lo="select * from locationinfo where mark=1 and locationstatus=0 limit 1";
}else if(volum.equals("L")){
	lo="select * from locationinfo where mark=2 and locationstatus=0 limit 1";
}
rs=connect.query(lo);
while (rs.next()) {
		String sln=rs.getString("storagelocationnum");
		PrintWriter pw=response.getWriter();
		response.setContentType("html/text");
		pw.write(sln);
		pw.close();
}
    }catch (Exception e) {
    out.print("get data error!");
    	//e.printStackTrace();
  }

%>
	<%-- jsp:include page="connection.jsp" flush="true"></jsp:include>--%>

	<%-- <jsp:forward page="test.jsp"></jsp:forward>--%>
</body>
</body>
</html>