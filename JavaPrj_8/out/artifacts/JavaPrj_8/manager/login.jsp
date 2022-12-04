<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="com.Bean.*"%>

<c:set var="temp" value="${sessionScope.users}"/>
<c:if test="${empty temp}">
    <c:redirect url="err.htm"/>
</c:if>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
    <TITLE>管理员控制台登录</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=utf-8">
    <LINK href="manager.css" type=text/css rel=stylesheet>
    <link  href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="/js/managerlogin.js" language="javascript"></script>
    </HEAD>
<BODY style="BACKGROUND: #f4f6f7;margin-top: 250px">
<center>
<div>
  <h2>管理员控制台登录</h2>
	<form action="../ServletManager" onsubmit="return check()" name="loginForm" method="post">
	<input type="hidden" name = "action" value="login"/>
	<table width="26%"  border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td><img src="image/login-top.gif" width="437" height="15"></td>
      </tr>
      <tr>
        <td align="center" valign="middle" background="image/login-center.gif"><table width="65%"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td height="37"><label>用户名:</label></td>
            <td><label for=uName></label><input class=nofocus id=uName
                                                onBlur="this.className='nofocus';" style="WIDTH: 200px"
                                                onFocus="this.className='nofocus';" readonly size=25 value="${temp.uname}" name=uName>
            </td>
          </tr>
          <tr>
            <td height="37"><label>密　码:</label></td>
            <td><label for=PassWord></label><input class=FormBase id=PassWord
                                                   onBlur="this.className='FormBase';" style="WIDTH: 200px"
                                                   onFocus="this.className='FormFocus';" type=password name=uPass></td>
          </tr>
          <tr align="center" valign="middle">
            <td height="53" colspan="2"><input name="submit" type=submit id=submit9 style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BACKGROUND: url(image/button.gif) no-repeat left top; BORDER-LEFT: 0px; WIDTH: 60px; CURSOR: pointer; BORDER-BOTTOM: 0px; HEIGHT: 26px" value=""></td>
          </tr>
        </table></td>
      </tr>
	  <tr background="image/login-center.gif">
	  	<td></td>
	  </tr>
      <tr>
        <td><img src="image/login-bottom.gif" width="438" height="17"></td>
      </tr>
    </table>
	</form>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
</div>
</center>

<DIV style="FONT-SIZE: 11px; PADDING-TOP: 60px; FONT-FAMILY: Arial" align="center">
<HR style="WIDTH: 600px; COLOR: #cccccc; HEIGHT: 1px">
版权信息
</DIV>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="script.js"></script>
</BODY></HTML>
