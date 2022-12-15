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
	<link rel="stylesheet" type="text/css" href="style/styleSheet.css">
	<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
	<link rel="stylesheet" type="text/css" href="style/showlogin.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
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
<body style="padding-top: 15%;background-image: url(image/bg.png);background-size: cover;">

<!--      用户信息、登录、注册        -->
<jsp:include page="showLogin.jsp"/>


<c:if test="${empty user}">
	<div class="container">
		<div class="row" style="margin-bottom:30px; height:200px">
			<!--栅格系统-->
			<div class="col-1">
			</div>
			<div class="col-4">
				<img src="image/loginText.png" alt="section"
					 style="width: 400px;">
				<div style="padding-top: 22%;">
					<a style="color: #FFFFFF;">暂无账号，前往注册？……</a>
				</div>
			</div>

			<div class="col-2">
			</div>

			<div class="col-4" style="background-color: #FFFFFF;text-align:left;display:table;border: 10px solid #B1D7B4;height: 400px;">

				<form name="loginForm" onSubmit="return check()" action="ServletLogin" method="post" style="padding-left: 30px;padding-right: 30px;">
					<div class="form-group"  style="padding-top: 10%;">
						<label>用户名</label>
						<input type="text" class="form-control" id="uName" aria-describedby="emailHelp" placeholder="Enter User's name please." name="uName">
					</div>
					<div class="form-group">
						<label>密码</label>
						<input type="password" class="form-control" id="uPass" placeholder="Password" name="uPass">
					</div>
					<div class="form-check" style="padding-bottom: 30%;padding-top: 10%;">
						<input type="checkbox" class="form-check-input" id="checkbox">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<label class="form-check-label">自动登录</label>
					</div>
					<p class="form-inline" style="padding-bottom: 30px;width: 100%;justify-content:space-between;">
						<button type="submit" class="btn btn-primary" style="background-color: #E28D28;height:40px;border:0;width: 120px;">登  录</button>
						<a href="index.jsp" class="btn btn-primary" role="button" aria-pressed="true" style="background-color: #B1D7B4;height:40px;border:0;width: 120px;">返回论坛首页</a>
					</p>
				</form>
			</div>
			<div class="col-1">
			</div>
		</div>
	</div>
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

<div style="height: 300px">

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
