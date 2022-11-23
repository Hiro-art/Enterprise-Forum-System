package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.*;
import com.entity.*;

public class ServletLogin extends HttpServlet {

	private UserInfoDAO udao = new UserInfoDAO();
	private ServletConfig config;
	private UserInfo user = null;
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String s = config.getInitParameter("character");
		//
		/**
		 * ----------------------------------------------------------
		 */
		response.setCharacterEncoding("utf-8");
		/**
		 * ----------------------------------------------------------
		 */
		request.setCharacterEncoding(s);
		response.setCharacterEncoding(s);
		response.setContentType("text/html");

		PrintWriter out = response.getWriter();
		//
		String userName = request.getParameter("uName");
		String passWord = request.getParameter("uPass");
		out.print(userName + "<br>" + passWord);

		if (udao.checkLogin(userName, passWord)) {
			user = udao.getUserInfo(userName);
			HttpSession session = request.getSession();//用户登录会话开始
			session.setAttribute("users", user);
			out.println("<h1>" + "登录！" + "</h1>");
			response.sendRedirect("index.jsp");
		} else {
			out.print("<script>" + "alert('用户名或者密码错误');"
					+ "window.history.back();" + "</script>");
		}

	}

	public void init(ServletConfig config) throws ServletException {
		this.config = config;
	}

}
