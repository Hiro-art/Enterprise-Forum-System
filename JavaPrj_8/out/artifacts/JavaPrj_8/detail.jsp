<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2022/11/28
  Time: 16:35
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.page.*,com.dao.*,com.Bean.*"%>
<%@ taglib prefix="wld" uri="TagForDividingPage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<jsp:useBean id="user_dao" class="com.dao.UserInfoDAO" scope="request"/>
<jsp:useBean id="common_dao" class="com.dao.CommonDAO" scope="request"/>
<jsp:useBean id="divPage_dao" class="com.pageDividing.DivPageDAO" scope="request"/>


<%
	DetailPage topicObj = (DetailPage)request.getAttribute("topicListDetailPage");
	request.setAttribute("topicObj",topicObj);
%>

<c:set var="sid" scope="session" value="${requestScope.sid}"/>
<c:set var="tid" scope="session" value="${requestScope.tid}"/>
<c:set var="topicObj" scope="session" value="${sessionScope.topicObj}"/>
<c:set var = "user" scope="session" value ="${sessionScope.users}"/>

<html>
<head>
	<meta charset="UTF-8">
	<title>企业论坛--看帖 </title>
	<link href="style/page.css" rel="stylesheet">
	<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
	<link  href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>

<body class="container">

<div>
</div>

<!--      用户信息、登录、注册        -->

<div class="h">
	<jsp:include page="showLogin.jsp"/>
</div>

<!--      主体        -->
<div><br/>
	<!--      导航        -->
	<div>
		&gt;&gt;<b><a href="index.jsp">论坛首页</a></b><jsp:include page="navigation.jsp"/>
	</div>
	<br/>

	<!--      回复、新帖        -->
	<div>
		<a href="post.jsp?tid=${sid}&sid=${sid}&action=reply"><IMG src="image/reply.gif"  border="0" id=td_post></a>
		<a href="post.jsp?tid=${tid}&sid=${tid}&action=post"><IMG src="image/post.gif"   border="0" id=td_post></a>
	</div>


	<!-- 分页 -->
	<!--pageSize和pageNo在标签类DivPageTag设定好了-->
	<div class="divLeft">


		<c:set var="pageSize" scope="session" value="10"/>

		<c:set var="url" scope="session"
			   value="servletDetailPage?tid=${tid}&sid=${sid}&action=showDetail"/>

		<wld:divPage pageSize="${pageSize}" pageNo="${pageNo}" url="${url}" recordCount="${divPage_dao.getReplyCountInfoTid(tid)}"/>

		<c:set var="pageNo" scope="session" value="${sessionScope.pageNo}"/>
		<!--divPage_dao-->
		<c:set var="thisPage" scope="session" value="${divPage_dao.CreatDetailPageInfoTid(tid,pageNo,pageSize)}"/>


	</div>


</div>
<!--      本页主题的标题        -->
<div>
	<table cellSpacing="0" cellPadding="0" width="100%">
		<tr>
			<th class="h">本页主题: ${topicObj.title}</th>
		</tr>
		<TR class="tr2">
			<TD>&nbsp;</TD>
		</TR>
	</table>
</div>

<!--      主题        -->

<div class="t">
	<table style="BORDER-TOP-WIDTH: 0; TABLE-LAYOUT: fixed; background-color:#c1dee7">

		<tr class="tr1">
			<th style="WIDTH: 20%">
				<b>#1</b><br/>
				<b>${topicObj.author}</b><br/>
				组别：${user_dao.getUserTypeNameById(topicObj.type)}<br/>
				性别：${user_dao.getSexName(topicObj.sex)}<br/>
				<img src="image/head/${topicObj.face}" alt=""/><br/>
				注册:${topicObj.regtime}<br/>
			</th>
			<th>
				<h4>${topicObj.title}</h4>
				<div>${topicObj.contents}</div>
				<div class="tipad gray">

					发表：[${common_dao.getDateFormat(topicObj.publishtime)}]

					<!--最后修改时间-->
					<c:if test="${empty topicObj.modifytime}">
						最后修改:[${common_dao.getDateFormat(topicObj.modifytime)}]
					</c:if>

					<!--只有管理员能删除-->
					<c:if test="${user.utype eq 2}">
						<a href="servletDetailPage?tid=${tid}&sid=${sid}&action=delTopic"
						   onclick = "return confirm('确定要删除吗?');">[删除]</a>
					</c:if>

					<!--只有管理员和当前帖发帖用户能修改-->
					<c:if test="${user.utype eq 2 or user.uid eq topicObj.uid}">
						<a href="servletDetailPage?tid=${tid}&sid=${sid}
                                &action=editTopic">[修改]</a>
					</c:if>

				</div>
			</th>
		</tr>

	</table>
</div>

<!--      回复        -->
<c:if test="${thisPage.size gt 0}">

	<c:forEach var="reply" items="${thisPage.rows}" varStatus="floor">
		<div class="t">
			<table style="BORDER-TOP-WIDTH: 0px; TABLE-LAYOUT: fixed">
				<tr class="tr1">
					<th style="WIDTH: 20%">
						<b>#${(floor.index + 2)+(pageNo-1)*pageSize}</b><br/>
						<b>${reply.author}</b><br/>
						组别：${user_dao.getUserTypeNameById(reply.type)}<br/>
						性别：${user_dao.getSexName(reply.sex)}<br/>
						<img src="image/head/${reply.face}" alt=""/><br/>
						注册:${reply.regtime}<br/>
					</th>
					<th>
						<h4>${reply.title}</h4>
						<div>${reply.contents}</div>
						<div class="tipad gray">

							发表：[${common_dao.getDateFormat(reply.publishtime)}]
							发表：[${reply.publishtime}]

							<!--最后修改时间-->
							<c:if test="${empty reply.modifytime}">
								最后修改:[${common_dao.getDateFormat(reply.modifytime)}]
							</c:if>

							<!--只有管理员能删除-->
							<c:if test="${user.utype eq 2}">
								<A href="servletDetailPage?tid=${tid}&sid=${sid}&action=delReply"
								   onclick = "return confirm('确定要删除吗?');">[删除]</A>
							</c:if>

							<!--只有管理员和当前帖发帖用户能修改-->
							<c:if test="${user.utype eq 2 or user.uid eq reply.uid}">
								<A href="servletDetailPage?tid=${tid}&sid=${sid}
							&action=editTopic">[修改]</A>
							</c:if>

						</div>
					</th>
				</tr>
			</table>
		</div>
	</c:forEach>
</c:if>

</DIV>

<!--      声明        -->
<BR>
<CENTER class="gray">版权信息</CENTER>

<!-- jQuery and JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="script.js"></script>
</body>
</HTML>

