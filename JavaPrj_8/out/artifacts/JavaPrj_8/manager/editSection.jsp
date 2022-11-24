<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.dao.*,com.page.*,com.Bean.*"%>
<%@ include file="checkManagerLogin.jsp"%>
<%
	ManagerDAO manager_dao = new ManagerDAO();
	UserInfoDAO user_dao = new UserInfoDAO();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<link href="manager.css" type=text/css rel=stylesheet>
<style>
#t1{font-size:12px;}
</style>

<script type="text/javascript">

function zoomtextarea(objname, zoom) 
{
 	zoomsize = zoom ? 10 : -10;
	obj = document.Form1.elements[objname];
	if(obj.rows + zoomsize > 0 && obj.cols + zoomsize * 3 > 0) {
		obj.rows += zoomsize;
		obj.cols += zoomsize * 3;
	}
}

function check(){
	var same = document.Form1.sName.value
	var reg = /^.{3,20}$/;//[\u4e00-\u9fa5]验证中文的正则表达式
	if(same =="" || !same.match(reg)){
		alert("论坛名称长度为3-20");
		document.Form1.sName.focus();
		return false;
	}
}

</script>

<body>
<%
	Integer sid = Integer.parseInt(request.getParameter("sid")); 	
	SectionInfo section = manager_dao.getSectionNameById(sid);
	UserInfo user = user_dao.getUserInfoByID(section.getSmasterid());
%>
<DIV style="FONT-SIZE: 14px; PADDING-TOP: 60px; FONT-FAMILY: Arial" align=center>
<DIV align="left">当前操作是：编辑版块</DIV>
<HR style="WIDTH: 99%; COLOR: #cccccc; HEIGHT: 1px">
</DIV>
<div class="ManagerForm">
	<form name="Form1" method="post" action="../ServletManager?sid=<%=sid%>" language="javascript" onsubmit="javascript:return check();" id="Form1">
	<input type="hidden" name = "action" value = "edit"/>
<table width="968" align="center" cellpadding="4" cellspacing="0" id="t1">
            <tr>
                <td width="50%" align="left" valign="top"  class="panelbox">
                    <table width="100%">
                        <tr>
						    <td width="99" style="width: 90px">论坛名称:</td>
						    <td width="338">
							    <input class=FormBase id=sName value="<%=section.getSname().trim()%>" onBlur="this.className='FormBase';" style="WIDTH: 200px" onFocus="this.className='FormFocus';" type=text name=sName>
							</td>
                            <td width="98">&nbsp;<br></td>
                            <td width="374"><br></td>
                        </tr>
                        <tr>
                   			<td width="99" style="width: 90px">版块版主:</td>
						    <td width="338">
							    <input class=FormBase id=uName onBlur="this.className='FormBase';" style="WIDTH: 200px" onFocus="this.className='FormFocus';" type=text name=uName value="<%=user.getUname().trim()%>" >
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
			   <button type="submit" class="ManagerButton" id="SubmitAdd" onclick=""><img src="image/submit.gif"/> 提 交 </button>&nbsp;&nbsp;&nbsp;&nbsp;
              <button onclick="window.history.back();" id="Button3" class="ManagerButton" type="button"><img src="image/arrow_undo.gif"/> 返 回 </button>
			  </td>
            </tr>
</table>
	</form>
	</div>
	  <p></p>
		<DIV style="FONT-SIZE: 11px; PADDING-TOP: 60px; FONT-FAMILY: Arial" align=center>
<HR style="WIDTH: 600px; COLOR: #cccccc; HEIGHT: 1px">
版权信息
</DIV>
</body>
</html>
