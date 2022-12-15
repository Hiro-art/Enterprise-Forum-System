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
<jsp:useBean id="sectioninfo_dao" class="com.dao.SectionInfoDAO" scope="request"/>

<c:set var="topicObj" value="${requestScope.topicListDetailPage}"/>
<c:set var="sid" scope="session" value="${requestScope.sid}"/>
<c:set var="tid" scope="session" value="${requestScope.tid}"/>
<c:set var="topicObj" scope="session" value="${sessionScope.topicObj}"/>
<c:set var = "user" scope="session" value ="${sessionScope.users}"/>

<html>
<head>
	<meta charset="UTF-8">
	<title>企业论坛--看帖</title>
	<link rel="stylesheet" type="text/css" href="style/styleSheet.css">
	<link rel="stylesheet" type="text/css" href="style/showlogin.css">
	<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
	<link rel="stylesheet" type="text/css" href="style/showlogin.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
	<link  href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>

<body style="padding-top: 100px;">

<!--      用户信息、登录、注册        -->
<jsp:include page="showLogin.jsp"/>

<div class="row" align="center" style="background-color:#d9d9d9;height: 42px;">
	<div class="col-md-7">
		<ul class="nav nav-tabs sidebar" style="background-color: #d9d9d9;">
			<li><a href="index.jsp" style="color: white">论坛首页</a></li>
			<c:forEach var="info" items="${sectioninfo_dao.getNavigationMenuById(sid)}" varStatus="p">
				<c:if test="${p.count !=1}">
					<li>
						<a href="servletListPage?sid=${info.sid}" style="color: white">${info.sname}</a>
					</li>
				</c:if>
			</c:forEach>
			<c:forEach var="info" items="${sectioninfo_dao.getNavigationMenuById(sid)}" varStatus="p">
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
	<div class="mm row">
		<div class="col-md-5" style="padding-top: 15px">
			<a href="post.jsp?tid=${tid}&sid=${sid}&action=reply">
				<button type="button" class="ff" id=td_post style="border-radius: 10px">回复帖子</button>
			</a>
			<a href="post.jsp?tid=${tid}&sid=${sid}&action=post">
				<button type="button" class="ff"  id=td_post style="border-radius: 10px" >发表话题</button>
			</a>
		</div>
		<div class="col-md-7">
			<c:set var="pageSize" scope="session" value="10"/>
			<c:set var="url" scope="session"
				   value="servletDetailPage?tid=${tid}&sid=${sid}&action=showDetail"/>
			<wld:divPage pageSize="${pageSize}" pageNo="${pageNo}" url="${url}" recordCount="${divPage_dao.getReplyCountInfoTid(tid)}"/>

			<c:set var="pageNo" scope="session" value="${sessionScope.pageNo}"/>
			<!--divPage_dao-->
			<c:set var="thisPage" scope="session" value="${divPage_dao.CreatDetailPageInfoTid(tid,pageNo,pageSize)}"/>
		</div>
	</div>
</div>

<!--      主题        -->
<div class="container">

	<div style="background-color:#899F9C;height: 75px;width:100% ;display:table;">
		<h4 style="display:table-cell;vertical-align:middle;color:#FFFFFF;padding-left: 20px;">
			本页主题：${topicObj.title}
		</h4>
	</div>

	<div class="row container" style="margin-bottom:30px; margin-top:20px; height:auto; padding-right: 0;">
		<!--栅格系统-->
		<div class="col-3 card"
			 style="width: 18rem;display: flex;flex-direction: column;
            justify-content: center;
            align-items: center;
            height: auto;">

			<img src="image/head/${topicObj.face}" alt="${topicObj.face}"
				 style=" width: 70%;
            height: width;
            padding-bottom: 10px;
            padding-top: 30px;">
			<div class="card-body">
				<p class="card-text" >
					<b>${topicObj.author}</b><br/>
					组别：${user_dao.getUserTypeNameById(topicObj.type)}<br/>
					性别：${user_dao.getSexName(topicObj.sex)}<br/>
					注册：${topicObj.regtime}<br/>
				</p>
			</div>
		</div>


		<div class="col-9" style="height: auto;padding-right: 0;display: flex;flex-direction: column;">

			<div class="form-inline" style="background-color: #B1D7B4;height: 50px;width:100% ;display:table; margin-bottom:15px;">
				<h5 style="display:table-cell;vertical-align:middle;color:#595959;padding-left: 20px;">
					${topicObj.title}
				</h5>
				<span class="badge badge-secondary" style="display:table-cell;vertical-align:middle;color: #FFFFFF;width: 50px;">
					#1
				</span>
			</div>

			<div style="background-color:#F2F2F2; margin-bottom:15px;height: auto;flex-grow: 90;">
				<p style="padding: 10px 25px 20px;">
					${topicObj.contents}
				</p>
			</div>


			<div class="form-inline" style="background-color:#F2F2F2;height: 50px;width: 100%;display: flex;vertical-align:middle;bottom: 0;">
				&nbsp;&nbsp;
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
					<a href="servletDetailPage?tid=${tid}&sid=${sid}&action=editTopic">[修改]</a>
				</c:if>
			</div>
		</div>
	</div>
