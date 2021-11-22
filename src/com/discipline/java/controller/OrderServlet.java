package com.discipline.java.controller;

import com.alipay.service.schema.util.StringUtil;
import com.discipline.java.bean.*;
import com.discipline.java.service.*;
import com.discipline.java.service.impl.*;
import com.discipline.java.utils.DruidUtils;
import com.discipline.java.utils.OrderUtils;
import org.apache.commons.lang3.StringUtils;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.DelayQueue;
import java.util.concurrent.TimeUnit;

@WebServlet("/orderservlet")
public class OrderServlet extends  BaseServlet{

    private UserService userService=new UserServiceImpl();
    private CartService cartService=new CartServiceImpl();
    private AddressService addressService=new AddressServiceImpl();
    private GoodsService goodsService=new GoodsServiceImpl();
    private OrderService orderService=new OrderServiceImpl();
    private OrderDetailService orderDetailService=new OrderDetailServiceImpl();
    //延迟队列
    private DelayQueue<Order> delayQueue=new DelayQueue<>();


    //支付信息预览
    public String checkout(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        User user = (User) request.getSession().getAttribute("user");
        if(user==null)
            return "redirect:/login.jsp";

        List<Cart> checkList = new ArrayList<>();


        //不指定cid默认支付信息包含购物车所有商品
        if(StringUtils.isEmpty(request.getParameter("cid"))){
            checkList = cartService.getCartList(user.getId());
            if(checkList.size()==0){
                request.setAttribute("msg","请求有误");
                return "forward:/message.jsp";
            }
            request.setAttribute("checkList",checkList);
            request.setAttribute("total",cartService.getTotalPrice(checkList));

        }
        //单件
        else{
            int cid;
            try{
                cid=Integer.parseInt(request.getParameter("cid"));
            }catch(NumberFormatException e){
                e.printStackTrace();
                request.setAttribute("msg","请求参数格式错误");
                return "forward:/message.jsp";
            }
            Cart cart = cartService.getCartById(cid);
            if(cart==null){
                request.setAttribute("msg","请求参数错误");
                return "forward:/message.jsp";
            }
            checkList.add(cart);
            request.setAttribute("cid",cid);

        }

        request.setAttribute("checkList",checkList);

        //System.out.println("checkList:"+checkList);
        request.setAttribute("price",cartService.getTotalPrice(checkList));

        List<Address> addressList = addressService.getAddressList(user.getId());
        if(addressList!=null&&addressList.size()>0)
            request.setAttribute("addressList",addressList);

        return "forward:/checkout.jsp";
    }

    //所有订单信息预览
    public String list(HttpServletRequest request, HttpServletResponse respons) throws SQLException {
        User user = (User) request.getSession().getAttribute("user");
        if(user==null)
            return "redirect:/login.jsp";

        List<Order> orderList = orderService.getOrderList(user.getId());
        if(orderList!=null)
            request.setAttribute("orderList",orderList);
        System.out.println("orderList: "+orderList);
        return "forward:/orders.jsp";

    }

    //订单详细
    public String detail(HttpServletRequest request, HttpServletResponse response)throws SQLException{

        User user = (User) request.getSession().getAttribute("user");
        if(user==null)
            return "redirect:/login";

        //获取用户所有订单信息
        List<Order> orderList = orderService.getOrderList(user.getId());

        String oid = request.getParameter("oid");
        if(StringUtil.isEmpty(oid)){
            request.setAttribute("msg","请求参数缺失");
            return "forward:/message.jsp";
        }
        Order order = orderService.getOrder(oid);
        if(order==null){
            request.setAttribute("msg","请求参数有误");
            return "forward:/message.jsp";
        }
        if(!orderList.contains(order)){
            request.setAttribute("msg","违规操作");
            return "forward:/message.jsp";
        }
        order.setOrderDetails(orderDetailService.getOrderDetailList(oid));

        request.setAttribute("order",order);
        //System.out.println("order详细："+order);


        return "forward:/view-order.jsp";
    }


