<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
<TITLE>企业论坛--注册</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
<script src="js/reg.js" language="javascript"></script>
</HEAD>
<BODY>
<!--      用户信息、登录、注册        -->
	<DIV class="h">
	<%@ include file="showLogin.jsp" %>
	</DIV>
<BR/>
<!--      导航        -->
<DIV>
	&gt;&gt;<B><a href="index.jsp">论坛首页</a></B>
</DIV>
<!--      用户注册表单        -->
<DIV  class="t" style="MARGIN-TOP: 15px" align="center">
	<c:set var = "user" value ="${sessionScope.users}"/>
	<c:if test="${empty user}">
		<FORM name="regForm" onSubmit="return check()" action="ServletReg" method="post">
			<br/>用&nbsp; &nbsp;户&nbsp;&nbsp;名&nbsp;<INPUT class="input" tabIndex="1" type="text" maxLength="20" size="35" name="uName">
			<br/>密&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码&nbsp;<INPUT class="input" tabIndex="2" type="password" maxLength="20" size="40" name="uPass">
			<br/>重复&nbsp;&nbsp;密码&nbsp;<INPUT class="input" tabIndex="3" type="password" maxLength="20" size="40" name="uPass1">
			<br/>性别 &nbsp;
			女<input type="radio" name="gender" value="1">
			男<input type="radio" name="gender" value="2" checked="checked" />
			<br/>请选择头像 <br/>
			<img src="image/head/1.gif"/><input type="radio" name="head" value="1.gif" checked="checked">
			<img src="image/head/2.gif"/><input type="radio" name="head" value="2.gif">
			<img src="image/head/3.gif"/><input type="radio" name="head" value="3.gif">
			<img src="image/head/4.gif"/><input type="radio" name="head" value="4.gif">
			<img src="image/head/5.gif"/><input type="radio" name="head" value="5.gif">
			<BR/>
			<img src="image/head/6.gif"/><input type="radio" name="head" value="6.gif">
			<img src="image/head/7.gif"/><input type="radio" name="head" value="7.gif">
			<img src="image/head/8.gif"/><input type="radio" name="head" value="8.gif">
			<img src="image/head/9.gif"/><input type="radio" name="head" value="9.gif">
			<img src="image/head/10.gif"/><input type="radio" name="head" value="10.gif">
			<BR/>
			<img src="image/head/11.gif"/><input type="radio" name="head" value="11.gif">
			<img src="image/head/12.gif"/><input type="radio" name="head" value="12.gif">
			<img src="image/head/13.gif"/><input type="radio" name="head" value="13.gif">
			<img src="image/head/14.gif"/><input type="radio" name="head" value="14.gif">
			<img src="image/head/15.gif"/><input type="radio" name="head" value="15.gif">
			<br/>
			<INPUT class="btn" tabIndex="4" type="submit" value="注 册">
		</FORM>
	</c:if>
	<c:if test="${not empty user}">
		<meta http-equiv="refresh" content="2; url=/bbs" />
		<table width="80%"  border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="100" align="center" valign="middle"><h1>提示信息 </h1>
					<p>不能重复注册用户 </p>
					<p><a href="/bbs">如果浏览器没有转向, 请点击这里. </a></p></td>
			</tr>
		</table>
	</c:if>
</DIV>
<!--      声明        -->
<BR>
<CENTER class="gray">版权信息</CENTER>
</BODY>
</HTML>
