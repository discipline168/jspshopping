<%--
  Created by IntelliJ IDEA.
  User: cheese
  Date: 2021/11/15
  Time: 13:29
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en-US">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>discipl!ne pro &#8211; 地址</title>
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


    <link rel='stylesheet' id='parlo-style-css' href='resources/css/style.css' type='text/css' media='all' />


    <script>


        var limit=${size};
        var flag=0;

        console.log('limit:'+limit)
        //移除地址信息
        function removeItem(id) {
            jQuery("[id='loading']").show();

            jQuery.ajax({
                url: "addressservlet?method=delete",
                data: {
                    "id": id,
                },
                type: "POST",
                success: function (data) {
                    jQuery("[id='loading']").hide(0);
                    if(data=="success"){
                        console.log('删除地址信息 id-'+id+'成功');
                        jQuery("[id='address-item-"+id+"']").slideUp(0);
                        flagAdd();
                    }
                    else{
                        alert(data);
                    }

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
        class="page-template-default page page-id-50 logged-in wp-custom-logo theme-parlo woocommerce-account woocommerce-page woocommerce-orders woocommerce-no-js woolentor_current_theme_parlo woocommerce-active elementor-default elementor-kit-915">

<div id="page" class="site">
    <!-- 导航 -->
    <%@include file="commons/header.jsp"%>


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
                            <li><a href="/${pageContext.request.contextPath}">主页</a></li>
                            <li><a href="account.jsp">我的</a></li>
                            <li>地址</li>
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
                                <h1 class="entry-title">Orders</h1>

                                <div class="entry-content">
                                    <div class="woocommerce">


                                        <!-- 左侧总览 -->
                                        <%@include file="commons/leftNav.jsp"%>


                                        <div class="woocommerce-MyAccount-content">

                                            <c:if test="${empty addressList}">
                                                <div class="woocommerce-message woocommerce-message--info woocommerce-Message woocommerce-Message--info woocommerce-info">
                                                    <a class="woocommerce-Button button"
                                                       href="addressservlet?method=operate&type=insert">去添加</a>
                                                    您还未添加任何地址信息
                                                </div>
                                            </c:if>

                                            <c:if test="${not empty addressList}">
                                                <table
                                                        class="woocommerce-orders-table woocommerce-MyAccount-orders shop_table shop_table_responsive my_account_orders account-orders-table">
                                                    <thead>
                                                    <tr>
                                                        <th  style="padding: 20px;" class="woocommerce-orders-table__header woocommerce-orders-table__header-order-number">
                                                            <span class="nobr">删除</span></th>
                                                        <th  class="woocommerce-orders-table__header woocommerce-orders-table__header-order-number">
                                                            <span class="nobr">收件人</span></th>
                                                        <th
                                                                class="woocommerce-orders-table__header woocommerce-orders-table__header-order-date">
                                                            <span class="nobr">手机号码</span></th>
                                                        <th
                                                                class="woocommerce-orders-table__header woocommerce-orders-table__header-order-status">
                                                            <span class="nobr">地区</span></th>
                                                        <th
                                                                class="woocommerce-orders-table__header woocommerce-orders-table__header-order-total">
                                                            <span class="nobr">具体地址</span></th>
                                                        <th
                                                                class="woocommerce-orders-table__header woocommerce-orders-table__header-order-actions">
                                                            <span class="nobr">修改</span></th>
                                                    </tr>
                                                    </thead>

                                                    <tbody>
                                                        <c:forEach items="${addressList}" var="address">
                                                            <tr id="address-item-${address.id}"
                                                                    class="woocommerce-orders-table__row woocommerce-orders-table__row--status-on-hold order">
                                                                <td class="product-remove" >
                                                                    <a style="margin: auto;" class="remove" aria-label="Remove this item" onclick="removeItem(${address.id})">
                                                                        <img style="width: 30px;" src="resources/images/delete.png">
                                                                    </a>
                                                                </td>
                                                                <td  data-title="收件人" class="woocommerce-orders-table__cell woocommerce-orders-table__cell-order-number" >
                                                                    <a> ${address.name} </a>
                                                                    <c:if test="${address.level==1}">
                                                                        <button style="background-color: white;border: 1px solid orange;color: orange;">默认</button>
                                                                    </c:if>
                                                                </td>
                                                                <td data-title="手机号码" class="woocommerce-orders-table__cell woocommerce-orders-table__cell-order-date" >
                                                                     ${address.phone}
                                                                </td>
                                                                <td data-title="地区" class="woocommerce-orders-table__cell woocommerce-orders-table__cell-order-status" >
                                                                    ${address.region}
                                                                </td>
                                                                <td data-title="具体地址" class="woocommerce-orders-table__cell woocommerce-orders-table__cell-order-total" >
                                                                    ${address.detail}
                                                                </td>
                                                                <td class="product-remove" >
                                                                    <a href="addressservlet?method=operate&type=update&id=${address.id}"
                                                                       class="woocommerce-button button view">修改</a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>

                                                <c:if test="${size<3}">
                                                    <a href="addressservlet?method=operate&type=insert" class="woocommerce-button button view" style="margin-top: 30px;">新增</a>
                                                </c:if>


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
