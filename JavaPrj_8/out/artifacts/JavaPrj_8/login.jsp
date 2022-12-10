<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2022/11/27
  Time: 20:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"
		 import="com.Bean.*"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html>
<head>
	<meta charset="UTF-8">
	<title>企业论坛--注册</title>
	<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
	<link  href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
</head>
<body class="container">

<div>
</div>
<!--      用户信息、登录、注册        -->

<div class="h">
	<%@ include file="showLogin.jsp"%>
</div>

<br/>

<!--      导航        -->
<div>
	&gt;&gt;<b><a href="index.jsp">论坛首页</a></b>
</div>


<!--      用户登录表单        -->
<div class="t" style="MARGIN-TOP: 15px" align="center">

	<c:if test="${empty user}">
		<form name="loginForm" onSubmit="return check()" action="ServletLogin" method="post">
			<label>
				用户名：
				<input class="input" tabIndex="1" type="text" maxLength="20" size="35" name="uName"
					   style="width: 225px">
			</label><Br>
			<label>
				密　码：
				<input class="input" tabIndex="2" type="password" maxLength="20" size="40" name="uPass"
					   style="width: 225px">
			</label><br>
			<label style="width: 289px;text-align: left">
				自动登录：
				<input type="checkbox" name="remember" value="on" id="checkbox" >
			</label><br>
			<input class="btn"  tabIndex="3"  type="submit" value="登 录">
		</form>
	</c:if>

	<c:if test="${not empty user}">
		<meta http-equiv="refresh" content="2; url=/bbs" />
		<table width="80%"  border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="100" align="center" valign="middle"><h1>提示信息 </h1>
					<p>您已经登录，无须重复登录 </p>
					<p><a href="${pageContext.request.contextPath}/login.jsp">如果浏览器没有转向, 请点击这里. </a></p></td>
			</tr>
		</table>
	</c:if>

</div>

<!--      声明        -->
<BR></BR>
<center class="gray">版权信息</center>

<!-- jQuery and JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="script.js"></script>

</body>
</html>
