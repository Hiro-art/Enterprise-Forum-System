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

<c:set var = "user" scope="session" value ="${sessionScope.users}"/>
<!--每次引入该页面都询问session才行-->
<c:if test="${empty user}">
	您尚未登录 <a href="${pageContext.request.contextPath}/login.jsp">登录</a>&nbsp;| &nbsp;<A href="${pageContext.request.contextPath}/reg.jsp">注册</A>|
</c:if>
<c:if test="${not empty user}">
	欢迎:&nbsp;${sessionScope.users.uname}&nbsp;<a href="ServletManager?action=exit">[退出]</a>
	<c:if test="${user.utype eq '2'}">
		<a href="${pageContext.request.contextPath}/manager/login.jsp">[管理]</a>
	</c:if>
</c:if>
