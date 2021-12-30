<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/12/17
  Time: 13:26
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.discipline.java.bean.User" %>
<%
    User user=(User)request.getSession().getAttribute("user");
    request.setAttribute("administrator",user);
%>
<style>
    .menu-icon {
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
                        <a href="${pageContext.request.contextPath}/" class="custom-logo-link" rel="home" aria-current="page"><img
                                src="resources/images/logo.png" class="custom-logo" alt="disciplinepro">

                        </a>
                    </div><!-- .site-branding -->
                </div>

                <div class="ht-col-md-7 ht-center-xs">
                    <div class="main-menu-area">



                        <nav id="site-navigation" class="main-navigation">
                            <ul class="menu">

                                <li class="menu-item menu-item-type-post_type menu-item-object-page nocls"><a
                                        href="admin?method=dashboard" class="">总览
                                </a></li>

                                <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children ">
                                    <a href="admin?method=goods" class=""> 商品管理
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="menu-item menu-item-type-custom menu-item-object-custom ">
                                            <a href="admin?method=goods&categoryid=1"
                                               class=""><span> 运动服饰</span> </a></li>
                                        <li class="menu-item menu-item-type-post_type menu-item-object-page ">
                                            <a href="admin?method=goods&categoryid=2"
                                               class=""><span>运动用品</span> </a></li>
                                        <li class="menu-item menu-item-type-custom menu-item-object-custom ">
                                            <a href="admin?method=goods&categoryid=3"
                                               class=""><span>运动补给</span> </a></li>
                                    </ul>
                                </li>

                                <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children ">
                                    <a href="admin?method=orders" class=""> 订单管理
                                        <i class="fa fa-angle-down"></i>
                                    </a>
                                    <ul class="sub-menu">
                                        <li class="menu-item menu-item-type-custom menu-item-object-custom ">
                                            <a href="admin?method=orders"
                                               class=""><span>全部订单</span> </a></li>
                                        <li class="menu-item menu-item-type-post_type menu-item-object-page ">
                                            <a href="admin?method=orders&status=1"
                                               class=""><span>待发货订单</span> </a></li>
                                        <li class="menu-item menu-item-type-custom menu-item-object-custom ">
                                            <a href="admin?method=orders&status=5"
                                               class=""><span>已逾期订单</span> </a></li>
                                    </ul>
                                </li>


                            </ul>
                        </nav><!-- #site-navigation -->
                    </div>
                </div>


                <div class="ht-col-md-3 ht-d-flex ht-end-sm">
                    <div class="header-right-content">
                        <ul>

                            <li class="parlo-dropdown">
                                <a class="parlo-dropdown-toggle" href="#">
                                    <i class="menu-icon"></i>
                                </a>
                                <div class="header-quick-menu parlo-dropdown-menu">
                                    <div id="nav_menu-5" class="single-header-quick-menu widget_nav_menu">
                                        <h4 class="widget-title">欢迎您！管理员 <strong>${administrator.username}</strong></h4>
                                        <div class="menu-account-container">
                                            <ul id="menu-account" class="menu">
                                                <li lass="menu-item menu-item-type-post_type menu-item-object-page">
                                                    <a href="userservlet?method=logout">登出</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div> <span class="parlo-dropdown-close" margin:="" 25px;="">
                                                <img src="resources/images/delete.png" style="width: 20px;">
                                            </span>
                                </div>
                            </li>


                        </ul>
                    </div>

                </div>

            </div>
        </div>
    </div>



    <div class="header-small-mobile">
        <div class="ht-container">
            <div class="ht-row">
                <div class="ht-col-md-6 ht-col-xs-6">
                    <div class="mobile-logo">
                        <a href="${pageContext.request.contextPath}/" class="custom-logo-link" rel="home" aria-current="page"><img
                                src="resources/images/logo.png" class="custom-logo" alt="disciplinepro"></a>
                    </div>
                </div>
                <div class="ht-col-md-6 ht-col-xs-6 ht-d-flex ht-end-xs">
                    <div class="header-right-wrap">
                        <div class="header-right-content">
                            <ul>

                                <li class="menu-icon"><a id="mobile-menu-trigger" class="mobile-menu-icon"
                                                         href="javascript:void(0)"><i class="sli sli-menu"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 适配移动端menu -->
    <div class="offcanvas-mobile-menu" id="offcanvas-mobile-menu">
        <a href="javascript:void(0)" id="offcanvas-menu-close-trigger">
            <img src="resources/images/delete.png" style="width: 20px;">
        </a>

        <div class="offcanvas-wrapper">
            <div class="offcanvas-inner-content">
                <nav class="offcanvas-navigation">
                    <ul id="primary-menu" class="menu">
                        <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-home current-menu-item page_item page-item-11 current_page_item menu-item-has-children menu-item-434">
                            <a href="admin?method=dashboard" aria-current="page">总览</a>
                        </li>
                        <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-672">
                            <a href="admin?method=goods">商品管理</a>
                            <ul class="sub-menu">
                                <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children">
                                    <a href="admin?method=goods&categoryid=1">运动服饰管理</a></li>
                                </li>
                                <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children">
                                    <a href="admin?method=goods&categoryid=2">运动用品管理</a></li>

                                </li>
                                <li class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children">
                                    <a href="admin?method=goods&categoryid=3">运动补给管理</a></li>
                                </li>
                            </ul>
                        </li>

                        <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-672">
                            <a href="admin?method=orders">订单管理</a>
                            <ul class="sub-menu">
                                <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children">
                                    <a href="admin?method=orders">全部订单</a></li>
                                </li>
                                <li class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children">
                                    <a href="admin?method=orders&status=1">待发货订单</a></li>

                                </li>
                                <li class="menu-item menu-item-type-custom menu-item-object-custom menu-item-has-children">
                                    <a href="admin?method=orders&status=5">已逾期订单</a></li>
                                </li>
                            </ul>
                        </li>
                        

                    </ul>
                </nav>
            </div>
        </div>
    </div>

</header>
