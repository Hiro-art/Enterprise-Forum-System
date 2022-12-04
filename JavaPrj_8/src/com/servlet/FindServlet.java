package com.servlet;

import com.Bean.TopicInfo;
import com.alibaba.fastjson.JSON;
import com.dao.TopicInfoDAO;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpRetryException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * <h3>JavaPrj_8</h3>
 * <p>FindServlet</p>
 *
 * @author : niujinwen
 * @version : 1.0
 * @Email : 472012824@qq.com
 * @date : 2022-11-28 03:00
 **/
@WebServlet("/FindServlet")
public class FindServlet extends HttpServlet {
    private ServletConfig config = null;				//��ʼ������
    private TopicInfoDAO dao = new TopicInfoDAO();		//����DAO

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String partname = request.getParameter("partname");
        System.out.println(partname);
        TopicInfoDAO es = new TopicInfoDAO();
        //������������
        ArrayList<TopicInfo> list = null;//��ѯ����
        try {
            list = es.findByPartName(partname);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("!!!!!!!!!!1��111��111����������11��");
        System.out.println(list);

        request.getSession().setAttribute("1", list);

        try{
            response.sendRedirect("query.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }

//        String json = JSON.toJSONString(list);
//        PrintWriter writer = response.getWriter();
//        writer.print(json);//����ǰ��
        //���ݴ���ǰ̨��ǰ̨��ʾ����
        //�����ݴ���ǰ̨
//        request.setAttribute("topicinfos",list);
//        request.getRequestDispatcher("/list.jsp").forward(request,response);
////        response.("topicinfos");
        //��ת��ҳ��
//        response.sendRedirect("list.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
//        request.getRequestDispatcher("list.jsp").forward(request, response);
    }
    public void init(ServletConfig config) throws ServletException {
        this.config = config;
    }
}

