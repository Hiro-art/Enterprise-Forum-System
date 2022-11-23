<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.entity.*"%>

<%
	UserInfo showLogin = (UserInfo) session.getAttribute("users");
	if (showLogin == null) {
%> 
您尚未登录 <a href="login.jsp">登录</a>&nbsp;| &nbsp;<A href="reg.jsp">注册</A>|
<%
	} else {
%>
	欢迎:&nbsp;<%=showLogin.getUname()%>&nbsp;<a href="ServletManager?action=exit">[退出]</a>
<%
	}
	if(showLogin != null && showLogin.getUtype()==2){//用户类型 禁言用户：-1、普通会员：0、版主：1、管理员：2
%>
<a href="manager/login.jsp">[管理]</a>
<%
	}
%>