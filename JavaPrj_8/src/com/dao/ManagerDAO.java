package com.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Bean.SectionInfo;

/**
 * 管理员数据访问对象
 */
public class ManagerDAO {

	private BaseDAO dao = new BaseDAO();
	private ResultSet rs = null;
	private List<SectionInfo> cList = new ArrayList<SectionInfo>();// 已对象格式保存所有版块
	private List<String> sign = new ArrayList<String>();// 保存分割符号图片
	private List<String> allList = new ArrayList<String>();// 以字符串格式保存所有版块的名字
	/*
	 * 树形列表图片文件
	 */
	// 根节点图片
	private final String rootImage = "<img src=\"image/tplus.gif\" width=\"19\" height=\"20\" align=\"absmiddle\">"
			+ "<img src=\"image/folders.gif\" width=\"16\" height=\"16\" align=\"absmiddle\">";
	// 第一个根节点图片
	private final String firstRootImage = "<img src=\"image/rplus.gif\" width=\"19\" height=\"20\" align=\"absmiddle\">"
			+ "<img src=\"image/folders.gif\" width=\"16\" height=\"16\" align=\"absmiddle\">";
	// 最后一个根节点图片
	private final String lastRootImage = "<img src=\"image/lplus.gif\" width=\"19\" height=\"20\" align=\"absmiddle\">"
			+ "<img src=\"image/folders.gif\" width=\"16\" height=\"16\" align=\"absmiddle\">";

	// 子节点图片
	private final String leafImage = "<img src=\"image/tminus.gif\" width=\"19\" height=\"20\" align=\"absmiddle\">"
			+ "<img src=\"image/folder.gif\" width=\"16\" height=\"16\" align=\"absmiddle\">";
	// 最后一个子节点图片
	private final String lastLeafImage = "<img src=\"image/lminus.gif\" width=\"19\" height=\"20\" align=\"absmiddle\">"
			+ "<img src=\"image/folder.gif\" width=\"16\" height=\"16\" align=\"absmiddle\">";

	// 空白图片
	private final String noexpandImage = "<img src=\"image/noexpand.gif\" width=\"19\" height=\"20\" align=\"absmiddle\">";
	// 竖线图片
	private final String iImage = "<img src=\"image/i.gif\" width=\"19\" height=\"20\" align=\"absmiddle\">";
	// 小箭头图片
	private final String arrow = "<img src=\"image/cal_nextMonth.gif\" width=\"5\" height=\"9\">";

	/* ---------------四个按钮--------------------- */

	// 添加按钮
	private final String addBt = "<input onClick=\"javascript:window.location.href=\'addSection.jsp\'\" type=\"button\" value=\"  添加\" style=\"background-image:url(image/add.gif); background-repeat:no-repeat; width:50px; height:18px;\">";
	// 编辑按钮
	private final String sEditBt = "&nbsp;<input onClick=\"javascript:window.location.href=\'editSection.jsp?sid=";
	private final String eEditBt = "\'\" type=\"button\" value=\"  编辑\" style=\"background-image:url(image/submit.gif); background-repeat:no-repeat; width:50px; height:18px;\">";
	// 删除按钮
	private final String sDelBt = "&nbsp;<input onClick=\"javascript:if(confirm(\'删除该版块所有主题\\n是否要删除？\')){window.location.href=\'../ServletManager?action=del&sid=";
	private final String eDelBt = "\';}else{return false;}\" type=\"button\" value=\"  删除\" style=\"background-image:url(image/del.gif); background-repeat:no-repeat; width:50px; height:18px;\">";
	// 移动按钮
	private final String sMoveBt = "&nbsp;<input onClick=\"javascript:window.location.href=\'moveSection.jsp?sid=";
	private final String eMoveBt = "\'\" type=\"button\" value=\"  移动\" style=\"background-image:url(image/del.gif); background-repeat:no-repeat; width:50px; height:18px;\">";

