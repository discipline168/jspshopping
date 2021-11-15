<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/11/10
  Time: 23:38
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





    <style id='woocommerce-inline-inline-css' type='text/css'>
        .woocommerce form .form-row .required {
            visibility: visible;
        }

        .size-select{
            width: 240px;
            margin-bottom: 20px;
            height: 60px;
            text-align: center;
            background-color: white;
            color:#8f8f8f

        }
        .size-select option{
            text-align: center;
        }
        .msg-hide{
            display: none;
        }
    </style>

    <script>
        function addToCart() {
            jQuery("[name='cartSuccess']").hide(0);
            jQuery.ajax({
                url: "/cartservlet?method=addToCart",
                data: {
                    "gid": jQuery("[name='gid']").val(),
                    "quantity": jQuery("[name='quantity']").val(),
                    "size": jQuery("[name='size']").val(),
                },
                type: "POST",
                success: function (data) {
                    if(data=="success"){
                        jQuery("[name='cartSuccess']").slideDown(500);
                        //定位锚点
                        var _targetTop = jQuery("[name='cartSuccess']").offset().top-50;
                        jQuery("html,body").animate({scrollTop:_targetTop},300);
                        //延迟3秒消失
                        jQuery("[name='cartSuccess']").delay(3000).slideUp(500);

                    }else if(data=="nouser"){
                        jQuery(location).attr('href', '/login.jsp')
                    }
                    else{
                        alert(data);
                    }

                }
            })
        }
    </script>






    <link rel='stylesheet'  href='resources/css/style.css' type='text/css' media='all' />

</head>

