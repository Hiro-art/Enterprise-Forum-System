package com.tag;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

/**
 * @author ldy
 * 在首页index.jsp实施图片轮播
 */
public class ImageSection extends TagSupport {

    private int num=-1;     //传入“第几个论坛版块”

    public int doStartTag() throws JspException {

        String[] img={"image/section/sect1.png",
                "image/section/sect2.png",
                "image/section/sect3.png",
                "image/section/sect4.png",
                "image/section/sect5.png"};

        //拼写要输出到页面的HTML文本
        StringBuilder sb = new StringBuilder();
        if(num!=-1&&num!=0) {
            sb.append("<img src=\"");
            sb.append(img[num%3]);
            sb.append("\" alt=\"section\" style=\"position: absolute;width: 100%; height:100%;left: 0;\">");
        }
        if(num==0) {
            sb.append("<img src=\"");
            sb.append(img[0]);
            sb.append("\" alt=\"section\" style=\"position: absolute;width: 100%; height:100%;left: 0;\">");
        }

        //把生成的HTML输出到响应中
        try {
            pageContext.getOut().println(sb.toString());
        } catch (IOException e) {
            throw new JspException(e);
        }
        return SKIP_BODY;  //本标签主体为空,所以直接跳过主体
    }

    public void setNum(int num) {
        this.num = num;
    }

    public int getNum() {
        return num;
    }
}
