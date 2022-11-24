<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.page.*,com.dao.*,com.Bean.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	UserInfoDAO user_dao = new UserInfoDAO();
	
	//获得请求对象的属性
	Integer sid = (Integer)request.getAttribute("sid");
	Integer tid = (Integer)request.getAttribute("tid");
	List<DetailPage> replyList = (List<DetailPage>)request.getAttribute("replyListDetailPage");
	DetailPage topicObj = (DetailPage)request.getAttribute("topicListDetailPage");
	
	//初始化分页变量
	Integer currPage = 1;//默认选择第一页
	Integer recordConut = 0;//记录总数
	Integer PageCount = 0;//分页的总页数
	Integer pageNum  = 4;//每页显示的记录数
	Integer startIndex = 0;//开始索引
	Integer endIndex = 0;//结束索引
	Integer nextPage = 0;
	Integer PreviousPage = 0;
	
	//获得请求对象的分页参数
	String action = request.getParameter("action");
	
	//设置pageCoontex属性 
	pageContext.setAttribute("page_sid",sid);
	//获得登录用户的信息
	UserInfo users = (UserInfo) session.getAttribute("users");
%>
<%-- 实现分页 主要代码一 开始 --%>
<%
	recordConut = replyList.size();
	//int result = recordConut % pageNum;
	//if(result != 0){//获得分页的总页数
		//PageCount = (recordConut / pageNum) + 1;
	//}else{
	//	PageCount = (recordConut / pageNum); 
	//}
	PageCount = (recordConut + (pageNum-1))/pageNum;//获得分页的总页数
	
	if("showpage".equals(action.toLowerCase())){//获得当前选择的页码
	
		//currPage = Integer.parseInt(request.getParameter("currPage"));
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
 <base href="<%=basePath%>">
<TITLE>企业论坛--看贴</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
</HEAD>

<BODY>
<DIV>
</DIV>

<!--      用户信息、登录、注册        -->

	<DIV class="h">
	<jsp:include page="showLogin.jsp"></jsp:include>
	<%-- include file="showLogin.jsp" --%>
	</DIV>

<!--      主体        -->
<DIV><br/>
	<!--      导航        -->
<DIV>
	&gt;&gt;<B><a href="index.jsp">论坛首页</a></B><%@ include file="navigation.jsp" %>
</DIV>
	<br/>

	<!--      回复、新帖        -->
	<DIV>
		<A href="post.jsp?tid=<%=tid%>&sid=<%=sid%>&action=reply"><IMG src="image/reply.gif"  border="0" id=td_post></A> 
		<A href="post.jsp?tid=<%=tid%>&sid=<%=sid%>&action=post"><IMG src="image/post.gif"   border="0" id=td_post></A>
	</DIV>

	<!--         翻 页         -->
	<DIV class="pages">
	
	<a href="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&action=showPage&currPage=<%=--PreviousPage%>">上一页</a>&nbsp;|&nbsp;
		<a href="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&action=showPage&currPage=<%=++nextPage%>">下一页</a>&nbsp;|&nbsp;
	<%
		if(PageCount > 0){
	%>
		<a href="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&action=showPage&currPage=1"><<</a>&nbsp;
		
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
		<a href="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&action=showPage&currPage=<%=i%>"><%=i%></a>&nbsp;
	<%
		} 
	%>
	<%-- 实现分页 打印代码一 结束 --%>
		<input style="width: 30px;height: 14px" type="text" onkeydown="javascript: if(event.keyCode==13){ location='servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&action=showPage&currPage='+this.value+'';return false;}" \>
		<a href="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&action=showPage&currPage=<%=PageCount%>">>></a>&nbsp;
		Pages:&nbsp;(&nbsp;<%=currPage %>&nbsp;/&nbsp;<%=PageCount %>&nbsp;total&nbsp;)
		&nbsp; 
	<%
		}
	%>
	
	</DIV>
	<!--      本页主题的标题        -->
	<DIV>
		<TABLE cellSpacing="0" cellPadding="0" width="100%">
			<TR>
				<TH class="h">本页主题: <%=topicObj.getTitle()%></TH>
			</TR>
			<TR class="tr2">
				<TD>&nbsp;</TD>
			</TR>
		</TABLE>
	</DIV>
	
	<!--      主题        -->
	
	<DIV class="t">
		<TABLE style="BORDER-TOP-WIDTH: 0px; TABLE-LAYOUT: fixed" 
						cellSpacing="0" cellPadding="0" width="100%">
		<TR class="tr1">
		<TH style="WIDTH: 20%">
			<b>#1</b><br/>
			<B><%=topicObj.getName()%></B><BR/> 
			组别：<%=user_dao.getUserTypeNameById(topicObj.getType()) %><br/>
			性别：<%=user_dao.getSexName(topicObj.getSex()) %><br/>
			<img src="image/head/<%=topicObj.getFace()%>"/><BR/>
			注册:<%=topicObj.getRegtime()%><BR/>
		</TH>
		<TH>
			<H4><%=topicObj.getTitle()%></H4>
			<DIV><%=topicObj.getContents()%></DIV>
			<DIV class="tipad gray">
			发表：[<%=CommonDAO.getDateFormat(topicObj.getPublishtime())%>] &nbsp;
			<%
				if(topicObj.getModifytime()!=null){
			%>
				最后修改:[<%=CommonDAO.getDateFormat(topicObj.getModifytime())%>]
			<%
				}
			%>
			<%
				//只有管理员能修改
				if(users != null && users.getUtype() == 2 ){ 
			%>
			 <A href="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&action=delTopic"
			  onclick = "return confirm('确定要删除吗?');">[删除]</A>
			<%
			 	} 
			%>
			<%
				//只有管理员和当前帖发帖用户能修改
				if(users != null && (users.getUtype() == 2 ||
									 users.getUid() == topicObj.getUid())){ 
			%>
				<A href="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>
							&action=editTopic">[修改]</A>
			<%
			 	} 
			%>
			</DIV>
		</TH>
		</TR>
		</TABLE>
	</DIV>
	
	<!--      回复        -->

	<%
		if(recordConut > 0){
			for(int i = startIndex; i <= endIndex; i++){
	%>
		<DIV class="t">
	<TABLE style="BORDER-TOP-WIDTH: 0px; TABLE-LAYOUT: 
				fixed" cellSpacing="0" cellPadding="0" width="100%">
	<TR class="tr1">
	<TH style="WIDTH: 20%">
		<b>#<%=i+2%></b><br/>
		<B><%=replyList.get(i).getName()%></B><BR/> 
		组别：<%=user_dao.getUserTypeNameById(replyList.get(i).getType()) %><BR/>
		性别：<%=user_dao.getSexName(replyList.get(i).getSex()) %><br/>
		<img src="image/head/<%=replyList.get(i).getFace()%>"/><BR/>
		注册:<%=replyList.get(i).getRegtime()%><BR/>
	</TH>
	<TH>
		<H4><%=replyList.get(i).getTitle()%></H4>
		<DIV><%=replyList.get(i).getContents()%></DIV>
		<DIV class="tipad gray">
			发表：[<%=CommonDAO.getDateFormat(replyList.get(i).getPublishtime())%>] &nbsp;
			<%
				if(replyList.get(i).getModifytime()!=null){
			%>
				最后修改:[<%=CommonDAO.getDateFormat(replyList.get(i).getModifytime())%>]
			<%
				}
			 %>
			 <%
				//只有管理员能修改
				if(users != null && users.getUtype() == 2 ){ 
			%>
			<A href="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&rid=
				<%=replyList.get(i).getId()%>&action=delReply"
					 onclick="return confirm('确定要删除吗?');">[删除]</A>
			<%
				}
			%>
			<%
				//只有管理员和当前帖发帖用户能修改
				if(users != null && (users.getUtype() == 2 ||
								 users.getUid() == replyList.get(i).getUid())){ 
			%>
			<A href="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&rid=
								<%=replyList.get(i).getId()%>&action=editReply">[修改]</A>
			<%
				} 
			%>
		</DIV>
	</TH>
	</TR>
	</TABLE>
		</DIV>
	<%			}
			} 
	%>
</DIV>
<!--         翻 页         -->
	<DIV class="pages">
	
	<a href="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&action=showPage&currPage=<%=PreviousPage%>">上一页</a>&nbsp;|&nbsp;
		<a href="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&action=showPage&currPage=<%=nextPage%>">下一页</a>&nbsp;|&nbsp;
	<%
		if(PageCount > 0){
	%>
		<a href="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&action=showPage&currPage=1"><<</a>&nbsp;
		
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
		<a href="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&action=showPage&currPage=<%=i%>"><%=i%></a>&nbsp;
	<%
		} 
	%>
	<%-- 实现分页 打印代码一 结束 --%>
		<input style="width: 30px;height: 14px" type="text" onkeydown="javascript: if(event.keyCode==13){ location='servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&action=showPage&currPage='+this.value+'';return false;}" \>
		<a href="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&action=showPage&currPage=<%=PageCount%>">>></a>&nbsp;
		Pages:&nbsp;(&nbsp;<%=currPage %>&nbsp;/&nbsp;<%=PageCount %>&nbsp;total&nbsp;)
		&nbsp; 
	<%
		}
	%>
	
	</DIV>
<!--      声明        -->
<BR>
<CENTER class="gray">版权信息</CENTER>
</BODY>
</HTML>

