package com.tag;

import com.Bean.SectionInfo;
import com.dao.ManagerDAO;
import com.dao.SectionInfoDAO;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;
import java.util.List;

public class ManagerSection extends SimpleTagSupport {
    private List<SectionInfo> listParent = null;
    SectionInfoDAO section_dao = new SectionInfoDAO();
    ManagerDAO manager_dao = new ManagerDAO();
    List<SectionInfo> f(int id){
        SectionInfoDAO section_dao = new SectionInfoDAO();
        List<SectionInfo> list = section_dao.getSectionById(id);

        if(list.size() == 0){
            return null;
        }
        for(int i = 0 ; i < list.size(); i++){
            id = list.get(i).getSid();
            f(id);
        }
        return list;
    }
    @Override
    public void doTag() throws JspException, IOException {
        JspWriter out = getJspContext().getOut();
        listParent = section_dao.getSectionById(0);
        List<String> strList = manager_dao.getAllSectionByList(listParent);
        for(int i = 0; i < strList.size(); i++){
            out.println(strList.get(i));
        }
    }
}
