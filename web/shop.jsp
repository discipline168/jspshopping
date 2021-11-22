<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/11/11
  Time: 15:29
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en-US">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="profile" href="https://gmpg.org/xfn/11">
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

    <script type='text/javascript' src='resources/js/jquery.min.js' id='jquery-core-js'></script>


    <style>
        .aDisabled{
            pointer-events: none;
        }
    </style>



</head>

<body
        class="archive post-type-archive post-type-archive-product wp-custom-logo theme-parlo woocommerce-shop woocommerce woocommerce-page woocommerce-no-js woolentor_current_theme_parlo hfeed woocommerce-active elementor-default elementor-kit-915">

<div id="page" class="site">
    <a class="skip-link screen-reader-text" href="#content">Skip to content</a>

    <!-- 导航 -->
    <%@include file="commons/header.jsp"%>

    <div id="content" class="site-content">
        <div class="page-title-area">
            <div class="ht-container">
                <div class="ht-col-md-12 ht-col-sx-12 ht-center-md">
                    <div class="breadcrumb-content">
                        <ul>
                            <li><a href="/">主页</a></li>
                            <li><a href="/goodsservlet?method=shop">商城</a></li>
                            <c:if test="${not empty category}">
                                <li>${category.name}</li>
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

                        <div class="products columns-4 ht-products">
                            <div class="ht-row">


                                <c:forEach items="${shopGoods}" var="goods" >
                                    <div  class="ht-product ht-col-lg-3 ht-col-md-6 ht-col-sm-6 ht-col-xs-12 mb-30 product ht-product-action-right ht-product-action-on-hover ht-product-category-right-bottom ht-product-countdown-fill type-product post-73 status-publish first instock product_cat-accessories has-post-thumbnail sale shipping-taxable purchasable product-type-simple">
                                        <div class="ht-product-inner">

                                            <div class="ht-product-image-wrap">
                                                <div class="ht-product-image">
                                                    <a href="/goodsservlet?method=detail&id=${goods.id}">
                                                        <img width="300" height="300"
                                                             src="${goods.picture}"
                                                             class="attachment-woocommerce_thumbnail size-woocommerce_thumbnail"
                                                             alt="" loading="lazy"
                                                             sizes="(max-width: 300px) 100vw, 300px" />
                                                    </a>

                                                </div>


                                                <div class="ht-product-action">
                                                    <ul class="woolentor-action-btn-area">
                                                        <li>
                                                            <a href="javascript:void(0);"
                                                               class="woolentorquickview"
                                                               data-quick-id="73">
                                                                <i
                                                                        class="sli sli-magnifier"></i>
                                                                <span
                                                                        class="ht-product-action-tooltip">查看</span>
                                                            </a>
                                                        </li>
                                                        <li>
                                                            <div
                                                                    class=" wishlist button-default yith-wcwl-add-to-wishlist add-to-wishlist-73">
                                                                <div
                                                                        class="yith-wcwl-add-button show">
                                                                    <a href="https://demo.shrimpthemes.com/1/parlo/wishlist/"
                                                                       data-product-id="73"
                                                                       data-product-type="simple"
                                                                       class="add_to_wishlist"><i
                                                                            class="sli sli-heart"></i><span
                                                                            class="ht-product-action-tooltip">Add
                                                                                                        to
                                                                                                        Wishlist</span></a><i
                                                                        class="fa fa-spinner fa-pulse ajax-loading"
                                                                        style="visibility:hidden"></i>
                                                                </div>
                                                                <div class="yith-wcwl-wishlistaddedbrowse hide"
                                                                     style="display:none;">
                                                                    <a class=""
                                                                       href="https://demo.shrimpthemes.com/1/parlo/wishlist/"><i
                                                                            class="sli sli-heart"></i><span
                                                                            class="ht-product-action-tooltip">Browse
                                                                                                        Wishlist</span></a>
                                                                </div>
                                                            </div>
                                                    </ul>
                                                </div>

                                            </div>


                                            <div class="ht-product-content">
                                                <div class="ht-product-content-inner">
                                                    <div class="ht-product-categories">
                                                        <a >${goods.category.name}</a>
                                                    </div>
                                                    <h4 class="ht-product-title"><a href="/goodsservlet?method=detail&id=${goods.id}">${goods.name}</a>
                                                    </h4>
                                                    <div class="ht-product-price">


                                                        <c:if test="${goods.discount<1}">
                                          <span class="price"><del
                                                  aria-hidden="true">
                                            <span
                                                    class="woocommerce-Price-amount amount"><bdi><span
                                                    class="woocommerce-Price-currencySymbol"></span>&#165;${goods.price}</bdi></span></del>


                                          <ins><span
                                                  class="woocommerce-Price-amount amount">
                                            <bdi style="color: red;font-size: 1rem"><span
                                                    class="woocommerce-Price-currencySymbol"></span>&#165;${goods.price*goods.discount}
                                            </bdi></span></ins></span>
                                                        </c:if>

                                                        <c:if test="${goods.discount==1}">
                                          <span class="price"><span class="woocommerce-Price-amount amount">
                                            <bdi style="font-size: 1rem"><span class="woocommerce-Price-currencySymbol"></span>&#165;${goods.price}
                                            </bdi></span>
                                          </span>
                                                        </c:if>

                                                    </div>
                                                    <div class="ht-product-ratting-wrap">
                                                    </div>


                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                </c:forEach>




                            </div>
                        </div>
                    </div>






                    <!-- 底部导航 -->
                    <nav class="woocommerce-pagination">
                        <ul class='page-numbers'>


                            <c:if test="${currentpPage>1}">

                            <li><a class="page-numbers"
                                   href="/goodsservlet?method=shop&categoryid=${category.id!=null?category.id:0}&page=${currentpPage-1}"><</a></li>
                            </c:if>
                            <li><span aria-current="page" class="page-numbers current">${currentpPage}</span></li>

                            <c:if test="${currentpPage<pages}">
                            <li><a class="next page-numbers"
                                   href="/goodsservlet?method=shop&categoryid=${category.id!=null?category.id:0}&page=${currentpPage+1}">><i
                                    class="fa fa-angle-right"></i></a></li>
                            </c:if>

                        </ul>

                        <ul class="page-numbers"><li>共 ${pages} 页</li></ul>

                    </nav>


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


<script type='text/javascript' src='resources/js/main.js'></script>




<script type='text/javascript' src='resources/js/woolentor-widgets-active.js'
        id='woolentor-widgets-scripts-js'></script>

</body>

</html>
