<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file ="checkLogin.jsp" %>
<%
	//获得请求对象的属性
	Integer sid = (Integer)request.getAttribute("sid");
	Integer tid = (Integer)request.getAttribute("tid");
	TopicInfo edittopic = (TopicInfo)request.getAttribute("edittopic");
	ReplyInfo editreply = (ReplyInfo)request.getAttribute("editreply");
	String action = (String)request.getAttribute("action");
	//设置pageCoontex属性 
	pageContext.setAttribute("page_sid",sid);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
<TITLE>企业论坛--修改帖子</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
<script type="text/javascript">
function check(flag){
	var topic = document.updateForm.title.value;
	var content = document.updateForm.content.value;
	var regTopic = /^.{4,20}$/;
	var regContent = /^(.|[\r\n]){1,1000}$/;
	if(flag){
		if(topic==="" || !topic.match(regTopic)){
			alert("标题不能为空,长度在4-20");
			return false;
		}
		
	}
	
	if(content==="" || !content.match(regContent)) {
		alert("内容不能为空，并且长度不大于1000");
		return false;
	}
}
</script>
</HEAD>

<BODY>
<DIV>
</DIV>
<!--      用户信息、登录、注册        -->

<DIV class="h">
<%@ include file="showLogin.jsp" %>
</DIV>


<!--      主体        -->
<DIV><BR></BR>
	<!--      导航        -->
	<DIV>
		&gt;&gt;<B><a href="index.jsp">论坛首页</a></B><%@ include file="navigation.jsp" %>
	</DIV><BR></BR>
	<!-- 修改主帖的表单 -->
	<%
		if("edittopic".equals(action.toLowerCase())){
	%>
	<DIV>
		<FORM name="updateForm" onSubmit="return check(1);" action="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&action=updateTopic" method="post">
			<INPUT type="hidden" name="boardId" value="8"></INPUT>
			<INPUT type="hidden" name="replyId" value="61"></INPUT>
			<DIV class="t">
				<TABLE cellSpacing="0" cellPadding="0" align="center">
				 
				    <TR>
					    <TD class="h" colSpan="3"><B>修改主帖</B></TD>
				    </TR>
				
				    <TR class="tr3">
					    <TH width="20%"><B>标题</B></TH>
					    <TH><INPUT name="title" value="<%=edittopic.getTtopic()%>" class="input" style="PADDING-LEFT: 2px; FONT: 14px Tahoma" tabIndex="1" size="60"></TH>
				    </TR>
				 
				    <TR class="tr3">
					    <TH vAlign="top">
					      <DIV><B>内容</B></DIV>
					    </TH>
					    <TH colSpan="2">
					        <DIV>
						        <span><textarea  name="content" style="WIDTH: 500px;word-break:break-all;" rows="20" cols="90" tabIndex="2" ><%=edittopic.getTcontents() %></textarea></span>
						    </DIV>
					      (不能大于:<FONT color="blue">1000</FONT>字)
					    </TH>
					</TR>
				</TABLE>
			</DIV>

			<DIV style="MARGIN: 15px 0px; TEXT-ALIGN: center">
				<INPUT class="btn" tabIndex="3" type="submit" value="修 改"> 
			</DIV>
		</FORM>
	</DIV>
	<!-- 修改跟帖的表单 -->
	<%
		}else if("editreply".equals(action.toLowerCase())){
	%>
		<DIV>
		<FORM name="updateForm" onSubmit="return check(0);" action="servletDetailPage?tid=<%=tid%>&sid=<%=sid%>&rid=<%=editreply.getRid()%>&action=updateReply" method="post">
			<INPUT type="hidden" name="boardId" value="8"></INPUT>
			<INPUT type="hidden" name="replyId" value="61"></INPUT>
			<DIV class="t">
				<TABLE cellSpacing="0" cellPadding="0" align="center">
				 
				    <TR>
					    <TD class="h" colSpan="3"><B>修改回帖</B></TD>
				    </TR>
				
				    <TR class="tr3">
					    <TH width="20%"><B>标题</B></TH>
					    <TH><INPUT name="title" value="<%=editreply.getRtopic()%>" class="input" style="PADDING-LEFT: 2px; FONT: 14px Tahoma" tabIndex="1" size="60"></TH>
				    </TR>
				 
				    <TR class="tr3">
					    <TH vAlign="top">
					      <DIV><B>内容</B></DIV>
					    </TH>
					    <TH colSpan="2">
					        <DIV>
						        <span><textarea  name="content" style="WIDTH: 500px;word-break:break-all;" rows="20" cols="90" tabIndex="2" ><%=editreply.getRcontents() %></textarea></span>
						    </DIV>
					      (不能大于:<FONT color="blue">1000</FONT>字)
					    </TH>
					</TR>
				</TABLE>
			</DIV>

			<DIV style="MARGIN: 15px 0px; TEXT-ALIGN: center">
				<INPUT class="btn" tabIndex="3" type="submit" value="修 改"> 
			</DIV>
		</FORM>
	</DIV>
	<%
	 	}
	%>
	<!--      声明        -->
	<BR/>
</DIV>
<CENTER class="gray">版权信息</CENTER>

</BODY>
</HTML>
