<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/11/9
  Time: 15:31
--%>
<%@ page import="com.discipline.java.bean.Goods" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="goodsService" class="com.discipline.java.service.impl.GoodsServiceImpl"/>
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




  <script type='text/javascript' src='resources/js/jquery.min.js' id='jquery-core-js'></script>



  <style type="text/css">
    .mask .main .logo {
      position: absolute;
      top: 40%;
      left: 50%;
      width: 22rem;
      margin-left: -10rem
    }

    .mask .main .logo img {
      width: 22rem
    }



    .mask #video {
      position: absolute;
      min-width: 100%;
      min-height: 100%;
      width: auto;
      height: auto;
      bottom: 0;
      right: 0
    }

    .mask .main .slogan {
      top: 60%;
      left: 50%;
      color: white;
      position: absolute;
      margin-left: -10rem;
      width: 20rem;
      text-align: center;
      font-size: 2rem;
      opacity: 0.7
    }
  </style>



</head>

<body
        class="home page-template page-template-elementor_header_footer page page-id-11 wp-custom-logo theme-parlo woocommerce-no-js woolentor_current_theme_parlo woocommerce-active elementor-default elementor-template-full-width elementor-kit-915 elementor-page elementor-page-11">

<div id="page" class="site">

  <!-- 头部导航 -->
  <%@include file="commons/header.jsp"%>

  <%
    request.setAttribute("indexClothes",goodsService.getIndexGoodsList(1));
    request.setAttribute("indexEquipment",goodsService.getIndexGoodsList(2));
    request.setAttribute("indexSupplements",goodsService.getIndexGoodsList(3));
  %>

  <div id="content" class="site-content">
    <div data-elementor-type="wp-post" data-elementor-id="11" class="elementor elementor-11"
         data-elementor-settings="[]">
      <div class="elementor-inner">
        <div class="elementor-section-wrap">



          <!-- background-vedio -->
          <video class="bg" autoplay="" id="video" loop="" muted="" webkit-playsinline="">
            <source src="resources/background-video.mp4" type="video/mp4">
          </video>
          <div class="mask">

            <div class="main">
              <div class="logo"><img src="resources/images/logo_white.png" alt="Video poster"></div>
              <div class="slogan">改变就现在</div>


            </div>
          </div>

        </div>



        <section
                class="elementor-section elementor-top-section elementor-element elementor-element-c2cd445 elementor-section-boxed elementor-section-height-default elementor-section-height-default"
                data-id="c2cd445" data-element_type="section">
          <div class="elementor-container elementor-column-gap-default">
            <div class="elementor-row">
              <div class="elementor-column elementor-col-100 elementor-top-column elementor-element elementor-element-49f7dd5"
                   data-id="49f7dd5" data-element_type="column">
                <div class="elementor-column-wrap elementor-element-populated">
                  <div class="elementor-widget-wrap">
                    <div class="elementor-element elementor-element-bdec8b8 elementor-widget elementor-widget-heading"
                         data-id="bdec8b8" data-element_type="widget"
                         data-widget_type="heading.default">
                      <div class="elementor-widget-container">
                        <br>
                        <h2 class="elementor-heading-title elementor-size-default">快速浏览</h2>
                      </div>
                    </div>

                    <div class="elementor-element elementor-element-f13b12b elementor-widget elementor-widget-woolentor-universal-product"
                         data-id="f13b12b" data-element_type="widget"
                         data-widget_type="woolentor-universal-product.default">
                      <div class="elementor-widget-container">
                        <div class="product-tab-list ht-text-center">
                          <ul class="ht-tab-menus">
                            <li><a class="htactive" href="#woolentortabf13b12b1">
                              运动服饰 </a></li>
                            <li><a class="" href="#woolentortabf13b12b2">
                              运动装备 </a></li>
                            <li><a class="" href="#woolentortabf13b12b3">
                              运动补给 </a></li>
                          </ul>
                        </div>

                        <div class="ht-products woocommerce">


                          <!-- 运动服饰 -->
                          <div class="ht-tab-pane htactive" id="woolentortabf13b12b1">
                            <div class="ht-row">

                              <c:forEach items="${indexClothes}" var="goods" >
                                <!--Product Start-->
                                <div  class="ht-product ht-col-lg-3 ht-col-md-6 ht-col-sm-6 ht-col-xs-12 mb-30 product ht-product-action-right ht-product-action-on-hover ht-product-category-right-bottom ht-product-countdown-fill type-product post-73 status-publish first instock product_cat-accessories has-post-thumbnail sale shipping-taxable purchasable product-type-simple">
                                <div class="ht-product-inner">

                                  <div class="ht-product-image-wrap">
                                    <span
                                            class="ht-product-label ht-product-label-right">Sale!</span>
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
                                              <a
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
                                              <a ><i
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
                                        <a href="/goodsservlet?method=shop&categoryid=1">运动服饰</a>
                                      </div>
                                      <h4 class="ht-product-title"><a href="/goodsservlet?method=detail&id=${goods.id}">${goods.name}</a>
                                      </h4>
                                      <div class="ht-product-price">


                                        <c:if test="${goods.discount<1}">
                                          <span class="price"><del
                                                  aria-hidden="true">
                                            <span
                                                    class="woocommerce-Price-amount amount"><bdi><span
                                                    class="woocommerce-Price-currencySymbol">&#165;</span>${goods.price}</bdi></span></del>


                                          <ins><span
                                                  class="woocommerce-Price-amount amount">
                                            <bdi><span
                                                    class="woocommerce-Price-currencySymbol">&#165;</span>${goods.price*goods.discount}
                                            </bdi></span></ins></span>
                                        </c:if>

                                        <c:if test="${goods.discount==1}">
                                          <span class="price"><span class="woocommerce-Price-amount amount">
                                            <bdi><span class="woocommerce-Price-currencySymbol">&#165;</span>${goods.price}
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
                                <!--Product End-->
                              </c:forEach>

                            </div>
                          </div>



                          <!-- 运动装备 -->

                          <div class="ht-tab-pane " id="woolentortabf13b12b2">
                            <div class="ht-row">


                              <c:forEach items="${indexEquipment}" var="goods" >
                                <!--Product Start-->
                                <div  class="ht-product ht-col-lg-3 ht-col-md-6 ht-col-sm-6 ht-col-xs-12 mb-30 product ht-product-action-right ht-product-action-on-hover ht-product-category-right-bottom ht-product-countdown-fill type-product post-73 status-publish first instock product_cat-accessories has-post-thumbnail sale shipping-taxable purchasable product-type-simple">
                                  <div class="ht-product-inner">

                                    <div class="ht-product-image-wrap">
                                    <span
                                            class="ht-product-label ht-product-label-right">Sale!</span>
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
                                          <a href="/goodsservlet?method=shop&categoryid=1">运动服饰</a>
                                        </div>
                                        <h4 class="ht-product-title"><a href="/goodsservlet?method=detail&id=${goods.id}">${goods.name}</a>
                                        </h4>
                                        <div class="ht-product-price">


                                          <c:if test="${goods.discount<1}">
                                          <span class="price"><del
                                                  aria-hidden="true">
                                            <span
                                                    class="woocommerce-Price-amount amount"><bdi><span
                                                    class="woocommerce-Price-currencySymbol">&#165;</span>${goods.price}</bdi></span></del>


                                          <ins><span
                                                  class="woocommerce-Price-amount amount">
                                            <bdi><span
                                                    class="woocommerce-Price-currencySymbol">&#165;</span>${goods.price*goods.discount}
                                            </bdi></span></ins></span>
                                          </c:if>

                                          <c:if test="${goods.discount==1}">
                                          <span class="price"><span class="woocommerce-Price-amount amount">
                                            <bdi><span class="woocommerce-Price-currencySymbol">&#165;</span>${goods.price}
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
                                <!--Product End-->
                              </c:forEach>

                            </div>
                          </div>




                          <!-- 运动补给 -->


                          <div class="ht-tab-pane " id="woolentortabf13b12b3">
                            <div class="ht-row">

                              <c:forEach items="${indexSupplements}" var="goods" >
                                <!--Product Start-->
                                <div  class="ht-product ht-col-lg-3 ht-col-md-6 ht-col-sm-6 ht-col-xs-12 mb-30 product ht-product-action-right ht-product-action-on-hover ht-product-category-right-bottom ht-product-countdown-fill type-product post-73 status-publish first instock product_cat-accessories has-post-thumbnail sale shipping-taxable purchasable product-type-simple">
                                  <div class="ht-product-inner">

                                    <div class="ht-product-image-wrap">
                                    <span
                                            class="ht-product-label ht-product-label-right">Sale!</span>
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
                                                <a
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
                                                <a ><i
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
                                          <a href="/goodsservlet?method=shop&categoryid=3">运动补给</a>
                                        </div>
                                        <h4 class="ht-product-title"><a href="/goodsservlet?method=detail&id=${goods.id}">${goods.name}</a>
                                        </h4>
                                        <div class="ht-product-price">


                                          <c:if test="${goods.discount<1}">
                                          <span class="price"><del
                                                  aria-hidden="true">
                                            <span
                                                    class="woocommerce-Price-amount amount"><bdi><span
                                                    class="woocommerce-Price-currencySymbol">&#165;</span>${goods.price}</bdi></span></del>


                                          <ins><span
                                                  class="woocommerce-Price-amount amount">
                                            <bdi><span
                                                    class="woocommerce-Price-currencySymbol">&#165;</span>${goods.price*goods.discount}
                                            </bdi></span></ins></span>
                                          </c:if>

                                          <c:if test="${goods.discount==1}">
                                          <span class="price"><span class="woocommerce-Price-amount amount">
                                            <bdi><span class="woocommerce-Price-currencySymbol">&#165;</span>${goods.price}
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
                                <!--Product End-->
                              </c:forEach>

                            </div>
                          </div>




                          <!-- 信息公示 -->
                          <div class="elementor-container elementor-column-gap-default">
                            <div class="elementor-row">
                              <div class="elementor-column elementor-col-33 elementor-top-column elementor-element elementor-element-67b7ae8"
                                   data-id="67b7ae8" data-element_type="column">
                                <div
                                        class="elementor-column-wrap elementor-element-populated">
                                  <div class="elementor-widget-wrap">
                                    <div class="elementor-element elementor-element-312ebcc elementor-widget elementor-widget-parlo-service-addons"
                                         data-id="312ebcc"
                                         data-element_type="widget"
                                         data-widget_type="parlo-service-addons.default">
                                      <div class="elementor-widget-container">
                                        <div class="single-service">
                                          <div class="service-icon">
                                            <img src="https://demo.shrimpthemes.com/1/parlo/wp-content/uploads/2019/03/service_1.png"
                                                 class="attachment-full size-full"
                                                 alt="" loading="lazy"
                                                 width="63" height="73">
                                          </div>
                                          <div class="service-content">
                                            <h4>免费送货</h4>
                                            <span></span>
                                            <p>大多数商品<br>
                                              免邮费</p>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                              <div class="elementor-column elementor-col-33 elementor-top-column elementor-element elementor-element-e141965"
                                   data-id="e141965" data-element_type="column">
                                <div
                                        class="elementor-column-wrap elementor-element-populated">
                                  <div class="elementor-widget-wrap">
                                    <div class="elementor-element elementor-element-8953690 elementor-widget elementor-widget-parlo-service-addons"
                                         data-id="8953690"
                                         data-element_type="widget"
                                         data-widget_type="parlo-service-addons.default">
                                      <div class="elementor-widget-container">
                                        <div class="single-service">
                                          <div class="service-icon">
                                            <img src="https://demo.shrimpthemes.com/1/parlo/wp-content/uploads/2019/03/service_2.png"
                                                 class="attachment-full size-full"
                                                 alt="" loading="lazy"
                                                 width="63" height="73">
                                          </div>
                                          <div class="service-content">
                                            <h4>客服服务</h4>
                                            <span></span>
                                            <p>24x7 在线客服服务</p>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                              <div class="elementor-column elementor-col-33 elementor-top-column elementor-element elementor-element-ee43e45"
                                   data-id="ee43e45" data-element_type="column">
                                <div
                                        class="elementor-column-wrap elementor-element-populated">
                                  <div class="elementor-widget-wrap">
                                    <div class="elementor-element elementor-element-4ee60f1 elementor-widget elementor-widget-parlo-service-addons"
                                         data-id="4ee60f1"
                                         data-element_type="widget"
                                         data-widget_type="parlo-service-addons.default">
                                      <div class="elementor-widget-container">
                                        <div class="single-service">
                                          <div class="service-icon">
                                            <img src="https://demo.shrimpthemes.com/1/parlo/wp-content/uploads/2019/03/service_1.png"
                                                 class="attachment-full size-full"
                                                 alt="" loading="lazy"
                                                 width="63" height="73">
                                          </div>
                                          <div class="service-content">
                                            <h4>Secure Payment</h4>
                                            <span></span>
                                            <p>Most Secure Payment<br>
                                              for customer.</p>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>

                        </div>



                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

      </div>
    </div>
  </div>

</div><!-- #content -->
<!-- 底部导航 -->
<%@include file="commons/footer.jsp"%>


<!-- #colophon -->
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
