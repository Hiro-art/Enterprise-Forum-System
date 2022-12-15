<%--
  Created by IntelliJ IDEA.
  User: 鹿白川
  Date: 2022/11/26
  Time: 下午 4:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.dao.*,com.page.*,com.Bean.*"%>
<%@ include file="checkManagerLogin.jsp"%>

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

<script type="text/javascript">

    function check(){
        var reguName = /^[\u4e00-\u9fa5A-Za-z0-9]{3,10}$/;
        var reguPass = /^[0-9a-zA-Z]{3,20}$/;
        var uName = document.Form1.uName.value;
        var uPass = document.Form1.uPass.value;
        var uPass1 = document.Form1.uPass1.value;
        if(uName == ""){
            alert("用户名不能为空");
            return false;
        }

        if(uPass == ""){
            alert("密码不能为空");
            return false;
        }

        if(!uName.match(reguName)){
            alert("用户名只能输入中文、数字、字母，长度为3-10");
            return false;
        }

        if(!uPass.match(reguPass)){
            alert("密码只能输入数字、字母，长度为3-20");
            return false;
        }

        if(uPass != uPass1){
            alert("2次密码不一样");
            return false;
        }
    }

</script>

<body>
        <DIV style="FONT-SIZE: 14px; PADDING-TOP: 60px; FONT-FAMILY: Arial" align=center>
            <DIV align="left">当前操作是：用户添加</DIV>
            <HR style="WIDTH: 99%; COLOR: #cccccc; HEIGHT: 1px;">
        </DIV>

        <div class="addUserForm">
            <form name="Form1" method="post" action="../ServletAddUser" language="javascript" onsubmit="return check();" id="Form1">
                <input type="hidden" name = "action" value="add"/>
                <table width="968" align="center" cellpadding="4" cellspacing="0" id="t1">

                    <tr>
                        <td width="50%" align="left" valign="top"  class="panelbox">
                            <table width="100%">
                                <tr>
                                    <td width="99" style="width: 90px">用户名:</td>
                                    <td width="338">
                                        <input class=input id=uName onBlur="this.className='FormBase';" style="WIDTH: 200px" onFocus="this.className='FormFocus';" type=text name=uName>
                                    </td>
                                </tr>

                                <tr>
                                    <td width="99" style="width: 90px">性别:</td>
                                    <td width="338">
                                        女<input type="radio" name="gender" value="1">
                                        男<input type="radio" name="gender" value="2" checked="checked" />
                                    </td>

                                </tr>

                                <tr>
                                    <td width="99" style="width: 90px">密码:</td>
                                    <td width="338">
                                        <input class=input id=uPass onBlur="this.className='FormBase';" style="WIDTH: 200px" onFocus="this.className='FormFocus';" type=password name=uPass>
                                    </td>
                                </tr>

                                <tr>
                                    <td width="99" style="width: 90px">确认密码:</td>
                                    <td width="338">
                                        <input class=input id=uPass1 onBlur="this.className='FormBase';" style="WIDTH: 200px" onFocus="this.className='FormFocus';" type=password name=uPass1>
                                    </td>
                                </tr>



                                <tr>

                                    <td width="99" style="width: 90px">请选择头像:</td>
                                    <td>
                                        <table class="table">

                                            <tbody>
                                            <tr>
                                                <td>
                                                    <img src="../image/head/1.gif" alt="head1" style="width: 100%;"/><input type="radio" name="head" value="1.gif" checked="checked">
                                                </td>
                                                <td>
                                                    <img src="../image/head/2.gif" alt="head2" style="width: 100%;"/><input type="radio" name="head" value="2.gif">
                                                </td>
                                                <td>
                                                    <img src="../image/head/3.gif" alt="head3" style="width: 100%;"/><input type="radio" name="head" value="3.gif">
                                                </td>
                                                <td>
                                                    <img src="../image/head/4.gif" alt="head4" style="width: 100%;"/><input type="radio" name="head" value="4.gif">
                                                </td>
                                                <td>
                                                    <img src="../image/head/5.gif" alt="head5" style="width: 100%;"/><input type="radio" name="head" value="5.gif">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../image/head/6.gif" alt="head1" style="width: 100%;"/><input type="radio" name="head" value="1.gif" checked="checked">
                                                </td>
                                                <td>
                                                    <img src="../image/head/7.gif" alt="head2" style="width: 100%;"/><input type="radio" name="head" value="2.gif">
                                                </td>
                                                <td>
                                                    <img src="../image/head/8.gif" alt="head3" style="width: 100%;"/><input type="radio" name="head" value="3.gif">
                                                </td>
                                                <td>
                                                    <img src="../image/head/9.gif" alt="head4" style="width: 100%;"/><input type="radio" name="head" value="4.gif">
                                                </td>
                                                <td>
                                                    <img src="../image/head/10.gif" alt="head5" style="width: 100%;"/><input type="radio" name="head" value="5.gif">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <img src="../image/head/11.gif" alt="head1" style="width: 100%;"/><input type="radio" name="head" value="1.gif" checked="checked">
                                                </td>
                                                <td>
                                                    <img src="../image/head/12.gif" alt="head2" style="width: 100%;"/><input type="radio" name="head" value="2.gif">
                                                </td>
                                                <td>
                                                    <img src="../image/head/13.gif" alt="head3" style="width: 100%;"/><input type="radio" name="head" value="3.gif">
                                                </td>
                                                <td>
                                                    <img src="../image/head/14.gif" alt="head4" style="width: 100%;"/><input type="radio" name="head" value="4.gif">
                                                </td>
                                                <td>
                                                    <img src="../image/head/15.gif" alt="head5" style="width: 100%;"/><input type="radio" name="head" value="5.gif">
                                                </td>
                                            </tr>
                                            </tbody>
                                        </table>

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
                            <button type="submit" class="btn" id="SubmitAdd" onclick="location='UserSection.jsp'"><img src="image/submit.gif"/> 添 加 </button>&nbsp;&nbsp;&nbsp;&nbsp;
                            <button onclick="location='UserSection.jsp';" id="Button3" class="ManagerButton" type="button"><img src="image/arrow_undo.gif"/> 返 回 </button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>

        <!--      声明        -->
        <BR>
        <CENTER class="gray">版权信息</CENTER>
</body>
</html>
