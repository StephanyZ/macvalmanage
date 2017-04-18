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
String option=request.getParameter("option");

if(option.equals("checkvalorgroup")){
	String valorgroupnumber=request.getParameter("valorgroupnumber");
	String select_val="select * from val_information where valnumber='"+valorgroupnumber+"'";
	ResultSet rs_select_val=connect.query(select_val);
	String select_group="select * from val_information where groupnum='"+valorgroupnumber+"'";
	ResultSet rs_select_group=connect.query(select_group);
	String ss="";
	while(rs_select_val.next()){
		ss+="<input type=\"checkbox\" value=\""+rs_select_val.getString("valnumber")+"\" name=\"checkisqualify\"/>";
		ss+="安全阀编制ID："+rs_select_val.getString("valnumber")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀出厂编号："+rs_select_val.getString("productno")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀制造单位："+rs_select_val.getString("manufacture")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀型号："+rs_select_val.getString("valvecate")+"<br>";
	}
	if(rs_select_group.next()){
		int count=0;
		ss+="安全阀组("+valorgroupnumber+"):<br>";
		count++;
		ss+="<input type=\"checkbox\" value=\""+rs_select_group.getString("valnumber")+"\" name=\"checkisqualify\"/>";
		ss+=count+".安全阀编制ID："+rs_select_group.getString("valnumber")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀出厂编号："+rs_select_group.getString("productno")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀制造单位："+rs_select_group.getString("manufacture")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀型号："+rs_select_group.getString("valvecate")+"<br>";
		while(rs_select_group.next()){
			count++;
			ss+="<input type=\"checkbox\" value=\""+rs_select_group.getString("valnumber")+"\" name=\"checkisqualify\"/>";
			ss+=count+".安全阀编制ID："+rs_select_group.getString("valnumber")+"<br>";
			ss+="&nbsp&nbsp&nbsp安全阀出厂编号："+rs_select_group.getString("productno")+"<br>";
			ss+="&nbsp&nbsp&nbsp安全阀制造单位："+rs_select_group.getString("manufacture")+"<br>";
			ss+="&nbsp&nbsp&nbsp安全阀型号："+rs_select_group.getString("valvecate")+"<br>";
		}
		
	}
	PrintWriter pw=response.getWriter();
	response.setContentType("text");
	pw.write(ss);
	pw.close();
}
if(option.equals("showvalorgroupinfo")){
	String valorgroupnumber=request.getParameter("valorgroupnumber");
	String select_val="select * from val_information where valnumber='"+valorgroupnumber+"'";
	ResultSet rs_select_val=connect.query(select_val);
	String select_group="select * from val_information where groupnum='"+valorgroupnumber+"'";
	ResultSet rs_select_group=connect.query(select_group);
	String ss="";
	while(rs_select_val.next()){
		ss+="安全阀编制ID："+rs_select_val.getString("valnumber")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀出厂编号："+rs_select_val.getString("productno")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀制造单位："+rs_select_val.getString("manufacture")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀型号："+rs_select_val.getString("valvecate")+"<br>";
	}
	if(rs_select_group.next()){
		int count=0;
		ss+="安全阀组("+valorgroupnumber+"):<br>";
		count++;
		ss+=count+".安全阀编制ID："+rs_select_group.getString("valnumber")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀出厂编号："+rs_select_group.getString("productno")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀制造单位："+rs_select_group.getString("manufacture")+"<br>";
		ss+="&nbsp&nbsp&nbsp安全阀型号："+rs_select_group.getString("valvecate")+"<br>";
		while(rs_select_group.next()){
			count++;
			ss+=count+".安全阀编制ID："+rs_select_group.getString("valnumber")+"<br>";
			ss+="&nbsp&nbsp&nbsp安全阀出厂编号："+rs_select_group.getString("productno")+"<br>";
			ss+="&nbsp&nbsp&nbsp安全阀制造单位："+rs_select_group.getString("manufacture")+"<br>";
			ss+="&nbsp&nbsp&nbsp安全阀型号："+rs_select_group.getString("valvecate")+"<br>";
		}
		
	}
	PrintWriter pw=response.getWriter();
	response.setContentType("text");
	pw.write(ss);
	pw.close();
}
if(option.equals("getvolume")){
	String valorgroupnumber=request.getParameter("valorgroupnumber");
	String select="select * from checkedwillbesaved where valorgroupnum='"+valorgroupnumber+"'";
	ResultSet rs_select=connect.query(select);
	if(rs_select.next()){
		String volume=rs_select.getString("valvolume");
		PrintWriter pw=response.getWriter();
		response.setContentType("text");
		pw.write(volume);
		pw.close();
	}
}

