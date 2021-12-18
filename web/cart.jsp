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
    <title>discipl!ne pro &#8211; 购物车</title>
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


    <link rel="stylesheet" href="resources/css/woocommerce.css">
    <link rel="stylesheet" href="resources/css/load.css">



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

        var limit=${size};
        var flag=0;
        //更新购物车数量
        function quantityChange(id) {
            jQuery("[id='loading']").show();

            jQuery.ajax({
                url: "cartservlet?method=changeQuantity",
                data: {
                    "id": id,
                    "quantity": jQuery("[id='quantity-"+id+"']").val(),
                },
                type: "POST",
                success: function (data) {
                    jQuery("[id='loading']").hide(0);

                    if(data=="success"){
                        console.log('更新购物车 id-'+id+'成功');
                        refreshMiniCart();
                    }
                    else{
                        alert(data);
                    }

                }
            })
        }

        //移除购物车信息
        function removeItem(id) {
            jQuery("[id='loading']").show();
            jQuery.ajax({
                url: "cartservlet?method=deleteFromCart",
                data: {
                    "id": id,
                },
                type: "POST",
                success: function (data) {
                    jQuery("[id='loading']").hide(0);
                    if(data=="success"){
                        console.log('删除购物车信息 id-'+id+'成功');
                        jQuery("[id='cart-item-"+id+"']").slideUp(0);
                        flagAdd();
                        refreshMiniCart();
                    }
                    else{
                        alert(data);
                    }

                }
            })

        }

        //异步刷新nav minicart信息
        function refreshMiniCart() {
            jQuery.ajax({
                url: "cartservlet?method=refreshMiniCart",
                type: "GET",
                success: function (data) {
                    console.log("refresh success");
                    jQuery("[id='nav']").html(data);
                }
            })
        }


        function flagAdd() {
            if(++flag==limit){
                window.location.reload()
            }
        }
    </script>



</head>

<body
        class="page-template-default page page-id-48 wp-custom-logo theme-parlo woocommerce-cart woocommerce-page woocommerce-no-js woolentor_current_theme_parlo woocommerce-active elementor-default elementor-kit-915">

<div id="page" class="site">

    <!-- 导航 -->
    <div id="nav"><%@include file="commons/header.jsp"%></div>

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
                            <li><a href="account.jsp">我的</a></li>
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
                                                   href="goodsservlet?method=shop">
                                                    去购物 </a>
                                            </p>
                                        </div>
                                    </div>
                                </c:if>



                               <c:if test="${not empty cartList}">
                                   <div class="entry-content">
                                       <div class="woocommerce">
                                           <div class="woocommerce-notices-wrapper"></div>
                                           <form class="woocommerce-cart-form">
                                               <div class="table-responsive cart-table-content">
                                                   <h3 class="cart-page-title">您购物车的商品</h3>
                                                   <table  class="shop_table shop_table_responsive cart woocommerce-cart-form__contents"
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
                                                                            src="resources/images/delete.png" />
                                                                   </a> </td>

                                                               <td class="product-thumbnail"
                                                                   data-title="Product Image"><a
                                                                       href="goodsservlet?method=detail&id=${cart.gid}"><img
                                                                       width="300" height="300"
                                                                       style="background: #f0f0f0;"
                                                                       src="${cart.goods.picture}"
                                                                       class="attachment-woocommerce_thumbnail size-woocommerce_thumbnail"
                                                                       alt="" loading="lazy"
                                                                       sizes="(max-width: 300px) 100vw, 300px" /></a>
                                                               </td>

                                                               <td class="product-name" data-title="商品"><a
                                                                       href="goodsservlet?method=detail&id=${cart.gid}">${cart.goods.name}</a></td>

                                                               <td class="product-price" data-title="价格">
																	<span class="woocommerce-Price-amount amount"><bdi><span
                                                                            class="woocommerce-Price-currencySymbol">&#165;</span>${cart.goods.price*cart.goods.discount}</bdi></span>
                                                               </td>

                                                               <td  data-title="尺码/规格">${cart.size}</td>

                                                               <td class="product-quantity" data-title="数量">
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


                                                               <td  data-title="支付">
                                                                   <a href="orderservlet?method=checkout&cid=${cart.id}"
                                                                      data-product_id="59"
                                                                      data-product_sku="woo-sunglasses">
                                                                       <img style="width: 30px;"
                                                                            src="resources/images/pay.png" >
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
                                                           <div class="cart-shiping-update">
                                                               <a href="goodsservlet?method=shop">继续购物</a>
                                                           </div>
                                                           <div class="cart-clear">
                                                               <a href="orderservlet?method=checkout">清空购物车</a>
                                                           </div>
                                                       </div>
                                                   </div>
                                               </div>

                                           </form>


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