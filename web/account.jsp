<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/11/9
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.discipline.java.bean.User" %>

<!doctype html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>discipl!ne pro &#8211; 我的</title>
    <meta name='robots' content='noindex, nofollow' />


    <link rel='stylesheet' id='simple-line-icons-wl-css' href='resources/css/simple-line-icons.css' type='text/css'
          media='all' />

    <link rel='stylesheet' id='htflexboxgrid-css' href='resources/css/htflexboxgrid.css' type='text/css' media='all' />
    <link rel='stylesheet' id='woolentor-widgets-css' href='resources/css/woolentor-widgets.css' type='text/css'
          media='all' />


    <link rel='stylesheet' id='parlo-style-css' href='resources/css/style.css' type='text/css' media='all' />
    <link rel='stylesheet' id='elementor-frontend-legacy-css' href='resources/css/frontend-legacy.min.css'
          type='text/css' media='all' />
    <link rel='stylesheet' id='elementor-frontend-css' href='resources/css/frontend.min.css' type='text/css'
          media='all' />

    <link rel='stylesheet' id='elementor-post-11-css' href='resources/css/post-11.css' type='text/css' media='all' />
    <link rel="stylesheet" href="resources/css/load.css">

    <link rel='stylesheet' id='woocommerce-layout-css' href='resources/css/woocommerce-layout.css' type='text/css'
          media='all' />


    <script>
        //使用代金券
        function applyCoupon() {
            jQuery("[id='loading']").show();

            jQuery.ajax({
                url: "userservlet?method=coupon",
                data: {
                    "code": jQuery("[id='coupon_code']").val(),
                },
                type: "POST",
                success: function (data) {
                    jQuery("[id='loading']").hide(0);

                    if(data=="success"){
                        window.location.reload();
                    }
                    else{
                        alert(data);
                    }

                }
            })
        }
    </script>

</head>
<script type='text/javascript'
        src='resources/js/jquery.min.js'></script>


<body
        class="page-template-default page page-id-50 wp-custom-logo theme-parlo woocommerce-account woocommerce-page woocommerce-no-js woolentor_current_theme_parlo woocommerce-active elementor-default elementor-kit-915">

<div id="page" class="site">


    <!-- 头部导航 -->
    <%@include file="commons/header.jsp"%>


    <!-- loading -->
    <div class="spinner" id="loading">
        <div class="spinner-inner">
            <div class="rect1"></div>
            <div class="rect2"></div>
            <div class="rect3"></div>
            <div class="rect4"></div>
            <div class="rect5"></div>
        </div>
    </div>

    <div id="content" class="site-content">


        <!-- 面包屑导航 -->
        <div class="page-title-area">
            <div class="ht-container">
                <div class="ht-col-md-12 ht-col-sx-12 ht-center-md">
                    <div class="breadcrumb-content">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/">主页</a></li>
                            <li>我的</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>




        <div id="primary" class="content-area parlopage-padding">
            <main id="main" class="site-main">


                <%-- 用户主页 --%>
                <div class="ht-container">
                    <div class="ht-row">
                        <div class="ht-col-xs-12">


                            <article id="post-50" class="post-50 page type-page status-publish hentry">
                                <h1 class="entry-title">我的</h1>

                                <div class="entry-content">
                                    <div class="woocommerce">



                                        <!-- 左侧总览 -->
                                        <%@include file="commons/leftNav.jsp"%>


                                        <div class="woocommerce-MyAccount-content">

                                            <c:if test="${empty user}">
                                                <p>
                                                    尚未登入
                                                    <a href="login.jsp">点此登入</a>)
                                                </p>
                                            </c:if>

                                            <c:if test="${not empty user}">
                                                <p>
                                                    Hello <strong>${user.username}</strong> (并不是 <strong>${user.username}</strong>?
                                                    <a href="userservlet?method=logout">点此登出</a>)
                                                </p>
                                                <p>钱包余额：<strong>&#165;${user.balance}</strong></p>
                                                <div class="coupon">
                                                    <input type="text" id="coupon_code" class="input-text"  placeholder="代金券代码" style="width: 50%;margin-top: 10px;">
                                                    <button type="button" class="button" onclick="applyCoupon()">使用代金券</button>
                                                </div>
                                            </c:if>
                                            

                                        </div>
                                    </div>
                                </div><!-- .entry-content -->

                            </article><!-- #post-50 -->

                        </div>
                    </div>
                </div>




            </main><!-- #main -->
        </div><!-- #primary -->


    </div>



    <!-- #content -->

    <!-- 底部导航 -->
    <%@include file="commons/footer.jsp"%>
</div><!-- #page -->



<script type='text/javascript' src='resources/js/main.js'></script>


</body>

</html>
