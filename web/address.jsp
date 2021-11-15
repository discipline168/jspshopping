<%--
  Created by IntelliJ IDEA.
  User: cheese
  Date: 2021/11/15
  Time: 13:29
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script>document.documentElement.className = document.documentElement.className + ' yes-js js_active js'</script>
    <title>地址</title>
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


    <link rel='stylesheet' id='woocommerce-layout-css' href='resources/css/woocommerce-layout.css' type='text/css'
          media='all' />
    <script type='text/javascript' src='resources/js/jquery.min.js'></script>

    <style>
        select {
            margin-bottom: 40px;
            margin-right: 10px;
            height: 60px;
            text-align: center;
            background-color: white;
            color: #8f8f8f;
        }
    </style>

</head>



<body
        class="page-template-default page page-id-50 wp-custom-logo theme-parlo woocommerce-account woocommerce-page woocommerce-no-js woolentor_current_theme_parlo woocommerce-active elementor-default elementor-kit-915">

<div id="page" class="site">


    <!-- 头部导航 -->
    <%@include file="commons/header.jsp"%>




    <div id="content" class="site-content">


        <!-- 面包屑导航 -->
        <div class="page-title-area">
            <div class="ht-container">
                <div class="ht-col-md-12 ht-col-sx-12 ht-center-md">
                    <div class="breadcrumb-content">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/">主页</a></li>
                            <li>地址</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>




        <div id="primary" class="content-area parlopage-padding">
            <main id="main" class="site-main">


                <%-- 用户主页 --%>
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

                                            <form method="post">

                                                <h3>地址</h3>
                                                <div class="woocommerce-address-fields">

                                                    <div class="woocommerce-address-fields__field-wrapper">
                                                        <p class="form-row form-row-first validate-required"
                                                           id="shipping_first_name_field" data-priority="10">
                                                            <label for="shipping_first_name" class="">收件人</label>
                                                            <span class="woocommerce-input-wrapper">
                                                                    <input type="text" style="margin-bottom: 30px;"
                                                                           class="input-text " name="name" required>
                                                                </span>
                                                        </p>


                                                        <p class="form-row form-row-wide"
                                                           id="shipping_company_field" data-priority="30">
                                                            <label for="shipping_company" class="">所在地区</label>
                                                            <span class="select2-selection__rendered">
                                                                    <div id="demo5">
                                                                        <select class="ui-select"
                                                                                name="province"></select>
                                                                        <select class="ui-select" name="city"></select>
                                                                        <select class="ui-select" name="area"></select>
                                                                        <select class="ui-select"
                                                                                name="street"></select>
                                                                    </div>
                                                                </span>
                                                        </p>

                                                        <p class="form-row form-row-wide validate-required">
                                                            <label>具体地址</label>
                                                            <span class="woocommerce-input-wrapper">
                                                                    <input type="text" class=" input-text "
                                                                           name=" specific" id="billing_email"
                                                                           placeholder="" value="107142280885@qq.com"
                                                                           autocomplete="email username">
                                                                </span>
                                                        </p>

                                                        <p class="result" id="result2">&nbsp;</p>
                                                    </div>


                                                </div>


                                                <p>
                                                    <button type="button" id="fetch" class="button" name="save_address"
                                                            value="Save address">保存地址</button>
                                                </p>


                                            </form>


                                        </div>


                                    </div>
                                </div><!-- .entry-content -->

                            </article><!-- #post-50 -->

                        </div>
                    </div>
                </div>




            </main><!-- #main -->
        </div><!-- #primary -->


    </div>



    <!-- #content -->

    <!-- 底部导航 -->
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
<script src="resources/js/city_select.js"></script>
<script>

    $('#demo5').citySelect({
        prompt: ['- 省/直辖市 -', '- 市 -', '- 区/县 -', '- 乡/镇/街道办 -']
    });

    $('#fetch').click(function () {
        $('#demo5').citySelect(function (code, nameArr) {
            $('#result2').html(
                '行政代码：' + code + '<br>' +
                '地址：' + nameArr.join('，')
            );
        });
    });
</script>


</body>
</html>
