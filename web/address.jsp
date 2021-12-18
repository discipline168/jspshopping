<%--
  Created by IntelliJ IDEA.
  User: cheese
  Date: 2021/11/15
  Time: 21:28
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>discipl!ne pro &#8211; 地址设置</title>
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
    <link rel="stylesheet" href="resources/css/load.css">

    <link rel='stylesheet' id='elementor-post-11-css' href='resources/css/post-11.css' type='text/css' media='all' />






    <link rel='stylesheet' id='woocommerce-layout-css' href='resources/css/woocommerce-layout.css' type='text/css'
          media='all' />

    <script type='text/javascript' src='resources/js/jquery.min.js' id='jquery-core-js'></script>

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

    <script>

        function postData(id) {

            var region;
            //获取地区信息
            jQuery('#region').citySelect(function (code, nameArr) {
                region = nameArr.join(',');
            });

            var name=jQuery("[name='name']").val();
            var phone=jQuery("[name='phone']").val();
            var detail=jQuery("[name='detail']").val();
            var level=jQuery("[name='level']").val();

           /* if(jQuery("input[type='checkbox']").prop('checked')){
                level=1
            }else{
                level=0
            }*/

            console.log('name: ' + name)
            console.log('phone: ' + phone)
            console.log('detail: ' + detail)
            console.log('region: ' + region)
            console.log('level: ' + level)

            if(jQuery.trim(name)==''||jQuery.trim(phone)==''||(region+'').indexOf(',')<=0||jQuery.trim(detail)==''){
                alert('请确保地址信息完整')
                return;
            }
            //新增
            if (id == null) {
                jQuery("[id='loading']").show();

                jQuery.ajax({
                    url: "addressservlet?method=insert",
                    data: {
                        "name": name,
                        "phone": phone,
                        "region": region,
                        "detail": detail,
                        "level": level,
                    },
                    type: "POST",
                    success: function (data) {
                        jQuery("[id='loading']").hide(0);
                        if (data == "success") {
                            console.log('新增地址信息成功');
                            jQuery(location).attr('href', 'addressservlet?method=list')
                        }
                        else if(data=="nouser"){
                            jQuery(location).attr('href', '/login.jsp')
                        }
                        else {
                            alert(data);
                        }

                    }
                })
            }
            //修改
            else{
                jQuery("[id='loading']").show();

                jQuery.ajax({
                    url: "addressservlet?method=update",
                    data: {
                        "id":id,
                        "name": name,
                        "phone": phone,
                        "region": region,
                        "detail": detail,
                        'level': level
                    },
                    type: "POST",
                    success: function (data) {
                        jQuery("[id='loading']").hide(0);

                        if (data == "success") {
                            console.log('修改地址信息id-'+id+'成功');
                            jQuery(location).attr('href', 'addressservlet?method=list')
                        }
                        else {
                            alert(data);
                        }

                    }
                })
            }

        };
    </script>


</head>

<body
        class="page-template-default page page-id-50 wp-custom-logo theme-parlo woocommerce-account woocommerce-page woocommerce-no-js woolentor_current_theme_parlo woocommerce-active elementor-default elementor-kit-915">

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
                            <li><a href="${pageContext.request.contextPath}/">主页</a></li>
                            <li><a href="/account.jsp">我的</a></li>
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
                                <h1 class="entry-title">我的</h1>

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
                                                        <p class="form-row form-row-first validate-required">
                                                            <label>收件人</label>
                                                            <span class="woocommerce-input-wrapper">
                                                                    <input type="text" style="margin-bottom: 30px;"
                                                                           class="input-text " name="name" value="${address.name}" required>
                                                                </span>
                                                        </p>
                                                        <p class="form-row form-row-last validate-required">
                                                            <label>电话号码</label>
                                                            <span class="woocommerce-input-wrapper">
                                                                    <input  class="input-text " name="phone"
                                                                           placeholder=""
                                                                            value="${address.phone}"
                                                                           autocomplete="family-name">
                                                                </span>
                                                        </p>


                                                        <p class="form-row form-row-wide" >
                                                            <label>所在地区</label>
                                                            <span class="select2-selection__rendered">
                                                                    <div id="region">
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
                                                                    <input type="text" class="input-text"  style="margin-bottom: 30px;" name="detail" value="${address.detail}">
                                                            </span>
                                                        </p>

                                                        <p class="form-row form-row-wide validate-required">
                                                            <label class="woocommerce-form__label woocommerce-form__label-for-checkbox woocommerce-form-login__rememberme">

                                                                <select class="ui-select" name="level" style="width: 200px;">
                                                                    <option value="1">默认地址</option>

                                                                    <c:if test="${address.level==1||empty address}">
                                                                        <option value="0">备选地址</option>
                                                                    </c:if>

                                                                    <c:if test="${address.level==0}">
                                                                        <option value="0" selected="true">备选地址</option>
                                                                    </c:if>
                                                                </select>
                                                            </label>
                                                        </p>
                                                    </div>


                                                </div>


                                                <p>
                                                    <button type="button" onclick="postData(${address.id})" class="button"
                                                            style="width: 100%;" name="save_address"
                                                            value="Save address">${type=='insert'?'新增':'修改'}</button>
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

    var type='${type}';
    console.log('type: '+type)

    if(type=='insert'){
        console.log('iiiiinsert')
        jQuery('#region').citySelect({
            prompt: ['- 省/直辖市 -', '- 市 -', '- 区/县 -', '- 乡/镇/街道办 -']
        });
    }else{
        //更新地址时地区初始化
        console.log('uuuuupdate')
        jQuery('#region').citySelect({search: '${address.region}'});
    }





    // $('#fetch').click(function () {
    //     $('#region').citySelect(function (code, nameArr) {
    //         $('#result2').html(
    //             '行政代码：' + code + '<br>' +
    //             '地址：' + nameArr.join('，')
    //         );
    //     });
    // });



</script>


</body>



</html>
