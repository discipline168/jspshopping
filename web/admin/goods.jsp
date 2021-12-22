<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/12/17
  Time: 13:29
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en-US">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>discipl!ne pro 后台管理 &#8211; 商品管理</title>
    <meta name='robots' content='noindex, nofollow' />


    <link rel='stylesheet' id='simple-line-icons-wl-css' href='../resources/css/simple-line-icons.css' type='text/css'
          media='all' />

    <link rel='stylesheet' id='htflexboxgrid-css' href='../resources/css/htflexboxgrid.css' type='text/css'
          media='all' />
    <link rel='stylesheet' id='woolentor-widgets-css' href='../resources/css/woolentor-widgets.css' type='text/css'
          media='all' />


    <link rel='stylesheet' id='parlo-style-css' href='../resources/css/style.css' type='text/css' media='all' />
    <link rel='stylesheet' id='elementor-frontend-legacy-css' href='../resources/css/frontend-legacy.min.css'
          type='text/css' media='all' />
    <link rel='stylesheet' id='elementor-frontend-css' href='../resources/css/frontend.min.css' type='text/css'
          media='all' />

    <link rel='stylesheet' id='elementor-post-11-css' href='../resources/css/post-11.css' type='text/css' media='all' />

    <link rel="stylesheet" id="woocommerce-smallscreen-css" href="../resources/css/woocommerce-smallscreen.css"
          type="text/css" media="only screen and (max-width: 768px)">



    <script type='text/javascript' src='../resources/js/jquery.min.js' id='jquery-core-js'></script>


</head>

<body
        class="archive post-type-archive post-type-archive-product wp-custom-logo theme-parlo woocommerce-shop woocommerce woocommerce-page woocommerce-no-js woolentor_current_theme_parlo hfeed woocommerce-active elementor-default elementor-kit-915">

<div id="page" class="site">
    <a class="skip-link screen-reader-text" href="#content">Skip to content</a>

    <!-- 导航 -->
   <%@include file="../commons/aheader.jsp"%>


    <div id="content" class="site-content">

        <div class="page-title-area">
            <div class="ht-container">
                <div class="ht-col-md-12 ht-col-sx-12 ht-center-md">
                    <div class="breadcrumb-content">
                        <ul>
                            <li><a href="admin?method=dashboard">总览</a></li>
                            <li><a href="admin?method=goods">商品管理</a></li>
                            <c:if test="${not empty category}">
                                <li>${category.name}管理</li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div id="primary" class="shop-area parlopage-padding">
            <main id="main" class="site-main" role="main">
                <div class="ht-container">
                    <div class="parlo-cus-tab-pane cusactive" id="grid">

                        <div class="products columns-3 ht-products">


                            <div class="ht-row">
                                <div class="ht-col-xs-12">

                                    <article id="post-50" class="post-50 page type-page status-publish hentry">


                                        <div class="entry-content">
                                            <div class="woocommerce">
                                                <form class="woocommerce-cart-form">
                                                    <div class="table-responsive cart-table-content">

                                                        <table
                                                                class="shop_table shop_table_responsive cart woocommerce-cart-form__contents"
                                                                cellspacing="0">


                                                            <!-- loading -->



                                                            <thead>
                                                            <tr>

                                                                <th>首页图片</th>

                                                                <th>商品名称</th>
                                                                <th>类别</th>
                                                                <th>价格</th>
                                                                <th>当前折扣</th>
                                                                <th>状态</th>
                                                                <th>编辑详情</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>



                                                            <c:forEach items="${goodsList}" var="goods">
                                                                <tr class="woocommerce-cart-form__cart-item cart_item">



                                                                    <td data-title="Product Image"><a
                                                                            href="goodsservlet?method=detail&id=${goods.id}"><img
                                                                            style="background: #f0f0f0;"
                                                                            src="${goods.picture}"
                                                                            class="attachment-woocommerce_thumbnail size-woocommerce_thumbnail"
                                                                            alt="" loading="lazy"
                                                                            sizes="(max-width: 300px) 100vw, 300px"
                                                                            width="300" height="300"></a>
                                                                    </td>

                                                                    <td data-title="商品"><a
                                                                            href="goodsservlet?method=detail&id=${goods.id}">${goods.name}</a></td>

                                                                    <td data-title="类别">${goods.category.name}</td>

                                                                    <td data-title="价格">
                                                                            <span
                                                                                    class="woocommerce-Price-amount amount"><bdi><span
                                                                                    class="woocommerce-Price-currencySymbol">¥</span>${goods.price}</bdi></span>
                                                                    </td>

                                                                    <td data-title="当前折扣">${goods.discount}</td>

                                                                    <td data-title="状态">
                                                                        <c:if test="${goods.status==1}">在售</c:if>
                                                                        <c:if test="${goods.status==0}">下架</c:if>
                                                                    </td>


                                                                    <td data-title="编辑详情">
                                                                        <a href="admin?method=editGoods&id=${goods.id}"
                                                                           data-product_id="59"
                                                                           data-product_sku="woo-sunglasses">
                                                                            <img style="width: 30px;"
                                                                                 src="../resources/images/edit.png">
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>





                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-lg-12">
                                                            <div class="cart-shiping-update-wrapper">

                                                                <div class="cart-clear">
                                                                    <a href="admin?method=editGoods">新增商品</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </form>
                                            </div>
                                        </div><!-- .entry-content -->

                                    </article><!-- #post-50 -->


                                </div>




                            </div>
                        </div>
                    </div>






                    <!-- 底部导航 -->
                    <nav class="woocommerce-pagination">
                        <ul class='page-numbers'>


                            <c:if test="${currentpPage>1}">

                                <li><a class="page-numbers"
                                       href="admin?method=goods&categoryid=${category.id!=null?category.id:0}&page=${currentpPage-1}"><</a></li>
                            </c:if>
                            <li><span aria-current="page" class="page-numbers current">${currentpPage}</span></li>

                            <c:if test="${currentpPage<pages}">
                                <li><a class="next page-numbers"
                                       href="admin?method=goods&categoryid=${category.id!=null?category.id:0}&page=${currentpPage+1}">><i
                                        class="fa fa-angle-right"></i></a></li>
                            </c:if>

                        </ul>

                        <ul class="page-numbers"><li>共 ${pages} 页</li></ul>

                    </nav>

                </div>
            </main><!-- #main -->
        </div><!-- #primary -->

    </div><!-- #content -->


</div><!-- #page -->




<script type='text/javascript' src='../resources/js/main.js'></script>




<script type='text/javascript' src='../resources/js/woolentor-widgets-active.js'
        id='woolentor-widgets-scripts-js'></script>

</body>

</html>
