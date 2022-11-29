package com.servlet;

import com.Bean.UserInfo;
import com.dao.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.match.*;
public class ServletDeleteUser extends HttpServlet{

    private UserInfoDAO udao = new UserInfoDAO();
    private ServletConfig config;
    private CheckDAO check_dao = new CheckDAO();

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uID = "";
        String s = config.getInitParameter("character");


        /**
         * ----------------------------------------------------------
         */
        response.setCharacterEncoding("utf-8");
        /**
         * ----------------------------------------------------------
         */


        response.setContentType("text/html");
        request.setCharacterEncoding(s);
        response.setCharacterEncoding(s);
        PrintWriter out = response.getWriter();
        //
        uID = request.getParameter("uId");

        if (!check_dao.checkUserIdIsExist(uID)) {
            out.print("<script>" + "alert('用户编号不存在，请重新输入');"
                    + "window.history.back();" + "</script>");
            return;
        }

        if (udao.deleteUser(uID)) {
            //
            out.println("删除成功！");
            response.sendRedirect("manager/UserSection.jsp");
        } else {
            //
            out.println("删除失败！");
        }
    }

    public void init(ServletConfig config) throws ServletException {
        this.config = config;
    }

}
