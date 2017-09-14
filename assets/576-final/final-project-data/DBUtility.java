package org.webproject.servlet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBUtility {
	private static final String Driver = "org.postgresql.Driver";
	private static final String ConnUrl = "jdbc:postgresql://localhost:5432/finalproject";
	private static final String Username = "soren";
	private static final String Password = "";
	
	//constructor
	public DBUtility() {
		
	}
	
	//connects to database; returns conection object
	private Connection connectDB() {
		Connection conn = null;
		try {
			Class.forName(Driver);
			conn = DriverManager.getConnection(ConnUrl, Username, Password);
			return conn;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	//takes sql statement and returns results object
	public ResultSet queryDB(String sql) {
		Connection conn = connectDB();
		ResultSet res = null;
		try {
			if (conn != null) {
				Statement stmt = conn.createStatement();
				res = stmt.executeQuery(sql);
				conn.close();
			}
		} catch (Exception e){
			e.printStackTrace();
		}
		return res;
	}
	
	//takes sql query and modifies the database
	public void modifyDB(String sql) {
		Connection conn = connectDB();
		try {
			if (conn != null) {
				Statement stmt = conn.createStatement();
				stmt.execute(sql);
				stmt.close();
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) throws SQLException {
		DBUtility util = new DBUtility();
		//util.modifyDB("insert into person (first_name, last_name) values ('test_user_1_fN', 'test_user_1_lN')");
		ResultSet res = util.queryDB("select * from report");
		while (res.next()) {
			System.out.println(res.getString("report_type"));
		}
	}
			

}
