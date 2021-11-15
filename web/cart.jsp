<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/11/14
  Time: 18:35
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="profile" href="https://gmpg.org/xfn/11">
    <script>document.documentElement.className = document.documentElement.className + ' yes-js js_active js'</script>
    <title>Parlo &#8211; WooCommerce WordPress Theme</title>
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


    <link rel='stylesheet'  href='resources/css/style.css' type='text/css' media='all' />

    <script>
        //更新购物车数量
        function quantityChange(id) {
            jQuery("[name=iname]").val(),
            jQuery.ajax({
                url: "/cartservlet?method=changeQuantity",
                data: {
                    "id": id,
                    "quantity": jQuery("[id='quantity-"+id+"']").val(),
                },
                type: "POST",
                success: function (data) {
                    if(data=="success"){
                        console.log('更新购物车 id-'+id+'成功');
                    }
                    else{
                        alert(data);
                    }

                }
            })
        }

        //移除购物车信息
        function removeItem(id) {
            jQuery.ajax({
                url: "/cartservlet?method=deleteFromCart",
                data: {
                    "id": id,
                },
                type: "POST",
                success: function (data) {
                    if(data=="success"){
                        console.log('删除购物车信息 id-'+id+'成功');
                        jQuery("[id='cart-item-"+id+"']").slideUp(500);
                    }
                    else{
                        alert(data);
                    }

                }
            })

        }


    </script>



</head>

