<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="java.io.*,java.sql.*,java.sql.Connection,java.sql.Statement,java.util.Formatter,java.text.ParseException,java.text.SimpleDateFormat,java.util.Calendar,java.util.Date,java.text.DecimalFormat"%>
<%@page import="com.google.gson.JsonArray"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="atg.taglib.json.util.JSONArray"%>
<%@page import="atg.taglib.json.util.JSONObject"%>
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
		String option = request.getParameter("option");
		String manindex = request.getParameter("manindex");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String checkedinfo = request.getParameter("checkedinfo");
		JSONArray check = new JSONArray(checkedinfo);
		Date d = new Date();
		String optime = sdf.format(d);
		String why = "&";
		if (option.equals("preoutvalve")) {
			String flag = "";
			int Flag = 0;
			int ff=0;
			String addtopre="";
			for (int i = 0; i < check.length(); i++) {
				JSONObject ob = check.getJSONObject(i);
				String ischecked = ob.getString("ischecked");
				if (ischecked.equals("true")) {
					String valorgroupnumber = ob.getString("cbvalnumber");
					String select_outstatus = "select * from valsavestatusinfo where valnumber='" + valorgroupnumber
							+ "'order by optime desc limit 1";
					ResultSet rs_select_outstatus = connect.query(select_outstatus);
					if (rs_select_outstatus.next()) {
						String valvolume = rs_select_outstatus.getString("valvolume");
						String storagelocationnum = rs_select_outstatus.getString("storagelocationnum");
						String opaction = "T";
						String exlocationnum = rs_select_outstatus.getString("exlocationnum");
						String valstatus = rs_select_outstatus.getString("valstatus");
						if(valstatus.equals("Y")){
							valstatus="O";
						}else if(valstatus.equals("N")){
							valstatus="C";
						}
						if(exlocationnum!=null){
							exlocationnum="'"+exlocationnum+"'";
						}
						addtopre= "insert into preparetochangeinfo values('" + valorgroupnumber + "','"
								+ valvolume + "','" + storagelocationnum + "','" + opaction + "','" + manindex
								+ "'," + optime + "," + exlocationnum + ",'" + valstatus + "')";
						int flag_insert = connect.addquery(addtopre);
						if (flag_insert == 0) {
							Flag = 1;
							System.out.println(addtopre);
						}

					}else{
						ff=1;
						System.out.println(select_outstatus);
					}
				}
			}
			if(Flag==1||ff==1){
				flag = "failed";
				if(Flag==1){
					why+="安全阀插入失败";
					
				}else if(ff==1){
					why+="安全阀查询失败";
				}
				flag+= why;
			}else{
				flag="sucess";
			}
			PrintWriter pw = response.getWriter();
			response.setContentType("text");
			pw.write(flag);
			pw.close();
			return;
		}

		if (option.equals("nochecksave") || option.equals("ischeckedsave")) {
			String valorgroupnumber = request.getParameter("valorgroupnumber");
			String storagelocationnum = request.getParameter("storagelocationnum");
			String opaction = request.getParameter("opaction");
			String valvolume = null;
			String exlocationnum = null;
			String flag = null;
			int Flag = 0;
			String valstatus = "";
			if (option.equals("ischeckedsave")) {
				exlocationnum = request.getParameter("exlocationnum");
				int flag_modify = 0;
				int qcount = 0;
				for (int i = 0; i < check.length(); i++) {
					JSONObject ob = check.getJSONObject(i);
					String valnumber = ob.getString("cbvalnumber");
					String modify_qualify = null;
					if (ob.getString("ischecked").equals("true")) {
						qcount++;
						modify_qualify = "update val_information set isqualify='yes' where valnumber='" + valnumber
								+ "'";
					} else if (ob.getString("ischecked").equals("false")) {
						modify_qualify = "update val_information set isqualify='no' where valnumber='" + valnumber
								+ "'";
					}
					flag_modify = connect.addquery(modify_qualify);
					if (flag_modify == 0) {
						Flag = 1;
						why += "modify qualify is error";
					}
				}
				if (qcount > 0 && qcount < check.length()) {
					if (exlocationnum == null) {
						Flag = 1;
						why += "未添加附加存储位置";
					}
				}
			}
			if (opaction.equals("S")) {
				String select_willbe = "select * from willbesaved where valorgroupnumber='" + valorgroupnumber
						+ "'";
				String select_checkedwillbe = "select * from checkedwillbesaved where valorgroupnum='"
						+ valorgroupnumber + "'";
				System.out.println(select_willbe);
				System.out.println(select_checkedwillbe);
				ResultSet rs_willbe = connect.query(select_willbe);
				ResultSet rs_checkedwillbe = connect.query(select_checkedwillbe);
				Boolean rs1 = rs_willbe.next();
				Boolean rs2 = rs_checkedwillbe.next();
				if (!rs1 && !rs2) {
					flag = "failed";
					PrintWriter pw = response.getWriter();
					response.setContentType("text");
					pw.write(flag + "&请确认填好委托书或咨询前台");
					pw.close();
					return;
				} else {
					if (!rs1) {
						valstatus = "Y";
					} else if (!rs2) {
						valstatus = "N";
					}
					String a = storagelocationnum.substring(0, 1);
					int index = Integer.parseInt(a, 10);
					if (index == 1 || index == 3 || index == 5) {
						valvolume = "S";
					} else if (index == 2 || index == 4 || index == 6) {
						valvolume = "L";
					} else {
						flag = "failed";
						PrintWriter pw = response.getWriter();
						response.setContentType("text");
						pw.write(flag + "&请确认存储位置编号为正确可使用编号");
						pw.close();
						return;
					}
					if(exlocationnum!=null){
						exlocationnum="'"+exlocationnum+"'";
					}
					String addtopre = "insert into preparetochangeinfo values('" + valorgroupnumber + "','"
							+ valvolume + "','" + storagelocationnum + "','" + opaction + "','" + manindex + "','"
							+ optime + "'," + exlocationnum + ",'" + valstatus + "')";
					System.out.println(addtopre);
					int addtopre_flag = connect.addquery(addtopre);
					if (addtopre_flag != 0 && Flag == 0) {
						flag = "sucess";
						System.out.print(flag);
						PrintWriter pw = response.getWriter();
						response.setContentType("text");
						pw.write(flag);
						pw.close();
						return;
					} else {
						flag = "failed";
						System.out.print(flag + why);
						PrintWriter pw = response.getWriter();
						response.setContentType("text");
						pw.write(flag + "&请向前台咨询添加权限问题");
						pw.close();
						return;
					}
				}
			}
		}
	%>
</body>
</html>