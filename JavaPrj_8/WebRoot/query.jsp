<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.page.*,com.dao.*,com.Bean.*"%>

<%-- 实现分页 主要代码一 结束 --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
    <TITLE>企业论坛--帖子列表</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=utf-8">
    <Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
</HEAD>
<body>


<DIV class="t">
    <TABLE cellSpacing="0" cellPadding="0" width="100%">
        <TR>
            <TH class="h" style="WIDTH: 100%" colSpan="4">
                <SPAN>&nbsp;Forum</SPAN></TH>
        </TR>

        <%
            Object topicInfos = session.getAttribute("1");
            if (null!=topicInfos && topicInfos instanceof ArrayList){
                ArrayList<TopicInfo> newlist = (ArrayList<TopicInfo>) topicInfos;
        %>

        <%
            if(newlist.size() == 0){
        %>

        <TR class="tr2">
            <TD>&nbsp;</TD>
            <TD style="WIDTH: 80%" align="center">article</TD>
            <TD style="WIDTH: 10%" align="center">author</TD>
            <TD style="WIDTH: 10%" align="center">reply</TD>
        </TR>
        <tr class="tr3">
            <td colspan="4">no number</td>
        </tr>
        <%
        }else{
        %>
        <TR class="tr2">
            <TD>&nbsp;</TD>
            <TD style="WIDTH: 80%" align="center">article</TD>
            <TD style="WIDTH: 10%" align="center">author</TD>
            <TD style="WIDTH: 10%" align="center">reply</TD>
        </TR>

        <%
        for(TopicInfo topicInfo:newlist){
        %>

        <TR class="tr3">
            <TD><IMG src="image/topic.gif" border=0></TD>
            <TD style="FONT-SIZE: 15px">
                <A href="servletDetailPage?tid=<%=topicInfo.getTid()%>
					&sid=<%=topicInfo.getTsid()%>&action=showDetail">
                    <%=topicInfo.getTtopic()%>
            </TD>
            <TD align="center"><%=topicInfo.getTuid()%></TD>
            <TD align="center"><%=topicInfo.getTreplycount()%></TD>
        </TR>
        <%
        }
        %>
        <%
            }
            }
        %>

    </TABLE>
</DIV>

</body>
</html>