	/**
	 * 根据id，获得它的父版块信息
	 *
	 * @param id
	 *            版块编号
	 * @return SectionInfo 返回一个对象
	 */
	public SectionInfo getPSectionById(Integer id) {
		SectionInfo section = null;
		String sql = "select * from sectionInfo where sId = ?";
		try {
			rs = dao.executeQuery(sql, new Object[] { id });
			if (rs != null && rs.next()) {
				section = new SectionInfo();

				section.setSid(rs.getInt("sId"));
				section.setSmasterid(rs.getInt("sMasterId"));
				section.setSname(rs.getString("sName"));
				section.setSparentid(rs.getInt("sParentId"));
				section.setStopiccount(rs.getInt("sTopicCount"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return section;
	}

	/**
	 * 根据版块id，获得所有子版块
	 *
	 * @param sId
	 *            版块编号
	 * @return List<SectionInfo> 返回一个集合
	 */
	public List<SectionInfo> getSectionById(Integer sId) {
		List<SectionInfo> list = new ArrayList<SectionInfo>();
		String sql = "select * from sectionInfo where sparentId = ?";
		try {
			rs = dao.executeQuery(sql, new Object[] { sId });
			while (rs != null && rs.next()) {
				SectionInfo section = new SectionInfo();

				section.setSid(rs.getInt("sId"));
				section.setSmasterid(rs.getInt("sMasterId"));
				section.setSname(rs.getString("sName"));
				section.setSparentid(rs.getInt("sParentId"));
				section.setStopiccount(rs.getInt("sTopicCount"));
				list.add(section);
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
	 * 判断对象是否在所有同级版块中的最后一个
	 *
	 * @param obj
	 *            要比较的SectionInfo对象
	 * @return Boolean 返回一个布尔型 true：是 false：否
	 */
	public Boolean isLastNode(SectionInfo obj) {
		SectionInfo section = null;
		String sql = "select top 1 * from sectionInfo where sparentId = ? order by sid desc";
		try {
			rs = dao.executeQuery(sql, new Object[] { obj.getSparentid() });
			if (rs != null && rs.next()) {
				section = new SectionInfo();

				section.setSid(rs.getInt("sId"));
				section.setSmasterid(rs.getInt("sMasterId"));
				section.setSname(rs.getString("sName"));
				section.setSparentid(rs.getInt("sParentId"));
				section.setStopiccount(rs.getInt("sTopicCount"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		// 如果是最后一个节
		if (obj.getSid() == section.getSid()) {
			return true;
		}
		return false;
	}

	/**
	 * 根据id，递归获得根节点
	 *
	 * @param id
	 */
	private void traverseRootNodeById(Integer id) {//
		// 带前导图片的
		SectionInfo parent = this.getPSectionById(id);// 获得当前节点的父节点
		if (parent != null && parent.getSparentid() == 0) {
			this.sign.add(iImage);// 添加竖线
		} else if (parent != null && parent.getSparentid() != 0) {// 如果是根节点，就跳出递归
			Integer result = this.getParentCount(parent.getSparentid());// 获得同级父节点的个数
			if (this.isLastNode(parent) || result == 1) {
				this.sign.add(noexpandImage);// 添加空格
			} else if (result > 1) {
				this.sign.add(iImage);// 添加竖线
			}

			id = parent.getSparentid();

			traverseRootNodeById(id);// 递归
		}
		return;
	}

	/**
	 * 根据id，递归获得空格符号
	 *
	 * @param id
	 *            版块编号
	 * @param blank
	 *            HTML格式的空格符
	 * @return String 返回空格字符串
	 */
	public String traverseRootNodeById(Integer id, String blank) {//
		// 带前导&nbsp;的
		String str = "";
		SectionInfo parent = this.getPSectionById(id);// 获得当前节点的父节点
		if (parent != null && parent.getSparentid() == 0) {
			str += blank;// 添加竖线
		} else if (parent != null && parent.getSparentid() != 0) {
			str += blank;
			id = parent.getSparentid();
			return str + traverseRootNodeById(id, blank);// 递归
		}
		return str;
	}

	/**
	 * 根据id，获得同级节点的个数
	 *
	 * @param id
	 *            版块编号
	 * @return Integer 返回一个整型
	 */
	private Integer getParentCount(Integer id) {
		String sql = "select count(*) as tt from sectionInfo where sparentId = ?";
		Integer result = 0;
		try {
			rs = dao.executeQuery(sql, new Object[] { id });
			if (rs != null && rs.next()) {
				result = rs.getInt("tt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return result;
	}

	/**
	 * 根据根版块的结果集list，按层级关系获得所有子版块
	 *
	 * @param listParent
	 *            父节点的结果集
	 * @return List<String> 返回一个集合
	 */
	public List<String> getAllSectionByList(List<SectionInfo> listParent) {
		int sParentId = -1;		//父版块编号
		Boolean flag = false;// 为最后一个根节点做记号
		String image = "";	//图片信息
		String name = "";	//名称信息

		for (int i = 0; i < listParent.size(); i++) {//遍历所有的父版块
			sParentId = listParent.get(i).getSid();	//获得父版块编号
			if (i == 0) {							//第一个根节点
				image = firstRootImage;				//设置其图片信息
			} else if (i == listParent.size() - 1) {// 最后一个根节点
				flag = true;						//设置为最后一个
				image = lastRootImage;				//设置图片信息
			} else {
				image = rootImage;
			}
			name = "<a href=\"../servletListPage?sid="
			+ listParent.get(i).getSid() + "\" target=\"_blank\">"
			+ listParent.get(i).getSname() + "</a>";//设置版块名称信息
			allList.add("<div onMouseOver=\"this.style.backgroundColor=\'#7DDFFF\'\"" +
						" onMouseOut=\"this.style.backgroundColor=\'#FFFFFF\'\">"
						+ image + "&nbsp;"+ name
						+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
						+ arrow + addBt+ sEditBt+ listParent.get(i).getSid()
						+ eEditBt+ sDelBt+ listParent.get(i).getSid()+ eDelBt
						+ sMoveBt+ listParent.get(i).getSid() + eMoveBt + "</div>");
			this.getAllLeafById(sParentId, flag);// 获得当前版块下的所有子版块
		}
		return allList;
	}

	/**
	 * 根据根版块的结果集list，按层级关系获得所有子版块对象
	 *
	 * @param listParent
	 *            父节点的结果集
	 * @return List<SectionInfo> 返回一个结果集
	 */
	public List<SectionInfo> getAllSectionObjByList(List<SectionInfo> listParent) {
		// 带前导&nbsp;的
		int sParentId = -1;

		for (int i = 0; i < listParent.size(); i++) {// 获得根节点对象（父版块）

			sParentId = listParent.get(i).getSid();

			// System.out.println("根节点：" + listParent.get(i).getSname());

			this.cList.add(listParent.get(i));// 块节点放入泛型
			this.getAllLeafById(sParentId);// 获得当前根节点下的所有子节点
		}
		return this.cList;
	}

	/**
	 * 根据版块id，递归获得当前根节点下的所有子节点
	 *
	 * @param sId
	 *            版块id
	 * @param flag
	 *            是否最后一个根节点
	 * @param isLastNode
	 *            是否最后一个节点 false：未知的 true：确定的 注意:在不确定的情况下请使用false
	 */
	private void getAllLeafById(Integer sId, Boolean flag) {
		List<SectionInfo> list = this.getSectionById(sId);//获得当前版块下所有子版块
		String image = "";								//图片信息
		String signStr = "";							//分割符字符串
		String name = "";								//版块名称信息
		if (list.size() == 0) {							//如果子版块数目为0
			return;
		}
		for (int i = 0; i < list.size(); i++) {
			sId = list.get(i).getSid();					//获得版块编号信息
			this.sign.clear(); 							//初始化分割符图片
			signStr = ""; 								//初始化分割符字符串
			traverseRootNodeById(list.get(i).getSparentid());//获得分割符
			if (i == list.size() - 1) {					//是否是最后一个版块
				image = lastLeafImage;					//设置图片信息
			} else {
				image = leafImage;						//设置图片信息
			}
			if (flag && this.sign.size() != 0) {		//格式化分割符
				this.sign.set(this.sign.size() - 1, noexpandImage);
			}
			for (int j = this.sign.size(); j > 0; j--) {//倒序遍历sign符号数组
				signStr += this.sign.get(j - 1);
			}
			name = "<a href=\"../servletListPage?sid=" + list.get(i).getSid()
					+ "\" target=\"_blank\">&nbsp;" + list.get(i).getSname()
					+ "</a>";							//设置编号名称信息
			allList.add("<div onMouseOver=\"this.style.backgroundColor=\'#7DDFFF\'\" " +
					"onMouseOut=\"this.style.backgroundColor=\'#FFFFFF\'\">"
					+ signStr + image + name
					+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
					+ arrow + addBt + sEditBt + list.get(i).getSid() + eEditBt
					+ sDelBt + list.get(i).getSid() + eDelBt + sMoveBt
					+ list.get(i).getSid()+ eMoveBt+ "</div>");//添加版块节点信息
			getAllLeafById(sId, flag);				//调用自身，执行递归
		}

	}

	/**
	 * 根据版块id，递归获得当前根节点下的所有子节点
	 *
	 * @param sId
	 *            版块id
	 */
	private void getAllLeafById(Integer sId) {
		// 带前导&nbsp;的
		List<SectionInfo> list = this.getSectionById(sId);// 获得当前节点下全部子节点

		if (list.size() == 0) {
			return;
		}
		for (int i = 0; i < list.size(); i++) {
			sId = list.get(i).getSid();
			cList.add(list.get(i));// 版块节点放入泛型
			getAllLeafById(sId);// 再次调用自己（递归)
		}

	}

	/**
	 * 添加版块
	 *
	 * @param sParentId
	 *            父版块编号
	 * @param sName
	 *            版块名
	 * @return Boolean 返回一个布尔型
	 */
	public Boolean addSection(Integer sParentId, String sName,String uName) {
		String sql = "select uId from userInfo where " +
						"uName = ?";//根据用户名来查找用户编号
		Integer sMasterId = 0;//初始化用户编号
		try {
			rs = dao.executeQuery(sql,
						new Object[] { uName });//执行查询
			if(rs.next()) {//如果能够查找到记录
				sMasterId = rs.getInt("uId");//设置用户编号
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		Integer result = -1;
		sql = "insert into sectionInfo(sName,sParentId,sMasterId)" +
				" values(?,?,?)";//插入SQL语句
		try {
			result = dao.executeUpdate(sql, new Object[]
			                { sName, sParentId,sMasterId});//执行插入
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();//关闭结果集
			dao.closeStatement();//关闭处理对象
			dao.closeConnection();//关闭连接对象
		}
		return result > 0 ? true : false;
	}

	/**
	 * 根据版块id获得版块信息
	 *
	 * @param sId
	 *            版块编号
	 * @return SectionInfo 返回一个对象
	 */
	public SectionInfo getSectionNameById(Integer sId) {
		String sql = "select * from sectionInfo where sid = ?";
		SectionInfo obj = null;
		try {
			rs = dao.executeQuery(sql, new Object[] { sId });
			if (rs != null && rs.next()) {
				obj = new SectionInfo();
				obj.setSid(rs.getInt("sId"));
				obj.setSmasterid(rs.getInt("sMasterId"));
				obj.setSname(rs.getString("sName"));
				obj.setSparentid(rs.getInt("sParentId"));
				obj.setStopiccount(rs.getInt("sTopicCount"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();
			dao.closeStatement();
			dao.closeConnection();
		}
		return obj;
	}

	/**
	 * 修改版块信息
	 *
	 * @param sId
	 *            版块编号
	 * @param sName
	 *            版块名
	 * @return Boolean 返回一个布尔型
	 */
	public Boolean updateSectionInfoById(Integer sId, String sName,String uName) {
		String sql = "select uId from userInfo where " +
									"uName = ?";//根据用户名来查找用户编号
		Integer sMasterId = 0;//初始化用户编号
		try {
			rs = dao.executeQuery(sql,
				new Object[] { uName });//执行查询
			if(rs.next()) {//如果能够查找到记录
				sMasterId = rs.getInt("uId");//设置用户编号
			}
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		sql = "update sectionInfo set sName = ?," +
					"sMasterId = ? where sId = ?";//更新SQL语句
		Integer result = 0;							//更新记录数
		try {
			result = dao.executeUpdate(sql,
					new Object[] { sName,sMasterId, sId });//执行更新
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();//关闭结果集
			dao.closeStatement();//关闭处理对象
			dao.closeConnection();//关闭连接对象
		}
		return result > 0 ? true : false;	//返回是否成功
	}

	/**
	 * 把源版块作为目标版块的子版块
	 *
	 * @param sourceSid
	 *            原版块编号
	 * @param targetSid
	 *            目标版块编号
	 * @return Boolean 返回一个布尔型 true:成功
	 */
	public Boolean moveToChildSectionInfoById(Integer sourceSid,
			Integer targetSid) {
		if (sourceSid == targetSid) {// 自身不能移动
			return false;
		}
		String sql = "update sectionInfo set sParentId = ? where sid = ?";
		Integer result = 0;
		try {
			result = dao.executeUpdate(sql,
					new Object[] { targetSid, sourceSid });
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
	 * 把源版块作为根版块
	 *
	 * @param sourceSid
	 *            原版块编号
	 * @return Boolean 返回一个布尔型 true:成功
	 */
	public Boolean moveToRootSectionInfoById(Integer sourceSid) {
		String sql = "update sectionInfo set sParentId = 0 where sid = ?";
		Integer result = 0;
		try {
			result = dao.executeUpdate(sql, new Object[] { sourceSid });
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
	 * 根据版块id，判断是否含有子节点
	 *
	 * @param sid
	 *            版块编号
	 * @return Boolean 返回一个布尔型 true：是
	 */
	public Boolean isHaveChildNode(Integer sid) {
		String sql = "select * from sectionInfo" +
				" where sParentId = ?";//查询指定编号下的子版块
		try {
			rs = dao.
				executeQuery(sql,new Object[]{sid});//执行查询
			if (rs != null && rs.next()) {	//如果存在记录
				return true;				//返回true
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();//关闭结果集
			dao.closeStatement();//关闭处理对象
			dao.closeConnection();//关闭连接对象
		}
		return false;
	}

	/**
	 * 根据版块id，删除所有主帖和跟帖
	 *
	 * @param sid
	 *            版块编号
	 * @return Boolean 返回一个布尔型 true：成功
	 */
	public Boolean delSectionInfo(Integer sid) {
		String sql1 = "delete from replyInfo where rSid = ?";// 先删除跟帖记录
		String sql2 = "delete from topicInfo where tSid = ?";// 再删除主帖记录
		String sql3 = "delete from sectionInfo where sid = ?";// 最后删除版块记录
		Integer result = 0;
		try {
			result = dao.executeUpdate(sql1,new Object[] { sid });//执行跟帖记录删除
			result = dao.executeUpdate(sql2, new Object[] { sid });//执行主贴记录删除
			result = dao.executeUpdate(sql3, new Object[] { sid });//执行版块记录删除
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();//关闭结果集
			dao.closeStatement();//关闭处理对象
			dao.closeConnection();//关闭连接对象
		}
		return result > 0 ? true : false;
	}
	//TODO 锁定解锁用户功能还在做

	/**
	 * 封禁用户
	 * @param uid 用户id
	 * @return Boolean 返回一个布尔型 true：成功
	 */
	public Boolean lockUser(Integer uid)
	{
		String sql = "update userinfo SET uActive = \'0\' WHERE uid =?";
		Integer result = 0;
		try {
			result = dao.executeUpdate(sql,new Object[] { uid });
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();//关闭结果集
			dao.closeStatement();//关闭处理对象
			dao.closeConnection();//关闭连接对象
		}
		return result > 0 ? true : false;
	}

	/**
	 * 解封用户
	 * @param uid 用户id
	 * @return Boolean 返回一个布尔型 true：成功
	 */
	public Boolean unlockUser(Integer uid)
	{
		String sql = "update userinfo SET uActive = \'1\' WHERE uid =?";
		Integer result = 0;
		try {
			result = dao.executeUpdate(sql,new Object[] { uid });
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.closeResultSet();//关闭结果集
			dao.closeStatement();//关闭处理对象
			dao.closeConnection();//关闭连接对象
		}
		return result > 0 ? true : false;
	}

	public static void main(String[] args) {
		// 变量声明
		SectionInfoDAO section_dao = new SectionInfoDAO();
		ManagerDAO manager_dao = new ManagerDAO();
		List<SectionInfo> clist = null;
		String blank = "";
		//
		List<SectionInfo> listParent = section_dao.getSectionById(0);
		clist = manager_dao.getAllSectionObjByList(listParent);
		// 先获得所有节点对象
		for (int i = 0; i < clist.size(); i++) {

			// 根据对象的spid 获得版块名
			blank = manager_dao.traverseRootNodeById(clist.get(i)
					.getSparentid(), "&bnsp;");
			System.out.println(blank + clist.get(i).getSname());
		}

	}
}
