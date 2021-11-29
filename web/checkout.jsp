<%--
  Created by IntelliJ IDEA.
  User: cheese
  Date: 2021/11/16
  Time: 22:43
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>discipl!ne pro &#8211; 订单预览</title>
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





    <link rel='stylesheet' id='parlo-style-css' href='resources/css/style.css' type='text/css' media='all' />

    <style id='woocommerce-inline-inline-css' type='text/css'>
        .woocommerce form .form-row .required {
            visibility: visible;
        }
        select {
            margin: 20px;
            height: 60px;
            text-align: center;
            background-color: white;
            color: #8f8f8f;
        }
        @media all and (orientation : portrait) {
            select {
                width: 120px;
            }

        }
    </style>




    <script>

        function pay() {
            var aid=jQuery("[name='level']").val();
            var cid=jQuery("[name='cid']").text();
            jQuery(location).attr('href', 'orderservlet?method=confirm&aid='+aid+(cid==""?"":("&cid="+cid)))
        }


    </script>


</head>

<body
        class="page-template-default page page-id-49 logged-in wp-custom-logo theme-parlo woocommerce-checkout woocommerce-page woocommerce-no-js woolentor_current_theme_parlo woocommerce-active elementor-default elementor-kit-915">

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
                            <li>预览支付信息</li>
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
                                <span name="cid" style="display: none">${cid}</span>

                                <div class="entry-content">
                                    <div class="woocommerce">
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

                                                            <c:forEach items="${checkList}" var="check">
                                                                <tr class="woocommerce-table__line-item order_item">

                                                                    <td class="woocommerce-table__product-name product-name">
                                                                        <a href="goodsservlet?method=detail&id=${check.gid}" >${check.goods.name} </a> <strong
                                                                            class="product-quantity">&times;&nbsp;${check.quantity}</strong>
                                                                    </td>

                                                                    <td
                                                                            class="woocommerce-table__product-total product-total">
																		<span class="woocommerce-Price-amount amount">
                                                                            <bdi><span
                                                                                class="woocommerce-Price-currencySymbol">&#165;
                                                                            </span> ${check.goods.price*check.goods.discount*check.quantity}
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




                                                        <tr class="woocommerce-shipping-totals shipping">
                                                            <th>地址</th>
                                                            <td data-title="Shipping">


                                                                <select class="ui-select" name="level" >

                                                                    <c:forEach items="${addressList}" var="address">
                                                                        <c:if test="${address.level==1}">
                                                                            <option value="${address.id}" selected="true" style="max-width: 500px;">
                                                                                    ${address.name} / ${address.region} ${address.detail}
                                                                            </option>
                                                                        </c:if>
                                                                        <c:if test="${address.level==0}">
                                                                            <option value="${address.id}"  style="max-width: 500px;">
                                                                                    ${address.name} / ${address.region} ${address.detail}
                                                                            </option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </select>

                                                            </td>
                                                        </tr>


                                                        <tr class="order-total">
                                                            <th>总价</th>
                                                            <td data-title="Total"><strong><span
                                                                    class="woocommerce-Price-amount amount"><bdi><span
                                                                    class="woocommerce-Price-currencySymbol">&#165;</span>${price}</bdi></span></strong>
                                                            </td>
                                                        </tr>


                                                    </table>

                                                    <div class="wc-proceed-to-checkout">

                                                        <a onclick="pay()" class="checkout-button button alt wc-forward"> 支付</a>
                                                    </div>


                                                </div>
                                            </div>

                                        </section>

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

<div class="woocommerce" id="htwlquick-viewmodal">
    <div class="htwl-modal-dialog product">
        <div class="htwl-modal-content"><button type="button" class="htcloseqv"><span
                class="sli sli-close"></span></button>
            <div class="htwl-modal-body"></div>
        </div>
    </div>
</div>
<script type='text/javascript' id='wc-cart-js-extra'>
    /* <![CDATA[ */
    var wc_cart_params = {};
    /* ]]> */
</script>
<script type='text/javascript' src='resources/js/cart.min.js' id='wc-cart-js'></script>

<script type='text/javascript' src='resources/js/main.js'></script>






</body>

</html>