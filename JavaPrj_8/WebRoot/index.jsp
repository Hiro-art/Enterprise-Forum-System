<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.dao.*,com.page.*"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
	<HEAD>
		<TITLE>欢迎访问论坛首页</TITLE>
		<META http-equiv=Content-Type content="text/html; charset=utf-8">
		<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
	</HEAD>
	<BODY>
		<DIV>
		</DIV>
		<DIV class="h">
			<%@ include file="showLogin.jsp" %>
		</DIV>
		<%
			List<SectionInfo> listParent = null;		//根版块列表
			List<SectionInfo> listChild = null;			//子版块列表
			int sParentId = 0;							//根版块编号
			int sId = 0;								//子版块编号
			int tId = 0;								//帖子编号
			SectionInfoDAO section_dao = new SectionInfoDAO();//版块DAO
			TopicInfoDAO topic_dao = new TopicInfoDAO();	//主题DAO
			ReplyInfoDAO reply_dao = new ReplyInfoDAO();	//回复DAO
		%>		
		<DIV class="t">
		<%
			listParent = section_dao.getSectionById(0);
			for (int i = 0; i < listParent.size(); i++) {
		%>
		<TABLE cellSpacing="0" cellPadding="0" width="100%">
			<TR class="tr2" align="center">
				<TD colSpan="2">论坛</TD>
				<TD style="WIDTH: 10%">主题</TD>
				<TD style="WIDTH: 30%">最后发表</TD>
			</TR>
			<TR class="tr3">
				<TD colspan="4">
					<a href="servletListPage?sid=<%=listParent.get(i).getSid() %>">
					<%=listParent.get(i).getSname()%></a>
				</TD>
			</TR>
			<%
			sParentId = listParent.get(i).getSid();		//获得根版块编号
			listChild = section_dao.getSectionById(sParentId);//获得其下所有子版块
			for (int j = 0; j < listChild.size(); j++) {//遍历子版块列表
			%>
			<TR class="tr3">
				<TD width="5%">&nbsp;</TD>
				<TH align="left"><IMG src="image/board.gif">
					<A href="servletListPage?sid=<%=listChild.get(j).getSid()%>">
					<%=listChild.get(j).getSname()%></A>
				</TH>
				<TD align="center">
					<%=listChild.get(j).getStopiccount()%>
				</TD>
				<TH>
				<%
				IndexPage temp1 = null;			//最后发帖记录
				IndexPage temp2 = null;			//最后回帖记录
				sId= listChild.get(j).getSid();	//获得版块编号
				temp1 = topic_dao.getALLTopicLastTimeById(sId);//获得最后发帖记录
				if (temp1 != null) {
					tId = temp1.getTid();		//获得帖子编号
					temp2 = reply_dao.
						getAllReplyLastTimeById(sId,tId);//获得最后跟帖的记录
					if(temp2 != null){
				%>
					<SPAN><A href="servletDetailPage?tid=<%=temp2.getTid()%>
					&sid=<%=sId%>&action=showDetail"><%=temp2.getTitle()%></A></SPAN>
					<BR/>
					<SPAN><%=temp2.getAuthor()%></SPAN>
					<SPAN class="gray">
					[ <%=CommonDAO.getDateFormat(temp2.getPublishtime())%> ]</SPAN>
				<%	}else{
				%>
					<SPAN><A href="servletDetailPage?tid=<%=temp1.getTid()%>
					&sid=<%=sId%>&action=showDetail"><%=temp1.getTitle()%></A></SPAN>
					<BR/>
					<SPAN><%=temp1.getAuthor()%></SPAN>
					<SPAN class="gray">
					[ <%=CommonDAO.getDateFormat(temp1.getPublishtime())%> ]</SPAN>
				<%
					}			
				}else{
				%>
					<SPAN>从未</SPAN>
				<%	
				}
				%>
				</TH>
			</TR>
			<%
			}
			%>
		</TABLE>
		<%
			}
		%>
		</DIV>

		<BR />
		<CENTER class="gray"> 
			版权信息 
		</CENTER>
	</BODY>
</HTML>