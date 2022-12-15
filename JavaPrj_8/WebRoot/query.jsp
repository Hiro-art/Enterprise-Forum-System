<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.page.*,com.dao.*,com.Bean.*"%>

<%-- 实现分页 主要代码一 结束 --%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
    <TITLE>企业论坛--帖子列表</TITLE>
    <META http-equiv=Content-Type content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="style/showlogin.css">
    <Link rel="stylesheet" type="text/css" href="style/style.css"></Link>
    <link rel="stylesheet" type="text/css" href="style/styleSheet.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link  href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</HEAD>
<body style="padding-top: 100px;margin-bottom: 0;">

<jsp:include page="showLogin.jsp"/>

<DIV class="container" style="padding-top: 2%">
    <table>
        <TR>
            <Th style="WIDTH: 100%;background-color: #e0f0f9;COLOR: #004c7d; padding: 5px 7px 3px;" colSpan="4">
                <SPAN>&nbsp;Forum</SPAN></Th>
        </TR>
        <c:set var="topicInfo" value="${sessionScope.find}"/>
        <c:if test="${empty topicInfo}">
        <tr style="height: 50px;background-color:#b2d7b5 ;border-style: solid;border-color: #b2d7b5;border-width: medium">
            <td>&nbsp;</td>
            <td style="WIDTH: 60%" align="center">article</td>
            <td style="WIDTH: 20%" align="center">author</td>
            <td style="WIDTH: 20%" align="center">reply</td>
        </tr>
        <tr style="height: 40px;border-style: solid;border-color: #dbdbdb;border-width: medium">
            <td align="center" style="color: #818a89">no number</td>
        </tr>
        </c:if>
        <c:if test="${not empty topicInfo}">
        <tr style="height: 50px;background-color:#b2d7b5 ;border-style: solid;border-color: #b2d7b5;border-width: medium">
            <td>&nbsp;</td>
            <td style="WIDTH: 60%" align="center">article</td>
            <td style="WIDTH: 20%" align="center">author</td>
            <td style="WIDTH: 20%" align="center">reply</td>
        </tr>
            <c:forEach var="info" items="${topicInfo}">
                <tr style="height: 40px;border-style: solid;border-color: #dbdbdb;border-width: medium">
                    <td><IMG src="image/topicLogo.png"></td>
                    <td style="FONT-SIZE: 15px">
                        <a href="servletDetailPage?tid=${info.tid}
					&sid=${info.tsid}&action=showDetail">
                                    ${info.ttopic}
                    </td>
                    <td align="center" style="color: #818a89">${info.tuid}</td>
                    <td align="center" style="color: #818a89">${info.treplycount}</td>
                </tr>
            </c:forEach>
        </c:if>
    </table>
</DIV>

<div style="height: 500px"></div>
<!--统一的尾部：版权信息-->
<jsp:include page="information.jsp"/>

</body>
</html>
