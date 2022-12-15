package com.Filter;


import com.Bean.UserInfo;
import com.dao.UserInfoDAO;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 请求响应过滤器
 * @author jxn
 * @version 1.0
 * @Date 2022.12.10
 */
public class LoginFilter implements Filter {

    private UserInfoDAO udao = new UserInfoDAO();

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest)request;
        HttpServletResponse res = (HttpServletResponse)response;
        HttpSession session = req.getSession();

        //得到首次登录登录的用户信息
        UserInfo user = (UserInfo) session.getAttribute("users");
        //只要用户信息不为空，说明已登录了，直接放行，退出
        if(user != null){
            chain.doFilter(req, res);
            return;
        }
        //这里说明用户未登录，那么获取cookies并验证是否能登录
        if(req.getSession().getAttribute("users")==null )
        {
            Cookie[] cookies = req.getCookies();
            String username=null;
            String passwd=null;
            if(cookies!=null)
            {
                for(Cookie cookie:cookies)
                {
                    if(cookie.getName().equals("username"))
                    {
                        username = cookie.getValue();
                    }
                    else if(cookie.getName().equals("passwd"))
                    {
                        passwd =cookie.getValue();
                    }
                }
            }
            if(username!=null&&passwd!=null)
            {
                //匹配数据中的用户名以及密码
                //匹配成功则设置登录，否则退出登录
                if(udao.getUserInfo(username).getUpassword().equals(passwd)){
                    user = udao.getUserInfo(username);
                    req.getSession().setAttribute("users", user);
                    request.getRequestDispatcher("index.jsp").forward(req,res);
                }

            }

        }

        chain.doFilter(req, res);

    }

    @Override
    public void destroy() {

    }
}