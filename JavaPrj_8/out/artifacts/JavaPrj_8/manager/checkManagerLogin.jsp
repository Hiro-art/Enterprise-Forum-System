<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="com.Bean.*"%>

<%
	UserInfo checkMLogin = (UserInfo)session.getAttribute("mUsers");
	if(checkMLogin == null){
		response.sendRedirect("err.htm");
		return;
	}
 %>
