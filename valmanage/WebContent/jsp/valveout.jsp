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
		String option = request.getParameter("option");
		String useraccount = (String) session.getAttribute("useraccount");
		String manindex=null;
		String opnumber = request.getParameter("opnumber");;
		String valvolume = null;
		String storagelocationnum = null;
		String status=null;
		String valstatus =null;
		String optime=null;
		String opaction = "T";
		String STR_FORMAT = "00000000";
		DecimalFormat df = new DecimalFormat(STR_FORMAT);
		if (option.equals("pc")) {
			manindex = request.getParameter("manindex");
			status = request.getParameter("status");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			Date d = new Date();
			optime= sdf.format(d);
		}else if(option.equals("android")){
			String select_info="select * from preparetochangeinfo where valorgroupnumber='"+opnumber+"'";
			ResultSet rs_select_info=connect.query(select_info);
			if(rs_select_info.next()){
				manindex=rs_select_info.getString("manindex");
				optime=rs_select_info.getString("optime");
				optime = optime.replaceAll("-","");
				optime = optime.replaceAll(" ","");
				optime=optime.replaceAll(":","");
				optime=optime.substring(0,14);
				status=rs_select_info.getString("valstatus");
			}
		}
		ResultSet rs = null;
		String savevalve = "select * from locationinfo where locationstatus=1 and valorgroupnumber='" + opnumber
				+ "'order by mark desc";
		String getinfo = "select * from valsavestatusinfo where valnumber='" + opnumber + "' order by optime desc";
		ResultSet rs_select_getinfo = connect.query(getinfo);
		if (rs_select_getinfo.next()) {
			valvolume = rs_select_getinfo.getString("valvolume");
			storagelocationnum = rs_select_getinfo.getString("storagelocationnum");
			ResultSet rs_select_save = connect.query(savevalve);
			if (status.equals("N") || status.equals("C")) {
				valstatus = "C";
			} else if (status.equals("Y") || status.equals("O")) {
				valstatus = "O";
			}
			if (rs_select_save.next()) {
				String exlocationnum =null;
				String location = rs_select_save.getString("storagelocationnum");
				String modify = "update locationinfo set locationstatus=0,valorgroupnumber=null where storagelocationnum='"
						+ location + "'";
				int flag = 0, flag1 = 0;
				flag = connect.addquery(modify);
				if (rs_select_save.next()) {
					exlocationnum = rs_select_save.getString("storagelocationnum");
					modify = "update locationinfo set locationstatus=0,valorgroupnumber=null where storagelocationnum='"
							+ exlocationnum + "'";
					flag1 = connect.addquery(modify);
				}
				int j = 0;
				if (flag!= 0) {
					if (exlocationnum != null) {
						exlocationnum = "'" + exlocationnum + "'";
					}
					if (valstatus.equals("C")) {
						String add_checkedwillbesaved = "insert into checkedwillbesaved values('" + opnumber + "','"
								+ valvolume + "')";
						j = connect.addquery(add_checkedwillbesaved);
						if (j == 0) {
							PrintWriter pw = response.getWriter();
							response.setContentType("text");
							pw.write("出库插入备存队列失败！！" + add_checkedwillbesaved);
							pw.close();
							return;
						}
					}
					String insert_out_info = "insert into valsavestatusinfo values('" + opnumber + "','" + valvolume
							+ "','" + storagelocationnum + "','" + opaction + "','" + manindex + "','" + useraccount
							+ "'," + optime + ",'" + valstatus + "'," + exlocationnum + ")";
					int rs_insert_out = connect.addquery(insert_out_info);
					if(option.equals("android")){
						String delete_pre="delete from preparetochangeinfo where valorgroupnumber='"+opnumber+"'";
						int flag_delete_pre=connect.addquery(delete_pre);
						if(flag_delete_pre==0){
							PrintWriter pw = response.getWriter();
							response.setContentType("text");
							pw.write("备选队列删除失败！" + insert_out_info);
							pw.close();
							return;
						}
					}
					if (rs_insert_out != 0) {
						PrintWriter pw = response.getWriter();
						response.setContentType("text");
						pw.write("出库成功！");
						pw.close();
					}else{
						PrintWriter pw = response.getWriter();
						response.setContentType("text");
						pw.write("出库信息插入失败");
						pw.close();
					}
				}else{
					PrintWriter pw = response.getWriter();
					response.setContentType("text");
					pw.write("存储位置更新失败！");
					pw.close();
				}
			} else {
				PrintWriter pw = response.getWriter();
				response.setContentType("text");
				pw.write("出库失败！");
				pw.close();
			}
		} else {
			PrintWriter pw = response.getWriter();
			response.setContentType("text");
			pw.write("系统未录入该安全阀编号或组号，请重新输入！");
			pw.close();
		}
	%>

</body>
</html>