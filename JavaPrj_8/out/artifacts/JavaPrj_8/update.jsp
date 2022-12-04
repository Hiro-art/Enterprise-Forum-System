<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file ="checkLogin.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="sid" value="${requestScope.sid}"/>
<c:set var="tid" value="${requestScope.tid}"/>
<c:set var="edittopic" value="${requestScope.edittopic}"/>
<c:set var="editreply" value="${requestScope.editreply}"/>
<c:set var="action" value="${requestScope.action}"/>
${pageContext.setAttribute("page_sid",sid)}

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
	<TITLE>企业论坛--修改帖子</TITLE>
	<META http-equiv=Content-Type content="text/html; charset=utf-8">
	<Link rel="stylesheet" type="text/css" href="style/style.css" />
	<script src="js/update.js" type="text/javascript"></script>
	<link  href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</HEAD>
<BODY>
<!--      用户信息、登录、注册        -->

<DIV class="h">
	<%@ include file="showLogin.jsp" %>
</DIV>
<!--      主体        -->
<DIV><BR/>
	<!--      导航        -->
	<DIV>
		&gt;&gt;<B><a href="index.jsp">论坛首页wwww</a></B><%@ include file="navigation.jsp" %>
	</DIV><BR/>
	<!-- 修改主帖的表单 -->
	<c:if test="${'edittopic'.equals(action.toLowerCase())}">
		<DIV>
			<FORM name="updateForm" onSubmit="return check(1);" action="servletDetailPage?tid=<c:out value="${tid}"/>&sid=<c:out value="${sid}"/>&action=<c:out value="updateTopic"/>" method="post">
				<INPUT type="hidden" name="boardId" value="8"/>
				<INPUT type="hidden" name="replyId" value="61"/>
				<DIV class="t">
					<TABLE cellSpacing="0" cellPadding="0" align="center">

						<TR>
							<TD class="h" colSpan="3"><B>修改主帖</B></TD>
						</TR>

						<TR class="tr3">
							<TH width="20%"><B>标题</B></TH>
							<TH><INPUT name="title" value="${edittopic.ttopic}" class="input" style="PADDING-LEFT: 2px; FONT: 14px Tahoma" tabIndex="1" size="60"></TH>
						</TR>

						<TR class="tr3">
							<TH vAlign="top">
								<DIV><B>内容</B></DIV>
							</TH>
							<TH colSpan="2">
								<DIV>
									<span><textarea  name="content" style="WIDTH: 500px;word-break:break-all;" rows="20" cols="90" tabIndex="2" >${edittopic.tcontents}</textarea></span>
								</DIV>
								(不能大于:<FONT color="blue">1000</FONT>字)
							</TH>
						</TR>
					</TABLE>
				</DIV>

				<DIV style="MARGIN: 15px 0px; TEXT-ALIGN: center">
					<INPUT class="btn" tabIndex="3" type="submit" value="修 改">
				</DIV>
			</FORM>
		</DIV>
	</c:if>
	<!-- 修改跟帖的表单 -->
	<c:if test="${'editreply'.equals(action.toLowerCase())}">
		<DIV>
			<FORM name="updateForm" onSubmit="return check(0);" action="servletDetailPage?tid=${tid}&sid=${sid}&rid=${editreply.rid}&action=updateReply" method="post">
				<INPUT type="hidden" name="boardId" value="8"/>
				<INPUT type="hidden" name="replyId" value="61"/>
				<DIV class="t">
					<TABLE cellSpacing="0" cellPadding="0" align="center">

						<TR>
							<TD class="h" colSpan="3"><B>修改回帖</B></TD>
						</TR>

						<TR class="tr3">
							<TH width="20%"><B>标题</B></TH>
							<TH><INPUT name="title" value="${editreply.rtopic}" class="input" style="PADDING-LEFT: 2px; FONT: 14px Tahoma" tabIndex="1" size="60"></TH>
						</TR>

						<TR class="tr3">
							<TH vAlign="top">
								<DIV><B>内容</B></DIV>
							</TH>
							<TH colSpan="2">
								<DIV>
									<span><textarea  name="content" style="WIDTH: 500px;word-break:break-all;" rows="20" cols="90" tabIndex="2" >${editreply.rcontents}</textarea></span>
								</DIV>
								(不能大于:<FONT color="blue">1000</FONT>字)
							</TH>
						</TR>
					</TABLE>
				</DIV>

				<DIV style="MARGIN: 15px 0px; TEXT-ALIGN: center">
					<INPUT class="btn" tabIndex="3" type="submit" value="修 改">
				</DIV>
			</FORM>
		</DIV>
	</c:if>

	<!--      声明        -->
	<BR/>
</DIV>
<CENTER class="gray">版权信息</CENTER>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="script.js"></script>
</BODY>
</HTML>
