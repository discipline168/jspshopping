package com.discipline.java.controller;

import com.discipline.java.bean.Address;
import com.discipline.java.bean.User;
import com.discipline.java.service.AddressService;
import com.discipline.java.service.impl.AddressServiceImpl;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/addressservlet")
public class AddressServlet extends BaseServlet {
    private AddressService addressService=new AddressServiceImpl();

    public String list(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        User user = (User) request.getSession().getAttribute("user");
        if(user==null)
            return "redirect:/login.jsp";
        List<Address> addressList = addressService.getAddressList(user.getId());
        if(addressList.size()>0) {
            request.setAttribute("addressList", addressList);
            request.setAttribute("size",addressList.size());
        }
        //System.out.println(addressList);
        return "forward:/addresses.jsp";
    }

    public String operate(HttpServletRequest request,HttpServletResponse response) throws SQLException {

        User user = (User) request.getSession().getAttribute("user");
        if(user==null)
            return "redirect:/login.jsp";

        if(StringUtils.isEmpty(request.getParameter("type"))||
                (!"insert".equals(request.getParameter("type"))&&!"update".equals(request.getParameter("type")))){
            request.setAttribute("msg","请求参数有误");
            return "forward:/message.jsp";
        }
        String type = request.getParameter("type");
        request.setAttribute("type",type);


        if("update".equals(type)){

            if(StringUtils.isEmpty(request.getParameter("id"))){
                request.setAttribute("msg","请求参数不存在");
                return "forward:/message.jsp";
            }
            int id;
            try{
                id = Integer.parseInt(request.getParameter("id"));
            }catch(NumberFormatException e){
                request.setAttribute("msg","请求参数有误");
                return "forward:/message.jsp";
            }


            Address address = addressService.getAddress(id);
            if(address==null){
                request.setAttribute("msg","请求参数不存在");
                return "forward:/message.jsp";
            }
            if(address.getUid()!=user.getId()){
                request.setAttribute("msg","违规操作");
                return "forward:/message.jsp";
            }
            request.setAttribute("address",address);
        }


        return "forward:/address.jsp";
    }

    public String update(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int id,level;
        User user = (User) request.getSession().getAttribute("user");
        if(user==null)
            return "redirect:/login.jsp";
        if(StringUtils.isEmpty(request.getParameter("id"))||StringUtils.isEmpty(request.getParameter("region"))
                ||StringUtils.isEmpty(request.getParameter("detail"))
                ||StringUtils.isEmpty(request.getParameter("phone"))||StringUtils.isEmpty(request.getParameter("name"))
                ||StringUtils.isEmpty(request.getParameter("level"))){

            response.getWriter().write("请求参数不完整");
            return null;
        }
        try {
            id = Integer.parseInt(request.getParameter("id"));
            level = Integer.parseInt(request.getParameter("level"));
        }catch (NumberFormatException e){
            response.getWriter().write("请求参数错误");
            return null;
        }
        Address address = addressService.getAddress(id);
        if(address==null){
            response.getWriter().write("请求信息不存在");
            return null;
        }

        if(user.getId()!=address.getUid()){
            response.getWriter().write("违规操作");
            return null;
        }
        address.setName(request.getParameter("name"));
        address.setPhone(request.getParameter("phone"));
        address.setRegion(request.getParameter("region"));
        address.setDetail(request.getParameter("detail"));
        address.setLevel((level==1||level==0)?level:0);

        int result = addressService.updateAddress(address);
        if(result>0)
            response.getWriter().write("success");
        else
            response.getWriter().write("更新地址失败");
        return null;
    }



    public String insert(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int level;
        User user = (User) request.getSession().getAttribute("user");
        if(user==null)
            return "nouser";
        if(StringUtils.isEmpty(request.getParameter("region"))
                ||StringUtils.isEmpty(request.getParameter("detail"))
                ||StringUtils.isEmpty(request.getParameter("phone"))||StringUtils.isEmpty(request.getParameter("name"))
                ||StringUtils.isEmpty(request.getParameter("level"))){

            response.getWriter().write("请求参数不完整");
            return null;
        }
        try {
            level = Integer.parseInt(request.getParameter("level"));
        }catch (NumberFormatException e){
            response.getWriter().write("请求参数错误");
            return null;
        }

        Address address = new Address();

        address.setName(request.getParameter("name"));
        address.setUid(user.getId());
        address.setPhone(request.getParameter("phone"));
        address.setRegion(request.getParameter("region"));
        address.setDetail(request.getParameter("detail"));
        address.setLevel((level==1||level==0)?level:0);

        int result = addressService.insertAddress(address);
        if(result>0)
            response.getWriter().write("success");
        else
            response.getWriter().write("新增地址失败");
        return null;
    }


    public String delete(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        User user = (User) request.getSession().getAttribute("user");
        if(user==null){
            response.getWriter().write("nouser");
            return null;
        }
        int id = Integer.parseInt(request.getParameter("id"));
        Address address = addressService.getAddress(id);
        if(address==null){
            response.getWriter().write("请求信息不存在");
            return null;
        }
        if(address.getUid()!=user.getId()){
            response.getWriter().write("违规操作");
            return null;
        }
        int result = addressService.deleteAddress(id);
        if(result>0)
            response.getWriter().write("success");
        else
            response.getWriter().write("删除地址信息失败");

        return null;
    }
}
