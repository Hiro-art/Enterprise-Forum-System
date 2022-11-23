<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.dao.*,com.entity.*"%>
<%@ include file="checkManagerLogin.jsp"%>
<%
	SectionInfoDAO section_dao = new SectionInfoDAO();
	ManagerDAO manager_dao = new ManagerDAO();
	List<SectionInfo> clist = null;
	String blank = "";
	Integer sId = Integer.parseInt(request.getParameter("sid"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>forumsmove</title>	
    </head>
<style>
	#t1{font-size:12px;}
</style>
	<body>
	<DIV style="FONT-SIZE: 14px; PADDING-TOP: 60px; FONT-FAMILY: Arial" align=center>
<DIV align="left">当前操作是：移动版块</DIV>
<HR style="WIDTH: 99%; COLOR: #cccccc; HEIGHT: 1px;">
</DIV>
	<div class="ManagerForm">
		<form name="Form1" method="get" action="../ServletManager" id="Form1">
		<input type="hidden" name = "action" value="move" />
		    <table width="90%" align="center" cellpadding="4" cellspacing="0" id="t1">
                <tr>
                    <td width="41%" align="left" valign="top"  class="panelbox">
                        <table width="100%">
                            <tr>
					            <td width="90" align="left">源版块:</td>
					            <td width="319">
						            <select name="source">
<%
		List<SectionInfo> listParent = section_dao.getSectionById(0);
		clist = manager_dao.getAllSectionObjByList(listParent);
		Integer sPid = 0;
		//先获得所有节点对象
		for (int i = 0; i < clist.size(); i++) {
			//根据对象的父id 获得版块名
			blank = manager_dao.traverseRootNodeById(clist.get(i).getSparentid(),"&nbsp;&nbsp;");
			if(clist.get(i).getSid()==sId){
			sPid = clist.get(i).getSparentid();//获得当前版块的父版块id
			
%>
		<option value="<%=clist.get(i).getSid()%>" selected="selected"><%=blank%><%=clist.get(i).getSname()%></option>
                        
<%
			}else{
%>
		<option value="<%=clist.get(i).getSid()%>"><%=blank%><%=clist.get(i).getSname()%></option>
<%	
			}
	}
%>
</select>
					            </td>
                            </tr>
			                <tr>
					            <td>移动方式:</td>
					            <td>
						            <table id="movetype" class="buttonlist" border="0" style="border-width:0px;border-style:Dotted;" onclick="javascript:document.getElementById('showtargetforum').style.display= (document.getElementById('rootSection').checked ? 'none' : 'block');" border="0" style="border-width:0px;border-style:Dotted;">
	<tr>
		<td><input type="radio" name="moveType" value="0" checked="checked" />作为目标版块的子版块</td>
	</tr>
	<tr>
		<td><input id="rootSection" type="radio" name="moveType" value="1" />作为根版块</td>
	</tr>
</table>  
					            </td>
				            </tr>
                  </table>                  </td>
                    <td  class="panelbox" align="right" width="59%">
                        <table width="100%" id="showtargetforum" style="display:block; ">
				            <tr>
					            <td width="98" align="left" valign="top">目标版块:</td>
					            <td width="534" align="left" valign="top">
						            <select size="4" name="target" style="height:290px;">
<%
	if(sPid==0){
		for (int i = 0; i < clist.size(); i++) {
			//根据对象的父id 获得版块名
			blank = manager_dao.traverseRootNodeById(clist.get(i).getSparentid(),"&nbsp;&nbsp;");
			if(clist.get(i).getSid() == sId){
%>
		<option value="<%=clist.get(i).getSid()%>" selected="selected"><%=blank%><%=clist.get(i).getSname()%></option>
<%
			}else{
%>
		<option value="<%=clist.get(i).getSid()%>"><%=blank%><%=clist.get(i).getSname()%></option>
<%
			}
		}
	}else{
	for (int i = 0; i < clist.size(); i++) {
			//根据对象的父id 获得版块名
		blank = manager_dao.traverseRootNodeById(clist.get(i).getSparentid(),"&nbsp;&nbsp;");
		if(clist.get(i).getSid() == sPid){
%>
		<option value="<%=clist.get(i).getSid()%>" selected="selected"><%=blank%><%=clist.get(i).getSname()%></option>
	                                         
<%
			}else{
%>
		<option value="<%=clist.get(i).getSid()%>"><%=blank%><%=clist.get(i).getSname()%></option>
<%
			}
		}
	}
%>
</select></td>
				            </tr>
                      </table>
                    </td>
                </tr>
                 <tr align="center" valign="middle" >
              <td height="34"  class="panelbox" colspan="2"></td>
            </tr>
            <tr align="center" valign="middle">
              <td  class="panelbox"  colspan="2">
			   <button type="submit" class="ManagerButton" id="SubmitAdd" onclick=""><img src="image/submit.gif"/> 提 交 </button>&nbsp;&nbsp;&nbsp;&nbsp;
              <button onclick="window.history.back();" id="Button3" class="ManagerButton" type="button"><img src="image/arrow_undo.gif"/> 返 回 </button>
			  </td>
            </tr>
          </table>
</form>
	</div>
<DIV style="FONT-SIZE: 11px; PADDING-TOP: 60px; FONT-FAMILY: Arial" align=center>
<HR style="WIDTH: 600px; COLOR: #cccccc; HEIGHT: 1px;">版权信息
</DIV>
	</body>
</html>
