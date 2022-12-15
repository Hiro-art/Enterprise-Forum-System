<%--
  Created by IntelliJ IDEA.
  User: 鹿白川
  Date: 2022/11/29
  Time: 下午 11:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.dao.*,com.page.*,com.Bean.*"%>
<%@ include file="checkManagerLogin.jsp"%>

<%-- 后台管理员删除用户 --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<link href="manager.css" type=text/css rel=stylesheet>
<style>
    #t1{font-size:12px;}
</style>
<body>
    <DIV style="FONT-SIZE: 14px; PADDING-TOP: 60px; FONT-FAMILY: Arial" align=center>
        <DIV align="left">当前操作是：用户删除</DIV>
        <HR style="WIDTH: 99%; COLOR: #cccccc; HEIGHT: 1px;">
    </DIV>

    <div class="deleteUserForm">
        <form name="deleteUserForm" method="post" action="../ServletDeleteUser" language="javascript" onsubmit="return check();" id="deleteUserForm">
            <input type="hidden" name = "action" value="add"/>
            <table width="968" align="center" cellpadding="4" cellspacing="0" id="t1">
                <tr>
                    <td width="50%" align="left" valign="top"  class="panelbox">
                        <table width="100%">
                            <tr>
                                <td width="99" style="width: 90px">待删除用户编号：</td>
                                <td width="338">
                                    <input class=input id=uId onBlur="this.className='FormBase';" style="WIDTH: 200px" onFocus="this.className='FormFocus';" type=text name=uId>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr align="center" valign="middle">
                    <td height="34"  class="panelbox"></td>
                </tr>
                <tr align="center" valign="middle">
                    <td  class="panelbox">
                        <button type="submit" class="btn" id="SubmitAdd" onclick=""><img src="image/submit.gif"/> 删 除 </button>&nbsp;&nbsp;&nbsp;&nbsp;
                        <button onclick="location='UserSection.jsp';" id="Button3" class="ManagerButton" type="button"><img src="image/arrow_undo.gif"/> 返 回 </button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
