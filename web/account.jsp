<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/11/9
  Time: 16:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="profile" href="https://gmpg.org/xfn/11">
    <script>document.documentElement.className = document.documentElement.className + ' yes-js js_active js'</script>
    <title>我的</title>
    <meta name='robots' content='noindex, nofollow' />


    <link rel='stylesheet' id='simple-line-icons-wl-css' href='/resources/css/simple-line-icons.css' type='text/css'
          media='all' />

    <link rel='stylesheet' id='htflexboxgrid-css' href='/resources/css/htflexboxgrid.css' type='text/css' media='all' />
    <link rel='stylesheet' id='woolentor-widgets-css' href='/resources/css/woolentor-widgets.css' type='text/css'
          media='all' />


    <link rel='stylesheet' id='parlo-style-css' href='resources/css/style.css' type='text/css' media='all' />
    <link rel='stylesheet' id='elementor-frontend-legacy-css' href='resources/css/frontend-legacy.min.css'
          type='text/css' media='all' />
    <link rel='stylesheet' id='elementor-frontend-css' href='resources/css/frontend.min.css' type='text/css'
          media='all' />

    <link rel='stylesheet' id='elementor-post-11-css' href='resources/css/post-11.css' type='text/css' media='all' />


    <link rel='stylesheet' id='woocommerce-layout-css' href='resources/css/woocommerce-layout.css' type='text/css'
          media='all' />


</head>
<script type='text/javascript'
        src='resources/js/jquery.min.js'></script>


<body
        class="page-template-default page page-id-50 wp-custom-logo theme-parlo woocommerce-account woocommerce-page woocommerce-no-js woolentor_current_theme_parlo woocommerce-active elementor-default elementor-kit-915">

<div id="page" class="site">


    <!-- 头部导航 -->
    <%@include file="commons/header.jsp"%>

    


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
                                            <div class="woocommerce-notices-wrapper"></div>
                                            <p>
                                                Hello <strong>${user.username}</strong> (并不是 <strong>${user.username}</strong>?
                                                <a href="/userservlet?method=logout">点此登出</a>)</p>
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

<div class="woocommerce" id="htwlquick-viewmodal">
    <div class="htwl-modal-dialog product">
        <div class="htwl-modal-content"><button type="button" class="htcloseqv"><span
                class="sli sli-close"></span></button>
            <div class="htwl-modal-body"></div>
        </div>
    </div>
</div>

<script type='text/javascript' src='resources/js/main.js'></script>


</body>

</html>
