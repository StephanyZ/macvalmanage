package com.xfzhang.bean;

import java.sql.Connection;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
public class DBConnection { 
	public static Connection getConnection() {  
	    Connection con = null;    //创建用于连接数据库的Connection对象  
	    DataSource ds = null;  
	    try {    
	        Context initContext = new InitialContext();  
	        Context envContext = (Context)initContext.lookup("java:/comp/env");  
	        ds = (DataSource)envContext.lookup("jdbc/mydb");  
	        System.out.println(ds.getConnection());  
	    } catch (Exception e1) {  
	        System.out.println("加载数据库驱动失败"+e1);     
	        return null;  
	    }// 加载Mysql数据驱动  
	    try {  
	        con = ds.getConnection();// 创建数据连接  
	        System.out.println("数据库连接成功了");     
	        return con;    //返回所建立的数据库连接  
	             
	    } catch (Exception e) {  
	        System.out.println("数据库连接失败" + e.getMessage());  
	        return null;  
	    }  
	}
}

	


