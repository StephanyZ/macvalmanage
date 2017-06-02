<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.ServletException,javax.servlet.http.HttpServlet,javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="ExportExcel" class="com.xfzhang.bean.ExportExcel" />
<body>
<% 
//HttpServletRequest requestT; 
//HttpServletResponse responseT;
String jsonStr = request.getParameter("json");  
//表格表头  
String sheaders = request.getParameter("headers");  
//表格标题名  
String title = request.getParameter("fileName");  
//表格文件名  
String fileName = request.getParameter("fileName")+".xls";
ExportExcel.export(jsonStr,sheaders,fileName,title, response, request);
%>
</body>
</html>