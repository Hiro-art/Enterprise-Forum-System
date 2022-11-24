package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.*;
import com.Bean.*;
import com.match.CheckDAO;
import com.page.*;

public class servletDetailPage extends HttpServlet {
	private ServletConfig config = null;					//配置参数
	private ReplyInfoDAO replyinfo_dao = new ReplyInfoDAO();//回复DAO
	private TopicInfoDAO topicinfo_dao = new TopicInfoDAO();//主题DAO
	private CheckDAO check_dao = new CheckDAO();			//校验处理类
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {


		/**
		 * ----------------------------------------------------------
		 */
		response.setCharacterEncoding("utf-8");
		/**
		 * ----------------------------------------------------------
		 */

		String s = config.getInitParameter("character");//获得初始化参数
		request.setCharacterEncoding(s);				//显示请求编码格式
		response.setCharacterEncoding(s);				//设置响应编码格式
		response.setContentType("text/html");			//设置响应文本类型
		PrintWriter out = response.getWriter();			//获得输出对象
		String action = (String) request.
								getParameter("action");	//获得action参数
		Integer tid = -1;								//初始化主题编号
		Integer sid = -1;								//初始化版块编号
		Integer rid = -1;								//初始化回复编号
		Integer uid = -1;								//初始化用户编号
		if ("showdetail".equals(action.toLowerCase())
				|| "showpage".equals(action.toLowerCase())) {
			tid = Integer.parseInt(
							request.getParameter("tid"));//获得主题编号
			sid = Integer.parseInt(
							request.getParameter("sid"));//获得版块编号
			List<DetailPage> replyList = replyinfo_dao
					.getReplyInfoAndUserInfoById(tid);	//获得回复列表
			DetailPage topicObj = topicinfo_dao
					.getTopicInfoAndUserInfoById(tid);	//获得主题信息
			request.setAttribute("sid", sid);			//保存版块编号
			request.setAttribute("tid", tid);			//保存主题编号
			request.setAttribute(
					"replyListDetailPage", replyList);	//保存回复列表
			request.setAttribute(
					"topicListDetailPage", topicObj);	//保存主题信息
			request.getRequestDispatcher("detail.jsp").
							forward(request,response);//请求转发到detail.jsp
		} else if ("edittopic".equals(action.toLowerCase())) {// 【获得修改主帖的内容】
			// 获得参数
			tid = Integer.parseInt(request.getParameter("tid"));
			sid = Integer.parseInt(request.getParameter("sid"));
			TopicInfo edittopic = topicinfo_dao.getEditTopicInfoById(tid);
			// 设置request对象的属性
			request.setAttribute("tid", tid);
			request.setAttribute("sid", sid);
			request.setAttribute("action", action);
			request.setAttribute("edittopic", edittopic);
			// 转发
			request.getRequestDispatcher("update.jsp").forward(request,
					response);

		} else if ("updatetopic".equals(action.toLowerCase())) {// 【修改主帖的内容】
			// 获得参数
			tid = Integer.parseInt(request.getParameter("tid"));
			sid = Integer.parseInt(request.getParameter("sid"));
			String title = (String) request.getParameter("title");
			String content = (String) request.getParameter("content");
			if (!check_dao.checkTopic(title)) {
				out.print("<script>" + "alert('标题不能为空,长度在4-20');"
						+ "window.history.back();" + "</script>");
			} else if (!check_dao.checContents(content)) {
				out.print("<script>" + "alert('内容不能为空，并且长度不大于100');"
						+ "window.history.back();" + "</script>");
			} else {
				Boolean result = topicinfo_dao.updateTopicInfoById(title,
						content, tid);
				// 判断修改成功与否
				if (result) {
					// 设置request对象的属性
					request.setAttribute("tid", tid);
					request.setAttribute("sid", sid);
					// 转发
					request.getRequestDispatcher(
							"servletDetailPage?tid=" + tid + "&sid=" + sid
									+ "&action=showDetail").forward(request,
							response);
				} else {
					out.print("<script>" + "alert('服务器忙！');"
							+ "window.history.back();" + "</script>");
				}
			}

		} else if ("editreply".equals(action.toLowerCase())) {// 【获得修改跟帖的内容】
			// 获得参数
			tid = Integer.parseInt(request.getParameter("tid"));
			sid = Integer.parseInt(request.getParameter("sid"));
			rid = Integer.parseInt(request.getParameter("rid"));
			ReplyInfo editreply = replyinfo_dao.getEditReplyInfoById(rid);
			// 设置request对象的属性
			request.setAttribute("tid", tid);
			request.setAttribute("sid", sid);
			request.setAttribute("rid", rid);
			request.setAttribute("action", action);
			request.setAttribute("editreply", editreply);
			// 转发
			request.getRequestDispatcher("update.jsp").forward(request,
					response);

		} else if ("updatereply".equals(action.toLowerCase())) {// 【修改跟帖的内容】
			// 获得参数
			tid = Integer.parseInt(request.getParameter("tid"));
			sid = Integer.parseInt(request.getParameter("sid"));
			rid = Integer.parseInt(request.getParameter("rid"));
			String title = (String) request.getParameter("title");
			String content = (String) request.getParameter("content");
			if (!check_dao.checContents(content)) {
				out.print("<script>" + "alert('内容不能为空，并且长度不大于100');"
						+ "window.history.back();" + "</script>");
			} else {
				Boolean result = replyinfo_dao.updateReplyInfoById(title,
						content, rid);
				// 判断修改成功与否
				if (result) {
					// 设置request对象的属性
					request.setAttribute("tid", tid);
					request.setAttribute("sid", sid);
					// 转发
					request.getRequestDispatcher(
							"servletDetailPage?tid=" + tid + "&sid=" + sid
									+ "&action=showDetail").forward(request,
							response);
				} else {
					out.print("<script>" + "alert('服务器忙！');"
							+ "window.history.back();" + "</script>");
				}
			}

		} else if ("deltopic".equals(action.toLowerCase())) {// 【把整个帖子删除，包含跟帖】
			// 获得参数
			sid = Integer.parseInt(request.getParameter("sid"));
			tid = Integer.parseInt(request.getParameter("tid"));
			Boolean result = topicinfo_dao.delTopicInfoById(tid);
			// 判断删除成功与否
			if (result) {
				// 设置request对象的属性
				request.setAttribute("tid", tid);
				request.setAttribute("sid", sid);
				// 转发
				request.getRequestDispatcher(
						"servletListPage?sid=" + sid + "&action=showDetail")
						.forward(request, response);
			} else {
				out.print("<script>" + "alert('服务器忙！');"
						+ "window.history.back();" + "</script>");
			}

		} else if ("delreply".equals(action.toLowerCase())) {// 【删除单个跟帖】
			// 获得参数
			sid = Integer.parseInt(request.getParameter("sid"));
			tid = Integer.parseInt(request.getParameter("tid"));
			rid = Integer.parseInt(request.getParameter("rid"));
			Boolean result = replyinfo_dao.delReplyInfoById(rid);
			// 判断删除成功与否
			if (result) {
				// 设置request对象的属性
				request.setAttribute("tid", tid);
				request.setAttribute("sid", sid);
				replyinfo_dao.getReplyCountById(tid, sid);
				// 转发
				request.getRequestDispatcher(
						"servletDetailPage?tid=" + tid + "&sid=" + sid
								+ "&action=showDetail").forward(request,
						response);
			} else {
				out.print("<script>" + "alert('服务器忙！');"
						+ "window.history.back();" + "</script>");
			}

		} else if ("reply".equals(action.toLowerCase())) {//发表主题
			sid = Integer.parseInt(request.getParameter("sid"));//版块编号
			tid = Integer.parseInt(request.getParameter("tid"));//主题编号
			uid = Integer.parseInt(request.getParameter("uid"));//用户编号
			String title = (String) request.getParameter("title");//回复标题
			String content = (String) request.getParameter("content");//回复内容
			if (!check_dao.checContents(content)) {//校验回复内容是否合法
				out.print("<script>" + "alert('内容不能为空，并且长度不大于100');"
						+ "window.history.back();" + "</script>");
			} else {
				Boolean result = replyinfo_dao.insertReplyInfo(
						title, content,tid, sid, uid);//执行插入操作
				if (result) {	//插入成功
					request.setAttribute("tid", tid);	//保存主题编号
					request.setAttribute("sid", sid);	//保存版块编号
					replyinfo_dao.getReplyCountById(tid, sid);//获得回复数目
					request.getRequestDispatcher(		//跳转到主题详细内容页
					"servletDetailPage?tid=" + tid + "&sid=" + sid
					+ "&action=showDetail").forward(request,response);
				} else {
					out.print("<script>" + "alert('服务器忙！');"
							+ "window.history.back();" + "</script>");
				}
			}
		} else if ("post".equals(action.toLowerCase())) {//发表主题
			sid = Integer.parseInt(request.getParameter("sid"));//版块编号
			uid = Integer.parseInt(request.getParameter("uid"));//用户编号
			String title = (String) request.getParameter("title");//主题标题
			String content = (String) request.getParameter("content");//主题内容
			if (!check_dao.checkTopic(title)) {//校验主题标题是否合法
				out.print("<script>" + "alert('标题不能为空,长度在4-20');"
						+ "window.history.back();" + "</script>");
			} else if (!check_dao.checContents(content)) {//校验主题内容是否合法
				out.print("<script>" + "alert('内容不能为空，并且长度不大于100');"
						+ "window.history.back();" + "</script>");
			} else {
				Boolean result = topicinfo_dao.
					insertTopicInfo(title, content,sid, uid);//执行插入操作
				if (result) {//插入成功
					request.setAttribute("sid", sid);		//保存版块编号
					topicinfo_dao.getTopicCountById(sid);	//取得版块下主题数
					request.getRequestDispatcher("servletListPage?sid=" 
						+ sid).forward(request, response);//跳转到主题列表页面
				} else {
					out.print("<script>" + "alert('服务器忙！');"
							+ "window.history.back();" + "</script>");
				}
			}
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

	public void init(ServletConfig config) throws ServletException {
		this.config = config;
	}
}
