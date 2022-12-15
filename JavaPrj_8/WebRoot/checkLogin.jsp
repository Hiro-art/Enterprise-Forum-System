<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2022/12/07
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="checkLogin" scope="session" value="${sessionScope.users}"/>
<c:if test="${empty checkLogin}">
	<jsp:forward page="login.jsp"/>
</c:if>
