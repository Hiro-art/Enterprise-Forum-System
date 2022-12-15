<%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2022/12/06
  Time: 22:31
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.page.*,com.dao.*"%>
<%@ page import="com.Bean.SectionInfo" %>
<%@ taglib prefix="wld" uri="TagForDividingPage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="section_dao" class="com.dao.SectionInfoDAO" scope="request"/>
<jsp:useBean id="topic_dao" class="com.dao.TopicInfoDAO" scope="request"/>
<jsp:useBean id="reply_dao" class="com.dao.ReplyInfoDAO" scope="request"/>
<jsp:useBean id="divPage_dao" class="com.pageDividing.DivPageDAO" scope="request"/>

<c:set var="sid" scope="session" value="${requestScope.sid}"/>
<c:set var = "user" scope="session" value ="${sessionScope.users}"/>
<c:set var="sectionInfoList" scope="session" value="${section_dao.getSectionById(sid)}"/>
<c:set var="list" scope="session" value="${requestScope.listPage}"/>
${pageContext.setAttribute("page_sid",sid)}
<jsp:useBean id="sectioninfo_dao" class="com.dao.SectionInfoDAO" scope="request"/>

<html>
<head>
    <meta charset="UTF-8">
    <title>企业论坛--帖子列表 </title>
    <link href="style/page.css" rel="stylesheet">
    <Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
    <link rel="stylesheet" type="text/css" href="style/showlogin.css">
    <link  href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>

<body>
<jsp:include page="showLogin.jsp"/>
<DIV>
</DIV>
<!--      导航以及搜索        -->
<div class="row" align="center" style="background-color:#d9d9d9">
    <div class="col-md-7">
        <ul class="nav nav-tabs sidebar" style="background-color: #d9d9d9">
            <li class="touch-bg"><a href="index.jsp" style="color: white">论坛首页</a></li>
            <c:forEach var="info" items="${sectioninfo_dao.getNavigationMenuById(page_sid)}">
                <li class="touch-bg">
                    <a href="servletListPage?sid=${info.sid}" style="color: white">${info.sname}</a>
                </li>
            </c:forEach>
            ${sectioninfo_dao.clearList()}
        </ul>
    </div>
    <div class="md col-md-5" style="padding-top: 5px;padding-right: 3%">
        <form action="${pageContext.request.contextPath}/FindServlet" >
            <input type="text" class="form-control" name="partname" placeholder="搜索...">
        </form>
    </div>
</div>


