<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/11/10
  Time: 17:40
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="profile" href="https://gmpg.org/xfn/11">
    <title></title>
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
                        jQuery('#emailMsg').text("此邮箱已被注册激活 ❌").css("color","red");
                        jQuery('#register_btn').attr("disabled",true);
                    }else{
                        jQuery('#emailMsg').text("邮箱地址 ✔").css("color","green");
                        jQuery('#register_btn').attr("disabled",false);
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



        <div class="page-title-area" >
            <div class="ht-container">
                <div class="ht-col-md-12 ht-col-sx-12 ht-center-md" style="margin-top: 10rem;margin-bottom: 12rem;">
                    <div class="breadcrumb-content">
                        <ul>
                            <li style="font-size: 3rem;">${msg}</li>

                        </ul>
                    </div>
                </div>
            </div>
        </div>



    </div>



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

