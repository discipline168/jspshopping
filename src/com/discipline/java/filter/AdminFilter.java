package com.discipline.java.filter;

import com.discipline.java.bean.User;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(
        filterName = "AdminFilter",
        value      = { "/admin/*"}
)
public class AdminFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        User user = (User)request.getSession().getAttribute("user");
        if(user!=null){
            //管理员放行
            if(user.getRole()==1)
                chain.doFilter(request,resp);
            else
                response.sendRedirect("index.jsp");

        }else
            response.sendRedirect("../login.jsp");
    }

    @Override
    public void destroy() {

    }
}
