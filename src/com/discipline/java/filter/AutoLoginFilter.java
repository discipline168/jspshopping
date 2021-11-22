package com.discipline.java.filter;

import com.discipline.java.bean.User;
import com.discipline.java.service.UserService;
import com.discipline.java.service.impl.UserServiceImpl;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.sql.SQLException;

@WebFilter(
    filterName = "AutoLoginFilter",
    value      = { "/*"}
)
public class AutoLoginFilter implements Filter {
    private UserService userService = new UserServiceImpl();

    @Override
    public void destroy() {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
            throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;

        // 获取所有Cookie
        Cookie[] cookies = request.getCookies();

        if (cookies != null) {

            for (Cookie cookie : cookies) {
                if ("disciplinepro".equals(cookie.getName())) {
                    String[] strs = cookie.getValue().split("#");

                    User user=null;
                    try{
                        user = userService.getUser(strs[0], strs[1]);
                    }catch(SQLException e){
                        e.printStackTrace();
                    }

                    if (user != null)
                        request.getSession().setAttribute("user", user);

                    break;
                }
            }
        }

        //放行
        chain.doFilter(request, resp);
    }

    @Override
    public void init(FilterConfig config) throws ServletException {}
}


