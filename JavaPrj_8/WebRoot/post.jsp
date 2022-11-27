<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="checkLogin.jsp"%>

<c:set var="sid" value="${requestScope.sid}"/>
<c:set var="tid" value="${requestScope.tid}"/>
<c:set var="action" value="${requestScope.action}"/>
<c:set var="users" value="${sessionScope.users}"/>
<jsp:setProperty name="page_sid" property="sid" value="${sid}"/>

<c:if test="${not empty users}">
	<c:set var="uid" value="${users.uid}"/>
</c:if>
<c:if test="${empty users}">
	<c:set var="uid" value="0"/>
</c:if>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
	<TITLE>企业论坛--发布帖子</TITLE>
	<META http-equiv=Content-Type content="text/html; charset=utf-8">
	<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
	<script src="js/post.js" type="text/javascript"/>
</HEAD>
<BODY>
<!--      用户信息、登录、注册        -->
<DIV class="h">
	<%@ include file="showLogin.jsp"%>
</DIV>
<!--      主体        -->
<DIV>
	<BR />
	<!--      导航        -->
	<DIV>
		&gt;&gt;
		<B><a href="index.jsp">论坛首页</a>
		</B><%@ include file="navigation.jsp"%>
	</DIV>
	<BR />
	<!-- 跟帖子的表单 -->
	<c:if test="${'reply'.equals(action.toLowerCase())}">
		<DIV>
			<FORM name="postForm" onsubmit="return check(0);"
				  action="servletDetailPage?tid=${tid}&sid=${sid}&uid=${uid}&action=${action}"
				  method="post">
				<INPUT type="hidden" name="boardId" value="4"></INPUT>
				<INPUT type="hidden" name="topicId" value=""></INPUT>
				<DIV class="t">
					<TABLE cellSpacing="0" cellPadding="0" align="center">
						<TR>
							<TD class="h" colSpan="2">
								<B>
									回复帖子
								</B>
							</TD>
						</TR>
						<TR class="tr3">
							<TH width="20%">
								<B>标题</B>
							</TH>
							<TH>
								<INPUT class="input"
									   style="PADDING-LEFT: 2px; FONT: 14px Tahoma" tabIndex="1"
									   size="60" name="title">
							</TH>
						</TR>
						<TR class="tr3">
							<TH vAlign=top>
								<DIV>
									<B>内容</B>
								</DIV>
							</TH>
							<TH colSpan=2>
								<DIV>
										<span><textarea style="WIDTH: 500px;" name="content"
														rows="20" cols="90" tabIndex="2"></textarea>
										</span>
								</DIV>
								(不能大于:
								<FONT color="blue">1000</FONT>字)
							</TH>
						</TR>
					</TABLE>
				</DIV>
				<DIV style="MARGIN: 15px 0px; TEXT-ALIGN: center">
					<INPUT class="btn" tabIndex="3" type="submit" value="提 交">
					<INPUT class="btn" tabIndex="4" type="reset" value="重 置">
				</DIV>
			</FORM>
		</DIV>
	</c:if>
	<!-- 发新帖子的表单 -->
	<c:if test="${!'reply'.equals(action.toLowerCase())}">
		<DIV>
			<FORM name="postForm" onsubmit="return check(1)"
				  action="servletDetailPage?tid=${tid}&sid=${sid}&uid=${uid}&action=${action}"
				  method="post">
				<INPUT type="hidden" name="boardId" value="4"></INPUT>
				<INPUT type="hidden" name="topicId" value=""></INPUT>
				<DIV class="t">
					<TABLE cellSpacing="0" cellPadding="0" align="center">
						<TR>
							<TD class="h" colSpan="2">
								<B>发表帖子</B>
							</TD>
						</TR>
						<TR class="tr3">
							<TH width="20%">
								<B>标题</B>
							</TH>
							<TH>
								<INPUT class="input"style="PADDING-LEFT: 2px;
					FONT: 14px Tahoma" tabIndex="1"size="60" name="title">
							</TH>
						</TR>

						<TR class="tr3">
							<TH vAlign=top>
								<DIV>
									<B>内容</B>
								</DIV>
							</TH>
							<TH colSpan=2>
								<DIV><span>
						<textarea style="WIDTH: 500px;" name="content"
								  rows="20" cols="90" tabIndex="2"></textarea>
					</span></DIV>
								(不能大于:
								<FONT color="blue">1000</FONT>字)
							</TH>
						</TR>
					</TABLE>
				</DIV>
				<DIV style="MARGIN: 15px 0px; TEXT-ALIGN: center">
					<INPUT class="btn" tabIndex="3" type="submit" value="提 交">
					<INPUT class="btn" tabIndex="4" type="reset" value="重 置">
				</DIV>
			</FORM>
		</DIV>
	</c:if>
</DIV>
<!--      声明        -->
<BR />
<CENTER class="gray">
	版权信息
</CENTER>
</BODY>
</HTML>