if(option.equals("getcheckedgroup")){
	request.setCharacterEncoding("UTF-8");
	String valorgroupnumber=request.getParameter("valorgroupnumber");
	String volume=request.getParameter("volume");
	String s[]=request.getParameterValues("checkedid");
	String getlocation="";
	String select="";
	select="select * from val_information where valnumber='"+valorgroupnumber+"'";
	String selectgroup="select * from val_information where groupnum='"+valorgroupnumber+"'";
	ResultSet rs_select=connect.query(select);
	ResultSet rs_selectgroup=connect.query(selectgroup);
	if(rs_select.next()){
		int flag_modify=0;
		String modify_qualify="";
		if(s!=null){
			if(volume.equals("S")){
				getlocation="select * from locationinfo where mark=5 and locationstatus=0 limit 1";
			}else if(volume.equals("L")){
				getlocation="select * from locationinfo where mark=6 and locationstatus=0 limit 1";
			}
			modify_qualify="update val_information set isqualify='yes' where valnumber='"+rs_select.getString("valnumber")+"'";
		}else if(s==null){
			if(volume.equals("S")){
				getlocation="select * from locationinfo where mark=3 and locationstatus=0 limit 1";
			}else if(volume.equals("L")){
				getlocation="select * from locationinfo where mark=4 and locationstatus=0 limit 1";
			}
			modify_qualify="update val_information set isqualify='no' where valnumber='"+rs_select.getString("valnumber")+"'";
			
		}
		flag_modify=connect.addquery(modify_qualify);
		if(flag_modify==0){
			PrintWriter pw=response.getWriter();
			response.setContentType("text");
			pw.write("更新安全阀检验结果失败！");
			pw.close();
			return;
		}
		ResultSet rs=connect.query(getlocation);
		if (rs.next()){
			String sln=rs.getString("storagelocationnum");
			JsonObject ob=new JsonObject();
			if(s!=null){
				ob.addProperty("qlocation",sln);
			}
			if(s==null){
				ob.addProperty("ulocation",sln);
			}	
			
			PrintWriter pw=response.getWriter();
			response.setContentType("text／json");
			pw.write(ob.toString());
			pw.close();
		}
	}
	else if(rs_selectgroup.next()){
		String qgetlocation="";
		String ugetlocation="";
		String qlocation="";
		String ulocation="";
		int flag_modify_group=0;
		String modify_qualify=null;
		int ucount=0;
		if(s!=null&&s.length==1){
			qgetlocation="select * from locationinfo where mark=5 and locationstatus=0 limit 1";
			modify_qualify="update val_information set isqualify='yes' where valnumber='"+s[0]+"'";
			flag_modify_group=connect.addquery(modify_qualify);
			if(!rs_selectgroup.getString("valnumber").equals(s[0])){
				ucount++;
				modify_qualify="update val_information set isqualify='no' where valnumber='"+rs_selectgroup.getString("valnumber")+"'";
				flag_modify_group=connect.addquery(modify_qualify);
			}
			while(rs_selectgroup.next()){
				if(s!=null&&!rs_selectgroup.getString("valnumber").equals(s[0])){
					ucount++;
					modify_qualify="update val_information set isqualify='no' where valnumber='"+rs_selectgroup.getString("valnumber")+"'";
					flag_modify_group=connect.addquery(modify_qualify);
				}
			}
		}else if(s!=null&&s.length>1){
			qgetlocation="select * from locationinfo where mark=6 and locationstatus=0 limit 1";
			for(int i=0;i<s.length;i++){
				modify_qualify="update val_information set isqualify='yes' where valnumber='"+s[i]+"'";
				flag_modify_group=connect.addquery(modify_qualify);
			}
			ucount=0;
			int flag=-1;
			for(int i=0;i<s.length;i++){
				if(rs_selectgroup.getString("valnumber").equals(s[i]))
					flag=1;
			}
			if(flag==-1){
				ucount++;
				modify_qualify="update val_information set isqualify='no' where valnumber='"+rs_selectgroup.getString("valnumber")+"'";
				flag_modify_group=connect.addquery(modify_qualify);
			}
			while(rs_selectgroup.next()){
				flag=-1;
				for(int i=0;i<s.length;i++){
					if(rs_selectgroup.getString("valnumber").equals(s[i]))
						flag=1;
				}
				if(flag==-1){
					ucount++;
					modify_qualify="update val_information set isqualify='no' where valnumber='"+rs_selectgroup.getString("valnumber")+"'";
					flag_modify_group=connect.addquery(modify_qualify);
				}
			}
			//旧方法，可能因为之前的纪录影响现在值的改变
			/*if(rs_selectgroup.getString("isqualify")==null||!rs_selectgroup.getString("isqualify").equals("yes")){
				ucount++;
				modify_qualify="update val_information set isqualify='no' where valnumber='"+rs_selectgroup.getString("valnumber")+"'";
				//flag_modify_group=connect.addquery(modify_qualify);
			}
			while(rs_selectgroup.next()){
				if(rs_selectgroup.getString("isqualify")==null||!rs_selectgroup.getString("isqualify").equals("yes")){
					ucount++;
					modify_qualify="update val_information set isqualify='no' where valnumber='"+rs_selectgroup.getString("valnumber")+"'";
					//flag_modify_group=connect.addquery(modify_qualify);
				}
			}*/
		}else if(s==null){
			ucount=0;
			ucount++;
			
			modify_qualify="update val_information set isqualify='no' where valnumber='"+rs_selectgroup.getString("valnumber")+"'";
			flag_modify_group=connect.addquery(modify_qualify);
			while(rs_selectgroup.next()){
				ucount++;
				modify_qualify="update val_information set isqualify='no' where valnumber='"+rs_selectgroup.getString("valnumber")+"'";
				flag_modify_group=connect.addquery(modify_qualify);
			}	
		}
		if(ucount==1){
			ugetlocation="select * from locationinfo where mark=3 and locationstatus=0 limit 1";
		}else if(ucount>1){
			ugetlocation="select * from locationinfo where mark=4 and locationstatus=0 limit 1";
		}
		if(s!=null){
			ResultSet rs_qgetlocation=connect.query(qgetlocation);
			if(rs_qgetlocation.next()){
				qlocation=rs_qgetlocation.getString("storagelocationnum");
			}
		}
		if(ucount!=0){
			ResultSet rs_ugetlocation=connect.query(ugetlocation);
			if(rs_ugetlocation.next()){
				ulocation=rs_ugetlocation.getString("storagelocationnum");
			}
		}
		JsonObject ob=new JsonObject();
		ob.addProperty("qlocation",qlocation);
		ob.addProperty("ulocation",ulocation);
		ob.addProperty("ucount",ucount);	
		
		PrintWriter pw=response.getWriter();
		response.setContentType("text／json");
		pw.write(ob.toString());
		pw.close();
		
		
	}
	
}

%>

</body>
</html>