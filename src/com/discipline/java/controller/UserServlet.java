package com.discipline.java.controller;

import cn.dsna.util.images.ValidateCode;
import com.discipline.java.bean.User;
import com.discipline.java.service.UserService;
import com.discipline.java.service.impl.UserServiceImpl;
import com.discipline.java.utils.Md5Utils;
import org.apache.commons.lang3.StringUtils;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;


@WebServlet("/userservlet")
public class UserServlet extends BaseServlet {

    private UserService userService = new UserServiceImpl();



    public String active(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        String email = request.getParameter("email");
        String code = request.getParameter("code");
        int result = userService.activeUser(email, code);

        if (result > 0) {
            request.setAttribute("msg", "激活成功，<a href='/login.jsp'>点此登录</a>");
        } else {
            request.setAttribute("msg", "激活失败");
        }

        return "forward:/message.jsp";
    }

    //验证码校验
    public String code(HttpServletRequest request, HttpServletResponse response) throws IOException {

        // 声明响应内容为图片数据
        response.setContentType("image/jpeg");

        // 告知浏览器无需缓存数据
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0L);

        // 创建一个规格的验证码对象
        ValidateCode vCode = new ValidateCode(120, 40, 4, 100);

        // 将验证码存储到Session中
        request.getSession().setAttribute("vcode", vCode.getCode());

        // 将验证码写出到浏览器
        vCode.write(response.getOutputStream());

        return null;
    }


    //验证邮箱唯一性(已激活)
    public String checkEmailUnique(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {

        User user = userService.getUserByEmail(request.getParameter("email"));
        if(user!=null)
            response.getWriter().write("false");
        else
            response.getWriter().write("success");

        return null;
    }


    //注册
    public String register(HttpServletRequest request, HttpServletResponse response) throws InvocationTargetException, IllegalAccessException, SQLException {

        String vcode= request.getParameter("vcode");
        if (StringUtils.isEmpty(vcode) || !vcode.equalsIgnoreCase((String) request.getSession().getAttribute("vcode"))) {
            request.setAttribute("registerMsg", "验证码有误");
            return "forward:/register.jsp";
        }


        //后端判断邮箱唯一性
        if(userService.getUserByEmail(request.getParameter("email"))!=null){
            request.setAttribute("registerMsg", "注册失败");
            return "forward:/register.jsp";
        }
        User  user = new User();
        user.setEmail(request.getParameter("email"));
        user.setUsername(request.getParameter("username"));
        //md5加密存储
        user.setPassword(Md5Utils.md5(request.getParameter("password")));

        if(StringUtils.isEmpty(user.getEmail())||StringUtils.isEmpty(user.getUsername())||StringUtils.isEmpty(user.getPassword())){
            request.setAttribute("registerMsg", "请确保注册信息完整");
            return "forward:/register.jsp";
        }


        int result = 0;

        try {
            result = userService.insertUser(user);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (result <= 0) {
            request.setAttribute("registerMsg", "注册失败");
            return "forward:/register.jsp";
        }

        request.setAttribute("msg", "注册成功，请前往邮箱进行验证");
        return "forward:/message.jsp";
    }

    //登录
    public String login(HttpServletRequest request, HttpServletResponse response) {

        String vcode= request.getParameter("vcode");
        if (StringUtils.isEmpty(vcode) || !vcode.equalsIgnoreCase((String) request.getSession().getAttribute("vcode"))) {
            request.setAttribute("loginMsg", "验证码有误");
            return "forward:/login.jsp";
        }

        User user = null;

        try {
            user = userService.getUser(request.getParameter("email"), Md5Utils.md5(request.getParameter("password")));
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (user == null) {
            request.getSession().setAttribute("loginMsg", "邮箱或密码错误");
            return "forward:/login.jsp";
        }
        if(user.getFlag()==0){
            request.getSession().setAttribute("loginMsg", "此邮箱尚未激活，请前往邮箱进行激活");
            return "forward:/login.jsp";
        }
        request.getSession().setAttribute("user", user);

        //自动登录
        String disciplinepro = request.getParameter("rememberme");


        if (disciplinepro != null) {
            Cookie cookie = new Cookie("disciplinepro", user.getEmail() + "#" + user.getPassword());
            //设置cookie生命周期为7天
            cookie.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(cookie);
        }

        return "redirect:/account.jsp";
    }


    //登出
    public String logout(HttpServletRequest request, HttpServletResponse response) {

        request.getSession().invalidate();

        //消除cookie
        Cookie cookie = new Cookie("disciplinepro", "");
        cookie.setMaxAge(0);
        response.addCookie(cookie);

        return "redirect:/";
    }

    //使用代金券
    public String coupon(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        User user = (User) request.getSession().getAttribute("user");
        response.setContentType("text/html;charset=UTF-8");

        if(user==null||StringUtils.isEmpty(request.getParameter("code"))) {
            response.getWriter().write("请求参数有误");
        }
        else{
            if(!"discipline".equalsIgnoreCase(request.getParameter("code"))){
                response.getWriter().write("代金券代码有误");
            }else{
                int result = userService.applyCoupon(user.getId());
                //更新用户信息
                request.getSession().setAttribute("user",userService.getUser(user.getEmail(),user.getPassword()));
                if(result>0) {
                    response.getWriter().write("success");
                }
            }
        }

        return null;
    }






}


