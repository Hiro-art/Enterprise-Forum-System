package com.tag;

import com.dao.BaseDAO;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class UserSection extends TagSupport {
    @Override
    public int doStartTag() throws JspException {
        JspWriter out = pageContext.getOut();
        ServletRequest request = pageContext.getRequest();
        BaseDAO baseDAO = new BaseDAO();
        String sql = "select * from userinfo";
        ResultSet lst = null;
        try {
            lst = baseDAO.executeQuery(sql);
            ResultSetMetaData rsmd=lst.getMetaData();  //获取结果集的元数据
            int columns=rsmd.getColumnCount();  //获取结果集的列数
            request.setAttribute("lst",lst);
            request.setAttribute("columns",columns);
            System.out.println(columns);
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
                        }else if(i==7){
                            if (lst.getString(i).equals("0")){
                                out.print("</td><td>"+"会员");
                            }
                            else if (lst.getString(i).equals("1")){
                                out.print("</td><td>"+"版主");
                            }
                            else if (lst.getString(i).equals("2")){
                                out.print("</td><td>"+"管理员");
                            }
                        }
                        else{
                            out.print("</td><td>"+lst.getString(i));
                        }
                        //修改输出图片
                    }
                    if (i==columns){
                        if (lst.getString(i).equals("1")){
                            out.print("</td><td>"+"正常"+"</td></tr>");
                        }
                        else if (lst.getString(i).equals("0")){
                            out.print("</td><td>"+"锁定"+"</td></tr>");
                        }
                    }
                }
                System.out.println("\n");
            }
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }

        return SKIP_BODY;
    }
}
