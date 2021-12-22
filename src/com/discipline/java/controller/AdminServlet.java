package com.discipline.java.controller;

import com.discipline.java.bean.Category;
import com.discipline.java.bean.Goods;
import com.discipline.java.bean.Order;
import com.discipline.java.bean.User;
import com.discipline.java.service.*;
import com.discipline.java.service.impl.*;
import com.discipline.java.utils.Constant;
import com.discipline.java.utils.QiniuCloudUtil;
import com.sun.org.apache.bcel.internal.generic.NEW;
import com.sun.org.apache.regexp.internal.RE;
import org.apache.commons.lang3.StringUtils;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.*;

@WebServlet("/admin")
public class AdminServlet extends BaseServlet {

    private GoodsService goodsService = new GoodsServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();
    private OrderService orderService = new OrderServiceImpl();
    private UserService userService = new UserServiceImpl();
    private OrderDetailService orderDetailService=new OrderDetailServiceImpl();
    private QiniuCloudUtil qiniuCloudUtil=new QiniuCloudUtil();


    public String dashboard(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        //获取注册用户数
        request.setAttribute("userNum", userService.getUserNum());

        //获取今日订单数
        request.setAttribute("todayOrderNum", orderService.getTodayOrderNum());

        //获取代发货订单数
        request.setAttribute("toDeliverOrderNum", orderService.getToDeliverOrderNum());


        //获取订单销售额
        Map<String, BigDecimal> sales = orderService.getSales();
        request.setAttribute("today", sales.get("today")==null?0:sales.get("today"));
        request.setAttribute("week", sales.get("week")==null?0:sales.get("week"));
        request.setAttribute("month", sales.get("month")==null?0:sales.get("month"));
        request.setAttribute("year", sales.get("year")==null?0:sales.get("year"));


        Map<String, BigDecimal> map = orderService.getPast7DaysSales();
        Object[] arr1 = map.keySet().toArray();
        Object[] arr2 = map.values().toArray();


        request.setAttribute("arr1", parasObjectArrayToString(arr1));
        request.setAttribute("arr2", parasObjectArrayToString(arr2));


        return "forward:admin/dashboard.jsp";
    }

    //商品管理-商品信息展示
    public String goods(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        int categoryid , page;

        if (request.getParameter("page") == null) {
            page = 1;
        } else {

            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
                return "forward:message.jsp";
            }

            if (page == 0)
                page = 1;
        }

        if(request.getParameter("categoryid")==null){
            categoryid=0;
        }else{
            try {
                categoryid = Integer.parseInt(request.getParameter("categoryid"));
            }catch (NumberFormatException e){
                e.printStackTrace();
                request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
                return "forward:message.jsp";
            }

            Category category = categoryService.getCategoryById(categoryid);

            if(category==null&&categoryid!=0){
                request.setAttribute("msg", Constant.REQUEST_RESOURCES_NOT_EXIT);
                return "forward:message.jsp";
            }

            request.setAttribute("category",category);
        }

        request.setAttribute("currentpPage", page);


        List<Category> allCategory = categoryService.getAllCategory();

        //存放所有商品种类信息 key-value: id-Category
        Map<Integer, Category> map = new HashMap<>();

        for (Category item : allCategory) {
            map.put(item.getId(), item);
        }

        //页数为8
        List<Goods> goodsList = goodsService.getAllGoodsListByPage(page, 8, categoryid);

        for (Goods item : goodsList) {
            item.setCategory(map.get(item.getCategoryid()));
        }

        request.setAttribute("goodsList", goodsList);
        long sum = goodsService.getGoodsSum(categoryid);
        request.setAttribute("pages",sum/8+(sum%8==0?0:1));


