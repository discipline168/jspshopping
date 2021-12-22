<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/12/21
  Time: 15:52
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en-US">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>discipl!ne pro 后台管理 &#8211; 订单管理</title>
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
    <link rel="stylesheet" href="../resources/css/load.css">


    <script type='text/javascript' src='../resources/js/jquery.min.js' id='jquery-core-js'></script>




    <style>
        [name="dialog"] {
            width: 300px;
            height: 300px;
            margin: auto;
            background-color: white;
            text-align: center;
            font-size: 10px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            box-shadow: 0 0 10px #ccc;
            z-index: 1000;
            display: none;
        }

        tr td{
            padding-top: 20px !important;
            padding-bottom: 20px !important;
        }
    </style>


    <script>
        function dialogClose() {
            jQuery("[name='dialog']").slideUp(400);
        }

        function dialogOpen(oid) {
            jQuery("[name='dialog']").slideDown(400);
            jQuery("[name='oid']").val(oid);
            console.log('oid: '+jQuery("[name='oid']").val());
        }

        function deliver() {
            jQuery("[id='loading']").show();
            jQuery.ajax({
                url: "admin?method=deliver",
                type: "POST",
                data: {
                    oid: jQuery("[name='oid']").val(),
                    lid: jQuery("[name='lid']").val(),
                },
                success: function (data) {
                    dialogClose();
                    jQuery("[id='loading']").hide(0);
                    if(data=='success'){
                        jQuery("[name='status-"+jQuery("[name='oid']").val()+"']").text('已发货');
                        jQuery("[name='button-"+jQuery("[name='oid']")).hide(0);
                    }else{
                        alert(data);
                    }
                }
            })
        }
    </script>


</head>

<body
        class="archive post-type-archive post-type-archive-product wp-custom-logo theme-parlo woocommerce-shop woocommerce woocommerce-page woocommerce-no-js woolentor_current_theme_parlo hfeed woocommerce-active elementor-default elementor-kit-915">

<div id="page" class="site">
    <!-- 导航 -->
    <%@include file="../commons/aheader.jsp"%>

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

    <div name="dialog">
        <div style="position: relative;">
            <a href="#" onclick="dialogClose()">
                <img src="../resources/images/delete.png"
                     style="position: absolute;width: 20px;height: 20px;top: 10px; right:10px;">
            </a>
        </div>
        <div style="margin: 30px;">
            <span style="font-size: 17px;">请输入物流订单号</span>
        </div>

        <div style="padding: 20px;">
            <input type="text" name="lid">
            <div class="cart-clear" style="margin: 60px;">
                <a href="#" onclick="deliver()">确认发货</a>
            </div>
        </div>
    </div>

    <input type="text" name="oid" style="display: none;">


    <div id="content" class="site-content">

        <div class="page-title-area">
            <div class="ht-container">
                <div class="ht-col-md-12 ht-col-sx-12 ht-center-md">
                    <div class="breadcrumb-content">
                        <ul>
                            <li><a href="admin?method=dashboard">总览</a></li>
                            <li><a href="admin?method=orders">订单管理</a></li>
                            <c:if  test="${empty status}">
                                <li>全部订单</li>
                            </c:if>
                            <c:if  test="${status==1}">
                                <li>待发货订单</li>
                            </c:if>
                            <c:if  test="${status==5}">
                                <li>已逾期订单</li>
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

                                        <c:if test="${empty orderList}}">
                                            <div class="entry-content">
                                                <div class="woocommerce">
                                                    <div class="woocommerce-notices-wrapper"></div>
                                                    <p class="cart-empty woocommerce-info">暂时没有
                                                        <c:if test="${status==1}">代发货</c:if>
                                                        <c:if test="${status==5}">已逾期</c:if>
                                                        订单信息</p>
                                                    <p class="return-to-shop">
                                                        <a class="button wc-backward"
                                                           href="admin?method=dashboard">返回总览 </a>
                                                    </p>
                                                </div>
                                            </div>
                                        </c:if>

                                        <div class="entry-content">
                                            <div class="woocommerce">
                                                <form class="woocommerce-cart-form" style="position: relative;">
                                                    <div class="table-responsive cart-table-content">
                                                        <c:if test="${not empty orderList}">
                                                            <table
                                                                class="shop_table shop_table_responsive cart woocommerce-cart-form__contents"
                                                                cellspacing="0">

                                                            <thead>
                                                            <tr>
                                                                <th>订单号</th>
                                                                <th>用户id</th>
                                                                <th>下单时间</th>
                                                                <th>状态</th>
                                                                <th>总价</th>
                                                                <th>操作</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>

                                                            <c:forEach items="${orderList}" var="order">
                                                                   <tr class="woocommerce-cart-form__cart-item cart_item">

                                                                       <td data-title="订单号">
                                                                           <a href="#">${order.id}</a>
                                                                       </td>
                                                                       <td data-title="用户ID">
                                                                           <a href="#">${order.uid}</a>
                                                                       </td>
                                                                       <td data-title="下单时间">
                                                                           <time>${order.otime} </time>
                                                                       </td>
                                                                       <td data-title="状态" name="status-${order.id}">
                                                                           <c:if test="${order.status==0}"> 未支付 </c:if>
                                                                           <c:if test="${order.status==1}"> 待发货 </c:if>
                                                                           <c:if test="${order.status==2}"> 已发货 </c:if>
                                                                           <c:if test="${order.status==3}"> 已签收 </c:if>
                                                                           <c:if test="${order.status==4}"> 已退款 </c:if>
                                                                           <c:if test="${order.status==5}"> 已逾期 </c:if>
                                                                       </td>
                                                                       <td data-title="总价">&#165; ${order.total}</td>
                                                                       <td data-title="操作">
                                                                           <a href="admin?method=detail&oid=${order.id}"
                                                                              style="margin-right: 10px;"
                                                                              class="woocommerce-button button view">
                                                                               查看详情
                                                                           </a>
                                                                           <c:if test="${order.status==1}">
                                                                               <a href="#" onclick="dialogOpen('${order.id}')"
                                                                                  name="button-${order.id}"
                                                                                  class="woocommerce-button button view">
                                                                                   前往发货
                                                                               </a>
                                                                           </c:if>
                                                                       </td>
                                                                   </tr>
                                                               </c:forEach>

                                                            </tbody>
                                                        </table>
                                                        </c:if>
                                                    </div>

                                                </form>
                                            </div>
                                        </div><!-- .entry-content -->

                                    </article><!-- #post-50 -->


                                    <!-- 底部导航 -->
                                    <nav class="woocommerce-pagination">
                                        <ul class='page-numbers'>

                                            <c:if test="${currentpPage>1}">

                                                <li><a class="page-numbers"
                                                       href="admin?method=orders&status=${status}&page=${currentpPage-1}">&lt;</a></li>
                                            </c:if>
                                            <li><span aria-current="page" class="page-numbers current">${currentpPage}</span></li>

                                            <c:if test="${currentpPage<pages}">
                                                <li><a class="next page-numbers"
                                                       href="admin?method=orders&status=${status}&page=${currentpPage+1}">&gt;<i
                                                        class="fa fa-angle-right"></i></a></li>
                                            </c:if>


                                        </ul>
                                        <ul class="page-numbers"><li>共 ${pages} 页</li></ul>

                                    </nav>

                                </div>




                            </div>
                        </div>
                    </div>







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