<!--      主体        -->
<div class="container">

    <c:if test="${!section_dao.isParentById(sid)}">
        <!--      新帖        -->
        <div class="mm row">

            <div class="col-md-5">
                <A href="post.jsp?tid=0&sid=${sid}&action=post">
                    <button type="button" class="btn ff"  name="td_post" border="0" id=td_post>发表话题</button>
                </A>
            </div>
            <div class="col-md-7">
                <c:set var="pageSize" scope="session" value="10"/>
                <c:set var="url" scope="session"
                       value="servletListPage?sid=${sid}"/>
                <wld:divPage pageSize="${pageSize}" pageNo="${pageNo}" url="${url}" recordCount="${divPage_dao.getTopicCountInfoSid(sid)}"/>

                <c:set var="pageNo" scope="session" value="${sessionScope.pageNo}"/>
                <!--divPage_dao-->
                <c:set var="thisPage" scope="session" value="${divPage_dao.CreatListPageInfoSid(sid,pageNo,pageSize)}"/>
            </div>
        </div>
    </c:if>

    <!-- 分页 -->
    <!--pageSize和pageNo在标签类DivPageTag设定好了-->
    <div class="divLeft">

        <c:set var="pageSize" scope="session" value="10"/>
        <c:set var="url" scope="session"
               value="servletListPage?sid=${sid}"/>
        <wld:divPage pageSize="${pageSize}" pageNo="${pageNo}" url="${url}" recordCount="${divPage_dao.getTopicCountInfoSid(sid)}"/>

        <c:set var="pageNo" scope="session" value="${sessionScope.pageNo}"/>
        <!--divPage_dao-->
        <c:set var="thisPage" scope="session" value="${divPage_dao.CreatListPageInfoSid(sid,pageNo,pageSize)}"/>

    </div>


    <!-- 子版块 -->
    <c:if test="${sectionInfoList.size() gt 0}">
        <div class="t">

            <table cellSpacing="0" cellPadding="0" width="100%">
                <tr>
                    <th class="h" style="WIDTH: 100%" colSpan="4"><span>&nbsp;子版块</span></th>
                </tr>
                <tr class="tr2" align="center">
                    <td colSpan="2">
                        论坛
                    </td>
                    <td style="WIDTH: 10%">
                        主题
                    </td>
                    <td style="WIDTH: 30%">
                        最后发表
                    </td>
                </tr>
                <!--       子版块      -->
                    <%--外层循环	开始--%>

                <c:forEach var="topic" items="${sectionInfoList}" varStatus="floor">
                    <tr class="tr3">
                        <td width="5%">
                            &nbsp;

                        </td>
                        <td align="left">
                            <img src="image/board.gif" alt="">
                            <A href="servletListPage?sid=${topic.getSid()}">${topic.getSname()}</A>
                        </td>
                        <td align="center">
                                ${topic.getStopiccount()}
                        </td>

                        <th>

                            <c:set var="sId" value="${sectionInfoList.sid}"/>
                            <c:set var="temp1" value="${topic_dao.getALLTopicLastTimeById(sId)}"/>
                            <c:set var="temp2" value="${reply_dao.getAllReplyLastTimeById(sId,tId)}"/>

                            <c:if test="${not empty temp1}">
                                <c:if test="${not empty temp2}">

                                    <%--显示同一版块所有帖子最后跟帖的记录--%>
                                    <span><A href="servletDetailPage?tid=${temp2.tid}
						&sid=${sId}>&action=showDetail">${temp2.title}</A></span><br/>
                                    <span>${temp2.author}</span>
                                    <span class="gray">
									[ ${common_dao.getDateFormat(temp2.publishtime)}]</span>
                                </c:if>
                                <c:if test="${empty temp2}">
									<SPAN><A href="servletDetailPage?tid${temp1.tid}
										&sid=${sId}&action=showDetail">${temp1.title}</A></SPAN>
                                    <br/>
                                    <span>${temp1.author}</span>
                                    <span class="gray">
									[ ${common_dao.getDateFormat(temp1.publishtime)}]</span>
                                </c:if>
                                <c:if test="${empty temp1}">
                                    <span>从未</span>
                                </c:if>
                            </c:if>
                        </th>
                    </tr>
                </c:forEach>
                    <%--外层循环	结束--%>
            </table>
        </div>
    </c:if>

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


    <c:if test="${!section_dao.isParentById(sid)}">
        <!-- 主帖 -->

        <div class="t">
            <table>
                <TR>
                    <TH class="h" style="WIDTH: 100%" colSpan="4">
                        <SPAN>&nbsp;企业论坛</SPAN></TH>
                </TR>

                <c:if test="${empty list || list.size() eq 0}">
                    <tr class="tr3">
                        <td colspan="4">暂无数据！</td>
                    </tr>
                </c:if>

                <c:if test="${not empty list && list.size() ne 0}">
                    <tr class="tr2">
                        <td>&nbsp;</td>
                        <td style="WIDTH: 80%" align="center">文章</td>
                        <td style="WIDTH: 10%" align="center">作者</td>
                        <td style="WIDTH: 10%" align="center">回复</td>
                    </tr>
                    <c:if test="${list.size() gt 0}">
                        <c:forEach var="topic" items="${thisPage.rows}">

                            <tr class="tr3">
                                <td><img src="image/topic.gif" ></td>
                                <td style="FONT-SIZE: 15px">
                                    <A href="servletDetailPage?tid=${topic.tid}
							&sid=${sid}&action=showDetail">
                                            ${topic.title}</A>
                                </td>
                                <td align="center">${topic.author}</td>
                                <td align="center">${topic.replycount}</td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </c:if>
            </table>
        </div>
    </c:if>

</div>
<!--             声 明          -->
<br/>
<center class="gray">版权信息</center>

<!-- jQuery and JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="script.js"></script>

</body>
</html>
