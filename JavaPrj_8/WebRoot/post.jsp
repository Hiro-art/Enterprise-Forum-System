<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ include file="checkLogin.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="users" value="${sessionScope.users}"/>
<c:set var="sid" value="${param.sid}"/>
<c:set var="tid" value="${param.tid}"/>
<c:set var="action" value="${param.action}"/>

<c:if test="${empty users}">
	<c:set var="uid" value="0"/>
</c:if>
<c:if test="${not empty users}">
	<c:set var="uid" value="${users.uid}"/>
</c:if>
${pageContext.setAttribute("page_sid",sid)}

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
	<TITLE>企业论坛--发布帖子</TITLE>
	<META http-equiv=Content-Type content="text/html; charset=utf-8">
	<link rel="stylesheet" type="text/css" href="style/styleSheet.css">
	<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
	<link rel="stylesheet" type="text/css" href="style/showlogin.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
	<link  href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
	<body style="padding-top: 100px;">
	<jsp:include page="showLogin.jsp"/>

<!--      导航以及搜索 顺序需要做出修改       -->
	<div class="row" align="center" style="background-color:#d9d9d9;height: 42px;">
		<div class="col-md-7">
			<ul class="nav nav-tabs sidebar" style="background-color: #d9d9d9;">
				<li><a href="index.jsp" style="color: white">论坛首页</a></li><jsp:include page="navigation.jsp"/>
				<c:forEach var="info" items="${sectioninfo_dao.getNavigationMenuById(page_sid)}" varStatus="p">
					<c:if test="${p.count eq 2}">
						<li class="active" style="background-color: #428675">
							<a href="servletListPage?sid=${info.sid}" style="color:#d9d9d9">${info.sname}</a>
							<c:set var="topicname" value="${info.sname}"/>
						</li>
					</c:if>
					<c:if test="${p.count !=2}">
						<li>
							<a href="servletListPage?sid=${info.sid}" style="color: white">${info.sname}</a>
						</li>
					</c:if>
				</c:forEach>
				${sectioninfo_dao.clearList()}
			</ul>
		</div>
	</div>
<!--      主体        -->
<DIV class="container" style="padding-top: 2%">
	<!-- 跟帖子的表单 -->
	<c:if test="${'reply' eq action.toLowerCase()}">
	<FORM name="postForm" onsubmit="return check(1)"
		  action="servletDetailPage?tid=${tid}&sid=${sid}&uid=${uid}&action=${action}"
		  method="post">
		<INPUT type="hidden" name="boardId" value="4"></INPUT>
		<INPUT type="hidden" name="topicId" value=""></INPUT>
		<div class="row" style="height: 50px;background-color: #899f9d;display: flex;flex-direction: column;justify-content: center;">
			<p style="color: white;font-size: large;padding-left: 1%;">回复帖子</p>
		</div>
		<div class="row">
			<div class="col-md-3" style="background-image: url(image/4.png);width:100%;height: 500px;display: flex;flex-direction: column;justify-content: center; align-items: center;">
				<h1 style="color:white;">
					请输入<br/>
					  标题<br/>
					和内容<br/>
					Please...
				</h1>
			</div>
			<div class="col-md-9" style="background-color: #f4f4f4;padding-left: 2%;height:500px">
					<table>
						<tr style="padding-top: 2%">
							<th style="padding-top: 2%">
								<input type="text" class="form-control" name="title" placeholder="请输入标题4-20">
							</th>
						</tr>
						<tr style="padding-top: 2%">
							<th style="padding-top: 2%">
							<textarea class="form-control" aria-label="With textarea" placeholder="请输入内容1000以内" name="content"
									  rows="20" cols="120" tabIndex="2"></textarea>
							</th>
						</tr>
					</table>
			</div>
		</div>
		<DIV class="row" style="margin: 15px 0px;float:right">
			<INPUT class="btn" style="background-color: #b2d7b5;color: white;margin-right: 10px;width:80px"  tabIndex="3" type="submit" value="提 交">
			<INPUT class="btn" style="background-color: #b2d7b5;color: white;width:80px" tabIndex="4" type="reset" value="重 置">
		</DIV>
	</FORM>
	</c:if>
	<c:if test="${'reply' !=action.toLowerCase()}">
		<FORM name="postForm" onsubmit="return check(1)"
			  action="servletDetailPage?tid=${tid}&sid=${sid}&uid=${uid}&action=${action}"
			  method="post">
			<INPUT type="hidden" name="boardId" value="4"></INPUT>
			<INPUT type="hidden" name="topicId" value=""></INPUT>
			<div class="row" style="height: 50px;background-color: #899f9d;display: flex;flex-direction: column;justify-content: center;">
				<p style="color: white;font-size: large;padding-left: 1%;">发表帖子</p>
			</div>
			<div class="row">
				<div class="col-md-3" style="background-image: url(image/4.png);width:100%;height: 500px;display: flex;flex-direction: column;justify-content: center; align-items: center;">
					<h1 style="color:white;">
						请输入<br/>
						标题<br/>
						和内容<br/>
						Please...
					</h1>
				</div>
					<div class="col-md-9" style="background-color: #f4f4f4;padding-left: 2%;height:500px">

						<table>
							<tr style="padding-top: 2%">
								<th style="padding-top: 2%">
									<input type="text" class="form-control" name="title" placeholder="请输入标题4-20">
								</th>
							</tr>
							<tr style="padding-top: 2%">
								<th style="padding-top: 2%">
									<textarea class="form-control" aria-label="With textarea" placeholder="请输入内容1000以内" name="content"
											  rows="20" cols="120" tabIndex="2"></textarea>
								</th>
							</tr>
						</table>
					</div>
			</div>
			<DIV class="row" style="margin: 15px 0px;float:right">
				<INPUT class="btn" style="background-color: #b2d7b5;color: white;margin-right: 10px;width:80px"  tabIndex="3" type="submit" value="提 交">
				<INPUT class="btn" style="background-color: #b2d7b5;color: white;;width:80px" tabIndex="4" type="reset" value="重 置">
			</DIV>
		</FORM>
	</c:if>
</DIV>

<!--统一的尾部：版权信息-->
<jsp:include page="information.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="script.js"></script>
</body>
</html>