<body
        class="product-template-default single single-product postid-59 wp-custom-logo theme-parlo woocommerce woocommerce-page woocommerce-no-js woolentor_current_theme_parlo woocommerce-active elementor-default elementor-kit-915">

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
                            <li><a href="/goodsservlet?method=shop">商城</a>
                            </li>
                            <li><a
                                    href="/goodsservlet?method=shop&categoryid=${goods.category.id}">${goods.category.name}</a>
                            </li>
                            <li>${goods.name}</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div id="primary" class="shop-area parlopage-padding">
            <main id="main" class="site-main" role="main">
                <div class="ht-container">
                    <div class="ht-row">


                        <div class="ht-col-md-12 ht-col-xs-12">

                            <div class="woocommerce-notices-wrapper msg-hide" name="cartSuccess">
                                <div class="woocommerce-message" role="alert">
                                    <a href="https://demo.shrimpthemes.com/1/parlo/cart/" tabindex="1"
                                       class="button wc-forward">查看购物车</a> ${goods.name} 已加入您的购物车 </div>
                            </div>

                            <div  class="product type-product post-59 status-publish first instock product_cat-accessories has-post-thumbnail featured shipping-taxable purchasable product-type-simple">

                                <div class="ht-row">
                                    <div class="ht-col-md-6 ht-col-sm-6 ht-col-xs-12">
                                        <div class="woocommerce-product-gallery woocommerce-product-gallery--with-images woocommerce-product-gallery--columns-4 images"
                                             data-columns="4"
                                             style="opacity: 0; transition: opacity .25s ease-in-out;">
                                            <figure class="woocommerce-product-gallery__wrapper">
                                                <div data-thumb="${goods.picture}"
                                                     data-thumb-alt="" class="woocommerce-product-gallery__image"><a><img
                                                        width="600" height="600"
                                                        src="${goods.picture}"
                                                        class="wp-post-image" alt="" loading="lazy"
                                                        title="product_11" data-caption=""
                                                        sizes="(max-width: 600px) 100vw, 600px" /></a></div>

                                                <!-- 其他介绍图片 -->

                                                <c:forEach items="${otherPictures}" var="picture" >

                                                <div data-thumb="${picture}"
                                                     data-thumb-alt="" class="woocommerce-product-gallery__image"><a><img
                                                        width="600" height="600"
                                                        src="${picture}"
                                                        class="" alt="" loading="lazy" title="product_2"
                                                        data-caption=""
                                                        data-large_image_width="800"
                                                        data-large_image_height="800" sizes="(max-width: 600px) 100vw, 600px" /></a>
                                                </div>
                                                </c:forEach>



                                            </figure>
                                        </div>
                                    </div>
                                    <div class="ht-col-md-6 ht-col-sm-6 ht-col-xs-12">
                                        <div class="summary entry-summary product-details-content">
                                            <h1 class="product_title entry-title">${goods.name}</h1>
                                            <p class="price"><span
                                                    class="woocommerce-Price-amount amount"><bdi><span
                                                    class="woocommerce-Price-currencySymbol">&#165;</span>${goods.price*goods.discount}</bdi></span>
                                            </p>
                                            <div class="woocommerce-product-details__short-description">
                                                <p>${goods.description}</p>
                                            </div>


                                            <form class="cart"
                                                  method="post" >

                                                <div class="msg-hide">
                                                    <input type="text" name="gid" value="${goods.id}"/>
                                                </div>

                                                <c:if test="${not empty sizes}">
                                                    <div>
                                                        <select name="size" class="size-select">

                                                            <c:forEach items="${sizes}" var="size">
                                                                <option value="${size}">${size}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </c:if>

                                                <c:if test="${empty sizes}">
                                                    <div class="msg-hide">
                                                        <input type="text" name="size" value="/"/>
                                                    </div>
                                                </c:if>

                                                <div class="quantity">
                                                    <label class="screen-reader-text"
                                                           for="quantity_6187a5057e2a0">${goods.name}</label>
                                                    <input type="number" id="quantity_6187a5057e2a0"
                                                           class="input-text qty text" step="1" min="1" max="99"
                                                           name="quantity" value="1" title="Qty" size="4"
                                                           placeholder="" inputmode="numeric" />
                                                </div>



                                                <button style="width: 150px;" type="button"  onclick="addToCart()" value="59"
                                                        class="single_add_to_cart_button button alt">加入购物车</button>

                                            </form>



                                            <a href="https://demo.shrimpthemes.com/1/parlo?action=yith-woocompare-add-product&id=59"
                                               class="compare button" data-product_id="59" rel="nofollow"><i
                                                    class="fa fa-refresh"></i></a>
                                            <div class="product_meta">



                                                <span class="sku_wrapper">目前库存数量: <span class="sku">${goods.quantity}</span></span>





                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="woocommerce-tabs wc-tabs-wrapper">
                                    <ul class="tabs wc-tabs" role="tablist">
                                        <li class="description_tab" id="tab-title-description" role="tab"
                                            aria-controls="tab-description">
                                            <a href="#tab-description">
                                                商品详情 </a>
                                        </li>

                                    </ul>
                                    <div class="woocommerce-Tabs-panel woocommerce-Tabs-panel--description panel entry-content wc-tab"
                                         id="tab-description" role="tabpanel"
                                         aria-labelledby="tab-title-description">

                                        <h2>描述</h2>

                                        <p>${goods.description}</p>
                                    </div>

                                </div>


                                <section class="related products">

                                    <h2>相关商品</h2>


                                    <div class="products columns-3 ht-products">
                                        <div class="ht-row">




                                            <!-- 商品推荐 -->

                                            <c:forEach items="${recommended}" var="recommend">
                                            <!--Product Start-->
                                            <div
                                                    class="ht-product ht-product-action-right ht-product-action-on-hover ht-col-xs-12 ht-col-sm-6 ht-col-md-4 product type-product post-73 status-publish last instock product_cat-accessories has-post-thumbnail sale shipping-taxable purchasable product-type-simple">
                                                <div class="ht-product-inner">


                                                    <div class="ht-product-image-wrap">
															<span
                                                                    class="ht-product-label ht-product-label-right">Sale!</span>
                                                        <a href="/goodsservlet?method=detail&id=${recommend.id}"
                                                           class="ht-product-image">
                                                            <img width="300" height="300"
                                                                 src="${recommend.picture}"
                                                                 class="attachment-woocommerce_thumbnail size-woocommerce_thumbnail"
                                                                 alt="" loading="lazy"
                                                                 sizes="(max-width: 300px) 100vw, 300px" /> </a>

                                                        <div class="ht-product-action">
                                                            <ul>
                                                                <li>
                                                                    <a href="javascript:void(0);" class="quickview"
                                                                       data-toggle="modal"
                                                                       data-target="#ht-quick-viewmodal"
                                                                       data-quick-id="73">
                                                                        <i class="sli sli-magnifier"></i>
                                                                        <span
                                                                                class="ht-product-action-tooltip">详情</span>
                                                                    </a>
                                                                </li>
                                                                <li>
                                                                    <div
                                                                            class=" wishlist button-default yith-wcwl-add-to-wishlist add-to-wishlist-73">
                                                                        <div class="yith-wcwl-add-button show"><a
                                                                                href="https://demo.shrimpthemes.com/1/parlo/wishlist/"
                                                                                data-product-id="73"
                                                                                data-product-type="simple"
                                                                                class="add_to_wishlist"><i
                                                                                class="sli sli-heart"></i><span
                                                                                class="ht-product-action-tooltip">Add
																						to Wishlist</span></a><i
                                                                                class="fa fa-spinner fa-pulse ajax-loading"
                                                                                style="visibility:hidden"></i></div>

                                                                    </div>
                                                                </li>
                                                            </ul>
                                                        </div>

                                                    </div>



                                                    <div class="ht-product-content">
                                                        <div class="ht-product-content-inner">
                                                            <div class="ht-product-categories"><a
                                                                    href="/goodsservlet?method=shop&categoryid=${goods.category.id}">${goods.category.name}</a>
                                                            </div>
                                                            <h4 class="ht-product-title"><a
                                                                    href="/goodsservlet?method=detail&id=${recommend.id}">${recommend.name}</a>
                                                            </h4>
                                                            <div class="ht-product-price">

                                                                <c:if test="${recommend.discount<1}">
                                                                  <span class="price"><del
                                                                          aria-hidden="true">
                                                                    <span
                                                                            class="woocommerce-Price-amount amount"><bdi><span
                                                                            class="woocommerce-Price-currencySymbol">&#165;</span>${recommend.price}</bdi></span></del>


                                                                  <ins><span
                                                                          class="woocommerce-Price-amount amount">
                                                                    <bdi style="color: red"><span
                                                                            class="woocommerce-Price-currencySymbol"></span>&#165;${recommend.price*recommend.discount}
                                                                    </bdi></span></ins></span>
                                                                </c:if>

                                                                <c:if test="${recommend.discount==1}">
                                                                  <span class="price"><span class="woocommerce-Price-amount amount">
                                                                    <bdi><span class="woocommerce-Price-currencySymbol">&#165;</span>${recommend.price}
                                                                    </bdi></span>
                                                                  </span>
                                                                </c:if>
                                                            </div>
                                                            <div class="ht-product-ratting-wrap"></div>
                                                        </div>
                                                    </div>


                                                </div>
                                            </div>
                                            <!--Product End-->
                                            </c:forEach>

                                        </div>
                                    </div>

                                </section>
                            </div>


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
<script
        type="application/ld+json">{"@context":"https:\/\/schema.org\/","@graph":[{"@context":"https:\/\/schema.org\/","@type":"BreadcrumbList","itemListElement":[{"@type":"ListItem","position":1,"item":{"name":"Home","@id":"https:\/\/demo.shrimpthemes.com\/1\/parlo"}},{"@type":"ListItem","position":2,"item":{"name":"Clothing","@id":"https:\/\/demo.shrimpthemes.com\/1\/parlo\/product-category\/clothing\/"}},{"@type":"ListItem","position":3,"item":{"name":"Accessories","@id":"https:\/\/demo.shrimpthemes.com\/1\/parlo\/product-category\/clothing\/accessories\/"}},{"@type":"ListItem","position":4,"item":{"name":"Vivamus et massa massa","@id":"https:\/\/demo.shrimpthemes.com\/1\/parlo\/product\/vivamus-et-massa-massa\/"}}]},{"@context":"https:\/\/schema.org\/","@type":"Product","@id":"https:\/\/demo.shrimpthemes.com\/1\/parlo\/product\/vivamus-et-massa-massa\/#product","name":"Vivamus et massa massa","url":"https:\/\/demo.shrimpthemes.com\/1\/parlo\/product\/vivamus-et-massa-massa\/","description":"Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo.","image":"https:\/\/demo.shrimpthemes.com\/1\/parlo\/wp-content\/uploads\/2019\/03\/product_11.png","sku":"woo-sunglasses","offers":[{"@type":"Offer","price":"90.00","priceValidUntil":"2022-12-31","priceSpecification":{"price":"90.00","priceCurrency":"GBP","valueAddedTaxIncluded":"false"},"priceCurrency":"GBP","availability":"http:\/\/schema.org\/InStock","url":"https:\/\/demo.shrimpthemes.com\/1\/parlo\/product\/vivamus-et-massa-massa\/","seller":{"@type":"Organization","name":"Parlo","url":"https:\/\/demo.shrimpthemes.com\/1\/parlo"}}]}]}</script>





