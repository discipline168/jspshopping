package com.discipline.java.controller;

import com.discipline.java.bean.Cart;
import com.discipline.java.bean.User;
import com.discipline.java.service.CartService;
import com.discipline.java.service.impl.CartServiceImpl;
import com.discipline.java.utils.Constant;
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
            response.getWriter().write("nouser");
            return null;

        }
        String size = request.getParameter("size");
        if(StringUtils.isEmpty(request.getParameter("gid"))
                || StringUtils.isEmpty(size)){
            /*request.setAttribute("msg","请求信息有误");
            return "forward:message.jsp";*/

            response.getWriter().write(Constant.REQUEST_PARAMETER_INCOMPLETE);
            return null;
        }
        int gid,quantity;

        try{
            gid = Integer.parseInt(request.getParameter("gid"));
            quantity = Integer.parseInt(request.getParameter("quantity"));
        }catch(NumberFormatException e){
            e.printStackTrace();
            request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
            return "forward:message.jsp";
        }


        Cart cart=new Cart();
        cart.setGid(gid);
        cart.setQuantity(quantity==0? 1: quantity);
        cart.setUid(user.getId());
        cart.setSize(size);

        int i = cartService.insertCart(cart);
        if(i<=0){
            /*request.setAttribute("msg","出了点小故障，加入购物车失败");
            return "forward:message.jsp";*/
            response.getWriter().write("出了点小故障，加入购物车失败");
            return null;
    }

        response.getWriter().write("success");
        return null;

    }


    public String list(HttpServletRequest request,HttpServletResponse response) throws SQLException {
        User user = (User) request.getSession().getAttribute("user");
        if(user==null)
            return "redirect: login.jsp";
        List<Cart> cartList = cartService.getCartList(user.getId());
        if (cartList!=null||cartList.size()>0) {
            request.setAttribute("cartList", cartList);
            request.setAttribute("size", cartList.size());
        }

        //System.out.println("cart list: " +cartList);
        return "forward:cart.jsp";
    }

    public String changeQuantity(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {

        response.setContentType("text/html;charset=UTF-8");
        if (StringUtils.isEmpty(request.getParameter("id"))
                ||StringUtils.isEmpty(request.getParameter("quantity"))){
            response.getWriter().write(Constant.REQUEST_PARAMETER_INCOMPLETE);
            return null;
        }
        int id,quantity;


        try {
            id = Integer.parseInt(request.getParameter("id"));
            quantity = Integer.parseInt(request.getParameter("quantity"));
        }catch (NumberFormatException e){
            e.printStackTrace();
            request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
            return "forward:message.jsp";
        }



        Cart cart = cartService.getCartById(id);
        if(cart==null){
            response.getWriter().write(Constant.REQUEST_RESOURCES_NOT_EXIT);
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
            response.getWriter().write(Constant.REQUEST_PARAMETER_INCOMPLETE);
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


    public String refreshMiniCart(HttpServletRequest request,HttpServletResponse response)  {
        //System.out.println("refresh");
        return "forward:commons/header.jsp";
    }




}
