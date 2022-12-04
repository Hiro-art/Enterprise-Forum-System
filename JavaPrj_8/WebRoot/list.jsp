<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.page.*,com.dao.*"%>
<%
	//解决数组越界/发现新问题，第十一个会被覆盖
	SectionInfoDAO section_dao = new SectionInfoDAO();
	TopicInfoDAO topic_dao = new TopicInfoDAO();
	ReplyInfoDAO reply_dao = new ReplyInfoDAO();

	//获得请求对象的属性
	List<ListPage> list = (List<ListPage>)request.getAttribute("listPage");
	Integer sid = (Integer)request.getAttribute("sid");
	List<SectionInfo> sectionInfoList = section_dao.getSectionById(sid);

	//设置pageCoontex属性
	pageContext.setAttribute("page_sid",sid);

	//初始化分页变量
	Integer currPage = 1;//默认选择第一页
	Integer recordConut = 0;//记录总数
	Integer PageCount = 0;//分页的总页数
	Integer pageNum  = 10;//每页显示的记录数
	Integer startIndex = 0;//开始索引
	Integer endIndex = 0;//结束索引
	Integer nextPage = 0;
	Integer PreviousPage = 0;


	//获得请求对象的分页参数
	String action = request.getParameter("action");
%>
<%-- 实现分页 主要代码一 开始 --%>
<%
	recordConut = list.size();
	//int result = recordConut % pageNum;

	//if(result != 0){//获得分页的总页数
	//PageCount = (recordConut / pageNum) + 1;
	//}else if(result == 0){
	//PageCount = (recordConut / pageNum);
	//}
	PageCount = (recordConut + (pageNum-1))/pageNum;//获得分页的总页数

	if(action != null && "showpage".equals(action.toLowerCase())){//获得当前选择的页码
		//当页数是非数字的时候，就转到最后一页
		String str = (String)request.getParameter("currPage");
		if(str.matches("(\\+|\\-){0,1}[0-9]{0,9}")){
			currPage = Integer.parseInt(request.getParameter("currPage"));
		}else{
			currPage = PageCount;
		}
		//控制【上一页】 【下一页】 的上下界限
		if (currPage <= 1) {
			currPage = 1;
		}
		if(currPage >= PageCount){
			currPage = PageCount;
		}
	}
	//
	endIndex = (currPage * pageNum) - 1;//获得分页结束索引
	//
	//当得到最后一页的时候，改变结束索引
	if(currPage == PageCount){
		if(endIndex > recordConut){
			if(recordConut == --endIndex){
				endIndex -= 1;
				startIndex = 0;
			}else{
				int offset = (endIndex - recordConut) + 1;
				endIndex -= offset;
				startIndex = endIndex;
			}
		}else{
			startIndex = ++endIndex - pageNum;
			endIndex = --recordConut;
		}
	}else if(endIndex > recordConut - 1){
		endIndex -= 1;
		startIndex = 0;
	}else{
		startIndex = endIndex - pageNum + 1 ;//获得分页开始索引
	}

	//获得上下页的页码
	PreviousPage = currPage;
	nextPage  = currPage;
%>
<%-- 实现分页 主要代码一 结束 --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
	<TITLE>企业论坛--帖子列表</TITLE>
	<META http-equiv=Content-Type content="text/html; charset=utf-8">
	<Link rel="stylesheet" type="text/css" href="style/style.css" />
</HEAD>

<BODY>
<DIV>
</DIV>
<!--      用户信息、登录、注册        -->

<DIV class="h">
	<%@ include file="showLogin.jsp" %>
</DIV>


