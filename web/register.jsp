<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/11/9
  Time: 22:45
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>discipl!ne pro &#8211; 注册</title>
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


    <link rel='stylesheet' id='woocommerce-layout-css' href='resources/css/woocommerce-layout.css' type='text/css'
          media='all' />
    <link rel="stylesheet" href="resources/css/load.css">

    <script type='text/javascript'
            src='resources/js/jquery.min.js'></script>

    <script type='text/javascript'>
        jQuery(function () {

            //更新验证码
            jQuery("#validatecode").click(function () {
                jQuery("#validatecode").attr("src","userservlet?method=code&num=" + Math.random());
            });


            //验证邮箱唯一性
            jQuery("#email").blur(function(){


                if(this.value!=''){
                    if(!testEmail(this.value)){
                        jQuery('#emailMsg').text("邮箱格式错误 ×").css("color","red");
                        return false;
                    }
                }
                if(this.value!=""){
                    jQuery.get('userservlet?method=checkEmailUnique',"email="+this.value,function(data){
                        console.log(data)
                        if(data=="false"){
                            jQuery('#emailMsg').text("此邮箱已被注册激活 ×").css("color","red");
                        }else{
                            jQuery('#emailMsg').text("邮箱地址 ✔").css("color","green");
                        }
                    });
                }

            });

        });

        //验证邮箱格式
        function testEmail(email) {
            let reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;

            if(!reg.test(email))
                return false;
            else
                return true;
        }


        function doRegister () {

            let username = jQuery("[name='username']").val();
            let email = jQuery("[name='email']").val();
            let password = jQuery("[name='password']").val();
            let vcode = jQuery("[name='vcode']").val();


            if(email==''||password==''||vcode==''){
                jQuery("[id='msg']").text("请填写完整信息！");
                return false;
            }

            let reg = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;

            if(!reg.test(email)) {
                jQuery('.msg').text("邮箱格式有误！");
                return false;
            }
            jQuery("[id='loading']").show();

            jQuery.ajax({
                url: "userservlet?method=register",
                data: {
                    "username": username,
                    "email": email,
                    "password": password,
                    "vcode": vcode,
                },
                type: "POST",
                success: function (data) {
                    jQuery("[id='loading']").hide(0);
                    if(data=="success"){
                        jQuery(location).attr('href', 'message.jsp')
                    }else{
                        jQuery("[id='msg']").text(data);
                    }

                }
            })


        }


    </script>

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
                            <li>注册</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>




        <div id="primary" class="content-area parlopage-padding">
            <main id="main" class="site-main">


                <!-- 注册 -->
                <div class="ht-container">
                        <div class="ht-row">
                            <div class="ht-col-xs-12">


                                <article id="post-50" class="post-50 page type-page status-publish hentry" style="width: 50%;margin: auto;">
                                    <h1 class="entry-title">我的</h1>

                                    <div class="entry-content">
                                        <div class="woocommerce">
                                            <div class="woocommerce-notices-wrapper"></div>

                                            <div class="u-column2 col-2">


                                                <form class="woocommerce-form woocommerce-form-register register" style="position: relative;">


                                                    <!-- loading -->
                                                    <div class="spinner" id="loading">
                                                        <div class="rect1"></div>
                                                        <div class="rect2"></div>
                                                        <div class="rect3"></div>
                                                        <div class="rect4"></div>
                                                        <div class="rect5"></div>
                                                    </div>


                                                    <p class="woocommerce-form-row woocommerce-form-row--wide form-row form-row-wide">
                                                        <label>用户名</label>
                                                        <input
                                                                class="woocommerce-Input woocommerce-Input--text input-text"
                                                                type="text" name="username"  required />
                                                    </p>


                                                    <p class="woocommerce-form-row woocommerce-form-row--wide form-row form-row-wide">
                                                        <label id="emailMsg">邮箱地址</label>
                                                        <input type="email"
                                                               class="woocommerce-Input woocommerce-Input--text input-text"
                                                               name="email"  autocomplete="email" id="email"  required /> </p>

                                                    <p class="woocommerce-form-row woocommerce-form-row--wide form-row form-row-wide">
                                                        <label>密码</label>
                                                        <input
                                                                class="woocommerce-Input woocommerce-Input--text input-text"
                                                                type="password" name="password" required/>
                                                    </p>


                                                    <p class="woocommerce-form-row woocommerce-form-row--wide form-row form-row-wide">
                                                        <label>验证码</label>
                                                        <input
                                                                class="woocommerce-Input woocommerce-Input--text input-text"
                                                                type="text" name="vcode"  style="width: 60%; float: left" required/>
                                                        <a><img src="userservlet?method=code" style="margin-left: 6px;" id="validatecode" ></a>
                                                    </p>


                                                    <p class="woocommerce-form-row woocommerce-form-row--wide form-row form-row-wide">
                                                        <span style="color: red;height: 20px;display: block;" id="msg"></span>

                                                    </p>

                                                    <div class="woocommerce-privacy-policy-text">
                                                        <p>您的个人信息将会被使用以此来支持您在此网站上的浏览，注册即代表您已阅读并同意我们的<a
                                                                href="#"
                                                                class="woocommerce-privacy-policy-link"
                                                                target="_blank">隐私政策</a>.</p>
                                                        <p>已有账号？<a href="login.jsp">点此登录</a></p>
                                                    </div>
                                                    <p class="woocommerce-form-row form-row">
                                                        <input type="hidden" id="woocommerce-register-nonce"
                                                               name="woocommerce-register-nonce" />
                                                        <input type="hidden" name="_wp_http_referer" />
                                                        <button type="button"
                                                                class="woocommerce-Button woocommerce-button button woocommerce-form-register__submit"
                                                                name="register" onclick="doRegister()" id="register_btn">注册</button>
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


<script type='text/javascript' src='resources/js/main.js'></script>


</body>

</html>

