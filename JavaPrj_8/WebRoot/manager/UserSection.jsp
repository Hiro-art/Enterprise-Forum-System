<%--
  Created by IntelliJ IDEA.
  User: 鹿白川
  Date: 2022/11/26
  Time: 上午 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ page import="java.util.*,com.dao.*,com.page.*,com.Bean.*"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSetMetaData" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
<DIV style="FONT-SIZE: 14px; PADDING-TOP: 60px; FONT-FAMILY: Arial" align=center>
    <DIV align="left">当前操作是：用户管理</DIV>
    <HR style="WIDTH: 99%; COLOR: #cccccc; HEIGHT: 1px;">
</DIV>
<table border="1" cellspacing="0">
    <tr>
        <td>编号</td>
        <td>用户名</td>
        <td>密码</td>
        <td>性别</td>
        <td>头像</td>
        <td>注册时间</td>
        <td>类别</td>
    </tr>

    <%
        BaseDAO baseDAO = new BaseDAO();
        String sql = "select * from userinfo";
        ResultSet lst = baseDAO.executeQuery(sql);

        ResultSetMetaData rsmd=lst.getMetaData();  //获取结果集的元数据
        int columns=rsmd.getColumnCount();  //获取结果集的列数

        while(lst.next()){
            for(int i=1;i<=columns;i++){
                if (i==1){
                    out.print("<tr><td>"+lst.getString(i));
                }
                if(i!=1 && i!= columns){
                    //修改输出性别
                    if (i==4){
                        if (lst.getString(i).equals("1")){
                            out.print("</td><td>"+"女");
                        }
                        else if (lst.getString(i).equals("0")){
                            out.print("</td><td>"+"男");
                        }
                    }else if (i==5){
                        out.print("</td><td>"+"<img src='../image/head/" + lst.getString(i)+ "'" +" width='40' height='40'>");
                    }
                    else{
                        out.print("</td><td>"+lst.getString(i));
                    }
                    //修改输出图片

                }

                if (i==columns){
                    if (lst.getString(i).equals("0")){
                        out.print("</td><td>"+"会员"+"</td></tr>");
                    }
                    else if (lst.getString(i).equals("1")){
                        out.print("</td><td>"+"版主"+"</td></tr>");
                    }
                    else if (lst.getString(i).equals("2")){
                        out.print("</td><td>"+"管理员"+"</td></tr>");
                    }
                }
            }
            System.out.println("\n");
        }
    %>
</table>

<DIV style="FONT-SIZE: 11px; PADDING-TOP: 60px; FONT-FAMILY: Arial" align=center>
    <HR style="WIDTH: 600px; COLOR: #cccccc; HEIGHT: 1px;">版权信息
</DIV>
</body>
</html>
