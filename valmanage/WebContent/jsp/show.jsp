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
	if(valorgroupnumber.length()>10){
		String get_valorgroupnumber="select * from val_information where acceptno='"+valorgroupnumber+"'";
		ResultSet rs_valorgroupnumber=connect.query(get_valorgroupnumber);
		if(rs_valorgroupnumber.next()){
			valorgroupnumber=rs_valorgroupnumber.getString("valnumber");
			if(rs_valorgroupnumber.next()){
				valorgroupnumber=rs_valorgroupnumber.getString("groupnum");
			}
		}
	}
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
	if(valorgroupnumber.length()>10){
		String get_valorgroupnumber="select * from val_information where acceptno='"+valorgroupnumber+"'";
		ResultSet rs_valorgroupnumber=connect.query(get_valorgroupnumber);
		if(rs_valorgroupnumber.next()){
			valorgroupnumber=rs_valorgroupnumber.getString("valnumber");
			if(rs_valorgroupnumber.next()){
				valorgroupnumber=rs_valorgroupnumber.getString("groupnum");
			}
		}
	}
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
if(option.equals("androidshowvalinfo")){
	String acceptno=request.getParameter("acceptno");
	String select_val="select * from val_information where acceptno='"+acceptno+"'";
	ResultSet rs_select_val=connect.query(select_val);
	String ss="";
	JsonObject object=new JsonObject();
	JsonArray array=new JsonArray();
	String select_willbe="select * from willbesaved where acceptno='"+acceptno+"'";
	ResultSet rs_willbe=connect.query(select_willbe);
	String select_checkedwillbe="select * from checkedwillbesaved where acceptno='"
	+acceptno+"'";
	ResultSet rs_checkedwillbe=connect.query(select_checkedwillbe);
	String status="";
	if(rs_willbe.next()){
		status="willbesaved";
	}else if(rs_checkedwillbe.next()){
		status="checkedwillbesaved";
	}else{
		status="Cantbesaved";}
	if(rs_select_val.next()){
		JsonObject ob=new JsonObject();
		int count=0;
		count++;
		ob.addProperty("index", count);
		ob.addProperty("valnumber",rs_select_val.getString("valnumber"));
		ob.addProperty("valproductno",rs_select_val.getString("productno"));
		ob.addProperty("manufacture",rs_select_val.getString("manufacture"));
		ob.addProperty("valvecate", rs_select_val.getString("valvecate"));
		object.addProperty("valorgroup","val");
		array.add(ob);	
		while(rs_select_val.next()){
			object.addProperty("valorgroup", "group");
			count++;
			JsonObject ob1=new JsonObject();
			ob1.addProperty("index", count);
			ob1.addProperty("valnumber",rs_select_val.getString("valnumber"));
			ob1.addProperty("valproductno",rs_select_val.getString("productno"));
			ob1.addProperty("manufacture",rs_select_val.getString("manufacture"));
			ob1.addProperty("valvecate", rs_select_val.getString("valvecate"));
			array.add(ob1);	
		}
		object.addProperty("status",status);		
		object.add("values", array);
		System.out.println(object.toString());
		PrintWriter pw=response.getWriter();
		response.setContentType("text／json");
		pw.write(object.toString());
		pw.close();
	}
	
}
if(option.equals("pcshowschedule")){
	String acceptno=request.getParameter("acceptno");
	String select_val="select * from valsavestatusinfo where (valnumber in (select valnumber from val_information where acceptno='"+acceptno+"')or valnumber in(select groupnum from val_information where acceptno='"+acceptno+"')) and valstatus<>'X'order by  optime";
	ResultSet rs_select_val=connect.query(select_val);
	JsonArray array=new JsonArray();
	int count=0;
	while(rs_select_val.next()){
		count++;
		JsonObject ob1=new JsonObject();
		ob1.addProperty("index", count);
		ob1.addProperty("optime",rs_select_val.getString("optime"));
		ob1.addProperty("valnumber",rs_select_val.getString("valnumber"));
		ob1.addProperty("storagelocationnum",rs_select_val.getString("storagelocationnum"));
		ob1.addProperty("exlocationnum", rs_select_val.getString("exlocationnum"));
		ob1.addProperty("valstatus", rs_select_val.getString("valstatus"));
		array.add(ob1);	
	}
	System.out.println(array.toString());
	PrintWriter pw=response.getWriter();
	response.setContentType("text／json");
	pw.write(array.toString());
	pw.close();
	
}
if(option.equals("pcshowvalinfo")){
	String valorgroupnumber=request.getParameter("valorgroupnumber");
	String select_val="select * from val_information where valnumber='"+valorgroupnumber+"'";
	System.out.println(select_val);
	String select_group="select * from val_information where groupnum='"+valorgroupnumber+"'";
	System.out.println(select_group);
	ResultSet rs_select_val=connect.query(select_val);
	ResultSet rs_select_group=connect.query(select_group);
	JsonObject object=new JsonObject();
	JsonArray array=new JsonArray();
	Boolean a=rs_select_val.next();
	Boolean b=rs_select_group.next();
	System.out.println(a+"&&"+b);
	if(a){
		JsonObject ob=new JsonObject();
		int count=0;
		count++;
		ob.addProperty("index", count);
		ob.addProperty("valnumber",rs_select_val.getString("valnumber"));
		ob.addProperty("valproductno",rs_select_val.getString("productno"));
		ob.addProperty("manufacture",rs_select_val.getString("manufacture"));
		ob.addProperty("valvecate", rs_select_val.getString("valvecate"));
		ob.addProperty("isqualify", rs_select_val.getString("isqualify"));
		System.out.println("val");
		array.add(ob);
	}else if(b){
		System.out.println("group");
		JsonObject ob=new JsonObject();
		int count=0;
		count++;
		ob.addProperty("index", count);
		ob.addProperty("valnumber",rs_select_group.getString("valnumber"));
		ob.addProperty("valproductno",rs_select_group.getString("productno"));
		ob.addProperty("manufacture",rs_select_group.getString("manufacture"));
		ob.addProperty("valvecate", rs_select_group.getString("valvecate"));
		ob.addProperty("isqualify", rs_select_group.getString("isqualify"));
		array.add(ob);	
		System.out.println(ob.toString());
		while(rs_select_group.next()){
			count++;
			JsonObject ob1=new JsonObject();
			ob1.addProperty("index", count);
			ob1.addProperty("valnumber",rs_select_group.getString("valnumber"));
			ob1.addProperty("valproductno",rs_select_group.getString("productno"));
			ob1.addProperty("manufacture",rs_select_group.getString("manufacture"));
			ob1.addProperty("valvecate", rs_select_group.getString("valvecate"));
			ob1.addProperty("isqualify", rs_select_group.getString("isqualify"));
			array.add(ob1);	
		}
	}
	System.out.println(object.toString());
	PrintWriter pw=response.getWriter();
	response.setContentType("text／json");
	pw.write(array.toString());
	pw.close();
	
}
if(option.equals("getvolume")){
	String valorgroupnumber=request.getParameter("valorgroupnumber");
	String select="select * from checkedwillbesaved where acceptno='"+valorgroupnumber+"'";
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
	String acceptno=null;
	if(valorgroupnumber.length()>10){
		acceptno=valorgroupnumber;
		String get_valorgroupnumber="select * from val_information where acceptno='"+acceptno+"'";
		ResultSet rs_valorgroupnumber=connect.query(get_valorgroupnumber);
		if(rs_valorgroupnumber.next()){
			valorgroupnumber=rs_valorgroupnumber.getString("valnumber");
			if(rs_valorgroupnumber.next()){
				valorgroupnumber=rs_valorgroupnumber.getString("groupnum");
			}
		}
	}
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
			System.out.println(sln);
			JsonObject ob=new JsonObject();
			if(s!=null){
				ob.addProperty("qlocation",sln);
			}
			if(s==null){
				ob.addProperty("ulocation",sln);
			}	
			ob.addProperty("valorgroupnumber",valorgroupnumber);
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
		System.out.println(ucount+ulocation+valorgroupnumber);
		JsonObject ob=new JsonObject();
		ob.addProperty("qlocation",qlocation);
		ob.addProperty("ulocation",ulocation);
		ob.addProperty("ucount",ucount);
		ob.addProperty("valorgroupnumber",valorgroupnumber);
		
		PrintWriter pw=response.getWriter();
		response.setContentType("text／json");
		pw.write(ob.toString());
		pw.close();
		
		
	}
	
}
if(option.equals("androidshowvaloutinfo")){
	String valorgroupnumber=request.getParameter("valorgroupnumber");
	String acceptno=null;
	if(valorgroupnumber.length()>10){
		acceptno=valorgroupnumber;
		String getnum="select * from checkorder where acceptno='"+valorgroupnumber+"'";
		ResultSet rs_getnum=connect.query(getnum);
		if(rs_getnum.next()){
			valorgroupnumber=rs_getnum.getString("valnumber");
		}
	}
	String selectsaveinfo=null;
	String checkorder=null;
	JsonArray valoutinfo=new JsonArray();
	if(valorgroupnumber.substring(0,1).equals("g")){
		selectsaveinfo="select * from valsavestatusinfo where valnumber='"+valorgroupnumber+"'order by optime desc limit 1";
		checkorder="select * from checkorder where valnumber='"+valorgroupnumber+"'";
		String selectval="select * from val_information where groupnum='"+valorgroupnumber+"'";
		ResultSet rs_selectval=connect.query(selectval);
		ResultSet rs_checkorder=connect.query(checkorder);
		ResultSet rs_saveinfo=connect.query(selectsaveinfo);
		//System.out.println(checkorder);
		if(rs_checkorder.next()&&rs_saveinfo.next()){
		while(rs_selectval.next()){
			if(!rs_selectval.getString("isvalid").equals("no")){
			JsonObject val=new JsonObject();
			val.addProperty("valnumber", rs_selectval.getString("valnumber"));
			//System.out.println(rs_checkorder.getString("acceptno"));
			val.addProperty("acceptno", rs_checkorder.getString("acceptno"));
			if(rs_saveinfo.getString("exlocationnum")==null||rs_selectval.getString("isqualify").equals("yes")){
				val.addProperty("location",rs_saveinfo.getString("storagelocationnum"));
			}else{
				val.addProperty("location",rs_saveinfo.getString("exlocationnum"));
			}
			val.addProperty("optime",rs_saveinfo.getString("optime"));
			val.addProperty("isqualify",rs_selectval.getString("isqualify"));
			val.addProperty("mark", "group");
			valoutinfo.add(val);
			}
		}
		}
	}else{
		String selectval="select * from val_information where valnumber='"+valorgroupnumber+"'";
		System.out.println(selectval);
		ResultSet rs_val=connect.query(selectval);
		JsonObject val=new JsonObject();
		if(rs_val.next()){
			if(rs_val.getString("groupnum")!=null){
				selectsaveinfo="select * from valsavestatusinfo where valnumber='"+rs_val.getString("groupnum")+"'";
				checkorder="select * from checkorder where valnumber='"+rs_val.getString("groupnum")+"'";
				val.addProperty("mark", "groupsingle");			
			}else{
				selectsaveinfo="select * from valsavestatusinfo where valnumber='"+valorgroupnumber+"'";
				checkorder="select * from checkorder where valnumber='"+valorgroupnumber+"'";
				val.addProperty("mark", "single");
			}
			ResultSet rs_saveinfo=connect.query(selectsaveinfo);
			ResultSet rs_checkorder=connect.query(checkorder);
			if(rs_saveinfo.next()&&rs_checkorder.next()){
				val.addProperty("valnumber", valorgroupnumber);
				val.addProperty("acceptno", rs_checkorder.getString("acceptno"));
				if(rs_saveinfo.getString("exlocationnum")==null||rs_val.getString("isqualify").equals("yes")){
					val.addProperty("location",rs_saveinfo.getString("storagelocationnum"));
				}else{
					val.addProperty("location",rs_saveinfo.getString("exlocationnum"));
				}
				val.addProperty("optime",rs_saveinfo.getString("optime"));
				val.addProperty("isqualify",rs_val.getString("isqualify"));
				valoutinfo.add(val);
			}			
		}
	}
	PrintWriter pw=response.getWriter();
	response.setContentType("text／json");
	pw.write(valoutinfo.toString());
	pw.close();	
}

%>

</body>
</html>