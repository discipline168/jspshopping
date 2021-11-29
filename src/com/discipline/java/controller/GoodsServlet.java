package com.discipline.java.controller;


import com.discipline.java.bean.Category;
import com.discipline.java.bean.Goods;
import com.discipline.java.service.CategoryService;
import com.discipline.java.service.GoodsService;
import com.discipline.java.service.impl.CategoryServiceImpl;
import com.discipline.java.service.impl.GoodsServiceImpl;
import com.discipline.java.utils.Constant;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/goodsservlet")
public class GoodsServlet extends BaseServlet {

    private GoodsService goodsService = new GoodsServiceImpl();
    private CategoryService categoryService=new CategoryServiceImpl();


    //查看商品详情
    public String detail(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        int id;

        try{
            id = Integer.parseInt(request.getParameter("id"));
        }catch(NumberFormatException e){
            e.printStackTrace();
            request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
            return "forward:message.jsp";
        }

        Goods goods = goodsService.getGoodsById(id);
        if(goods==null){
            request.setAttribute("msg", Constant.REQUEST_RESOURCES_NOT_EXIT);
            return "forward:message.jsp";
        }
        //获取其他介绍图片地址
        if(StringUtils.isNotEmpty(goods.getOthers())){
            String[] otherPictures = goods.getOthers().split(",,,");
            request.setAttribute("otherPictures",otherPictures);
        }

        //获取商品种类信息
        goods.setCategory(categoryService.getCategoryById(goods.getCategoryid()));
        System.out.println(goods.getCategory());
        request.setAttribute("goods",goods);


        //获取商品尺码/规格
        if(goods.getSizes()!=null){
            String[] sizes = goods.getSizes().split(",");
            request.setAttribute("sizes",sizes);
        }

        //获取同类推荐商品
        request.setAttribute("recommended",goodsService.getRecommendedGoodsList(id,goods.getCategoryid()));


        return "forward:detail.jsp";
    }


    //浏览商城
    public String shop(HttpServletRequest request, HttpServletResponse response) throws SQLException {

        int categoryid,page;

        if(request.getParameter("page")==null){
            page=1;
        }else{

            try{
                page = Integer.parseInt(request.getParameter("page"));
            }catch(NumberFormatException e){
                e.printStackTrace();
                request.setAttribute("msg", Constant.REQUEST_PARAMETER_ERROR);
                return "forward:message.jsp";
            }

            if(page==0)
                page=1;
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

        request.setAttribute("currentpPage",page);


        List<Category> allCategory = categoryService.getAllCategory();

        //存放所有商品种类信息 key-value: id-Category
        Map<Integer,Category>map = new HashMap<>();

        for (Category item:allCategory){
            map.put(item.getId(),item);
        }




        //todo 页数为8（暂定）
        List<Goods> shopGoods = goodsService.getGoodsListByPage(page,8,categoryid);
        System.out.println(shopGoods);

        if(shopGoods.size()==0||shopGoods==null){
            request.setAttribute("msg", Constant.REQUEST_RESOURCES_NOT_EXIT);
            return "forward:message.jsp";
        }


        for (Goods item:shopGoods){
            item.setCategory(map.get(item.getCategoryid()));
        }

        request.setAttribute("shopGoods",shopGoods);
        long sum = goodsService.getGoodsSum(categoryid);
        request.setAttribute("pages",sum/8+(sum%8==0?0:1));


        return "forward:shop.jsp";
    }
}
