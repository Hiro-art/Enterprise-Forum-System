<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2022/11/27
  Time: 20:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ page import="com.Bean.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="title fixed-top form-inline" style="display: flex;" >
	<img src="image/logo.png" alt="logo" style="height: 100%;">
	<c:set var = "user" scope="session" value ="${sessionScope.users}"/>
<!--每次引入该页面都询问session才行-->
	<div style="color: white;padding-bottom:10px;">
	<c:if test="${empty user}">
		<h1 class="font-weight-bold" style="color:white;">您尚未登录 </h1>
		<a href="${pageContext.request.contextPath}/login.jsp" style="color: white;" >登录</a>&nbsp;| &nbsp;<A href="${pageContext.request.contextPath}/reg.jsp" style="color: white">注册</A>
	</c:if>
	<c:if test="${not empty user}">
	<h1 class="font-weight-bold" style="color:white;">Welcome!&nbsp;${sessionScope.users.uname}&nbsp;
	</h1>
		<a href="ServletLogin?action=exit" style="color: white;">[退出]</a>
		&nbsp;|&nbsp;
	<c:if test="${user.utype eq '2'}">
		<a href="${pageContext.request.contextPath}/manager/login.jsp" style="color: white;">[管理]</a>
	</c:if>
	</c:if>
	</div>
</div>
