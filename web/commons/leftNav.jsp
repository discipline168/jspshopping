<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/11/10
  Time: 18:26
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="woocommerce-MyAccount-navigation">
    <ul>
        <li class="woocommerce-MyAccount-navigation-link woocommerce-MyAccount-navigation-link--dashboard">
            <a href="account.jsp">总览</a>
        </li>
        <li class="woocommerce-MyAccount-navigation-link woocommerce-MyAccount-navigation-link--orders">
            <a  href="orderservlet?method=list">订单</a>
        </li>

        <li class="woocommerce-MyAccount-navigation-link woocommerce-MyAccount-navigation-link--edit-address">
            <a href="addressservlet?method=list">地址</a>
        </li>
        <li class="woocommerce-MyAccount-navigation-link woocommerce-MyAccount-navigation-link--customer-logout">
            <a  href="userservlet?method=logout">登出</a>
        </li>
    </ul>
</nav>