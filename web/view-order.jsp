<%--
  Created by IntelliJ IDEA.
  User: cheese
  Date: 2021/11/22
  Time: 13:34
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en-US">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>discipl!ne pro &#8211; 订单明细</title>
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



    <style id='woocommerce-inline-inline-css' type='text/css'>
        .woocommerce form .form-row .required {
            visibility: visible;
        }
    </style>


    <link rel='stylesheet' id='parlo-style-css' href='resources/css/style.css' type='text/css' media='all' />


    <script>
        //订单逾期倒计时
        if("${order.status}"=="0"){
            var starttime = new Date("${order.otime}");

            //15分钟后过期
            //starttime.setMinutes(starttime.getMinutes()+15);
            //1分钟后过期-测试
            starttime.setMinutes(starttime.getMinutes()+1);


            setInterval(function () {
                var nowtime = new Date();
                var time = starttime - nowtime;
                var minute = parseInt(time / 1000 / 60 % 60);
                var seconds = parseInt(time / 1000 % 60);

                if(minute>=0&&seconds>=0){
                    jQuery("[class='timespan']").html("还剩余 "+minute + "分钟" + seconds + "秒");
                }
                if (minute == 0 && seconds == 0) {
                    setInterval(window.location.reload(),1500)
                }
            }, 1000);
        }

        function pay() {
            jQuery(location).attr('href', 'orderservlet?method=confirm&oid=${order.id}')
        }

    </script>


</head>

<body
        class="page-template-default page page-id-49 logged-in wp-custom-logo theme-parlo woocommerce-checkout woocommerce-page woocommerce-order-received woocommerce-no-js woolentor_current_theme_parlo woocommerce-active elementor-default elementor-kit-915">

<div id="page" class="site">


    <%@include file="commons/header.jsp"%>

    <div id="content" class="site-content">
        <div class="page-title-area">
            <div class="ht-container">
                <div class="ht-col-md-12 ht-col-sx-12 ht-center-md">
                    <div class="breadcrumb-content">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/">主页</a></li>
                            <li><a href="account.jsp">我的</a></li>
                            <li><a href="orderservlet?method=list">订单</a></li>
                            <li>订单详情</li>
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


                            <article id="post-49" class="post-49 page type-page status-publish hentry">
                                <div class="entry-content">
                                    <div class="woocommerce">
                                        <div class="woocommerce-order">
                                            <c:if test="${order.status!=0}">
                                                <p  lass="woocommerce-notice woocommerce-notice--success woocommerce-thankyou-order-received">
                                                    <c:if test="${order.status==1}">您的订单正在准备发货</c:if>
                                                    <c:if test="${order.status==2}">您的订单已发货</c:if>
                                                    <c:if test="${order.status==3}">您的订单已到达</c:if>
                                                    <c:if test="${order.status==5}">您的订单已过期</c:if>
                                                </p>
                                            </c:if>

                                            <c:if test="${order.status==0}">
                                                <p  lass="woocommerce-notice woocommerce-notice--success woocommerce-thankyou-order-received">
                                                    您尚未完成支付，请尽快支付
                                                    <span class="timespan" style="font-size: 15px; margin-left: 20px;color: gray"></span>
                                                </p>
                                            </c:if>

                                            <ul
                                                    class="woocommerce-order-overview woocommerce-thankyou-order-details order_details">

                                                <li class="woocommerce-order-overview__order order">
                                                    订单号: <strong>${order.id}</strong>
                                                </li>

                                                <li class="woocommerce-order-overview__date date">
                                                    订单时间: <strong>${order.otime}</strong>
                                                </li>

                                                <c:if test="${order.status==1||order.status==2||order.status==3}">
                                                    <li class="woocommerce-order-overview__date date">
                                                        支付时间: <strong>${order.ptime}</strong>
                                                    </li>
                                                </c:if>


                                                <li class="woocommerce-order-overview__email email">
                                                    收件人: <strong>${order.name}</strong>
                                                </li>
                                                <li class="woocommerce-order-overview__email email">
                                                    收获地址: <strong>${order.address}</strong>
                                                </li>
                                                <li class="woocommerce-order-overview__total total">
                                                    总计: <strong><span
                                                        class="woocommerce-Price-amount amount"><bdi><span
                                                        class="woocommerce-Price-currencySymbol">&#165;</span>${order.total}</bdi></span></strong>
                                                </li>


                                            </ul>


                                            <section class="woocommerce-order-details" style="width:80%;margin: auto; ">

                                                <div class="checkout-area">
                                                    <div>
                                                        <table  class="woocommerce-table woocommerce-table--order-details shop_table order_details"
                                                                style="text-align: center;">

                                                            <thead>
                                                            <tr>
                                                                <th style="width: 50%;"> 商品</th>
                                                                <th> 价格</th>
                                                            </tr>
                                                            </thead>

                                                            <tbody>

                                                            <c:forEach items="${order.orderDetails}" var="orderDetail">
                                                                <tr class="woocommerce-table__line-item order_item">

                                                                    <td class="woocommerce-table__product-name product-name">
                                                                        <a href="goodsservlet?method=detail&id=${orderDetail.gid}" >${orderDetail.name}</a> <strong
                                                                            class="product-quantity">&times;&nbsp;${orderDetail.quantity}</strong>
                                                                    </td>

                                                                    <td
                                                                            class="woocommerce-table__product-total product-total">
																		<span class="woocommerce-Price-amount amount">
                                                                            <bdi><span
                                                                                    class="woocommerce-Price-currencySymbol">&#165;
                                                                            </span> ${orderDetail.price*orderDetail.quantity}
                                                                            </bdi>
                                                                        </span>
                                                                    </td>

                                                                </tr>
                                                            </c:forEach>


                                                            </tbody>
                                                            <tr class="cart-subtotal">
                                                                <th>邮费</th>
                                                                <td data-title="Subtotal"><span
                                                                        class="woocommerce-Price-amount amount"><bdi><span
                                                                        class="woocommerce-Price-currencySymbol"></span>免邮费</bdi></span>
                                                                </td>
                                                            </tr>


                                                            <tr class="order-total">
                                                                <th>总价</th>
                                                                <td data-title="Total"><strong><span
                                                                        class="woocommerce-Price-amount amount"><bdi><span
                                                                        class="woocommerce-Price-currencySymbol">&#165;</span>${order.total}</bdi></span></strong>
                                                                </td>
                                                            </tr>


                                                        </table>

                                                        <c:if test="${order.status==0}">
                                                            <div class="wc-proceed-to-checkout">
                                                                <a onclick="pay()" class="checkout-button button alt wc-forward"> 支付</a>
                                                            </div>
                                                        </c:if>

                                                    </div>
                                                </div>

                                            </section>



                                        </div>
                                    </div>
                                </div><!-- .entry-content -->

                            </article><!-- #post-49 -->

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

