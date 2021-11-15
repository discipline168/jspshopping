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
    <link rel="profile" href="https://gmpg.org/xfn/11">
    <title>注册</title>
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
                jQuery.get('/userservlet?method=checkEmailUnique',"email="+this.value,function(data){
                    console.log(data)
                    if(data=="false"){
                        jQuery('#emailMsg').text("此邮箱已被注册激活 ×").css("color","red");
                        jQuery('#register_btn').attr("disabled","true");
                    }else{
                        jQuery('#emailMsg').text("邮箱地址 ✔").css("color","green");
                        jQuery('#register_btn').attr("disabled","false");
                    }
                })
            });




        });

        //注册
        // function register_verify(){
        //
        //     jQuery.ajax({
        //         url: "/userservlet?method=register",
        //         data: {
        //             "username": jQuery("[name='username']").val(),
        //             "email": jQuery("[name='email']").val(),
        //             "password": jQuery("[name='password']").val(),
        //             "validatecode": jQuery("[name='validatecode']").val(),
        //         },
        //         type: "POST",
        //         success: function (data) {
        //             if(data=="success"){
        //                 jQuery(location).attr('href', '/account.jsp');
        //             }else{
        //                 msg.text(data);
        //                 return false;
        //             }
        //
        //
        //         }
        //     })
        // };
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


                                                <form method="post"
                                                      action="/userservlet?method=register"
                                                      class="woocommerce-form woocommerce-form-register register">


                                                    <p
                                                            class="woocommerce-form-row woocommerce-form-row--wide form-row form-row-wide">
                                                        <label>用户名</label>
                                                        <input
                                                                class="woocommerce-Input woocommerce-Input--text input-text"
                                                                type="text" name="username"
                                                                autocomplete="current-password" required />
                                                    </p>


                                                    <p
                                                            class="woocommerce-form-row woocommerce-form-row--wide form-row form-row-wide">
                                                        <label id="emailMsg">邮箱地址</label>
                                                        <input type="email"
                                                               class="woocommerce-Input woocommerce-Input--text input-text"
                                                               name="email"  autocomplete="email" id="email"
                                                               value="" required /> </p>

                                                    <p
                                                            class="woocommerce-form-row woocommerce-form-row--wide form-row form-row-wide">
                                                        <label>密码</label>
                                                        <input
                                                                class="woocommerce-Input woocommerce-Input--text input-text"
                                                                type="password" name="password"
                                                                autocomplete="current-password" required/>
                                                    </p>


                                                    <p
                                                            class="woocommerce-form-row woocommerce-form-row--wide form-row form-row-wide">
                                                        <label>验证码</label>
                                                        <input
                                                                class="woocommerce-Input woocommerce-Input--text input-text"
                                                                type="text" name="vcode"
                                                                autocomplete="current-password" style="width: 60%; float: left" required/>
                                                        <a><img src="/userservlet?method=code" style="margin-left: 6px;" id="validatecode" ></a>
                                                    </p>


                                                    <p
                                                            class="woocommerce-form-row woocommerce-form-row--wide form-row form-row-wide">
                                                        <span style="color: red;" id="msg">${registerMsg}</span>

                                                    </p>

                                                    <div class="woocommerce-privacy-policy-text">
                                                        <p>您的个人信息将会被使用以此来支持您在此网站上的浏览，注册即代表您已阅读并同意我们的<a
                                                                href="#"
                                                                class="woocommerce-privacy-policy-link"
                                                                target="_blank">隐私政策</a>.</p>
                                                        <p>已有账号？<a href="/login.jsp">点此登录</a></p>
                                                    </div>
                                                    <p class="woocommerce-form-row form-row">
                                                        <input type="hidden" id="woocommerce-register-nonce"
                                                               name="woocommerce-register-nonce"
                                                               value="e2aaece555" /><input type="hidden"
                                                                                           name="_wp_http_referer" value="/1/parlo/my-account/" />
                                                        <button
                                                                class="woocommerce-Button woocommerce-button button woocommerce-form-register__submit"
                                                                name="register" value="Register"  id="register_btn">注册</button>
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


</body>

</html>

