<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	import="com.entity.*"
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
<TITLE>企业论坛--登录</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
<script language="javascript">
function check() {
 if(document.loginForm.uName.value===""){
    alert("用户名不能为空");
    return false;
 }
 if(document.loginForm.uPass.value===""){
    alert("密码不能为空");
    return false;
 }
}
</script>
</HEAD>

<BODY>
<DIV>
</DIV>
<!--      用户信息、登录、注册        -->

	<DIV class="h">
		<%@ include file="showLogin.jsp"%>
	</DIV>


<BR/>
<!--      导航        -->
<DIV>
	&gt;&gt;<B><a href="index.jsp">论坛首页</a></B>
</DIV>
<!--      用户登录表单        -->
<DIV class="t" style="MARGIN-TOP: 15px" align="center">
<%
	UserInfo temp = (UserInfo)session.getAttribute("users"); 
	if(temp==null){
%>

<FORM name="loginForm" onSubmit="return check()" action="ServletLogin" method="post"> 
	用户名： <INPUT class="input" tabIndex="1"  type="text"      maxLength="20" size="35" name="uName" style="width: 225px"><Br> 
	密　码： <INPUT class="input" tabIndex="2"  type="password"  maxLength="20" size="40" name="uPass" style="width: 225px"><br>
	<INPUT class="btn"  tabIndex="3"  type="submit" value="登 录">
</FORM>
<%
	} else{
	%>
	<meta http-equiv="refresh" content="2; url=/bbs" />
	<table width="80%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="100" align="center" valign="middle"><h1>提示信息 </h1>
      <p>您已经登录，无须重复登录 </p>
    <p><a href="/bbs">如果浏览器没有转向, 请点击这里. </a></p></td>
  </tr>
	</table>
<%
	}
%>
</DIV>
<!--      声明        -->
<BR/>
<CENTER class="gray">版权信息</CENTER>
</BODY>
</HTML>
