<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/11/9
  Time: 16:42
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.discipline.java.bean.User" %>
<%@ page import="com.discipline.java.bean.Cart" %>
<%@ page import="java.util.List" %>
<jsp:useBean id="cartService" class="com.discipline.java.service.impl.CartServiceImpl"/>

<%
    User user=(User)request.getSession().getAttribute("user");
    if(user!=null){
        List<Cart> cartList = cartService.getCartList(user.getId());
        request.setAttribute("cartList",cartList);
        request.setAttribute("num",cartList.size());
        request.setAttribute("total",cartService.getTotalPrice(cartList));
    }

%>
<style>
    .cart-icon{
        background-image: url(resources/images/cart.png);
        background-position: center center;
        width: 25px;
        display: inline-block;
        height: 25px;
        background-size: 25px;
    }
    .menu-icon{
        background-image: url(resources/images/menu.png);
        background-position: center center;
        width: 25px;
        display: inline-block;
        height: 25px;
        background-size: 25px;
    }
</style>
<header id="masthead" class="site-header">


    <div class="main-header-wrap">

        <div class="ht-container">
            <div class="ht-row ht-middle-md">

                <div class="ht-col-md-2">
                    <div class="site-branding">
                        <a href="${pageContext.request.contextPath}/" class="custom-logo-link" rel="home"
                           aria-current="page"><img src="resources/images/logo.png"
                                                    class="custom-logo" alt="disciplinepro" /></a> </div><!-- .site-branding -->
                </div>

                <div class="ht-col-md-7 ht-center-xs">
                    <div class="main-menu-area">



                        <nav id="site-navigation" class="main-navigation">
                            <ul id="primary-menu1" class="menu">

                                <li class="menu-item menu-item-type-post_type menu-item-object-page nocls"><a
                                        href="${pageContext.request.contextPath}/" class="">主页
                                </a></li>
                                <li
                                        class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children ">
                                    <a href="goodsservlet?method=shop" class=""><span
                                            class="parlo-menu-tag">HOT</span> 商城 <i
                                            class="fa fa-angle-down"></i></a>
                                    <ul class="sub-menu">
                                        <li class="menu-item menu-item-type-custom menu-item-object-custom ">
                                            <a href="goodsservlet?method=shop&categoryid=1"
                                               class=""><span>运动服饰</span> </a></li>
                                        <li class="menu-item menu-item-type-post_type menu-item-object-page ">
                                            <a href="goodsservlet?method=shop&categoryid=2"
                                               class=""><span>运动装备</span> </a></li>
                                        <li class="menu-item menu-item-type-custom menu-item-object-custom ">
                                            <a href="goodsservlet?method=shop&categoryid=3"
                                               class=""><span>运动补给</span> </a></li>
                                    </ul>
                                </li>
                                <li
                                        class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children ">
                                    <a href="account.jsp" class=""><span
                                            class="parlo-menu-tag">New</span> 账户 <i
                                            class="fa fa-angle-down"></i></a>



                                    <c:if test="${not empty user}">
                                        <ul class="sub-menu">
                                            <li class="menu-item menu-item-type-custom menu-item-object-custom ">
                                                <a href="account.jsp"
                                                   class=""><span>我的</span> </a></li>
                                            <li class="menu-item menu-item-type-post_type menu-item-object-page ">
                                                <a href="orderservlet?method=list"
                                                   class=""><span>订单</span> </a></li>
                                            <li class="menu-item menu-item-type-post_type menu-item-object-page ">
                                                <a href="addressservlet?method=list"
                                                   class=""><span>地址</span> </a></li>
                                            <li class="menu-item menu-item-type-custom menu-item-object-custom ">
                                                <a href="cartservlet?method=list"
                                                   class=""><span>购物车</span> </a></li>
                                        </ul>
                                    </c:if>


                                    <c:if test="${empty user}">
                                        <ul class="sub-menu">
                                            <li class="menu-item menu-item-type-post_type menu-item-object-page ">
                                                <a href="login.jsp"
                                                   class=""><span>登录</span> </a></li>
                                            <li class="menu-item menu-item-type-custom menu-item-object-custom ">
                                                <a href="register.jsp"
                                                   class=""><span>注册</span> </a></li>
                                        </ul>
                                    </c:if>


                                </li>
                                <li class="menu-item menu-item-type-post_type menu-item-object-page nocls"><a
                                        href="about.jsp" class="">关于
                                </a></li>

                            </ul>
                        </nav><!-- #site-navigation -->
                    </div>
                </div>



                <div class="ht-col-md-3 ht-d-flex ht-end-sm">
                    <div class="header-right-content">
                        <ul>

                            <c:if test="${not empty user}">
                                <li class="mini-cart parlo-dropdown">
                                    <a class="parlo-dropdown-toggle" href="#">
                                        <i class="cart-icon"></i>
                                        <span class="parlo-mini-cart">
                                            <span class="minicart-counter">${num}</span>
                                            <span class="minicart-price">
                                                <span
                                                    class="woocommerce-Price-amount amount"><bdi><span
                                                    class="woocommerce-Price-currencySymbol">&#165;</span>${total}</bdi>
                                                </span>
                                            </span>
                                        </span>
                                    </a>
                                    <!-- 购物车信息-->
                                    <div class="minicart-page-area parlo-dropdown-menu" style="width: 400px">
                                        <h3>购物车</h3>
                                        <span class="mini-cart-close parlo-dropdown-close">
                                            <img src="resources/images/delete.png" style="width: 20px;"></img>
                                        </span>
                                        <div class="items-list">
                                            <div class="widget_shopping_cart_content">

                                                <c:if test="${not empty cartList}">
                                                    <ul class="woocommerce-mini-cart cart_list product_list_widget ">
                                                        <c:forEach items="${cartList}" var="cart">
                                                            <li class="woocommerce-mini-cart-item mini_cart_item">

                                                                <div class="mini-cart-thumb">
                                                                    <a href="goodsservlet?method=detail&id=${cart.gid}"><img
                                                                            src="${cart.goods.picture}"
                                                                            style="background: #f0f0f0;"
                                                                            class="attachment-woocommerce_thumbnail size-woocommerce_thumbnail"
                                                                            alt="" loading="lazy"
                                                                            sizes="(max-width: 300px) 100vw, 300px"
                                                                            width="300" height="300"></a> </div>
                                                                <div class="mini-cart-content">
                                                                    <h4>
                                                                        <a href="goodsservlet?method=detail&id=${cart.gid}">${cart.goods.name}</a> </h4>
                                                                    <span class="quantity">${cart.quantity} × <span
                                                                            class="woocommerce-Price-amount amount"><bdi><span
                                                                            class="woocommerce-Price-currencySymbol">&#165;</span>${cart.goods.price*cart.goods.discount}</bdi></span></span>
                                                                </div>
                                                            </li>
                                                        </c:forEach>

                                                    </ul>

                                                    <p class="woocommerce-mini-cart__total total">
                                                        <strong>总和:</strong> <span
                                                            class="woocommerce-Price-amount amount"><bdi><span
                                                            class="woocommerce-Price-currencySymbol">&#165;</span>${total}</bdi></span>
                                                    </p>


                                                    <p class="woocommerce-mini-cart__buttons buttons">
                                                        <a href="cartservlet?method=list"
                                                           class="button wc-forward">查看购物车</a>
                                                        <a href="orderservlet?method=checkout"
                                                           class="button checkout wc-forward">结算</a></p>
                                                </c:if>

                                                <c:if test="${empty cartList}">
                                                    <p class="woocommerce-mini-cart__empty-message">这里好像空空如也</p>
                                                </c:if>

                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </c:if>


                            <c:if test="${not empty user}">
                                <li class="parlo-dropdown">
                                    <a class="parlo-dropdown-toggle" href="#">
                                        <i class="menu-icon"></i>
                                    </a>
                                    <div class="header-quick-menu parlo-dropdown-menu">
                                        <div id="nav_menu-5" class="single-header-quick-menu widget_nav_menu">
                                            <h4 class="widget-title">账户</h4>
                                            <div class="menu-account-container">
                                                <ul id="menu-account" class="menu">
                                                    <li lass="menu-item menu-item-type-post_type menu-item-object-page">
                                                        <a href="account.jsp">我的</a>
                                                    </li>
                                                    <li lass="menu-item menu-item-type-post_type menu-item-object-page">
                                                        <a href="orderservlet?method=list">订单</a>
                                                    </li>
                                                    <li class="menu-item menu-item-type-post_type menu-item-object-page">
                                                        <a href="cartservlet?method=list">购物车</a>
                                                    </li>
                                                    <li class="menu-item menu-item-type-post_type menu-item-object-page">
                                                        <a href="addressservlet?method=list">地址</a>
                                                    </li>
                                                    <li lass="menu-item menu-item-type-post_type menu-item-object-page">
                                                        <a href="userservlet?method=logout">登出</a>
                                                    </li>

                                                </ul>
                                            </div>
                                        </div> <span class="parlo-dropdown-close" margin: 25px;>
                                    <img src="resources/images/delete.png" style="width: 20px;"/>
                                </span>
                                    </div>
                                </li>
                            </c:if>

                        </ul>
                    </div>

                </div>

            </div>
        </div>
    </div>


    <!-- 移动端适配 header-->
    <div class="header-small-mobile">
        <div class="ht-container">
            <div class="ht-row">
                <div class="ht-col-md-6 ht-col-xs-6">
                    <div class="mobile-logo">
                        <a href="${pageContext.request.contextPath}/" class="custom-logo-link" rel="home"
                           aria-current="page"><img src="resources/images/logo.png"
                                                    class="custom-logo" alt="disciplinepro" /></a> </div>
                </div>
                <div class="ht-col-md-6 ht-col-xs-6 ht-d-flex ht-end-xs">
                    <div class="header-right-wrap">
                        <div class="header-right-content">
                            <ul>
                                <c:if test="${not empty user}">
                                    <li class="mini-cart parlo-dropdown">
                                        <a class="parlo-dropdown-toggle" href="#">
                                            <i class="cart-icon"></i>
                                            <span class="parlo-mini-cart">
                                                <span class="minicart-counter">${num}</span>
                                                <span class="minicart-price"><span
                                                        class="woocommerce-Price-amount amount"><bdi><span
                                                        class="woocommerce-Price-currencySymbol">&#165;</span>${total}</bdi></span></span>
                                            </span>
                                        </a>
                                        <div class="minicart-page-area parlo-dropdown-menu" >
                                            <h3>购物车</h3><span class="mini-cart-close parlo-dropdown-close">
                                            <img src="resources/images/delete.png" style="width: 20px;">
                                        </span>
                                            <div class="items-list">
                                                <div class="widget_shopping_cart_content">



                                                    <c:if test="${not empty cartList}">
                                                        <ul class="woocommerce-mini-cart cart_list product_list_widget ">
                                                            <c:forEach items="${cartList}" var="cart">
                                                                <li class="woocommerce-mini-cart-item mini_cart_item">

                                                                    <div class="mini-cart-thumb">
                                                                        <a href="goodsservlet?method=detail&id=${cart.gid}"><img
                                                                                src="${cart.goods.picture}"
                                                                                class="attachment-woocommerce_thumbnail size-woocommerce_thumbnail"
                                                                                alt="" loading="lazy"
                                                                                sizes="(max-width: 300px) 100vw, 300px"
                                                                                width="300" height="300"></a> </div>
                                                                    <div class="mini-cart-content">
                                                                        <h4>
                                                                            <a href="goodsservlet?method=detail&id=${cart.gid}">${cart.goods.name}</a> </h4>
                                                                        <span class="quantity">${cart.quantity} × <span
                                                                                class="woocommerce-Price-amount amount"><bdi><span
                                                                                class="woocommerce-Price-currencySymbol">&#165;</span>${cart.goods.price*cart.goods.discount}</bdi></span></span>
                                                                    </div>
                                                                </li>
                                                            </c:forEach>

                                                        </ul>

                                                        <p class="woocommerce-mini-cart__total total">
                                                            <strong>总和:</strong> <span
                                                                class="woocommerce-Price-amount amount"><bdi><span
                                                                class="woocommerce-Price-currencySymbol">&#165;</span>${total}</bdi></span>
                                                        </p>


                                                        <p class="woocommerce-mini-cart__buttons buttons">
                                                            <a
                                                                    href="/cartservlet?method=list"
                                                                    class="button wc-forward">查看购物车</a>
                                                            <a
                                                                    href="/orderservlet?method=checkout"
                                                                    class="button checkout wc-forward">结算</a>
                                                        </p>
                                                    </c:if>

                                                    <c:if test="${empty cartList}">
                                                        <p class="woocommerce-mini-cart__empty-message">这里好像空空如也</p>
                                                    </c:if>

                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </c:if>

                                <li class="mobile-menu-li"><a id="mobile-menu-trigger" class="mobile-menu-icon"
                                                              href="javascript:void(0)"><i class="menu-icon"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--移动端适配 menu -->
    <div class="offcanvas-mobile-menu" id="offcanvas-mobile-menu">
        <a href="javascript:void(0)" id="offcanvas-menu-close-trigger">
            <img src="resources/images/delete.png" style="width: 20px;">
        </a>

        <div class="offcanvas-wrapper">
            <div class="offcanvas-inner-content">
                <nav class="offcanvas-navigation">
                    <ul id="primary-menu" class="menu">
                        <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-home current-menu-item page_item page-item-11 current_page_item menu-item-has-children menu-item-434">
                            <a href="${pageContext.request.contextPath}/" aria-current="page">主页</a>
                        </li>
                        <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-672">
                            <a href="goodsservlet?method=shop">商城</a>
                            <ul class="sub-menu">
                                <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children">
                                    <a href="goodsservlet?method=shop&categoryid=1">运动服饰</a></li>
                                </li>
                                <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children">
                                    <a href="goodsservlet?method=shop&categoryid=2">运动装备</a></li>

                                </li>
                                <li class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children">
                                    <a href="goodsservlet?method=shop&categoryid=3">运动补给</a></li>
                                </li>
                            </ul>
                        </li>

                        <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-672">
                            <a href="account.jsp">我的</a>
                            <ul class="sub-menu">
                                <c:if test="${not empty user}">
                                    <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children">
                                        <a href="account.jsp">我的</a></li>
                                    </li>
                                    <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children">
                                        <a href="orderservlet?method=list">订单</a></li>

                                    </li>
                                    <li class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children">
                                        <a href="addressservlet?method=list">地址</a></li>
                                    </li>
                                    <li class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children">
                                        <a href="userservlet?method=logout">登出</a></li>
                                    </li>
                                </c:if>
                                <c:if test="${empty user}">
                                    <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children">
                                        <a href="login.jsp">登入</a></li>

                                    </li>
                                    <li class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children">
                                        <a href="register.jsp">注册</a></li>
                                    </li>
                                </c:if>
                            </ul>
                        </li>

                        <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-672">
                            <a href="about.jsp">关于</a>
                        </li>

                    </ul>
                </nav>
            </div>
        </div>
    </div>

</header>