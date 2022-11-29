package com.servlet;

import com.dao.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.match.*;

public class ServletReg extends HttpServlet {

	private UserInfoDAO udao = new UserInfoDAO();
	private ServletConfig config;
	private CheckDAO check_dao = new CheckDAO();

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String userName = "";
		String passWord = "";
		String passWord1 = "";
		String sex = "";
		boolean sexType = false;
		String userFace = "";
		String s = config.getInitParameter("character");


		/**
		 * ----------------------------------------------------------
		 */
		response.setCharacterEncoding("utf-8");
		/**
		 * ----------------------------------------------------------
		 */


		response.setContentType("text/html");
		request.setCharacterEncoding(s);
		response.setCharacterEncoding(s);
		PrintWriter out = response.getWriter();
		//
		userName = request.getParameter("uName");
		passWord = request.getParameter("uPass");
		passWord1 = request.getParameter("uPass1");// 重复密码
		// 验证用户名和密码长度
		if (userName == null || passWord == null || passWord1 == null) {
			out.print("<script>" + "alert('用户名或者密码不能为空');"
					+ "window.history.back();" + "</script>");
			return;
		}
		if (!check_dao.checkUserName(userName)) {
			out.print("<script>" + "alert('用户名只能输入中文、数字、字母，长度为3-10');"
					+ "window.history.back();" + "</script>");
			return;
		}
		if (check_dao.checkUserNameIsExist(userName)) {
			out.print("<script>" + "alert('用户名已经存在');"
					+ "window.history.back();" + "</script>");
			return;
		}
		if (!check_dao.CheckUserPassWord(passWord)) {
			out.print("<script>" + "alert('密码只能输入数字、字母，长度为3-20');"
					+ "window.history.back();" + "</script>");
			return;
		}
		if (!passWord.equals(passWord1)) {
			out.print("<script>" + "alert('2次密码不一样');"
					+ "window.history.back();" + "</script>");
			return;
		}
		sex = request.getParameter("gender");
		if (sex.equals("1")) {// 女
			sexType = true;
		} else {// 男
			sexType = false;
		}
		userFace = request.getParameter("head");
		//
		if (udao.checkReg(userName, passWord, sexType, userFace)) {
			//
			out.println("注册成功！");
			response.sendRedirect("login.jsp");
		} else {
			//
			out.println("注册失败！");
		}
	}

	public void init(ServletConfig config) throws ServletException {
		this.config = config;
	}
}
