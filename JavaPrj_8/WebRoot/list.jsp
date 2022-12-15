<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2022/12/06
  Time: 22:31
  To change this template use File | Settings | File Templates.
--%>
<%--,weiye， yijifanye,zibankuai --%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.page.*,com.dao.*"%>
<%@ page import="com.Bean.SectionInfo" %>
<%@ taglib prefix="wld" uri="TagForDividingPage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="section_dao" class="com.dao.SectionInfoDAO" scope="request"/>
<jsp:useBean id="topic_dao" class="com.dao.TopicInfoDAO" scope="request"/>
<jsp:useBean id="reply_dao" class="com.dao.ReplyInfoDAO" scope="request"/>
<jsp:useBean id="divPage_dao" class="com.pageDividing.DivPageDAO" scope="request"/>

<c:set var="sid" scope="session" value="${requestScope.sid}"/>
<c:set var = "user" scope="session" value ="${sessionScope.users}"/>
<c:set var="sectionInfoList" scope="session" value="${section_dao.getSectionById(sid)}"/>
<c:set var="list" scope="session" value="${requestScope.listPage}"/>
${pageContext.setAttribute("page_sid",sid)}
<jsp:useBean id="sectioninfo_dao" class="com.dao.SectionInfoDAO" scope="request"/>

<html>
<head>
	<meta charset="UTF-8">
	<title>企业论坛--帖子列表 </title>
	<link href="style/showlogin.css" rel="stylesheet">
	<link href="style/styleSheet.css" rel="stylesheet">
	<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
	<link rel="stylesheet" type="text/css" href="style/showlogin.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
	<link  href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body style="padding-top: 100px;margin-bottom: 0;">

<jsp:include page="showLogin.jsp"/>
<!--      导航以及搜索        -->
<div class="row" align="center" style="background-color:#d9d9d9;height: 42px;">
	<div class="col-md-7">
		<ul class="nav nav-tabs sidebar" style="background-color: #d9d9d9;">
			<li><a href="index.jsp" style="color: white">论坛首页</a></li>
			<c:forEach var="info" items="${sectioninfo_dao.getNavigationMenuById(page_sid)}" varStatus="p">
				<c:if test="${p.count !=1}">
					<li>
						<a href="servletListPage?sid=${info.sid}" style="color: white">${info.sname}</a>
					</li>
				</c:if>
			</c:forEach>
			<c:forEach var="info" items="${sectioninfo_dao.getNavigationMenuById(page_sid)}" varStatus="p">
				<c:if test="${p.count eq 1}">
					<li class="active" style="background-color: #428675">
						<a href="servletListPage?sid=${info.sid}" style="color:#d9d9d9">${info.sname}</a>
						<c:set var="topicname" value="${info.sname}"/>
					</li>
				</c:if>
			</c:forEach>
			${sectioninfo_dao.clearList()}
		</ul>
	</div>
	<div class="md col-md-5" style="padding-top: 4px;padding-right: 3%">
		<form action="FindServlet?sid=${sid}" method="post">
			<input type="text" class="form-control" name="partname" placeholder="搜索...">
		</form>
	</div>
