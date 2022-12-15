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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="imb" uri="TagForImage" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>欢迎访问论坛首页！</title>
	<link rel="stylesheet" type="text/css" href="style/styleSheet.css">
	<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
	<link rel="stylesheet" type="text/css" href="style/showlogin.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
	<link  href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body style="padding-top: 100px;">

<!--统一的头部： 用户信息、登录、注册  -->
<jsp:include page="showLogin.jsp"/>

<div class="imgset">
	<img src="image/topicpage3.png" alt="topic" style="height:40%;width:100%;opacity:0.8">
</div>

<jsp:useBean id="user_dao" class="com.dao.UserInfoDAO" scope="request"/>
<jsp:useBean id="common_dao" class="com.dao.CommonDAO" scope="request"/>
<jsp:useBean id="section_dao" class="com.dao.SectionInfoDAO" scope="request"/>
<jsp:useBean id="reply_dao" class="com.dao.ReplyInfoDAO" scope="request"/>
<jsp:useBean id="topic_dao" class="com.dao.TopicInfoDAO" scope="request"/>

<c:set var="img" value="image/topicpage2.png"/>

<div class="container" >

	<c:forEach var="listParent" items="${section_dao.getSectionById(0)}" varStatus="num">

		<div>
			<div class="row parentSection">
				<!--栅格系统-->
				<div class="col-8">
					<imb:sectionImage num="${num.index}"/>
				</div>

				<div class="col-4 parentSectionColor">
					<h1 class="sectionTitle">
						<a href="servletListPage?sid=${listParent.sid}" class="sectionHerf">
								${listParent.sname}</a>
					</h1>
				</div>
			</div>
		</div>

		<div>
			<c:set var="sParentId" value="${listParent.sid}"/>
			<c:forEach var="listChild" items="${section_dao.getSectionById(sParentId)}">

				<div class="row sonSection">
					<!--栅格系统-->
					<div class="col-4 sonSectionColor">
						<h3 class="sectionTitle">
							<a href="servletListPage?sid=${listChild.sid}" class="sectionHerf">
									${listChild.sname}</a></h3>
					</div>

					<div class="col-8 form-inline sonSectionDetail">
						<div style="left:5%;position: absolute;">
							总主题数：<strong>${listChild.getStopiccount()}</strong>
						</div>
						<div style="left:60%;position: absolute;">
							<c:set var="sId" value="${listChild.sid}"/>
							<c:set var="temp1" value="${topic_dao.getALLTopicLastTimeById(sId)}"/>
							<c:set var="temp2" value="${reply_dao.getAllReplyLastTimeById(sId,tId)}"/>

							<c:if test="${not empty temp1}">
								<c:if test="${not empty temp2}">
									<span><A href="servletDetailPage?tid=${temp2.tid}
													&sid=${sId}>&action=showDetail" class="topicHerf">
											${temp2.title}</A></span>
									<br/>
									<span>${temp2.author}</span>
									<span class="gray">
										[ ${common_dao.getDateFormat(temp2.publishtime)}]</span>
								</c:if>
								<c:if test="${empty temp2}">
									<SPAN><A href="servletDetailPage?tid=${temp1.tid}
													&sid=${sId}&action=showDetail" class="topicHerf">${temp1.title}</A></SPAN>
									<br/>
									<span>${temp1.author}</span>
									<span class="gray">
										[ ${common_dao.getDateFormat(temp1.publishtime)}]</span>
								</c:if>

							</c:if>
							<c:if test="${empty temp1}">
								<span>还未发布过主题！</span>
							</c:if>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</c:forEach>
</div>

<br/>

<!--统一的尾部：版权信息-->
<jsp:include page="information.jsp"/>

<!-- jQuery and JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="script.js"></script>

</body>
</html>