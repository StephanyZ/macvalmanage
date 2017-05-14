package com.xfzhang.bean;
//import java.sql.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.xfzhang.bean.DBConnection;

public class connection {
	private static Connection conn;  
    private static Statement st;  
    private static ResultSet rs;
    private static int flag;
	public static ResultSet query(String sql ) {  
        System.out.println("函数DBQuery日志");  
        if(conn == null){  
            conn = DBConnection.getConnection();    //同样先要获取连接，即连接到数据库  
            if(conn == null){  
                System.out.println("数据库连接失败" );  
                return null;  
            }  
        }  
        System.out.println("查询函数中连接到数据库数据成功"+conn);  
        try {  
            st = (Statement) conn.createStatement();    //创建用于执行静态sql语句的Statement对象，st属局部变量     
            rs = (ResultSet) st.executeQuery(sql);    //执行sql查询语句，返回查询数据的结果集 
            return rs;  
        } catch (SQLException e) {  
            System.out.println("数据库中查数据失败");  
            return null;  
        }  
         
    }  
	public static int addquery(String sql ) {  
        System.out.println("函数DBQuery日志");  
        if(conn == null){  
            conn = DBConnection.getConnection();    //同样先要获取连接，即连接到数据库  
            if(conn == null){  
                System.out.println("数据库连接失败" );  
                return 0;  
            }  
        }  
        System.out.println("插入函数中连接到数据库数据成功"+conn);  
        try {  
            st = (Statement) conn.createStatement();    //创建用于执行静态sql语句的Statement对象，st属局部变量     
            flag = (int) st.executeUpdate(sql);    //执行sql查询语句，返回查询数据的结果集 
            return flag;  
        } catch (SQLException e) {  
            System.out.println("数据库中插入数据失败");  
            return 0;  
        }          
    }
    public static void closeDB() throws SQLException{  
        if(null != rs)  
            rs.close();  
        if(null != st)  
            st.close();  
        if(null != conn)  
            conn.close();    //关闭数据库连接  
    }  
}

