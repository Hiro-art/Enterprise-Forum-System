<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.dao.*,com.page.*,com.Bean.*"%>
<%@ include file="checkManagerLogin.jsp"%>
<%
	//初始化变量
	List<SectionInfo> listParent = null;
	SectionInfoDAO section_dao = new SectionInfoDAO();
	ManagerDAO manager_dao = new ManagerDAO();
%>
<%!
	List<SectionInfo> f(int id){
		SectionInfoDAO section_dao = new SectionInfoDAO();
		List<SectionInfo> list = section_dao.getSectionById(id);
		
		if(list.size() == 0){
			return null;
		}
		for(int i = 0 ; i < list.size(); i++){
			id = list.get(i).getSid();
			//out.println("<h3>_"+list.get(i).getSname()+"</h3>");
			f(id);
		}
		return list;
	} 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>无标题文档</title>
</head>

<style>
body{
	font-size:12px;
}

a{
	color:#000000;
	text-decoration: none;
}

a:hover{
	color:#FF0000;
	text-decoration:underline;
}
</style>

<script type="text/javascript">
	function check(){
		return false;
	}
</script>

<body>
<DIV style="FONT-SIZE: 14px; PADDING-TOP: 60px; FONT-FAMILY: Arial" align=center>
<DIV align="left">当前操作是：版块管理</DIV>
<HR style="WIDTH: 99%; COLOR: #cccccc; HEIGHT: 1px;">
</DIV>
<p></p><p></p>
	<div>
<%
		listParent = section_dao.getSectionById(0);// 获得跟版块
		List<String> strList = manager_dao.getAllSectionByList(listParent);
		
		for(int i = 0; i < strList.size(); i++){
			out.println(strList.get(i));
		}
%>
	</div>
	<DIV style="FONT-SIZE: 11px; PADDING-TOP: 60px; FONT-FAMILY: Arial" align=center>
<HR style="WIDTH: 600px; COLOR: #cccccc; HEIGHT: 1px;">版权信息
</DIV>
</body>
</html>
