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
        background-image: url(/resources/images/cart.png);
        background-position: center center;
        width: 25px;
        display: inline-block;
        height: 25px;
        background-size: 25px;
    }
    .menu-icon{
        background-image: url(/resources/images/menu.png);
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
                        <a href="https://demo.shrimpthemes.com/1/parlo/" class="custom-logo-link" rel="home"
                           aria-current="page"><img width="116" height="28"
                                                    src="https://demo.shrimpthemes.com/1/parlo/wp-content/uploads/2019/03/logo.png"
                                                    class="custom-logo" alt="Parlo" /></a> </div><!-- .site-branding -->
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
                                    <a href="${pageContext.request.contextPath}/goodsservlet?method=shop" class=""><span
                                            class="parlo-menu-tag">HOT</span> 商城 <i
                                            class="fa fa-angle-down"></i></a>
                                    <ul class="sub-menu">
                                        <li class="menu-item menu-item-type-custom menu-item-object-custom ">
                                            <a href="${pageContext.request.contextPath}/goodsservlet?method=shop&categoryid=1"
                                               class=""><span>运动服饰</span> </a></li>
                                        <li class="menu-item menu-item-type-post_type menu-item-object-page ">
                                            <a href="${pageContext.request.contextPath}/goodsservlet?method=shop&categoryid=2"
                                               class=""><span>运动装备</span> </a></li>
                                        <li class="menu-item menu-item-type-custom menu-item-object-custom ">
                                            <a href="${pageContext.request.contextPath}/goodsservlet?method=shop&categoryid=3"
                                               class=""><span>运动补给</span> </a></li>
                                    </ul>
                                </li>
                                <li
                                        class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children ">
                                    <a href="https://demo.shrimpthemes.com/1/parlo/shop/" class=""><span
                                            class="parlo-menu-tag">New</span> 账户 <i
                                            class="fa fa-angle-down"></i></a>



                                    <c:if test="${not empty user}">
                                        <ul class="sub-menu">
                                            <li class="menu-item menu-item-type-custom menu-item-object-custom ">
                                                <a href="${pageContext.request.contextPath}/account.jsp"
                                                   class=""><span>我的</span> </a></li>
                                            <li class="menu-item menu-item-type-post_type menu-item-object-page ">
                                                <a href="https://demo.shrimpthemes.com/1/parlo/shop/"
                                                   class=""><span>订单</span> </a></li>
                                            <li class="menu-item menu-item-type-custom menu-item-object-custom ">
                                                <a href="/cartservlet?method=list"
                                                   class=""><span>购物车</span> </a></li>
                                        </ul>
                                    </c:if>


                                    <c:if test="${empty user}">
                                        <ul class="sub-menu">
                                            <li class="menu-item menu-item-type-post_type menu-item-object-page ">
                                                <a href="${pageContext.request.contextPath}/login.jsp"
                                                   class=""><span>登录</span> </a></li>
                                            <li class="menu-item menu-item-type-custom menu-item-object-custom ">
                                                <a href="${pageContext.request.contextPath}/register.jsp"
                                                   class=""><span>注册</span> </a></li>
                                        </ul>
                                    </c:if>


                                </li>
                                <li class="menu-item menu-item-type-post_type menu-item-object-page nocls"><a
                                        href="https://demo.shrimpthemes.com/1/parlo/about-us/" class="">关于
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
                                    <div class="minicart-page-area parlo-dropdown-menu" style="width: 400px">
                                        <h3>购物车</h3>
                                        <span class="mini-cart-close parlo-dropdown-close">
                                            <img src="resources/images/delete.png" style="width: 20px;"></img>
                                        </span>
                                        <div class="items-list">
                                            <div class="widget_shopping_cart_content">

                                                <ul class="woocommerce-mini-cart cart_list product_list_widget ">
                                                    <c:forEach items="${cartList}" var="cart">
                                                        <li class="woocommerce-mini-cart-item mini_cart_item">

                                                            <div class="mini-cart-thumb">
                                                                <a href="/goodsservlet?method=detail&id=${cart.gid}"><img
                                                                        src="${cart.goods.picture}"
                                                                        class="attachment-woocommerce_thumbnail size-woocommerce_thumbnail"
                                                                        alt="" loading="lazy"
                                                                        sizes="(max-width: 300px) 100vw, 300px"
                                                                        width="300" height="300"></a> </div>
                                                            <div class="mini-cart-content">
                                                                <h4>
                                                                    <a href="/goodsservlet?method=detail&id=${cart.gid}">${cart.goods.name}</a> </h4>
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


                                                <p class="woocommerce-mini-cart__buttons buttons"><a
                                                        href="/cartservlet?method=list"
                                                        class="button wc-forward">查看购物车</a><a
                                                        href="https://demo.shrimpthemes.com/1/parlo/checkout/"
                                                        class="button checkout wc-forward">结算</a></p>


                                            </div>
                                        </div>
                                    </div>
                                </li>
                            </c:if>


                            <li class="parlo-dropdown">
                                <a class="parlo-dropdown-toggle" href="#">
                                    <i class="menu-icon"></i>
                                </a>
                                <div class="header-quick-menu parlo-dropdown-menu">
                                    <div id="nav_menu-5" class="single-header-quick-menu widget_nav_menu">
                                        <h4 class="widget-title">账户</h4>
                                        <div class="menu-account-container">
                                            <ul id="menu-account" class="menu">
                                                <li lass="menu-item menu-item-type-post_type menu-item-object-page menu-item-234">
                                                    <a
                                                            href="https://demo.shrimpthemes.com/1/parlo/my-account/">我的</a>
                                                </li>
                                                <li lass="menu-item menu-item-type-post_type menu-item-object-page menu-item-235">
                                                    <a
                                                            href="https://demo.shrimpthemes.com/1/parlo/checkout/">订单</a>
                                                </li>
                                                <li lass="menu-item menu-item-type-post_type menu-item-object-page menu-item-700">
                                                    <a
                                                            href="https://demo.shrimpthemes.com/1/parlo/wishlist/">心愿单</a>
                                                </li>
                                                <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-236">
                                                    <a
                                                            href="https://demo.shrimpthemes.com/1/parlo/cart/">购物车</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div> <span class="parlo-dropdown-close" margin: 25px;>
                                    <img src="resources/images/delete.png" style="width: 20px;"/>
                                </span>
                                </div>
                            </li>
                        </ul>
                    </div>

                </div>

            </div>
        </div>
    </div>


    <!-- 移动端适配-->
    <div class="header-small-mobile">
        <div class="ht-container">
            <div class="ht-row">
                <div class="ht-col-md-6 ht-col-xs-6">
                    <div class="mobile-logo">
                        <a href="/" class="custom-logo-link" rel="home"
                           aria-current="page"><img width="116" height="28"
                                                    src="https://demo.shrimpthemes.com/1/parlo/wp-content/uploads/2019/03/logo.png"
                                                    class="custom-logo" alt="Parlo" /></a> </div>
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

                                                    <ul class="woocommerce-mini-cart cart_list product_list_widget ">
                                                        <c:forEach items="${cartList}" var="cart">
                                                            <li class="woocommerce-mini-cart-item mini_cart_item">

                                                                <div class="mini-cart-thumb">
                                                                    <a href="/goodsservlet?method=detail&id=${cart.gid}"><img
                                                                            src="${cart.goods.picture}"
                                                                            class="attachment-woocommerce_thumbnail size-woocommerce_thumbnail"
                                                                            alt="" loading="lazy"
                                                                            sizes="(max-width: 300px) 100vw, 300px"
                                                                            width="300" height="300"></a> </div>
                                                                <div class="mini-cart-content">
                                                                    <h4>
                                                                        <a href="/goodsservlet?method=detail&id=${cart.gid}">${cart.goods.name}</a> </h4>
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


                                                    <p class="woocommerce-mini-cart__buttons buttons"><a
                                                            href="/cartservlet?method=list"
                                                            class="button wc-forward">查看购物车</a><a
                                                            href="https://demo.shrimpthemes.com/1/parlo/checkout/"
                                                            class="button checkout wc-forward">结算</a></p>


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

    <!--=======  offcanvas mobile menu  =======-->
    <div class="offcanvas-mobile-menu" id="offcanvas-mobile-menu">
        <a href="javascript:void(0)" class="offcanvas-menu-close" id="offcanvas-menu-close-trigger">
            <i class="sli sli-close"></i>
        </a>

        <div class="offcanvas-wrapper">
            <div class="offcanvas-inner-content">
                <div class="offcanvas-mobile-search-area">
                    <form action="https://demo.shrimpthemes.com/1/parlo/">
                        <input type="text" name="s" placeholder="Search..." value="">
                        <input type="hidden" name="post_type" value="product" />
                        <button type="submit"><i class="fa fa-search"></i></button>
                    </form>
                </div>

                <%-- 手机适配 --%>
                <nav class="offcanvas-navigation">
                    <ul id="primary-menu" class="menu">
                        <li id="menu-item-434"
                            class="menu-item menu-item-type-post_type menu-item-object-page menu-item-home current-menu-item page_item page-item-11 current_page_item menu-item-has-children menu-item-434">
                            <a href="https://demo.shrimpthemes.com/1/parlo/" aria-current="page">Home</a>
                            <ul class="sub-menu">
                                <li id="menu-item-504"
                                    class="menu-item menu-item-type-custom menu-item-object-custom menu-item-504">
                                    <a href="http://demo.shrimpthemes.com/1/parlo/home-two/?footerlayout=1">Home
                                        Two (Pro)</a></li>
                                <li id="menu-item-505"
                                    class="menu-item menu-item-type-custom menu-item-object-custom menu-item-505">
                                    <a href="http://demo.shrimpthemes.com/1/parlo/home-three/?footerlayout=1">Home
                                        Three (Pro)</a></li>
                            </ul>
                        </li>
                        <li id="menu-item-672"
                            class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-672">
                            <a href="https://demo.shrimpthemes.com/1/parlo/shop/">Shop</a>
                            <ul class="sub-menu">
                                <li id="menu-item-257"
                                    class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-257">
                                    <a href="https://demo.shrimpthemes.com/1/parlo/shop/">Shop</a>
                                    <ul class="sub-menu">
                                        <li id="menu-item-711"
                                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-711">
                                            <a
                                                    href="http://demo.shrimpthemes.com/1/parlo/shop/?shoplayout=right">Shop
                                                Right Sidebar</a></li>
                                        <li id="menu-item-713"
                                            class="menu-item menu-item-type-post_type menu-item-object-page menu-item-713">
                                            <a href="https://demo.shrimpthemes.com/1/parlo/shop/">Shop Left
                                                Sidebar</a></li>
                                        <li id="menu-item-712"
                                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-712">
                                            <a
                                                    href="http://demo.shrimpthemes.com/1/parlo/shop/?shoplayout=full">Shop
                                                Full Width</a></li>
                                    </ul>
                                </li>
                                <li id="menu-item-245"
                                    class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-245">
                                    <a href="https://demo.shrimpthemes.com/1/parlo/my-account/">My account</a>
                                    <ul class="sub-menu">
                                        <li id="menu-item-248"
                                            class="menu-item menu-item-type-post_type menu-item-object-page menu-item-248">
                                            <a href="https://demo.shrimpthemes.com/1/parlo/my-account/">My
                                                account</a></li>
                                        <li id="menu-item-249"
                                            class="menu-item menu-item-type-post_type menu-item-object-page menu-item-249">
                                            <a
                                                    href="https://demo.shrimpthemes.com/1/parlo/checkout/">Checkout</a>
                                        </li>
                                        <li id="menu-item-250"
                                            class="menu-item menu-item-type-post_type menu-item-object-page menu-item-250">
                                            <a href="https://demo.shrimpthemes.com/1/parlo/cart/">Cart</a></li>
                                    </ul>
                                </li>
                                <li id="menu-item-714"
                                    class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children menu-item-714">
                                    <a href="#">Product Details Page</a>
                                    <ul class="sub-menu">
                                        <li id="menu-item-715"
                                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-715">
                                            <a
                                                    href="http://demo.shrimpthemes.com/1/parlo/product/nulla-nibh-sagittis-augue/?prodetaillayout=left">Product
                                                Left Sidebar</a></li>
                                        <li id="menu-item-716"
                                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-716">
                                            <a
                                                    href="http://demo.shrimpthemes.com/1/parlo/product/nulla-nibh-sagittis-augue/?prodetaillayout=right">Product
                                                Right Sidebar</a></li>
                                        <li id="menu-item-717"
                                            class="menu-item menu-item-type-custom menu-item-object-custom menu-item-717">
                                            <a
                                                    href="http://demo.shrimpthemes.com/1/parlo/product/nulla-nibh-sagittis-augue/?prodetaillayout=full">Product
                                                Full Width</a></li>
                                    </ul>
                                </li>
                                <li id="menu-item-718"
                                    class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children menu-item-718">
                                    <a href="#">Pages</a>
                                    <ul class="sub-menu">
                                        <li id="menu-item-247"
                                            class="menu-item menu-item-type-post_type menu-item-object-page menu-item-247">
                                            <a href="https://demo.shrimpthemes.com/1/parlo/cart/">Cart</a></li>
                                        <li id="menu-item-719"
                                            class="menu-item menu-item-type-post_type menu-item-object-page menu-item-719">
                                            <a
                                                    href="https://demo.shrimpthemes.com/1/parlo/wishlist/">Wishlist</a>
                                        </li>
                                        <li id="menu-item-720"
                                            class="menu-item menu-item-type-post_type menu-item-object-page menu-item-720">
                                            <a
                                                    href="https://demo.shrimpthemes.com/1/parlo/checkout/">Checkout</a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                        <li id="menu-item-673"
                            class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-673">
                            <a href="https://demo.shrimpthemes.com/1/parlo/blog/">Blog</a>
                            <ul class="sub-menu">
                                <li id="menu-item-724"
                                    class="menu-item menu-item-type-custom menu-item-object-custom menu-item-724">
                                    <a href="http://demo.shrimpthemes.com/1/parlo/blog/?bloglayout=full">Blog
                                        Full Width</a></li>
                                <li id="menu-item-721"
                                    class="menu-item menu-item-type-post_type menu-item-object-page menu-item-721">
                                    <a href="https://demo.shrimpthemes.com/1/parlo/blog/">Blog Right Sidebar</a>
                                </li>
                                <li id="menu-item-723"
                                    class="menu-item menu-item-type-custom menu-item-object-custom menu-item-723">
                                    <a href="http://demo.shrimpthemes.com/1/parlo/blog/?bloglayout=left">Blog
                                        Left Sidebar</a></li>
                            </ul>
                        </li>
                        <li id="menu-item-670"
                            class="menu-item menu-item-type-post_type menu-item-object-page menu-item-670"><a
                                href="https://demo.shrimpthemes.com/1/parlo/about-us/">About Us</a></li>
                        <li id="menu-item-671"
                            class="menu-item menu-item-type-post_type menu-item-object-page menu-item-671"><a
                                href="https://demo.shrimpthemes.com/1/parlo/contact-us/">Contact us</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
    <!--=======  End of offcanvas mobile menu  =======-->

</header>