        return "forward:admin/goods.jsp";
    }



    /**
     * @Author discipline
     * @Date 18:47 2021/12/17
     * @Description 商品管理-前往编辑或新增商品信息页面
     **/
    public String editGoods(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        // 若带有参数id则视为商品的编辑，否则视为商品的新增
        if (StringUtils.isNotEmpty(request.getParameter("id"))) {
            int id;
            try {
                id = Integer.parseInt(request.getParameter("id"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
                return "forward:message.jsp";
            }
            Goods goods = goodsService.getGoodsById(id);
            if (goods == null) {
                request.setAttribute("msg", Constant.REQUEST_RESOURCES_NOT_EXIT);
                return "forward:message.jsp";
            }
            request.setAttribute("goods", goods);

            //获取其他介绍图片地址
            if (StringUtils.isNotEmpty(goods.getOthers())) {
                String[] otherPictures = goods.getOthers().split(",,,");
                request.setAttribute("otherPictures", otherPictures);
            }

        }


        return "forward:admin/edit-goods.jsp";
    }


    /**
     * @Author discipline
     * @Date 18:57 2021/12/17
     * @Description 商品管理-上传图片至七牛云oss
     **/
    public String uploadPic(HttpServletRequest request, HttpServletResponse response) throws Exception {

        //获取base64字符串和图片字节长度
        String file64 = request.getParameter("file");
        String length = request.getParameter("length");

        if(StringUtils.isNotEmpty(file64)&&StringUtils.isNotEmpty(length)){
            file64=file64.substring("data:image/jpeg;base64,".length());
            String url = qiniuCloudUtil.put64image(file64, length,UUID.randomUUID().toString());
            response.getWriter().write(url);

        }else{
            response.getWriter().write("error");
        }


        return null;
    }



    //商品管理-新增或编辑商品
    public String insertOrUpdateGoods(HttpServletRequest request, HttpServletResponse response) throws Exception {

        response.setContentType("text/html;charset=UTF-8");

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String discount = request.getParameter("discount")==null?"1":request.getParameter("discount");
        String categoryid = request.getParameter("categoryid");
        String picture = request.getParameter("picture");
        String others = request.getParameter("others");
        String status = request.getParameter("status")==null?"1":request.getParameter("status");
        String sizes = request.getParameter("sizes");
        String description = request.getParameter("description");


        if(StringUtils.isEmpty(id)||StringUtils.isEmpty(name)||StringUtils.isEmpty(price)||
                StringUtils.isEmpty(categoryid)||StringUtils.isEmpty(picture)||StringUtils.isEmpty(sizes)){
            response.getWriter().write(Constant.REQUEST_PARAMETER_INCOMPLETE);
            return null;
        }

        Goods goods=new Goods();


        try {
            goods.setId(Integer.parseInt(id));
            goods.setCategoryid(Integer.parseInt(categoryid));
            goods.setPrice(Double.valueOf(price));
            goods.setDiscount(Double.valueOf(discount));
            goods.setStatus(Integer.parseInt(status));
        }catch (NumberFormatException e){
            e.printStackTrace();
            response.getWriter().write(Constant.REQUEST_PARAMETER_ERROR);
            return null;
        }
        goods.setName(name);
        goods.setOthers(others);
        goods.setPicture(picture);
        goods.setSizes(sizes);
        goods.setDescription(description);


        int result;

        //case 1、新增商品信息(id=0)
        if(goods.getId()==0){
            result=goodsService.insertGoods(goods);
            if(result<0){
                response.getWriter().write("新增商品信息失败");
            }else {
                response.getWriter().write("insertSuccess");
            }
        }
        //case 2、更新商品信息
        else{
            try {
                goods.setId(Integer.parseInt(id));
            }catch (NumberFormatException e){
                e.printStackTrace();
                response.getWriter().write(Constant.REQUEST_PARAMETER_ERROR);
                return null;
            }
            result=goodsService.updateGoods(goods);
            if(result<0){
                response.getWriter().write("编辑商品id="+id+"信息失败");
            }else{
                response.getWriter().write("updateSuccess");
            }
        }

        return null;
    }




    //订单管理-展示订单信息
    public String orders(HttpServletRequest request, HttpServletResponse response) throws Exception {

        int status, page;

        if(request.getParameter("status")==null){
            status=-1;
        }else {
            try {
                status = Integer.parseInt(request.getParameter("status"));
            }catch (NumberFormatException e){
                e.printStackTrace();
                request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
                return "forward:message.jsp";
            }
        }
        request.setAttribute("status",status);


        if (request.getParameter("page") == null) {
            page = 1;
        } else {

            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
                return "forward:message.jsp";
            }

            if (page == 0)
                page = 1;
        }

        request.setAttribute("currentpPage", page);

        //页数为8
        List<Order> orderList = orderService.getAllOrderListByPage(page, 8, status);
        request.setAttribute("orderList", orderList);

        long sum = orderService.getAllOrderSum(status);
        request.setAttribute("pages",sum/8+(sum%8==0?0:1));

        return "forward:admin/orders.jsp";
    }


    //订单管理-发货
    public String deliver (HttpServletRequest request, HttpServletResponse response) throws Exception{

        response.setContentType("text/html;charset=UTF-8");

        String oid = request.getParameter("oid");
        String lid = request.getParameter("lid");
        if(StringUtils.isEmpty(oid)||StringUtils.isEmpty(lid)) {
            response.getWriter().write(Constant.REQUEST_PARAMETER_INCOMPLETE);
            return null;
        }

        if(orderService.deliver(oid, lid)>0)
            response.getWriter().write("success");
        else
            response.getWriter().write("发货失败");

        return null;
    }


    //订单管理-订单详细
    public String detail(HttpServletRequest request, HttpServletResponse response)throws SQLException{

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

        order.setOrderDetails(orderDetailService.getOrderDetailList(oid));

        request.setAttribute("order",order);

        return "forward:admin/view-order.jsp";
    }


    //将数组转换成 ['?','?','?'...] 格式字符串
    public String parasObjectArrayToString(Object[] objects) {
        StringBuffer buffer = new StringBuffer();
        buffer.append("[");
        for (int i = 0; i < objects.length; i++) {
            buffer.append("'");
            buffer.append(objects[i]);
            buffer.append("'");
            if (i != objects.length - 1)
                buffer.append(",");
        }
        buffer.append("]");
        return String.valueOf(buffer);
    }
}