</div>
<!--      主体        -->
<div class="container">
	<!--      发表和分页       -->
	<div class="mm row">
		<div class="col-md-5" style="padding-top: 15px">
		<c:if test="${!section_dao.isParentById(sid)}">

			<A href="post.jsp?tid=0&sid=${sid}&action=post">
				<button type="button" class="ff"  name="td_post" border="0" id=td_post style="border-radius: 10px">发表话题</button>
			</A>
		</c:if>
		</div>
		<div class="col-md-7">
			<c:set var="pageSize" scope="session" value="10"/>
			<c:set var="url" scope="session" value="servletListPage?sid=${sid}"/>
			<c:set var="pageNo" scope="session" value="${sessionScope.pageNo}"/>
			<!--divPage_dao-->

			<c:if test="${sectioninfo_dao.isParentById(sid)}">
				<wld:divPage pageSize="${pageSize}" pageNo="${pageNo}" url="${url}" recordCount="${divPage_dao.getSectionCountInfoSid(sid)}"/>
				<c:set var="thisPage" scope="session" value="${divPage_dao.CreatSectionInfoPageInfoSid(sid,pageNo,pageSize)}"/>
			</c:if>

			<c:if test="${!sectioninfo_dao.isParentById(sid)}">
				<wld:divPage pageSize="${pageSize}" pageNo="${pageNo}" url="${url}" recordCount="${divPage_dao.getTopicCountInfoSid(sid)}"/>
				<c:set var="thisPage" scope="session" value="${divPage_dao.CreatListPageInfoSid(sid,pageNo,pageSize)}"/>
			</c:if>
		</div>
	</div>

	<c:if test="${sectionInfoList.size() gt 0}">
	<TABLE>
		<TR>
			<Th style="WIDTH: 100%;background-color: #e0f0f9;COLOR: #004c7d; padding: 5px 7px 3px;" colSpan="4">
				<SPAN>&nbsp;子 版 块</SPAN></Th>
		</TR>
		<tr style="height: 50px;background-color:#b2d7b5 ;border-style: solid;border-color: #b2d7b5;border-width: medium">
			<td>&nbsp;</td>
			<td style="WIDTH: 60%" align="center">论坛</td>
			<td style="WIDTH: 20%" align="center">主题</td>
			<td style="WIDTH: 20%" align="center">最后发表</td>
		</tr>
		<c:forEach var="topic" items="${sectionInfoList}" varStatus="floor">
			<tr style="height: 40px;border-style: solid;border-color: #dbdbdb;border-width: medium">
			<td><img src="image/ban.png" alt="logo" style="height: 35px;"></td>
				<td style="FONT-SIZE: 15px;">
					<A href="servletListPage?sid=${topic.getSid()}" style="color: #818a89">${topic.getSname()}</A>
				</td>
			<td align="center" style="color: #818a89">
					${topic.getStopiccount()}
			</td>
			<th>
				<c:set var="temp1" value="${topic_dao.getALLTopicLastTimeById(sId)}"/>
				<c:set var="temp2" value="${reply_dao.getAllReplyLastTimeById(sId,tId)}"/>
				<c:if test="${not empty temp1}">
					<c:if test="${not empty temp2}">

						<%--显示同一版块所有帖子最后跟帖的记录--%>
						<span><A href="servletDetailPage?tid=${temp2.tid}
						&sid=${sId}>&action=showDetail">${temp2.title}</A></span><br/>
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
					<c:if test="${empty temp1}">
						<span>从未</span>
					</c:if>
				</c:if>
			</th>
		</tr>
		</c:forEach>
	</TABLE>
	</c:if>

	<c:if test="${!section_dao.isParentById(sid)}">
	<!-- 主帖 -->
		<div class="row" style="height:500px;">
			<div class="col-md-8">
				<table>
					<c:if test="${empty list || list.size() eq 0}">
						<tr style="height: 50px;background-color:#b2d7b5 ;border-style: solid;border-color: #b2d7b5;border-width: medium">
							<td colspan="4">暂无数据！</td>
						</tr>
					</c:if>
					<c:if test="${not empty list && list.size() ne 0}">
						<tr style="height: 50px;background-color:#b2d7b5 ;border-style: solid;border-color: #b2d7b5;border-width: medium">
							<td>&nbsp;</td>
							<td style="WIDTH: 60%" align="center">文章</td>
							<td style="WIDTH: 20%" align="center">作者</td>
							<td style="WIDTH: 20%" align="center">回复</td>
						</tr>
						<c:if test="${list.size() gt 0}">
							<c:forEach var="topic" items="${thisPage.rows}">
								<tr style="height: 40px;border-style: solid;border-color: #dbdbdb;border-width: medium">
									<td><img src="image/topicLogo.png" ></td>
									<td style="FONT-SIZE: 15px">
										<A href="servletDetailPage?tid=${topic.tid}
							&sid=${sid}&action=showDetail" style="color: #818a89">
												${topic.title}</A>

										<!--只有管理员能置顶-->
										<c:if test="${user.utype eq 2 and topic.tisTop eq false}">
											<a href="servletDetailPage?tid=${topic.tid}&sid=${sid}&action=stickTopic">[置顶]</a>
										</c:if>
										<!--只有管理员能取消置顶-->
										<c:if test="${user.utype eq 2 and topic.tisTop eq true}">
											<a href="servletDetailPage?tid=${topic.tid}&sid=${sid}&action=unstickTopic">[取消置顶]</a>
										</c:if>

									</td>
									<td align="center" style="color: #818a89">${topic.author}</td>
									<td align="center" style="color: #818a89">${topic.replycount}</td>
								</tr>
							</c:forEach>
						</c:if>
					</c:if>
				</table>
			</div>
			<c:set var="num" value="${thisPage.rows.size()*40+50}"/>
			<div class="col-md-4" align="center"
				 style="height:${num}px;overflow:hidden;background-image:url(image/4.png);opacity:0.8;display: flex;flex-direction: column;justify-content: center; align-items: center;">
				<h1 style="color: white;top:40%;right: 32%">${topicname}</h1>
			</div>
		</div>
	</c:if>
	</div>
</div>

<!--统一的尾部：版权信息-->
<jsp:include page="information.jsp"/>
	<!-- jQuery and JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
	<script type="text/javascript" src="script.js"></script>

</body>
</html>
