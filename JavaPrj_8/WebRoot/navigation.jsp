<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.dao.*,com.page.*"%>

<jsp:useBean id="sectioninfo_dao" class="com.dao.SectionInfoDAO" scope="request"/>
<c:set var="page_sid" value="${pageContext.getAttribute('page_sid')}"/>
<c:forEach var="info" items="${sectioninfo_dao.getNavigationMenuById(page_sid)}">
	<B>>>
		<a href="servletListPage?sid=${info.sid}">${info.sname}</a>
	</B>
</c:forEach>
${sectioninfo_dao.clearList()}