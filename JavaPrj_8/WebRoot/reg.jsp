<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >

<HTML>
<head>
	<title>企业论坛--注册</title>
	<meta http-equiv=Content-Type content="text/html; charset=utf-8">
	<link rel="stylesheet" type="text/css" href="style/styleSheet.css">
	<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
	<link rel="stylesheet" type="text/css" href="style/showlogin.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
	<link  href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
	<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="js/reg.js" language="javascript"></script>
</head>
<body style="padding-top: 100px;">

<!--      用户信息、登录、注册        -->
<jsp:include page="showLogin.jsp"/>

<c:set var = "user" value ="${sessionScope.users}"/>
<c:if test="${empty user}">

	<div class="container">
		<div class="row" style="margin-bottom:30px; height:200px">
			<!--栅格系统-->

			<div class="col-2">
			</div>

			<div class="col-8">
				<FORM name="regForm" onSubmit="return check()" action="ServletReg" method="post">
					<div style="padding-bottom: 5%;">
						<div class="input-group-prepend"  style="padding-top: 10%;">
							<div class="input-group-prepend">
								<span class="input-group-text" style="width: 150px">用 户 名</span>
							</div>
							<input type="text" class="form-control" id="uName" aria-describedby="emailHelp" placeholder="Enter User's name please." name="uName">
						</div>
						<div class="input-group-prepend"  style="padding-top: 20px;">
							<div class="input-group-prepend">
								<span class="input-group-text" style="width: 150px">密  码</span>
							</div>
							<input type="password" class="form-control" id="uPass" placeholder="Password" name="uPass">
						</div>
						<div class="input-group-prepend"  style="padding-top: 20px;">
							<div class="input-group-prepend">
								<span class="input-group-text" style="width: 150px">请重复密码</span>
							</div>
							<input type="password" class="form-control" id="uPass1" placeholder="Password" name="uPass1">
						</div>
						<div style="padding-top: 20px;">
							性别：
							女<input type="radio" name="gender" value="1">&nbsp;&nbsp;
							男<input type="radio" name="gender" value="2" checked="checked" />
						</div>

					</div>
					<div style="background-color:#899F9C;height: 50px;width:100% ;display:table;">
						<h5 style="display:table-cell;vertical-align:middle;color:#FFFFFF;padding-left: 20px;">请选择头像：</h5>
					</div>

					<table class="table">

						<tbody>
						<tr>
							<td>
								<img src="image/head/1.gif" alt="head1" style="width: 100%;"/><input type="radio" name="head" value="1.gif" checked="checked">
							</td>
							<td>
								<img src="image/head/2.gif" alt="head2" style="width: 100%;"/><input type="radio" name="head" value="2.gif">
							</td>
							<td>
								<img src="image/head/3.gif" alt="head3" style="width: 100%;"/><input type="radio" name="head" value="3.gif">
							</td>
							<td>
								<img src="image/head/4.gif" alt="head4" style="width: 100%;"/><input type="radio" name="head" value="4.gif">
							</td>
							<td>
								<img src="image/head/5.gif" alt="head5" style="width: 100%;"/><input type="radio" name="head" value="5.gif">
							</td>
						</tr>
						<tr>
							<td>
								<img src="image/head/6.gif" alt="head1" style="width: 100%;"/><input type="radio" name="head" value="1.gif" checked="checked">
							</td>
							<td>
								<img src="image/head/7.gif" alt="head2" style="width: 100%;"/><input type="radio" name="head" value="2.gif">
							</td>
							<td>
								<img src="image/head/8.gif" alt="head3" style="width: 100%;"/><input type="radio" name="head" value="3.gif">
							</td>
							<td>
								<img src="image/head/9.gif" alt="head4" style="width: 100%;"/><input type="radio" name="head" value="4.gif">
							</td>
							<td>
								<img src="image/head/10.gif" alt="head5" style="width: 100%;"/><input type="radio" name="head" value="5.gif">
							</td>
						</tr>
						<tr>
							<td>
								<img src="image/head/11.gif" alt="head1" style="width: 100%;"/><input type="radio" name="head" value="1.gif" checked="checked">
							</td>
							<td>
								<img src="image/head/12.gif" alt="head2" style="width: 100%;"/><input type="radio" name="head" value="2.gif">
							</td>
							<td>
								<img src="image/head/13.gif" alt="head3" style="width: 100%;"/><input type="radio" name="head" value="3.gif">
							</td>
							<td>
								<img src="image/head/14.gif" alt="head4" style="width: 100%;"/><input type="radio" name="head" value="4.gif">
							</td>
							<td>
								<img src="image/head/15.gif" alt="head5" style="width: 100%;"/><input type="radio" name="head" value="5.gif">
							</td>
						</tr>
						</tbody>
					</table>
					<p class="form-inline" style="padding-bottom: 30px;width: 100%;justify-content:space-between;">
						<button type="submit" class="btn btn-primary" style="background-color: #E28D28;height:40px;border:0;width: 120px;">注  册</button>
						<a href="index.jsp" class="btn btn-primary" role="button" aria-pressed="true" style="background-color: #B1D7B4;height:40px;border:0;width: 120px;">返回论坛首页</a>
					</p>
				</form>
			</div>

			<div class="col-2">
			</div>
		</div>
	</div>
</c:if>

<div style="height: 800px">

</div>

<!--统一的尾部：版权信息-->
<jsp:include page="information.jsp"/>

</body>
</HTML>