<body
        class="page-template-default page page-id-48 wp-custom-logo theme-parlo woocommerce-cart woocommerce-page woocommerce-no-js woolentor_current_theme_parlo woocommerce-active elementor-default elementor-kit-915">

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
                            <li><a href="/">主页</a></li>
                            <li><a href="/account.jsp">我的</a></li>
                            <li>购物车</li>
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


                            <article id="post-48" class="post-48 page type-page status-publish hentry">

                                <c:if test="${empty cartList}">
                                    <div class="entry-content">
                                        <div class="woocommerce">
                                            <div class="woocommerce-notices-wrapper"></div>
                                            <p class="cart-empty woocommerce-info">您还没有往购物车里添加商品</p>
                                            <p class="return-to-shop">
                                                <a class="button wc-backward"
                                                   href="/goodsservlet?method=shop">
                                                    去购物 </a>
                                            </p>
                                        </div>
                                    </div>
                                </c:if>



                               <c:if test="${not empty cartList}">
                                   <div class="entry-content">
                                       <div class="woocommerce">
                                           <div class="woocommerce-notices-wrapper"></div>
                                           <form class="woocommerce-cart-form"
                                                 action="https://demo.shrimpthemes.com/1/parlo/cart/" method="post">
                                               <div class="table-responsive cart-table-content">
                                                   <h3 class="cart-page-title">您购物车的商品</h3>
                                                   <table
                                                           class="shop_table shop_table_responsive cart woocommerce-cart-form__contents"
                                                           cellspacing="0">
                                                       <thead>
                                                       <tr>
                                                           <th class="product-remove d-none">操作</th>
                                                           <th class="product-thumbnail">图片</th>
                                                           <th class="product-name">商品名称</th>
                                                           <th class="product-price">目前价格</th>
                                                           <th class="product-quantity">尺寸/规格</th>
                                                           <th class="product-quantity">数量</th>
                                                           <th class="product-remove">直接支付</th>
                                                       </tr>
                                                       </thead>
                                                       <tbody>


                                                       <c:forEach items="${cartList}" var="cart">
                                                           <tr class="woocommerce-cart-form__cart-item cart_item"
                                                               id="cart-item-${cart.id}">

                                                               <td class="product-remove d-none">
                                                                   <a class="remove" aria-label="Remove this item"
                                                                      onclick="removeItem(${cart.id})">
                                                                       <img style="width: 30px;"
                                                                            src="/resources/images/delete.png" />
                                                                   </a> </td>

                                                               <td class="product-thumbnail"
                                                                   data-title="Product Image"><a
                                                                       href="/goodsservlet?method=detail&id=${cart.gid}"><img
                                                                       width="300" height="300"
                                                                       src="${cart.goods.picture}"
                                                                       class="attachment-woocommerce_thumbnail size-woocommerce_thumbnail"
                                                                       alt="" loading="lazy"
                                                                       sizes="(max-width: 300px) 100vw, 300px" /></a>
                                                               </td>

                                                               <td class="product-name" data-title="Product"><a
                                                                       href="/goodsservlet?method=detail&id=${cart.gid}">${cart.goods.name}</a></td>

                                                               <td class="product-price" data-title="Price">
																	<span class="woocommerce-Price-amount amount"><bdi><span
                                                                            class="woocommerce-Price-currencySymbol">&#165;</span>${cart.goods.price*cart.goods.discount}</bdi></span>
                                                               </td>

                                                               <td >${cart.size}</td>

                                                               <td class="product-quantity" data-title="Quantity">
                                                                   <div class="quantity">
                                                                       <input type="number"
                                                                              onchange="quantityChange(${cart.id})"
                                                                              value="${cart.quantity}"
                                                                              class="input-text qty text" step="1" min="1"
                                                                              max="99"
                                                                              id="quantity-${cart.id}"
                                                                              placeholder="" inputmode="numeric" />
                                                                   </div>
                                                               </td>


                                                               <td class="product-remove">
                                                                   <a href="https://demo.shrimpthemes.com/1/parlo/cart/?remove_item=093f65e080a295f8076b1c5722a46aa2&#038;_wpnonce=702001be9e"
                                                                      data-product_id="59"
                                                                      data-product_sku="woo-sunglasses">
                                                                       <img style="width: 30px;"
                                                                            src="/resources/images/pay.png" >
                                                                   </a>
                                                               </td>
                                                           </tr>
                                                       </c:forEach>



                                                       <tr>
                                                           <td colspan="6" class="actions">

                                                               <div class="coupon">
                                                                   <label for="coupon_code">Coupon:</label> <input
                                                                       type="text" name="coupon_code"
                                                                       class="input-text" id="coupon_code" value=""
                                                                       placeholder="优惠券代码" /> <button type="submit"
                                                                                                      class="button" name="apply_coupon"
                                                                                                      value="Apply coupon">使用优惠券</button>
                                                               </div>

                                                               <button type="submit" class="button"
                                                                       name="update_cart"
                                                                       value="Update cart">更新购物车</button>


                                                               <input type="hidden" id="woocommerce-cart-nonce"
                                                                      name="woocommerce-cart-nonce"
                                                                      value="702001be9e" /><input type="hidden"
                                                                                                  name="_wp_http_referer"
                                                                                                  value="/1/parlo/cart/" />
                                                           </td>
                                                       </tr>

                                                       </tbody>
                                                   </table>
                                               </div>

                                               <div class="row">
                                                   <div class="col-lg-12">
                                                       <div class="cart-shiping-update-wrapper">
                                                           <div class="cart-shiping-update">
                                                               <a
                                                                       href="https://demo.shrimpthemes.com/1/parlo/shop/">继续购物</a>
                                                           </div>
                                                           <div class="cart-clear">
                                                               <a
                                                                       href="https://demo.shrimpthemes.com/1/parlo/cart/?clear-cart">清空购物车</a>
                                                           </div>
                                                       </div>
                                                   </div>
                                               </div>

                                           </form>

                                           <div class="cart-collaterals">
                                               <div class="cart_totals ">


                                                   <h2>购物车总和</h2>

                                                   <table cellspacing="0" class="shop_table shop_table_responsive">

                                                       <tr class="cart-subtotal">
                                                           <th>总价</th>
                                                           <td data-title="Subtotal"><span
                                                                   class="woocommerce-Price-amount amount"><bdi><span
                                                                   class="woocommerce-Price-currencySymbol">&pound;</span>196.00</bdi></span>
                                                           </td>
                                                       </tr>




                                                       <tr class="woocommerce-shipping-totals shipping">
                                                           <th>邮费</th>
                                                           <td data-title="Shipping">
                                                               <ul id="shipping_method"
                                                                   class="woocommerce-shipping-methods">
                                                                   <li>
                                                                       <input type="hidden" name="shipping_method[0]"
                                                                              data-index="0"
                                                                              id="shipping_method_0_free_shipping2"
                                                                              value="free_shipping:2"
                                                                              class="shipping_method" /><label
                                                                           for="shipping_method_0_free_shipping2">免邮费</label>
                                                                   </li>
                                                               </ul>
                                                               <p class="woocommerce-shipping-destination">
                                                                   寄给 <strong>兔橘长啊</strong>. </p>



                                                               <form class="woocommerce-shipping-calculator"
                                                                     action="https://demo.shrimpthemes.com/1/parlo/cart/"
                                                                     method="post">

                                                                   <a href="#" >修改收货地址</a>
                                                                   <img style="width: 30px;"	src="/resources/images/address.png">



                                                                       <p class="form-row form-row-wide"
                                                                          id="calc_shipping_city_field">
                                                                           <input type="text" class="input-text"
                                                                                  value="" placeholder="城市"
                                                                                  name="calc_shipping_city"
                                                                                  id="calc_shipping_city" />
                                                                       </p>

                                                                       <p class="form-row form-row-wide"
                                                                          id="calc_shipping_postcode_field">
                                                                           <input type="text" class="input-text"
                                                                                  value="" placeholder="具体地址"
                                                                                  name="calc_shipping_postcode"
                                                                                  id="calc_shipping_postcode" />
                                                                       </p>

                                                                       <p><button type="submit" name="calc_shipping"
                                                                                  value="1" class="button">更新</button>
                                                                       </p>
                                                                       <input type="hidden"
                                                                              id="woocommerce-shipping-calculator-nonce"
                                                                              name="woocommerce-shipping-calculator-nonce"
                                                                              value="3b3e644f90" /><input type="hidden"
                                                                                                          name="_wp_http_referer"
                                                                                                          value="/1/parlo/cart/" />
                                                                   </section>
                                                               </form>

                                                           </td>
                                                       </tr>






                                                       <tr class="order-total">
                                                           <th>Total</th>
                                                           <td data-title="Total"><strong><span
                                                                   class="woocommerce-Price-amount amount"><bdi><span
                                                                   class="woocommerce-Price-currencySymbol">&pound;</span>196.00</bdi></span></strong>
                                                           </td>
                                                       </tr>


                                                   </table>

                                                   <div class="wc-proceed-to-checkout">

                                                       <a href="https://demo.shrimpthemes.com/1/parlo/checkout/"
                                                          class="checkout-button button alt wc-forward">
                                                           支付</a>
                                                   </div>


                                               </div>
                                           </div>

                                       </div>
                                   </div>
                               </c:if>

                            </article><!-- #post-48 -->

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
    var wc_cart_params = { };
    /* ]]> */
</script>
<script type='text/javascript'
        src='resources/js/cart.min.js'
        id='wc-cart-js'></script>


<script type='text/javascript' src='resources/js/main.js'></script>
</body>

</html>