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
		String s[] = request.getParameterValues("checkedid");
		String useraccount = (String) session.getAttribute("useraccount");
		if (useraccount == null) {
			PrintWriter pw = response.getWriter();
			response.setContentType("text");
			pw.write("请登入后操作");
			pw.close();
			return;
		}
		String storagelocationnum = null;
		String manindex = request.getParameter("manindex");
		String optime = null;
		String opaction = null;
		String valvolume = null;
		String valstatus = null;
		String exlocationnum = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Date d = new Date();
		int F = 0;
		int FF = 0;
		int FFF = 0;
		System.out.println(s.length);
		for (int i = 0; i < s.length; i++) {
			opaction = "T";
			valvolume = "S";
			String select = "select * from val_information where valnumber='" + s[i] + "' limit 1";
			ResultSet rs = connect.query(select);
			if (rs.next()) {
				FF = 0;
				String isqualify = rs.getString("isqualify");
				String select_valsave = null;
				if (rs.getString("groupnum") != null || !rs.getString("groupnum").equals("null")) {
					select_valsave = "select * from valsavestatusinfo where valnumber='" + rs.getString("groupnum")
							+ "' order by optime desc";
					FF = 1;
				} else {
					select_valsave = "select * from valsavestatusinfo where valnumber='" + rs.getString("valnumber")
							+ "' order by optime desc";
				}
				ResultSet rs_valsave = connect.query(select_valsave);
				if (rs_valsave.next()) {
					if (isqualify != null && isqualify.equals("no") && rs_valsave.getString("exlocationnum") != null
							&& !(rs_valsave.getString("exlocationnum").equals("null"))) {
						exlocationnum = rs_valsave.getString("exlocationnum");
						storagelocationnum = rs_valsave.getString("exlocationnum");
					} else {
						storagelocationnum = rs_valsave.getString("storagelocationnum");
					}

					optime = sdf.format(d);
					String status = rs_valsave.getString("valstatus");
					if (status.equals("N") || status.equals("C")) {
						valstatus = "C";
					} else if (status.equals("Y") || status.equals("O")) {
						valstatus = "O";
					}
					String insert = "insert into valsavestatusinfo values('" + s[i] + "','" + valvolume + "','"
							+ storagelocationnum + "','" + opaction + "','" + manindex + "','" + useraccount + "','"
							+ optime + "','" + valstatus + "'," + null + ")";
					int flag = connect.addquery(insert);
					if (flag != 0 && FF == 1) {
						String update = "update val_information set groupnum=null where valnumber='" + s[i] + "'";
						int flag_update = connect.addquery(update);
						if (flag == 0) {
							PrintWriter pw = response.getWriter();
							response.setContentType("text");
							pw.write("更新单个安全阀出组失败");
							pw.close();
							return;
						} else {
							storagelocationnum = rs_valsave.getString("storagelocationnum");
							String select_val = "select * from val_information where groupnum='"
									+ rs.getString("groupnum") + "'and isqualify='yes'";
							String select_val1 = "select * from val_information where groupnum='"
									+ rs.getString("groupnum") + "'and isqualify='no'";
							ResultSet rs_val = connect.query(select_val);
							ResultSet rs_val1 = connect.query(select_val1);
							Boolean a = !rs_val.next();
							Boolean c = !rs_val1.next();
							if (FF == 1 && exlocationnum != null && c) {
								String update_location = "update locationinfo set locationstatus=0,valorgroupnumber=null where storagelocationnum='"
										+ exlocationnum + "'";
								String insertstatus = "insert into valsavestatusinfo values('"
										+ rs.getString("groupnum") + "','" + rs_valsave.getString("valvolume")
										+ "','" + rs_valsave.getString("storagelocationnum") + "','"
										+ rs_valsave.getString("opaction") + "','"
										+ rs_valsave.getString("manindex") + "','"
										+ rs_valsave.getString("useraccount") + "','" + optime + "','"
										+ rs_valsave.getString("valstatus") + "'," + null + ")";
								System.out.println(1 + insertstatus);
								int rs_insertstatus = connect.addquery(insertstatus);
								if (rs_insertstatus == 0) {
									PrintWriter pw = response.getWriter();
									response.setContentType("text");
									pw.write("存储状态备选位置更新失败");
									pw.close();
									return;
								}
								int rs_uplocation = connect.addquery(update_location);
								
								if (rs_uplocation == 0) {
									PrintWriter pw = response.getWriter();
									response.setContentType("text");
									pw.write("存储位置更新失败");
									pw.close();
									return;
								}
							}
							if (FF == 0 || a) {
								String update_location = "update locationinfo set locationstatus=0,valorgroupnumber=null where storagelocationnum='"
										+ storagelocationnum + "'";
								System.out.println(2 + update_location);
								int rs_uplocation = connect.addquery(update_location);
								if (rs_uplocation == 0) {
									PrintWriter pw = response.getWriter();
									response.setContentType("text");
									pw.write("存储位置更新失败");
									pw.close();
									return;
								} else if (FF == 1) {
									String insertstatus = null;
									if (exlocationnum != null && rs_val1.next()) {
										insertstatus = "insert into valsavestatusinfo values('"
												+ rs.getString("groupnum") + "','"
												+ rs_valsave.getString("valvolume") + "','" + exlocationnum + "','"
												+ rs_valsave.getString("opaction") + "','"
												+ rs_valsave.getString("manindex") + "','"
												+ rs_valsave.getString("useraccount") + "','" + optime + "','"
												+ rs_valsave.getString("valstatus") + "'," + null + ")";
									} else {
										insertstatus = "insert into valsavestatusinfo values('"
												+ rs.getString("groupnum") + "','"
												+ rs_valsave.getString("valvolume") + "','" + exlocationnum + "','"
												+ opaction + "','" + manindex + "','" + useraccount + "','" + optime
												+ "','" + valstatus + "'," + null + ")";
									}
									int flag_updatestatus = connect.addquery(insertstatus);
									if (flag_updatestatus == 0) {
										PrintWriter pw = response.getWriter();
										response.setContentType("text");
										pw.write("更新组状态失败");
										pw.close();
									}
								}
							}

						}
					} else if (FF == 1) {
						PrintWriter pw = response.getWriter();
						response.setContentType("text");
						pw.write("插入存储状态失败");
						pw.close();
						return;
					}
				}
			}
			FFF = 1;
		}
		
		if (s.length > 0 && FFF == 1) {
			PrintWriter pw = response.getWriter();
			response.setContentType("text");
			pw.write("出库成功");
			pw.close();
		} else {
			PrintWriter pw = response.getWriter();
			response.setContentType("text");
			pw.write("未选择任何安全法出库");
			pw.close();
		}
		s=null;
	%>


</body>
</html>