<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2022/11/28
  Time: 14:18
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.dao.*,com.page.*"%>

<html>
<head>
	<meta charset="UTF-8">
	<title>欢迎访问论坛首页！</title>
	<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
	<link  href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body class="container">
<DIV>
</DIV>
<DIV class="h">
	<%@ include file="showLogin.jsp" %>
</DIV>

<%
	SectionInfoDAO section_dao = new SectionInfoDAO();//版块DAO
	TopicInfoDAO topic_dao = new TopicInfoDAO();	//主题DAO
	ReplyInfoDAO reply_dao = new ReplyInfoDAO();	//回复DAO
	CommonDAO common_dao=new CommonDAO();

	request.setAttribute("section_dao", section_dao); // 一定要注意加到request域中
	request.setAttribute("topic_dao", topic_dao); // 一定要注意加到request域中
	request.setAttribute("reply_dao", reply_dao); // 一定要注意加到request域中
	request.setAttribute("common_dao", common_dao); // 一定要注意加到request域中
%>

<div class="t">
	<c:forEach var="listParent" items="${section_dao.getSectionById(0)}">
		<table>
			<tr class="tr2">
				<TD colSpan="2">论坛</TD>
				<TD style="WIDTH: 10%">主题</TD>
				<TD style="WIDTH: 30%">最后发表</TD>
			</tr>
			<tr class="tr3">
				<td colspan="4">
					<a href="servletListPage?sid=${listParent.sid}">
							${listParent.sname}</a>
				</td>
			</tr>

			<c:set var="sParentId" value="${listParent.sid}"/>
			<c:forEach var="listChild" items="${section_dao.getSectionById(sParentId)}">

				<tr class="tr3">
					<td>&nbsp;</td>
					<th><img src="image/board.gif" alt="">
						<a href="servletListPage?sid=${listChild.sid}">
								${listChild.sname}</a>
					</th>
					<td >
							${listChild.getStopiccount()}
					</td>
					<th>

						<c:set var="sId" value="${listChild.sid}"/>
						<c:set var="temp1" value="${topic_dao.getALLTopicLastTimeById(sId)}"/>
						<c:set var="temp2" value="${reply_dao.getAllReplyLastTimeById(sId,tId)}"/>

						<c:if test="${not empty temp1}">
							<c:if test="${not empty temp2}">
									<span><A href="servletDetailPage?tid=${temp2.tid}
										&sid=${sId}>&action=showDetail">${temp2.title}</A></span>
								<br/>
								<span>${temp2.author}</span>
								<span class="gray">
									[ ${common_dao.getDateFormat(temp2.publishtime)}]</span>
							</c:if>
							<c:if test="${empty temp2}">
									<SPAN><A href="servletDetailPage?tid${temp1.tid}
										&sid=${sId}&action=showDetail">${temp1.title}</A></SPAN>
								<br/>
								<span>${temp1.author}</span>
								<span class="gray">
									[ ${common_dao.getDateFormat(temp1.publishtime)}]</span>
							</c:if>

						</c:if>
						<c:if test="${empty temp1}">
							<span>从未</span>
						</c:if>
					</th>
				</tr>
			</c:forEach>
		</table>
	</c:forEach>
</div>

<br/>
<CENTER class="gray">
	版权信息
</CENTER>

<!-- jQuery and JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="script.js"></script>

</body>
</html>