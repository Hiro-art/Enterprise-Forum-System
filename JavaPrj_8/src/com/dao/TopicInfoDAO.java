package com.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.page.*;
import com.Bean.*;

/**
 * 主贴数据访问对象
 */
public class TopicInfoDAO {

	private BaseDAO dao = new BaseDAO();
	private ResultSet rs = null;

	/**
	 * 根据当前版块id，获得同一版块下所有主帖子最后发表记录
	 * 
	 * @param sId
	 *            版块id
	 * @return TopicInfo 返回一个对象
	 */
	public IndexPage getALLTopicLastTimeById(Integer sId) {
		IndexPage index_page = null;
		String sql = "select (select uName from userInfo where userInfo.uId= tb.tUid ) as author,tTopic as title,tPublishTime as publishTime,tid"
				+ " from"
				+ " (select * from topicInfo where tPublishTime =(select max(tPublishTime) from topicInfo where tSid = ?)) as tb";
		try {
			rs = dao.executeQuery(sql, new Object[] { sId });
			if (rs != null && rs.next()) {
				index_page = new IndexPage();
				//
				index_page.setAuthor(rs.getString("author"));
				index_page.setPublishtime(rs.getTimestamp("publishTime"));
				index_page.setTitle(rs.getString("title"));
				index_page.setTid(rs.getInt("tid"));
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
	 * 根据主帖id获得主帖用户信息
	 * 
	 * @param tid
	 *            主帖编号
	 * @return DetailPage 返回一个对象
	 */
	public DetailPage getTopicInfoAndUserInfoById(Integer tid) {
		DetailPage detail = null;
		String sql = "select tTopic,tContents,tPublishTime,tModifyTime,tId,tUid,"
				+ "(select uName from  userInfo where userInfo.uId = topicInfo.tuid) as tName,"
				+ "(select uFace from  userInfo where userInfo.uId = topicInfo.tuid) as tFace,"
				+ "(select uRegTime from  userInfo where userInfo.uId = topicInfo.tuid) as tRegTime,"
				+ "(select uType from  userInfo where userInfo.uId = topicInfo.tuid) as tUserType,"
				+ "(select uSex from  userInfo where userInfo.uId = topicInfo.tuid) as tSex"
				+ " from topicInfo where tid = ?";
		try {
			rs = dao.executeQuery(sql, new Object[] { tid });
			if (rs != null && rs.next()) {
				detail = new DetailPage();
				//
				detail.setContents(rs.getString("tContents"));
				detail.setFace(rs.getString("tFace"));
				detail.setModifytime(rs.getTimestamp("tModifyTime"));
				detail.setName(rs.getString("tName"));
				detail.setPublishtime(rs.getTimestamp("tPublishTime"));
				detail.setRegtime(rs.getDate("tRegTime"));
				detail.setTitle(rs.getString("tTopic"));
				detail.setType(rs.getInt("tUserType"));
				detail.setSex(rs.getBoolean("tSex"));
				detail.setId(rs.getInt("tId"));
				detail.setUid(rs.getInt("tUid"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return detail;
	}

	/**
	 * 根据版块id获得版块对应的所有主帖信息（主帖标题、作者、回复数）
	 * 
	 * @param sId
	 *            版块id
	 * @return List<ListPage> 返回一个集合
	 */
	public List<ListPage> getTopicInfoById(Integer sId) {
		String sql = "select tId,tTopic,tReplyCount,(select uName from userInfo where uid = topicInfo.tuid) as tuid "
				+ "from topicInfo where tsid = ? order by tPublishTime desc";
		List<ListPage> list = null;
		try {
			rs = dao.executeQuery(sql, new Object[] { sId });
			if (rs != null) {
				list = new ArrayList<ListPage>();
				while (rs.next()) {
					ListPage temp = new ListPage();
					temp.setAuthor(rs.getString("tUId"));
					temp.setReplycount(rs.getInt("tReplyCount"));
					temp.setTitle(rs.getString("tTopic"));
					temp.setTid(rs.getInt("tId"));
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
	 * 根据主帖id获得需要修改的信息
	 * 
	 * @param tid
	 *            主帖编号
	 * @return TopicInfo 返回一个对象
	 */
	public TopicInfo getEditTopicInfoById(Integer tid) {
		TopicInfo topicinfo = null;
		String sql = "select * from topicInfo where tid = ?";
		String content = "";
		try {
			rs = dao.executeQuery(sql, new Object[] { tid });
			if (rs != null && rs.next()) {
				topicinfo = new TopicInfo();
				//
				topicinfo.setTclickcount(rs.getInt("tClickCount"));
				// <br>替换成\r\n
				content = rs.getString("tContents").replace("<br>", "\r\n");
				content = content.replace("&gt;", ">");
				content = content.replace("&lt;", "<");
				content = content.replace("&nbsp", " ");
				
				topicinfo.setTcontents(content);
				topicinfo.setTid(rs.getInt("tId"));
				topicinfo.setTmodifytime(rs.getDate("tModifyTime"));
				topicinfo.setTpublishtime(rs.getDate("tPublishTime"));
				topicinfo.setTreplycount(rs.getInt("tReplyCount"));
				topicinfo.setTsid(rs.getInt("tSid"));
				topicinfo.setTtopic(rs.getString("tTopic"));
				topicinfo.setTuid(rs.getInt("tUid"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return topicinfo;
	}

	/**
	 * 根据主帖id更新主帖标题和内容
	 * 
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @param tid
	 *            主帖编号
	 * @return Boolean 返回一个布尔型
	 */
	public Boolean updateTopicInfoById(String title, String content, Integer tid) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String time = sdf.format(new Date());// 获得当前的时间
		int result = -1;
		// 把\r\n替换成<br>
		content = content.replace("<", "&lt;");
		content = content.replace(">", "&gt;");
		content = content.replace(" ", "&nbsp");
		content = content.replace("\r\n", "<br>");
		
		String sql = "update topicInfo set tTopic = ?,tContents = ?,tModifyTime = ? where tid = ?";
		try {
			result = dao.executeUpdate(sql, new Object[] { title, content,
					time, tid });
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
	 * 根据主帖id删除整个帖子
	 * 
	 * @param tid
	 *            主帖编号
	 * @return Boolean 返回布尔型 true：表示删除成功
	 */
	public Boolean delTopicInfoById(Integer tid) {
		int result = -1;
		String sql = "delete from topicInfo where tid = ?";
		try {
			result = dao.executeUpdate(sql, new Object[] { tid });
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
	 * 插入主帖信息
	 * 
	 * @param title
	 *            标题
	 * @param content
	 *            内容
	 * @param sid
	 *            版块编号
	 * @param uid
	 *            用户编号
	 * @return Boolean 返回布尔型 true：表示插入成功
	 */
	public Boolean insertTopicInfo(String title, String content, Integer sid,
			Integer uid) {
		int result = -1;
		String sql = "insert into topicInfo(tSid,tuid,tTopic,tContents)"
				+ " values(?,?,?,?)";
		// 把\r\n替换成<br>
		content = content.replace("<", "&lt;");
		content = content.replace(">", "&gt;");
		content = content.replace(" ", "&nbsp");
		content = content.replace("\r\n", "<br>");
		
		try {
			result = dao.executeUpdate(sql, new Object[] { sid, uid, title,
					content });
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
	 * 根据版块id统计主帖的数量
	 * 
	 * @param sid
	 *            版块id
	 * @return Boolean 返回布尔型 true：表示统计成功
	 */
	public Boolean getTopicCountById(Integer sid) {
		String sql = "update sectionInfo set sTopicCount = "
				+ " (select count(*) as topicCount from topicInfo where tsid = ?)"
				+ " where sid = ?";
		int result = -1;
		try {
			result = dao.executeUpdate(sql, new Object[] { sid, sid });
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return result > 0 ? true : false;
	}

	public ArrayList<TopicInfo> findByPartName(String partName) throws SQLException {
		dao.getConn();
		String sql = "SELECT * FROM topicInfo where tTopic like '%" + partName + "%'";
//            String sql = "SELECT * FROM topicInfo where ttopic like '%" + partName + "%'" ;

		ArrayList<TopicInfo> topicInfosnew = new ArrayList<>();
		try {
			ResultSet rs = dao.executeQuery(sql);
//			rs = dao.executeQuery(sql, new Object[] { partName });
//            if (rs != null && rs.next()) {
//                return rs.getString("uName");
//            }

//            PreparedStatement pstmt = conn.prepareStatement(sql);

			//pstmt.setObject(1,obj);
//            rs = pstmt.executeQuery();
			while(rs.next()){
				TopicInfo topicInfo = new TopicInfo();
//                Apost apost=new Apost();
//                UserInfo userInfo  = new UserInfo();
				topicInfo.setTid(rs.getInt("tId"));
//                topicInfo.setApId(rs.getInt("apId"));
				topicInfo.setTsid(rs.getInt("tSID"));
				topicInfo.setTuid(rs.getInt("tUID"));
				topicInfo.setTtopic(rs.getString("tTopic"));
				topicInfo.setTcontents(rs.getString("tContents"));
				topicInfo.setTclickcount(rs.getInt("tClickCount"));
				topicInfo.setTreplycount(rs.getInt("tReplyCount"));
				topicInfo.setTpublishtime(rs.getTimestamp("tPublishTime"));
				topicInfo.setTmodifytime(rs.getTimestamp("tModifyTime"));
//                topicInfo.setReplyTime(rs.getTimestamp("replyTime"));
//                topicInfo.setReplyCount(rs.getInt("replyCount"));
//                topicInfo.setScanCount(rs.getInt("scanCount"));
//                userInfo.setUid(rs.getInt("userId"));
//                apost.setUser(user);
//                topic.setTid(rs.getInt("topId"));
//                apost.setTopic(topic);
//                aposts.add(apost);
				topicInfosnew.add(topicInfo);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return topicInfosnew;
//		TopicInfo topicinfo = null;
//		PreparedStatement ps = conn.prepareStatement("select * FROM dept");
//		String sql = "SELECT * FROM topicInfo where tTopic like '%\" + partName + \"%'";
//		String content = "";
//		try {
//			rs = dao.executeQuery(sql, new Object[]{partName});
//			if (rs != null && rs.next()) {
//				topicinfo = new TopicInfo();
//				//
//				topicinfo.setTclickcount(rs.getInt("tClickCount"));
//				// <br>替换成\r\n
//				content = rs.getString("tContents").replace("<br>", "\r\n");
//				content = content.replace("&gt;", ">");
//				content = content.replace("&lt;", "<");
//				content = content.replace("&nbsp", " ");
//
//				topicinfo.setTcontents(content);
//				topicinfo.setTid(rs.getInt("tId"));
//				topicinfo.setTmodifytime(rs.getDate("tModifyTime"));
//				topicinfo.setTpublishtime(rs.getDate("tPublishTime"));
//				topicinfo.setTreplycount(rs.getInt("tReplyCount"));
//				topicinfo.setTsid(rs.getInt("tSid"));
//				topicinfo.setTtopic(rs.getString("tTopic"));
//				topicinfo.setTuid(rs.getInt("tUid"));
//
//				topicInfos.add(topicinfo);
//			}
//
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} finally {
//			dao.closeResultSet();
//			dao.closeStatement();
//			dao.closeConnection();
//		}
//		return topicInfos;
	}

	// 测试
	public static void main(String[] args) {
		TopicInfoDAO dao = new TopicInfoDAO();
		Boolean x = dao.insertTopicInfo("d", "d", 11, 1);
		System.out.print(x);
		// System.out.print(x);
		// System.out.print(dao.updateTopicInfoById("33", "dfdsfsdfs", 1));
	}
}
