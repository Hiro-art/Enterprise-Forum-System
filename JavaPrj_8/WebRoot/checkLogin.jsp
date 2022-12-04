<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ page import="com.Bean.*"%>

<%
	UserInfo checkLogin = (UserInfo)session.getAttribute("users");
	if(checkLogin == null){
		response.sendRedirect("login.jsp");
	}
%>
