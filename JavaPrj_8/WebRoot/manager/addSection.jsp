<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.dao.*,com.entity.*"%>
<%@ include file="checkManagerLogin.jsp"%>
<%
	SectionInfoDAO section_dao = new SectionInfoDAO();
	ManagerDAO manager_dao = new ManagerDAO();
	List<SectionInfo> clist = null;
	String blank = "";
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
	var reg = /^[\u4e00-\u9fa5A-Za-z0-9]{3,20}$/;//[\u4e00-\u9fa5]验证中文的正则表达式
	if(same =="" || !same.match(reg)){
		alert("论坛名称长度为3-20");
		document.Form1.sName.focus();
		return false;
	}
}

</script>

<body>
<DIV style="FONT-SIZE: 14px; PADDING-TOP: 60px; FONT-FAMILY: Arial" align=center>
<DIV align="left">当前操作是：版块添加</DIV>
<HR style="WIDTH: 99%; COLOR: #cccccc; HEIGHT: 1px">
</DIV>
<div class="ManagerForm">
	<form name="Form1" method="post" action="../ServletManager" language="javascript" onsubmit="return check();" id="Form1">
	<input type="hidden" name = "action" value="add"/>
<table width="968" align="center" cellpadding="4" cellspacing="0" id="t1">
            <tr>
                <td width="50%" align="left" valign="top"  class="panelbox">
                    <table width="100%">
                        <tr>
						    <td width="99" style="width: 90px">论坛名称:</td>
						    <td width="338">
							    <input class=FormBase id=sName onBlur="this.className='FormBase';" style="WIDTH: 200px" onFocus="this.className='FormFocus';" type=text name=sName>
							</td>
						</tr>
						<tr>	
                            <td width="98">所属类别:</td>
                            <td width="374"><table width="374">
                              <tr>
                                <td width="232">
                                  <table id="" class="buttonlist" onclick="javascript:document.getElementById('showtargetforum').style.display= (document.getElementById('rootSection').checked ? 'none' : 'block');" border="0" style="border-width:0px;border-style:Dotted;">
                                    <tr>
                                      <td><input id="rootSection" type="radio" name="sType" value="0" checked="checked"/>
                                          <label for="rootSection">论坛版块</label></td>
                                      <td><input id="leafSection" type="radio" name="sType" value="1"  />
                                          <label for="leafSection">论坛子版块</label></td>
                                    </tr>
                                </table></td>
                                <td width="145"><div id="showtargetforum" style="display:none">
                                    <select name="select">
                                      <option value="-1" selected="selected">请选择所属父版块</option>
	<%
			List<SectionInfo> listParent = section_dao.getSectionById(0);
			clist = manager_dao.getAllSectionObjByList(listParent);
			//先获得所有节点对象
			for (int i = 0; i < clist.size(); i++) {
				//根据对象的父id 获得版块名
				blank = manager_dao.traverseRootNodeById(clist.get(i).getSparentid(),"&nbsp;&nbsp;");
	%>
	               <option value="<%=clist.get(i).getSid()%>"><%=blank%><%=clist.get(i).getSname()%></option>
	<%
		}
	%>
                                    </select>
                                </div></td>
                              </tr>
                            </table></td>
                        </tr>
                   	<tr>
                   			<td width="99" style="width: 90px">版块版主:</td>
						    <td width="338">
							    <input class=FormBase id=uName onBlur="this.className='FormBase';" style="WIDTH: 200px" onFocus="this.className='FormFocus';" type=text name=uName>
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
			   <button type="submit" class="ManagerButton" id="SubmitAdd" onclick=""><img src="image/submit.gif"/> 添 加 </button>&nbsp;&nbsp;&nbsp;&nbsp;
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
