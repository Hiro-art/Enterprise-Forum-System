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
import com.page.*;

public class servletListPage extends HttpServlet {
	private ServletConfig config = null;				//初始化参数
	private TopicInfoDAO dao = new TopicInfoDAO();		//主题DAO
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
		Integer sid = Integer.parseInt(
						request.getParameter("sid"));	//获得版块编号参数
		List<ListPage> list = dao.getTopicInfoById(sid);//查询该板块下所有主题
		request.setAttribute("sid", sid);				//将版块编号保存到request范围
		request.setAttribute("listPage", list);			//将主题列表保存到request范围
		request.getRequestDispatcher("list.jsp").
							forward(request, response);	//执行请求转发
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);					//调用doGet方法
	}
	public void init(ServletConfig config) throws ServletException {
		this.config = config;							//获得初始化参数信息
	}
}
