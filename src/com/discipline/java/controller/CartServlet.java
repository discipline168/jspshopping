package com.discipline.java.controller;

import com.discipline.java.bean.Cart;
import com.discipline.java.bean.User;
import com.discipline.java.service.CartService;
import com.discipline.java.service.impl.CartServiceImpl;
import com.sun.deploy.net.HttpResponse;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/cartservlet")
public class CartServlet extends BaseServlet {
    private CartService cartService=new CartServiceImpl();


    public String addToCart(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        response.setContentType("text/html;charset=UTF-8");
        if (user==null) {
            //return "redirect: /login.jsp";
            response.getWriter().write("nouser");
            return null;

        }
        String size = request.getParameter("size");
        if(StringUtils.isEmpty(request.getParameter("gid"))
                || StringUtils.isEmpty(size)){
            /*request.setAttribute("msg","请求信息有误");
            return "forward:/message.jsp";*/

            response.getWriter().write("请求参数缺失");
            return null;
        }

        int gid = Integer.parseInt(request.getParameter("gid"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        Cart cart=new Cart();
        cart.setGid(gid);
        cart.setQuantity(quantity==0? 1: quantity);
        cart.setUid(user.getId());
        cart.setSize(size);

        int i = cartService.insertCart(cart);
        if(i<=0){
            /*request.setAttribute("msg","出了点小故障，加入购物车失败");
            return "forward:/message.jsp";*/
            response.getWriter().write("出了点小故障，加入购物车失败");
            return null;
    }

        response.getWriter().write("success");
        return null;

    }


    public String list(HttpServletRequest request,HttpServletResponse response) throws SQLException {
        User user = (User) request.getSession().getAttribute("user");
        if(user==null)
            return "redirect:/login.jsp";
        List<Cart> cartList = cartService.getCartList(user.getId());
        if (cartList!=null||cartList.size()>0)
            request.setAttribute("cartList",cartList);

        System.out.println("cart list: " +cartList);
        return "forward:/cart.jsp";
    }

    public String changeQuantity(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {

        response.setContentType("text/html;charset=UTF-8");
        if (StringUtils.isEmpty(request.getParameter("id"))
                ||StringUtils.isEmpty(request.getParameter("quantity"))){
            response.getWriter().write("请求参数缺失");
            return null;
        }
        int id = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Cart cart = cartService.getCartById(id);
        if(cart==null){
            response.getWriter().write("请求信息不存在");
            return null;
        }
        cart.setQuantity(quantity);
        cartService.updateCart(cart);
        response.getWriter().write("success");

        return null;
    }
    public String deleteFromCart(HttpServletRequest request,HttpServletResponse response) throws IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        if (StringUtils.isEmpty(request.getParameter("id"))){
            response.getWriter().write("请求参数缺失");
            return null;
        }
        int id = Integer.parseInt(request.getParameter("id"));

        int i = cartService.deleteFromCart(id);
        if(i>0)
            response.getWriter().write("success");
        else
            response.getWriter().write("删除购物车信息失败");

        return null;
    }
}
