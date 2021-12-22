<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/11/18
  Time: 16:40
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>discipl!ne pro &#8211; 订单</title>
    <meta name='robots' content='noindex, nofollow' />


    <link rel='stylesheet' id='simple-line-icons-wl-css' href='resources/css/simple-line-icons.css' type='text/css'
          media='all' />

    <link rel='stylesheet' id='htflexboxgrid-css' href='resources/css/htflexboxgrid.css' type='text/css' media='all' />
    <link rel='stylesheet' id='woolentor-widgets-css' href='resources/css/woolentor-widgets.css' type='text/css'
          media='all' />



    <link rel='stylesheet' id='elementor-frontend-legacy-css' href='resources/css/frontend-legacy.min.css'
          type='text/css' media='all' />
    <link rel='stylesheet' id='elementor-frontend-css' href='resources/css/frontend.min.css' type='text/css'
          media='all' />

    <link rel='stylesheet' id='elementor-post-11-css' href='resources/css/post-11.css' type='text/css' media='all' />


    <link rel="stylesheet" href="resources/css/woocommerce.css">



    <link rel='stylesheet' id='woocommerce-layout-css' href='resources/css/woocommerce-layout.css' type='text/css'
          media='all' />

    <script type='text/javascript' src='resources/js/jquery.min.js' id='jquery-core-js'></script>

    <link rel="stylesheet" id="woocommerce-smallscreen-css"
          href="resources/css/woocommerce-smallscreen.css"
          type="text/css" media="only screen and (max-width: 768px)">


    <style id='woocommerce-inline-inline-css' type='text/css'>
        .woocommerce form .form-row .required {
            visibility: visible;
        }
    </style>


    <link rel='stylesheet' id='parlo-style-css' href='resources/css/style.css' type='text/css' media='all' />


</head>

<body
        class="page-template-default page page-id-50 logged-in wp-custom-logo theme-parlo woocommerce-account woocommerce-page woocommerce-orders woocommerce-no-js woolentor_current_theme_parlo woocommerce-active elementor-default elementor-kit-915">

<div id="page" class="site">
    <a class="skip-link screen-reader-text" href="#content">Skip to content</a>

    <!-- 导航 -->
    <%@include file="commons/header.jsp"%>

    <div id="content" class="site-content">
        <!-- 面包屑导航 -->
        <div class="page-title-area">
            <div class="ht-container">
                <div class="ht-col-md-12 ht-col-sx-12 ht-center-md">
                    <div class="breadcrumb-content">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/">主页</a></li>
                            <li><a href="account.jsp">我的</a></li>
                            <li>订单</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div id="primary" class="content-area parlopage-padding">
            <main id="main" class="site-main">

                <div class="ht-container">
                    <div class="ht-row">
                        <div class="ht-col-xs-12">


                            <article id="post-50" class="post-50 page type-page status-publish hentry">

                                <div class="entry-content">
                                    <div class="woocommerce">


                                        <!-- 左侧总览 -->
                                       <%@include file="commons/leftNav.jsp"%>


                                        <div class="woocommerce-MyAccount-content">
                                            <div class="woocommerce-notices-wrapper"></div>




                                            <c:if test="${empty orderList}">
                                                <div class="woocommerce-message woocommerce-message--info woocommerce-Message woocommerce-Message--info woocommerce-info">
                                                    <a class="woocommerce-Button button"
                                                       href="goodsservlet?method=shop">去浏览商品</a>
                                                    您目前暂时没有任何订单信息
                                                </div>
                                            </c:if>

                                            <c:if test="${not empty orderList}">
                                                <table
                                                        class="woocommerce-orders-table woocommerce-MyAccount-orders shop_table shop_table_responsive my_account_orders account-orders-table">
                                                    <thead>
                                                    <tr>
                                                        <th  class="woocommerce-orders-table__header woocommerce-orders-table__header-order-number">
                                                            <span class="nobr">订单号</span></th>
                                                        <th
                                                                class="woocommerce-orders-table__header woocommerce-orders-table__header-order-date">
                                                            <span class="nobr">下单时间</span></th>
                                                        <th
                                                                class="woocommerce-orders-table__header woocommerce-orders-table__header-order-status">
                                                            <span class="nobr">状态</span></th>
                                                        <th
                                                                class="woocommerce-orders-table__header woocommerce-orders-table__header-order-total">
                                                            <span class="nobr">总价</span></th>
                                                        <th
                                                                class="woocommerce-orders-table__header woocommerce-orders-table__header-order-actions">
                                                            <span class="nobr">操作</span></th>
                                                    </tr>
                                                    </thead>

                                                    <tbody>

                                                    <c:forEach items="${orderList}" var="order">
                                                        <tr class="woocommerce-orders-table__row woocommerce-orders-table__row--status-on-hold order">
                                                            <td data-title="订单号" class="woocommerce-orders-table__cell woocommerce-orders-table__cell-order-number">
                                                                <a href="#"> ${order.id}</a>

                                                            </td>
                                                            <td data-title="下单时间" class="woocommerce-orders-table__cell woocommerce-orders-table__cell-order-date">
                                                                <time>${order.otime} </time>

                                                            </td>
                                                            <td data-title="状态" class="woocommerce-orders-table__cell woocommerce-orders-table__cell-order-status">
                                                                <c:if test="${order.status==0}"> 未支付 </c:if>
                                                                <c:if test="${order.status==1}"> 待发货 </c:if>
                                                                <c:if test="${order.status==2}"> 已发货 </c:if>
                                                                <c:if test="${order.status==3}"> 已签收 </c:if>
                                                                <c:if test="${order.status==4}"> 已退款 </c:if>
                                                                <c:if test="${order.status==5}"> 已逾期 </c:if>
                                                            </td>
                                                            <td data-title="总价"  class="woocommerce-orders-table__cell woocommerce-orders-table__cell-order-total">
																<span class="woocommerce-Price-amount amount"><span
                                                                        class="woocommerce-Price-currencySymbol">&#165;</span>${order.total}</span>
                                                            </td>
                                                            <td class="product-remove">
                                                                <a href="orderservlet?method=detail&oid=${order.id}" class="woocommerce-button button view">
                                                                    <c:if test="${order.status==0}">前往支付</c:if>
                                                                    <c:if test="${order.status!=0}">查看详情</c:if>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>

                                                    </tbody>
                                                </table>
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


    </div><!-- #content -->

    <%@include file="commons/footer.jsp"%>
</div><!-- #page -->

<script type='text/javascript' src='resources/js/main.js'></script>

</body>

</html>
