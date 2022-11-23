package com.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.entity.*;
import com.page.*;

public class ReplyInfoDAO {

	private BaseDAO dao = new BaseDAO();
	private ResultSet rs = null;

	/**
	 * 根据当前版块id，获得同一版块下所有主帖的最后一条跟帖记录
	 * 
	 * @param sId
	 *            版块编号
	 * @param tId
	 *            主帖编号
	 * @return IndexPage 返回一个对象
	 */
	public IndexPage getAllReplyLastTimeById(Integer sId, Integer tId) {
		IndexPage index_page = null;
		String sql = "select (select uName from userInfo where userInfo.uId= tb.rUid ) as author,rTopic as title,rPublishTime as publishTime,rTid as tid"
				+ " from "
				+ " (select * from replyInfo where rPublishTime =(select max(rPublishTime) from replyInfo where rSid = ? and rTid = ?)) as tb";
		try {
			rs = dao.executeQuery(sql, new Object[] { sId, tId });
			if (rs != null && rs.next()) {
				index_page = new IndexPage();
				//
				index_page.setAuthor(rs.getString("author"));
				index_page.setPublishtime(rs.getTimestamp("publishTime"));
				index_page.setTid(rs.getInt("tid"));
				index_page.setTitle(rs.getString("title"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return index_page;
	}

	/**
	 * 根据主帖id获得跟帖用户信息的集合
	 * 
	 * @param tid
	 *            主帖编号
	 * @return List<DetailPage> 返回一个集合
	 */
	public List<DetailPage> getReplyInfoAndUserInfoById(Integer tid) {
		List<DetailPage> list = null;
		String sql = "select rTopic,rContents,rPublishTime,rModifyTime,rId,rUid,"
				+ "(select uName from  userInfo where userInfo.uid = replyInfo.ruid) as rName,"
				+ "(select uFace from  userInfo where userInfo.uid = replyInfo.ruid) as rFace,"
				+ "(select uRegTime from  userInfo where userInfo.uid = replyInfo.ruid) as rRegTime,"
				+ "(select uType from  userInfo where userInfo.uid = replyInfo.ruid) as rUserType,"
				+ "(select uSex from  userInfo where userInfo.uid = replyInfo.ruid) as rUsex"
				+ " from replyInfo where rtid in (?) order by rPublishTime";
		try {
			rs = dao.executeQuery(sql, new Object[] { tid });
			if (rs != null) {
				list = new ArrayList<DetailPage>();
				while (rs.next()) {
					DetailPage temp = new DetailPage();
					//
					temp.setContents(rs.getString("rContents"));
					temp.setFace(rs.getString("rFace"));
					temp.setModifytime(rs.getTimestamp("rModifyTime"));
					temp.setName(rs.getString("rName"));
					temp.setPublishtime(rs.getTimestamp("rPublishTime"));
					temp.setRegtime(rs.getDate("rRegTime"));
					temp.setTitle(rs.getString("rTopic"));
					temp.setType(rs.getInt("rUserType"));
					temp.setSex(rs.getBoolean("rUsex"));
					temp.setId(rs.getInt("rId"));
					temp.setUid(rs.getInt("rUid"));
					//
					list.add(temp);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return list;
	}

	/**
	 * 根据跟帖id，获得需要修改的信息
	 * 
	 * @param rid
	 *            跟帖编号
	 * @return ReplyInfo 返回一个对象
	 */
	public ReplyInfo getEditReplyInfoById(Integer rid) {
		ReplyInfo replyinfo = null;
		String sql = "select * from replyInfo where rid = ?";
		String content = "";
		try {
			rs = dao.executeQuery(sql, new Object[] { rid });
			if (rs != null && rs.next()) {
				replyinfo = new ReplyInfo();
				//
				replyinfo.setRmodifytime(rs.getDate("rModifyTime"));
				replyinfo.setRpublishtime(rs.getDate("rPublishTime"));
				// <br>替换成\r\n
				content = rs.getString("rContents").replace("<br>", "\r\n");
				content = content.replace("&gt;", ">");
				content = content.replace("&lt;", "<");
				content = content.replace("&nbsp", " ");

				replyinfo.setRcontents(content);
				replyinfo.setRid(rs.getInt("rId"));
				replyinfo.setRsid(rs.getInt("rSId"));
				replyinfo.setRtid(rs.getInt("rTId"));
				replyinfo.setRtopic(rs.getString("rTopic"));
				replyinfo.setRuid(rs.getInt("rUId"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return replyinfo;
	}

	/**
	 * 根据跟帖id更新跟帖标题和内容
	 * 
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @param rid
	 *            跟帖编号
	 * @return Boolean 返回布尔型 true：表示修改成功
	 */
	public Boolean updateReplyInfoById(String title, String content, Integer rid) {
		int result = -1;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String time = sdf.format(new Date());
		// 把\r\n替换成<br>
		content = content.replace("<", "&lt;");
		content = content.replace(">", "&gt;");
		content = content.replace(" ", "&nbsp");
		content = content.replace("\r\n", "<br>");
		
		String sql = "update replyInfo set rTopic = ?,rContents = ?,rModifyTime = ? where rid = ?";
		try {
			result = dao.executeUpdate(sql, new Object[] { title, content,
					time, rid });
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return result > 0 ? true : false;
	}

	/**
	 * 根据跟帖id删除跟帖
	 * 
	 * @param rid
	 *            跟帖编号
	 * @return Boolean 返回布尔型 true：表示删除成功
	 */
	public Boolean delReplyInfoById(Integer rid) {
		int result = -1;
		String sql = "delete from replyInfo where rid = ?";
		try {
			result = dao.executeUpdate(sql, new Object[] { rid });
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return result > 0 ? true : false;
	}

	/**
	 * 插入跟帖信息
	 * 
	 * @param title
	 *            标题
	 * @param contents
	 *            内容
	 * @param tid
	 *            主帖编号
	 * @param sid
	 *            版块编号
	 * @param uid
	 *            用户编号
	 * @return Boolean 返回布尔型 true：表示插入成功
	 */
	public Boolean insertReplyInfo(String title, String content, Integer tid,
			Integer sid, Integer uid) {
		int result = -1;
		String sql = "insert into replyInfo(rTid,rSid,rUid,rTopic,rContents)"
				+ " values(?,?,?,?,?)";
		// 把\r\n替换成<br>
		content = content.replace("<", "&lt;");
		content = content.replace(">", "&gt;");
		content = content.replace(" ", "&nbsp");
		content = content.replace("\r\n", "<br>");
		
		try {
			result = dao.executeUpdate(sql, new Object[] { tid, sid, uid,
					title, content });
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return result > 0 ? true : false;
	}

	/**
	 * 根据版块id和主帖id统计主帖的回复数量
	 * 
	 * @param tid
	 *            主帖编号
	 * @param sid
	 *            版块编号
	 * @return Boolean 返回布尔型 true：表示插入成功
	 */
	public Boolean getReplyCountById(Integer tid, Integer sid) {
		int result = -1;
		String sql = "update topicInfo set tReplyCount = "
				+ " (select count(*) as replyCount from replyInfo where rTid = ? and rSid = ?) "
				+ " where tid = ?";
		try {
			result = dao.executeUpdate(sql, new Object[] { tid, sid, tid });
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return result > 0 ? true : false;
	}

	// 测试
	public static void main(String[] args) {
		ReplyInfoDAO dao = new ReplyInfoDAO();
		// Boolean x = dao.insertTopicInfo("d","d",11,1);
		// System.out.print(x);
	}
}
