package com.discipline.java.controller;

import com.discipline.java.bean.*;
import com.discipline.java.service.*;
import com.discipline.java.service.impl.*;
import com.discipline.java.utils.Constant;
import com.discipline.java.utils.DruidUtils;
import com.discipline.java.utils.OrderUtils;
import org.apache.commons.lang3.StringUtils;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.DelayQueue;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

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
            return "redirect: login.jsp";

        if(addressService.getAddressList(user.getId()).size()<=0){
            request.setAttribute("msg","请先设置收货地址");
            request.setAttribute("jump","addressservlet?method=list");
            return "forward:message.jsp";
        };


        List<Cart> checkList = new ArrayList<>();


        //case1 不指定cid默认支付信息包含购物车所有商品
        if(StringUtils.isEmpty(request.getParameter("cid"))){
            checkList = cartService.getCartList(user.getId());

            if(checkList.size()==0){
                request.setAttribute("msg", "您的购物车好像空空如也");
                request.setAttribute("jump","cartservlet?method=list");
                return "forward:message.jsp";
            }else {
                //过滤已下架的商品
                checkList=checkList.stream()
                        .filter(c->c.getGoods().getStatus()==Constant.GOODS_STATUS_ON_SALE)
                        .collect(Collectors.toList());
                if(checkList.size()==0) {
                    request.setAttribute("msg", "您购物车里的商品均已下架，无法进行购买");
                    request.setAttribute("jump","cartservlet?method=list");
                    return "forward:message.jsp";
                }
            }
            request.setAttribute("checkList",checkList);
            request.setAttribute("total",cartService.getTotalPrice(checkList));

        }
        //case2 单件
        else{
            int cid;
            try{
                cid=Integer.parseInt(request.getParameter("cid"));
            }catch(NumberFormatException e){
                e.printStackTrace();
                request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
                return "forward:message.jsp";
            }

            Cart cart = cartService.getCartById(cid);
            if(cart==null){
                request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
                return "forward:message.jsp";
            }else{
                if(cart.getGoods().getStatus()==Constant.GOODS_STATUS_NOT_SALE){
                    request.setAttribute("msg", "该商品已下架，无法进行购买");
                    request.setAttribute("jump","cartservlet?method=list");
                    return "forward:message.jsp";
                }
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

        return "forward:checkout.jsp";
    }

    //所有订单信息预览
    public String list(HttpServletRequest request, HttpServletResponse respons) throws SQLException {
        User user = (User) request.getSession().getAttribute("user");
        if(user==null)
            return "redirect: login.jsp";

        List<Order> orderList = orderService.getOrderList(user.getId());
        if(orderList!=null)
            request.setAttribute("orderList",orderList);
        System.out.println("orderList: "+orderList);
        return "forward:orders.jsp";

    }



    //订单详细
    public String detail(HttpServletRequest request, HttpServletResponse response)throws SQLException{

        User user = (User) request.getSession().getAttribute("user");
        if(user==null)
            return "redirect: login";

        //获取用户所有订单信息
        List<Order> orderList = orderService.getOrderList(user.getId());

        String oid = request.getParameter("oid");
        if(StringUtils.isEmpty(oid)){
            request.setAttribute("msg", Constant.REQUEST_PARAMETER_INCOMPLETE);
            return "forward:message.jsp";
        }
        Order order = orderService.getOrder(oid);
        if(order==null){
            request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
            return "forward:message.jsp";
        }
        //非法查看他人订单给信息
        if(!orderList.contains(order)){
            request.setAttribute("msg", Constant.REQUEST_VIOLATE);
            return "forward:message.jsp";
        }
        order.setOrderDetails(orderDetailService.getOrderDetailList(oid));

        request.setAttribute("order",order);
        //System.out.println("order详细："+order);


        return "forward:view-order.jsp";
    }




    /**
     * @Author discipline
     * @Date 22:40 2021/11/15
     * @Description 确认订单+支付
     **/
    public String confirm(HttpServletRequest request, HttpServletResponse respons) throws SQLException {
        User user = (User) request.getSession().getAttribute("user");
        if(user==null)
            return "redirect: login.jsp";

        //case 1、订单已生成
        if(!StringUtils.isEmpty(request.getParameter("oid"))){
            Order order = orderService.getOrder(request.getParameter("oid"));
            if(order==null){
                request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
                return "forward:message.jsp";
            }

            switch (order.getStatus()){
                case Constant.ORDER_STATUS_OVERDUE:
                case Constant.ORDER_STATUS_REFUND:
                    request.setAttribute("msg","订单已过期");
                    break;
                case Constant.ORDER_STATUS_TO_DELIVER:
                case Constant.ORDER_STATUS_DELIVERING:
                case Constant.ORDER_STATUS_SIGNED:
                    request.setAttribute("msg","该订单已支付");
                    break;
                case Constant.ORDER_STATUS_NOT_PAY:
                    //1.1、支付
                    int payResult = pay(user, order.getTotal(), order.getId());
                    switch (payResult){
                        case 0:
                            request.setAttribute("msg","支付出错");
                            break;
                        case 1:
                            request.setAttribute("msg","支付成功");
                            //更新用户信息
                            request.getSession().setAttribute("user",userService.getUser(user.getEmail(),user.getPassword()));
                            request.setAttribute("jump","orderservlet?method=detail&oid="+order.getId());
                            break;
                        case 2:
                            request.setAttribute("msg","余额不足，支付失败");
                            request.setAttribute("jump","orderservlet?method=detail&oid="+order.getId());
                            break;
                    }
                    break;
            }
            return "forward:message.jsp";

        }



        //case 2、订单还未生成

        List<Cart> cartList = new ArrayList<>();

        if(StringUtils.isEmpty(request.getParameter("aid"))){
            request.setAttribute("msg", Constant.REQUEST_PARAMETER_INCOMPLETE);
            return "forward:message.jsp";
        }
        int aid,cid;
        try {
            aid = Integer.parseInt(request.getParameter("aid"));
        }catch (NumberFormatException e){
            e.printStackTrace();
            request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
            return "forward:message.jsp";
        }
        Address address = addressService.getAddress(aid);
        if(address==null){
            request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
            return "forward:message.jsp";
        }

        //2.1、若不指定cid默认支付购物车所有商品
        if(StringUtils.isEmpty(request.getParameter("cid"))){
            cartList = cartService.getCartList(user.getId());

            if(cartList.size()==0){
                request.setAttribute("msg","您的购物车好像空空如也");
                request.setAttribute("jump","cartservlet?method=list");
                return "forward:message.jsp";
            }else {
                //过滤已下架的商品
                cartList=cartList.stream()
                        .filter(c->c.getGoods().getStatus()==Constant.GOODS_STATUS_ON_SALE)
                        .collect(Collectors.toList());
                if(cartList.size()==0) {
                    request.setAttribute("msg", "您购物车里的商品均已下架，无法进行购买");
                    request.setAttribute("jump","cartservlet?method=list");
                    return "forward:message.jsp";
                }
            }

        }
        //2.2、若指定商品号
        else{
            try {
                cid = Integer.parseInt(request.getParameter("cid"));
            }catch (NumberFormatException e){
                e.printStackTrace();
                request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
                return "forward:message.jsp";
            }

            Cart cart = cartService.getCartById(cid);
            if(cart==null){
                request.setAttribute("msg", Constant.REQUEST_RESOURCES_NOT_EXIT);
                return "forward:message.jsp";
            }
            if(cart.getGoods().getStatus()==Constant.GOODS_STATUS_NOT_SALE){
                request.setAttribute("msg", "该商品已下架，无法进行购买");
                return "forward:message.jsp";
            }
            cartList.add(cart);
        }

        String oid=OrderUtils.genrateOrderId();
        System.out.println("预生成订单号："+oid);

        //2.3、生成订单
        if (genrateOrder(oid,cartList,address,user.getId())){



            //2.4支付
            int payResult = pay(user, cartService.getTotalPrice(cartList), oid);
            switch (payResult){
                case 0:
                    request.setAttribute("msg","支付出错");
                    break;
                case 1:
                    request.setAttribute("msg","支付成功");
                    request.setAttribute("jump","orderservlet?method=detail&oid="+oid);
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
                    },"overdue-oid-"+oid).start();
                    request.setAttribute("jump","orderservlet?method=detail&oid="+oid);
                    break;
            }
            return "forward:message.jsp";
        }
        request.setAttribute("msg","生成订单失败");
        return "forward:message.jsp";

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
        //如果延迟队列里有值则将userService资源上锁
        if (delayQueue.size()>0){
            synchronized (orderService){
                try {
                    System.out.println("支付方法--获取到userService资源锁");
                    if(orderService.getOrder(oid).getStatus()==Constant.ORDER_STATUS_NOT_PAY){
                        if (userService.pay(user,total)>0) {
                            //更新订单状态和支付时间
                            orderService.updateOrderStatus(oid, Constant.ORDER_STATUS_TO_DELIVER);
                            System.out.println("用户-"+user.getId()+"支付成功，已修改订单-"+oid+"状态");
                            //todo 增加商品销量
                            return 1;
                        }else {
                            System.out.println("用户-"+user.getId()+"账户余额不足，支付订单-"+oid+"失败");
                            return 2;
                        }
                    }else {
                        System.out.println("用户-"+user.getId()+"支付失败，订单-"+oid+"已逾期");
                    }

                }catch (SQLException e){
                    e.printStackTrace();
                    return 0;
                }
                System.out.println("支付方法--释放userService资源锁\n");
            }
        }else{
            if(orderService.getOrder(oid).getStatus()==Constant.ORDER_STATUS_NOT_PAY){
                if (userService.pay(user,total)>0) {
                    //更新订单状态和支付时间
                    orderService.updateOrderStatus(oid, Constant.ORDER_STATUS_TO_DELIVER);
                    System.out.println("用户-"+user.getId()+"支付成功，已修改订单-"+oid+"状态");
                    //todo 增加商品销量
                    return 1;
                }else {
                    System.out.println("用户-"+user.getId()+"账户余额不足，支付订单-"+oid+"失败");
                    return 2;
                }
            }else {
                System.out.println("用户-"+user.getId()+"支付失败，订单-"+oid+"已逾期");
            }
        }

        return 0;
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
                address.getName(),address.getPhone(), Constant.ORDER_STATUS_NOT_PAY, LocalDateTime.now());

        DruidUtils.startTX();
        try {
            orderService.insertOrder(order);
            orderDetailService.insertOrderDetails(cartList,oid);
            //移除购物车信息
            if(cartService.deleteFromCart(cartList)==0)
                System.out.println("删除购物车信息出错");

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

            //业务逻辑资源类加锁
            synchronized (orderService) {
                try {
                    System.out.println(Thread.currentThread().getName()+"--获取到userService资源锁");
                    //倒计时结束订单状态仍未未支付则设置订单状态逾期
                    if (orderService.getOrder(take.getId()).getStatus() == Constant.ORDER_STATUS_NOT_PAY) {
                        System.out.println("订单" + take.getId() + "已经逾期，正在修改订单状态");
                        //测试休眠
                        //TimeUnit.SECONDS.sleep(3);
                        orderService.updateOrderStatus(take.getId(), Constant.ORDER_STATUS_OVERDUE);
                        System.out.println("订单" + take.getId() + "已逾期");
                        System.out.println("Thread.currentThread().getName()"+"--释放orderService资源锁\n");

                    }
                }catch (SQLException  e) {
                    e.printStackTrace();
                }
            }

        }

    }
}