    /**
     * @Author discipline
     * @Date 22:40 2021/11/15
     * @Description 确认订单+支付
     **/
    public String confirm(HttpServletRequest request, HttpServletResponse respons) throws SQLException {
        User user = (User) request.getSession().getAttribute("user");
        if(user==null)
            return "redirect:/login.jsp";

        //1、订单已生成
        if(!StringUtil.isEmpty(request.getParameter("oid"))){
            Order order = orderService.getOrder(request.getParameter("oid"));
            if(order==null){
                request.setAttribute("msg","请求参数错误");
                return "forward:/message.jsp";
            }

            switch (order.getStatus()){
                case 5:
                    request.setAttribute("msg","订单已过期");
                    break;
                case 1:
                case 2:
                case 3:
                case 4:
                    request.setAttribute("msg","该订单已支付");
                    break;
                case 0:
                    //1.1、支付
                    int payResult = pay(user, order.getTotal(), order.getId());
                    switch (payResult){
                        case 0:
                            request.setAttribute("msg","支付出错");
                            break;
                        case 1:
                            request.setAttribute("msg","支付成功");
                            orderService.updateOrderStatus(order.getId(),1);
                            orderService.updatePayTime(order.getId());
                            //更新用户信息
                            request.getSession().setAttribute("user",userService.getUser(user.getEmail(),user.getPassword()));
                            request.setAttribute("jump","/orderservlet?method=detail&oid="+order.getId());
                            break;
                        case 2:
                            request.setAttribute("msg","余额不足，支付失败");
                            request.setAttribute("jump","/orderservlet?method=detail&oid="+order.getId());
                            break;
                    }
                    break;
            }
            return "forward:/message.jsp";

        }



        //2、订单还未生成

        List<Cart> cartList = new ArrayList<>();

        if(StringUtils.isEmpty(request.getParameter("aid"))){
            request.setAttribute("msg","请求参数缺失");
            return "forward:/message.jsp";
        }
        int aid,cid;
        try {
            aid = Integer.parseInt(request.getParameter("aid"));
        }catch (NumberFormatException e){
            e.printStackTrace();
            request.setAttribute("msg","请求参数有误");
            return "forward:/message.jsp";
        }
        Address address = addressService.getAddress(aid);
        if(address==null){
            request.setAttribute("msg","请求资源有误");
            return "forward:/message.jsp";
        }

        //2.1、若不指定cid默认支付购物车所有商品
        if(StringUtils.isEmpty(request.getParameter("cid"))){
            cartList = cartService.getCartList(user.getId());

            if(cartList.size()==0){
                request.setAttribute("msg","请求资源有误");
                return "forward:/message.jsp";
            }
        }
        //2.2、若指定商品号
        else{
            try {
                cid = Integer.parseInt(request.getParameter("cid"));
            }catch (NumberFormatException e){
                e.printStackTrace();
                request.setAttribute("msg","请求参数有误");
                return "forward:/message.jsp";
            }

            Cart cart = cartService.getCartById(cid);
            if(cart==null){
                request.setAttribute("msg","请求资源有误");
                return "forward:/message.jsp";
            }
            cartList.add(cart);
        }

        String oid=OrderUtils.genrateOrderId();
        System.out.println("预生成订单号："+oid);

        //2.3、生成订单
        if (genrateOrder(oid,cartList,address,user.getId())){

            //todo 移除购物车信息


            //2.4支付
            int payResult = pay(user, cartService.getTotalPrice(cartList), oid);
            switch (payResult){
                case 0:
                    request.setAttribute("msg","支付出错");
                    break;
                case 1:
                    request.setAttribute("msg","支付成功");
                    //todo 支付和更新paytime合并
                    orderService.updateOrderStatus(oid,1);
                    orderService.updatePayTime(oid);
                    request.setAttribute("jump","/orderservlet?method=detail&oid="+oid);
                    //更新用户信息
                    request.getSession().setAttribute("user",userService.getUser(user.getEmail(),user.getPassword()));
                    break;
                case 2:
                    request.setAttribute("msg","余额不足，支付失败");
                    //开启多线程 固定时间后订单逾期
                    new Thread(()->{
                        try {
                            overdue(oid);
                        } catch (InterruptedException | SQLException e) {
                            e.printStackTrace();
                        }
                    },oid).start();
                    request.setAttribute("jump","/orderservlet?method=detail&oid="+oid);
                    break;
            }
            return "forward:/message.jsp";
        }
        request.setAttribute("msg","生成订单失败");
        return "forward:/message.jsp";

    }


    /**
     * @Author discipline
     * @Date 13:52 2021/11/17
     * @Param  user,total,oid
     * @return int
     * @Description 支付方法
     **/
    public int pay(User user,double total,String oid) throws SQLException {
        if(orderService.getOrder(oid)==null)
            return 0;
        //支付成功
        DruidUtils.startTX();
        try {
            if(userService.pay(user,total)>0)
                //更新订单状态
                orderService.updateOrderStatus(oid,1);
            else
                return 2;

        }catch (SQLException e){
            e.printStackTrace();
            DruidUtils.rollbackTX();
            return 0;
        }
        DruidUtils.endTx();

        return 1;
    }





    /**
     * @Author discipline
     * @Date 19:39 2021/11/22
     * @Param oid,cartList,address,uid
     * @return boolean
     * @Description 生成订单方法
     **/
    public boolean genrateOrder(String oid,List<Cart> cartList,Address address,int  uid) throws SQLException {
        if(cartList.size()<=0)
            return false;

        System.out.println("total:" +cartService.getTotalPrice(cartList));
        Order order = new Order(oid,uid,cartService.getTotalPrice(cartList),
                address.getRegion()+" "+address.getDetail(),
                address.getName(),address.getPhone(),0, LocalDateTime.now());

        DruidUtils.startTX();
        try {
            orderService.insertOrder(order);
            orderDetailService.insertOrderDetails(cartList,oid);

        }catch (SQLException e){
            e.printStackTrace();
            DruidUtils.rollbackTX();
            return false;
        }
        DruidUtils.endTx();
        return true;

    }


    /**
     * @Author discipline
     * @Date 18:16 2021/11/22
     * @Param oid
     * @Description 订单逾期方法
     **/
    public void overdue(String oid) throws InterruptedException, SQLException {
        Order order = new Order();
        order.setId(oid);
        //todo 暂定一分钟后逾期
        order.setStart( System.currentTimeMillis());
        order.setDelay(1000*60);
        //放入阻塞队列
        delayQueue.put(order);
        System.out.println("订单"+order.getId()+"加入逾期队列");

        while (delayQueue.size()>0){
            Order take = delayQueue.take();
            //倒计时结束订单状态仍未未支付则设置订单状态逾期
            if(orderService.getOrder(take.getId()).getStatus()==0) {
                orderService.updateOrderStatus(take.getId(), 5);
                System.out.println("订单" + take.getId() + "已逾期");
            }
        }

    }
}