</div>

<div class="container">
	<!--      回复        -->
	<c:if test="${thisPage.size gt 0}">
		<c:forEach var="reply" items="${thisPage.rows}" varStatus="floor">
			<div class="row container" style="margin-bottom:30px; margin-top:20px; height:auto; padding-right: 0;">
				<!--栅格系统-->
				<div class="col-3 card"
					 style="width: 18rem;display: flex;flex-direction: column;
            justify-content: center;
            align-items: center;
            height: auto;">

					<img src="image/head/${reply.face}" alt="head"
						 style=" width: 70%;
            height: width;
            padding-bottom: 10px;
            padding-top: 30px;">
					<div class="card-body">
						<p class="card-text" >
							<b>${reply.author}</b><br/>
							组别：${user_dao.getUserTypeNameById(reply.type)}<br/>
							性别：${user_dao.getSexName(reply.sex)}<br/>
							注册：${reply.regtime}<br/>
						</p>
					</div>
				</div>


				<div class="col-9" style="height: auto;padding-right: 0;display: flex;flex-direction: column;">

					<div class="form-inline" style="background-color: #B1D7B4;height: 50px;width:100% ;display:table; margin-bottom:15px;">
						<h5 style="display:table-cell;vertical-align:middle;color:#595959;padding-left: 20px;">
								${reply.title}
						</h5>
						<span class="badge badge-secondary" style="display:table-cell;vertical-align:middle;color: #FFFFFF;width: 50px;">
							#${(floor.index + 2)+(pageNo-1)*pageSize}
					</span>
					</div>

					<div style="background-color:#F2F2F2; margin-bottom:15px;height: auto;flex-grow: 90;">
						<p style="padding: 10px 25px 20px;">
								${reply.contents}
						</p>
					</div>

					<div class="form-inline" style="background-color:#F2F2F2;height: 50px;display: flex;width: 100%; vertical-align:middle;">
						&nbsp;&nbsp;
						发表：[${common_dao.getDateFormat(reply.publishtime)}]

						<!--最后修改时间-->
						<c:if test="${not empty reply.modifytime}">
							最后修改:[${common_dao.getDateFormat(reply.modifytime)}]
						</c:if>

						<!--只有管理员能删除-->
						<c:if test="${user.utype eq 2}">
							<A href="servletDetailPage?tid=${tid}&sid=${sid}&rid=${reply.id}&action=delReply"
							   onclick = "return confirm('确定要删除吗?');">[删除]</A>
						</c:if>

						<!--只有管理员和当前帖发帖用户能修改-->
						<c:if test="${user.utype eq 2 or user.uid eq reply.uid}">
							<A href="servletDetailPage?tid=${tid}&sid=${sid}&rid=${reply.id}&action=editReply">[修改]</A>
						</c:if>

					</div>
				</div>
			</div>

		</c:forEach>
	</c:if>
</div>

<!--统一的尾部：版权信息-->
<jsp:include page="information.jsp"/>

<!-- jQuery and JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="script.js"></script>
</body>
</HTML>