<script type='text/javascript' src='resources/js/main.js'></script>

<script type='text/javascript' src='resources/js/woolentor-widgets-active.js'
        id='woolentor-widgets-scripts-js'></script>




<script type='text/javascript' id='wc-add-to-cart-js-extra'>
    /* <![CDATA[ */
    var wc_add_to_cart_params = { "ajax_url": "\/1\/parlo\/wp-admin\/admin-ajax.php", "wc_ajax_url": "\/1\/parlo\/?wc-ajax=%%endpoint%%", "i18n_view_cart": "View cart", "cart_url": "https:\/\/demo.shrimpthemes.com\/1\/parlo\/cart\/", "is_cart": "", "cart_redirect_after_add": "no" };
    /* ]]> */
</script>


<script type='text/javascript'
        src='resources/js/jquery.flexslider.min.js'
        id='flexslider-js'></script>


<script type='text/javascript' id='wc-single-product-js-extra'>
    /* <![CDATA[ */
    var wc_single_product_params = { "i18n_required_rating_text": "Please select a rating", "review_rating_required": "yes", "flexslider": { "rtl": false, "animation": "slide", "smoothHeight": true, "directionNav": false, "controlNav": "thumbnails", "slideshow": false, "animationSpeed": 500, "animationLoop": false, "allowOneSlide": false }, "zoom_enabled": "1", "zoom_options": [], "photoswipe_enabled": "1", "photoswipe_options": { "shareEl": false, "closeOnScroll": false, "history": false, "hideAnimationDuration": 0, "showAnimationDuration": 0 }, "flexslider_enabled": "1" };
    /* ]]> */
</script>
<script type='text/javascript'
        src='resources/js/single-product.min.js'
        id='wc-single-product-js'></script>




</body>

</html>
