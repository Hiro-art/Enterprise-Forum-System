package com.dao;

import com.Bean.UserInfo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BaseDAO {
	public BaseDAO() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	// 属性 --------------------------
	private Connection conn;
	private Statement stm;
	private PreparedStatement pstm;
	private ResultSet rs;

	// 获得连接--------------------------
	public Connection getConn() {
		try {
			if (conn == null || conn.isClosed()) {
				conn = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/bbs?useUnicode=yes&characterEncoding=utf8",
						"root", "2022");
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("getConnection（）错误");
		}
		return conn;
	}

	// 执行增、删、改SQL语句--------------------
	public int executeUpdate(String sql) throws SQLException {
		if (getConn() == null) {
			System.out.println("与数据库连接失败!");
			return -1;
		}
		stm = conn.createStatement();
		return stm.executeUpdate(sql);
	}

	// 重载执行增、删、改SQL语句--------------------
	public int executeUpdate(String sql, Object[] obj) throws SQLException {
		if (getConn() == null) {
			System.out.println("与数据库连接失败!");
			return -1;
		}
		pstm = conn.prepareStatement(sql);
		if (obj != null) {
			for (int i = 0; i < obj.length; i++) {
				pstm.setObject(i + 1, obj[i]);
			}
		}
		return pstm.executeUpdate();
	}

	// 执行查询SQL语句----------------------------
	public ResultSet executeQuery(String sql) throws SQLException {
		if (getConn() == null) {
			System.out.println("与数据库连接失败!");
			return null;
		}
		stm = conn.createStatement();
		rs = stm.executeQuery(sql);
		return rs;
	}

	// 重载执行查询SQL语句----------------------------
	public ResultSet executeQuery(String sql, Object[] obj) throws SQLException {
		if (getConn() == null) {
			System.out.println("与数据库连接失败!");
			return null;
		}
		pstm = conn.prepareStatement(sql);
		if (obj != null) {
			for (int i = 0; i < obj.length; i++) {
				pstm.setObject(i + 1, obj[i]);
			}
		}
		rs = pstm.executeQuery();
		return rs;
	}

	// 关闭ResultSet
	public void closeResultSet() {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	// 关闭Connection
	public void closeConnection() {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	// 关闭Statement和PreparedStatement
	public void closeStatement() {
		if (stm != null) {
			try {
				stm.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		if (pstm != null) {
			try {
				pstm.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
