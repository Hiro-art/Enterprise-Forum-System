package com.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.Bean.*;

/**
 * 普通用户数据访问对象
 */
public class UserInfoDAO {
	private BaseDAO dao = new BaseDAO();

	/**
	 * 创建注册用户
	 * 
	 * @param userName
	 *            用户名
	 * @param passWord
	 *            密码
	 * @param sex
	 *            性别
	 * @param userFace
	 *            头像图片名
	 * @return boolean 返回true表示注册成功
	 */
	public boolean checkReg(String userName, String passWord, boolean sex,
			String userFace) {
		String sql = "insert into userInfo(uName,uPassWord,uSex,uFace,uRegTime) values(?,?,?,?,now())";//加了注册日期
		int result = -1;
		try {
			result = dao.executeUpdate(sql, new Object[] { userName, passWord,
					sex, userFace });
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeStatement();
			dao.closeConnection();
		}
		return result > 0 ? true : false;
	}

	// 测试
	public UserInfo getUserInfoByID(int uid) {
		UserInfo user = new UserInfo();
		String sql = "select * from userInfo where uId=?";
		ResultSet rs = null;
		try {
			rs = dao.executeQuery(sql, new Object[] { uid });
			if (rs != null && rs.next()) {
				user.setUid(rs.getInt("uId"));
				user.setUname(rs.getString("uName"));
				user.setUpassword(rs.getString("uPassWord"));
				user.setUsex(rs.getBoolean("uSex"));
				user.setUface(rs.getString("uFace"));
				user.setUregtime(rs.getDate("uRegTime"));
				user.setUtype(rs.getInt("uType"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return user;
	}

	/**
	 * 根据用户编号修改信息
	 * @param uid 用户编号
	 * @param userName 用户名
	 * @param passWord 用户密码
	 * @param sexType 用户性别
	 * @param state 用户状态
	 * @param userFace 用户头像
	 * @return 布尔值
	 */
	public boolean updateUser(String uid,String userName,String passWord,boolean sexType,boolean state,String userFace){
		String sql = "update userInfo set uName=? , uPassWord=? , uSex = ? ,uFace=? ,uActive=? where uId=?";
		int result = -1;
		try {
			result = dao.executeUpdate(sql, new Object[] { userName, passWord,
					sexType, userFace,state,uid });
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeStatement();
			dao.closeConnection();
		}
		return result > 0 ? true : false;
	}


	/**
	 * 根据id删除用户
	 * @param uid
	 * @return
	 */
	public boolean deleteUser(String uid){
		String sql = "delete from userInfo where uId=?";
		int result = -1;
		try {
			result = dao.executeUpdate(sql, new Object[] { uid });
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeStatement();
			dao.closeConnection();
		}
		return result > 0 ? true : false;
	}
	/**
	 * 检查用户登录名和密码
	 * 
	 * @param userName
	 *            用户名
	 * @param passWord
	 *            密码
	 * @return boolean 返回true表示用户合法
	 */
	public boolean checkLogin(String userName, String passWord) {
		String sql = "select * from userInfo where uName=? and uPassWord=? ";
		ResultSet rs = null;
		try {
			rs = dao.executeQuery(sql, new Object[] { userName, passWord, });
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			return (rs != null && rs.next()) ? true : false;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return false;
	}

	/**
	 * 根据用户名，获得用户信息
	 * 
	 * @param userName
	 *            用户名
	 * @return UserInfo 返回一个对象
	 */
	public UserInfo getUserInfo(String userName) {
		UserInfo user = new UserInfo();
		String sql = "select * from userInfo where uName=?";
		ResultSet rs = null;
		try {
			rs = dao.executeQuery(sql, new Object[] { userName });
			if (rs != null && rs.next()) {

				user.setUid(rs.getInt("uId"));
				user.setUname(rs.getString("uName"));
				user.setUpassword(rs.getString("uPassWord"));
				user.setUsex(rs.getBoolean("uSex"));
				user.setUface(rs.getString("uFace"));
				user.setUregtime(rs.getDate("uRegTime"));
				user.setUtype(rs.getInt("uType"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return user;
	}

	/**
	 * 根据用户类型id，获得名称
	 * 
	 * @param id
	 *            用户类型编号
	 * @return 返回用户类型名称
	 */
	public String getUserTypeNameById(Integer id) {
		switch (id) {
		case 0:
			return "会员";
		case 1:
			return "版主";
		case 2:
			return "管理员";
		}
		return "";
	}

	/**
	 * 根据布尔值获得性别名称
	 * 
	 * @param sex
	 *            布尔值 true：男 false：女
	 * @return 返回性别名
	 */
	public String getSexName(Boolean sex) {
		return sex ? "男" : "女";
	}
}
