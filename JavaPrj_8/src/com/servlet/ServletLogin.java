package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.dao.*;
import com.Bean.*;

public class ServletLogin extends HttpServlet {

	private UserInfoDAO udao = new UserInfoDAO();
	private ServletConfig config;
	private UserInfo user = null;

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");	//获得action参数
		if ("exit".equals(action.toLowerCase())){
			//用户主动注销，那么不用再保存Cookies
			Cookie[] cookies1 = request.getCookies();
			for(Cookie cookie:cookies1)
			{
				if(cookie.getName().equals("username"))
				{
					cookie.setMaxAge(0);
					response.addCookie(cookie);  //设置失效
				}
				else if(cookie.getName().equals("passwd"))
				{
					cookie.setMaxAge(0);
					response.addCookie(cookie); //设置失效
				}
			}

			//重定向到登录界面
			request.getSession().removeAttribute("users");
			response.sendRedirect("login.jsp");
		}
//		this.doPost(request,response);

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
		Cookie[] cookies = request.getCookies();
		HttpSession session = request.getSession();//用户登录会话开始


		user = udao.getUserInfo(userName);
		for (Cookie cookie2:cookies){
			if(cookie2.getName().equals("username")) {
				user = udao.getUserInfo(cookie2.getValue());
			}
		}

		String real_passwd = udao.getUserInfo(userName).getUpassword();

		if (real_passwd.equals(passWord)) {

			//设置session username属性表示用户已经登录
			request.getSession().setAttribute("username", user.getUname());

			//检查用户是否选择自动登录
			//如果选择了自动登录，则需要保存cookies

			if("on".equals(request.getParameter("remember")))
			{
//				int saveTime = Integer.parseInt(request.getParameter("maxage"));
//				saveTime =24*60*60*saveTime;
				Cookie user_cookie = new Cookie("username", user.getUname());
				Cookie passwd_cookie = new Cookie("passwd", user.getUpassword());
				user_cookie.setMaxAge(2*3600);
				passwd_cookie.setMaxAge(2*3600);
				response.addCookie(user_cookie);
				response.addCookie(passwd_cookie);

			}else {//如果没有选择自动登录

				for(Cookie cookie:cookies)
				{
					if(cookie.getName().equals("username"))
					{
						cookie.setMaxAge(0);
						response.addCookie(cookie);  //添加生成的新的cookie
					}
					else if(cookie.getName().equals("passwd"))
					{
						cookie.setMaxAge(0);
						response.addCookie(cookie);  //添加生成的新的cookie
					}
				}

			}

			session.setAttribute("users", user);
			session.setMaxInactiveInterval(2 * 3600);  // Session保存两小时
			//重定向到后台界面
			out.print("<script>alert('登录成功! 当前在线用户是：<"+userName+">');window.location.href='index.jsp'</script>");

		} else {
			out.print("<script>" + "alert('用户名或者密码错误');"
					+ "window.history.back();" + "</script>");
		}

	}

	public void init(ServletConfig config) throws ServletException {
		this.config = config;
	}

}