<!--      主体        -->
<DIV>
	<!--      导航        -->
	<br/>
	<DIV>
		&gt;&gt;<B><a href="index.jsp">论坛首页</a></B><%@ include file="navigation.jsp" %>
	</DIV>
	<br/>
	<%
		if(!section_dao.isParentById(sid)){
	%>
	<!--      新帖        -->
	<DIV>
		<A href="post.jsp?tid=0&sid=<%=sid%>&action=post"><IMG src="image/post.gif" name="td_post" border="0" id=td_post></A>
	</DIV>
	<!--         翻 页         -->
	<DIV class = "pages">
		<a href="servletListPage?sid=<%=sid%>&action=showPage&currPage=<%=--PreviousPage%>">上一页</a>&nbsp;|&nbsp;
		<a href="servletListPage?sid=<%=sid%>&action=showPage&currPage=<%=++nextPage%>">下一页</a>&nbsp;|&nbsp;
		<%
			if(PageCount > 0){
		%>
		<a href="servletListPage?sid=<%=sid%>&action=showPage&currPage=1"><<</a>&nbsp;
		<%-- 实现分页 主要代码二 开始	只显示x个页码导航按钮 --%>
		<%
			Integer x  = 3;//控制分页导航按钮显示的个数
			if(x > PageCount){//防止 x 超出分页总页数
				x = PageCount;
			}

			Integer pageNavigationStartIndex = 1;//分页导航按钮开始索引
			Integer pageNavigationEndIndex = x+1;//分页导航按钮结束索引

			if(PageCount == 1){
				pageNavigationStartIndex = 1;
				pageNavigationEndIndex = 2;
			}
			else
			if(currPage <= 1){//如果选择了最前一页
				pageNavigationStartIndex = 1;
			}
			else
			if(currPage >= PageCount){//如果选择了最后一页
				pageNavigationStartIndex = PageCount - (x-(x-1)) ;//分页导航开始索引
				pageNavigationEndIndex = PageCount + 1;//分页导航结束索引
			}
			else
			if(currPage >= x+1 && currPage < PageCount){//如果选择了最前一页与最后一页之间的区间
				pageNavigationEndIndex = currPage+1;
				pageNavigationStartIndex = pageNavigationEndIndex - x;
			}
		%>
		<%-- 实现分页 主要代码二 结束 --%>

		<%-- 实现分页 打印代码一 开始 --%>
		<%
			for(int i = pageNavigationStartIndex; i < pageNavigationEndIndex; i++){
		%>
		<a href="servletListPage?sid=<%=sid%>&action=showPage&currPage=<%=i%>"><%=i%></a>&nbsp;
		<%
			}
		%>
		<%-- 实现分页 打印代码一 结束 --%>
		<input style="width: 30px;height: 14px" type="text" onkeydown="javascript: if(event.keyCode==13){ location='servletListPage?&sid=<%=sid%>&action=showPage&currPage='+this.value+'';return false;}" \>
		<a href="servletListPage?sid=<%=sid%>&action=showPage&currPage=<%=PageCount%>">>></a>&nbsp;
		Pages:&nbsp;(&nbsp;<%=currPage %>&nbsp;/&nbsp;<%=PageCount %>&nbsp;total&nbsp;)
		&nbsp;
		<%
			}
		%>
	</DIV>
	<%
		}
	%>
	<!-- 子版块 -->
	<%
		if(sectionInfoList.size()>0){
	%>
	<DIV class="t">

		<TABLE cellSpacing="0" cellPadding="0" width="100%">
			<TR>
				<TH class="h" style="WIDTH: 100%" colSpan="4"><SPAN>&nbsp;子版块</SPAN></TH>
			</TR>
			<TR class="tr2" align="center">
				<TD colSpan="2">
					论坛
				</TD>
				<TD style="WIDTH: 10%">
					主题
				</TD>
				<TD style="WIDTH: 30%">
					最后发表
				</TD>
			</TR>
			<!--       子版块      -->
			<%--外层循环	开始--%>
			<%
				for (int i = 0; i < sectionInfoList.size(); i++) {
			%>
			<TR class="tr3">
				<TD width="5%">
					&nbsp;

				</TD>
				<Td align="left">
					<IMG src="image/board.gif">
					<A href="servletListPage?sid=<%=sectionInfoList.get(i).getSid()%>"><%=sectionInfoList.get(i).getSname()%></A>
				</Td>
				<TD align="center">
					<%=sectionInfoList.get(i).getStopiccount()%>
				</TD>

				<TH>
					<%
						Integer tId=0,sId=0;
						IndexPage temp1 = null;
						IndexPage temp2 = null;
						sId= sectionInfoList.get(i).getSid();
						//获得同一版块所有帖子最后发帖的记录
						temp1 = topic_dao.getALLTopicLastTimeById(sId);
						if (temp1 != null) {
							//获得同一版块所有帖子最后跟帖的记录
							tId = temp1.getTid();
							temp2 = reply_dao.getAllReplyLastTimeById(sId,tId);
							if(temp2 != null){
					%>
					<%--显示同一版块所有帖子最后跟帖的记录--%>
					<SPAN><A href="servletDetailPage?tid=<%=temp2.getTid()%>&sid=<%=sId%>&action=showDetail"><%=temp1.getTitle()%></A> </SPAN>
					<BR/>
					<SPAN><%=temp2.getAuthor()%></SPAN>
					<SPAN class="gray">[ <%=CommonDAO.getDateFormat(temp2.getPublishtime())%> ]</SPAN>

					<%		}else{
					%>
					<%--显示同一版块所有帖子最后发帖的记录--%>
					<SPAN><A href="servletDetailPage?tid=<%=temp1.getTid()%>&sid=<%=sId%>&action=showDetail"><%=temp1.getTitle()%></A></SPAN>
					<BR/>
					<SPAN><%=temp1.getAuthor()%></SPAN>
					<SPAN class="gray">[ <%=CommonDAO.getDateFormat(temp1.getPublishtime())%> ]</SPAN>
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
			<%--外层循环	结束--%>
		</TABLE>


	</DIV>
	<%
		}
	%>

	<table>
		<tr>
			<td colspan="3">
				<form action="${pageContext.request.contextPath}/FindServlet" >
					<input type="text" placeholder="请输入帖子名" name="partname" />
					<input type="submit" value="搜索"/>
				</form>
			</td>
		</tr>
	</table>

	<%
		if(!section_dao.isParentById(sid)){
	%>
	<!-- 主帖 -->

	<DIV class="t">
		<TABLE cellSpacing="0" cellPadding="0" width="100%">
			<TR>
				<TH class="h" style="WIDTH: 100%" colSpan="4">
					<SPAN>&nbsp;企业论坛</SPAN></TH>
			</TR>
			<%
				if(list==null||list.size()==0){
			%>
			<tr class="tr3">
				<td colspan="4">暂无数据！</td>
			</tr>
			<%
			}else{
			%>
			<TR class="tr2">
				<TD>&nbsp;</TD>
				<TD style="WIDTH: 80%" align="center">文章</TD>
				<TD style="WIDTH: 10%" align="center">作者</TD>
				<TD style="WIDTH: 10%" align="center">回复</TD>
			</TR>
			<%
				if(recordConut > 0){//如果记录数大于0
					for(int i = startIndex; i <= endIndex; i++){//进行遍历
			%>
			<TR class="tr3">
				<TD><IMG src="image/topic.gif" border=0></TD>
				<TD style="FONT-SIZE: 15px">
					<A href="servletDetailPage?tid=<%=list.get(i).getTid()%>
					&sid=<%=sid%>&action=showDetail">
						<%=list.get(i).getTitle()%></A>
				</TD>
				<TD align="center"><%=list.get(i).getAuthor()%></TD>
				<TD align="center"><%=list.get(i).getReplycount()%></TD>
			</TR>
			<%
						}
					}
				}
			%>
		</TABLE>
	</DIV>

	<!--         翻 页         -->
	<DIV class = "pages">
		<a href="servletListPage?sid=<%=sid%>&action=showPage&currPage=<%=PreviousPage%>">上一页</a>&nbsp;|&nbsp;
		<a href="servletListPage?sid=<%=sid%>&action=showPage&currPage=<%=nextPage%>">下一页</a>&nbsp;|&nbsp;
		<%
			if(PageCount > 0){
		%>
		<a href="servletListPage?sid=<%=sid%>&action=showPage&currPage=1"><<</a>&nbsp;
		<%-- 实现分页 主要代码二 开始	只显示x个页码导航按钮 --%>
		<%
			Integer x  = 3;//控制分页导航按钮显示的个数
			if(x > PageCount){//防止 x 超出分页总页数
				x = PageCount;
			}

			Integer pageNavigationStartIndex = 1;//分页导航按钮开始索引
			Integer pageNavigationEndIndex = x+1;//分页导航按钮结束索引

			if(PageCount == 1){
				pageNavigationStartIndex = 1;
				pageNavigationEndIndex = 2;
			}
			else
			if(currPage <= 1){//如果选择了最前一页
				pageNavigationStartIndex = 1;
			}
			else
			if(currPage >= PageCount){//如果选择了最后一页
				pageNavigationStartIndex = PageCount - (x-(x-1)) ;//分页导航开始索引
				pageNavigationEndIndex = PageCount + 1;//分页导航结束索引
			}
			else
			if(currPage >= x+1 && currPage < PageCount){//如果选择了最前一页与最后一页之间的区间
				pageNavigationEndIndex = currPage+1;
				pageNavigationStartIndex = pageNavigationEndIndex - x;
			}
		%>
		<%-- 实现分页 主要代码二 结束 --%>

		<%-- 实现分页 打印代码一 开始 --%>
		<%
			for(int i = pageNavigationStartIndex; i < pageNavigationEndIndex; i++){
		%>
		<a href="servletListPage?sid=<%=sid%>&action=showPage&currPage=<%=i%>"><%=i%></a>&nbsp;
		<%
			}
		%>
		<%-- 实现分页 打印代码一 结束 --%>
		<input style="width: 30px;height: 14px" type="text" onkeydown="javascript: if(event.keyCode==13){ location='servletListPage?&sid=<%=sid%>&action=showPage&currPage='+this.value+'';return false;}" \>
		<a href="servletListPage?sid=<%=sid%>&action=showPage&currPage=<%=PageCount%>">>></a>&nbsp;
		Pages:&nbsp;(&nbsp;<%=currPage %>&nbsp;/&nbsp;<%=PageCount %>&nbsp;total&nbsp;)
		&nbsp;
		<%
			}
		%>
	</DIV>
	<%
		}
	%>

</DIV>
<!--             声 明          -->
<BR/>
<CENTER class="gray">版权信息</CENTER>

</BODY>
</HTML>
