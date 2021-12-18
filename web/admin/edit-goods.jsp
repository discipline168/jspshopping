<%--
  Created by IntelliJ IDEA.
  User: cheese
  Date: 2021/12/17
  Time: 13:30
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>discipl!ne pro 后台管理 &#8211; 商品<c:if test="${not empty goods}">编辑</c:if><c:if test="${not empty goods}">新增</c:if></title>
    <meta name='robots' content='noindex, nofollow' />


    <link rel='stylesheet' id='simple-line-icons-wl-css' href='../resources/css/simple-line-icons.css' type='text/css'
          media='all' />

    <link rel='stylesheet' id='htflexboxgrid-css' href='../resources/css/htflexboxgrid.css' type='text/css'
          media='all' />
    <link rel='stylesheet' id='woolentor-widgets-css' href='../resources/css/woolentor-widgets.css' type='text/css'
          media='all' />


    <link rel='stylesheet' id='elementor-frontend-legacy-css' href='../resources/css/frontend-legacy.min.css'
          type='text/css' media='all' />
    <link rel='stylesheet' id='elementor-frontend-css' href='../resources/css/frontend.min.css' type='text/css'
          media='all' />

    <link rel='stylesheet' id='elementor-post-11-css' href='../resources/css/post-11.css' type='text/css' media='all' />


    <link rel="stylesheet" href="../resources/css/woocommerce.css">
    <link rel="stylesheet" href="../resources/css/load.css">


    <link rel='stylesheet' id='woocommerce-layout-css' href='../resources/css/woocommerce-layout.css' type='text/css'
          media='all' />

    <script type='text/javascript' src='../resources/js/jquery.min.js' id='jquery-core-js'></script>





    <link rel='stylesheet' id='parlo-style-css' href='../resources/css/style.css' type='text/css' media='all' />

    <style id='woocommerce-inline-inline-css' type='text/css'>
        .woocommerce form .form-row .required {
            visibility: visible;
        }

        select {
            margin: 20px;
            height: 60px;
            text-align: center;
            background-color: white;
            color: #8f8f8f;
        }

        @media all and (orientation : portrait) {
            select {
                width: 120px;
            }

        }

        #upload_btn {
            border: gray solid 1px;
            width: 100px;
            height: 100px;
            position: relative;
            margin: auto;
            display: none;
        }

        #uploadOther_btn {
            float: left;
            margin-left: 5px;
            border: gray solid 1px;
            width: 100px;
            height: 100px;
            position: relative;
            display: none;
        }
        a[name='remove-btn'] {
            position: absolute;
            top: 37%;
            right: 37%;
        }


        .picDiv {
            width: 100px;
            height: 100px;
            margin: auto;
            position: relative;

        }


        .otherPicDiv {
            width: 100px;
            height: 100px;
            float: left;
            position: relative;
            margin-right: 5px;
        }


        .m-pic {
            background: #f0f0f0;
            width: 100px !important;
            height: 100px !important;
        }
    </style>




    <script>

        //新增OR更新
        function postData() {
            jQuery("[name='updateSuccess']").hide(0);
            jQuery("[id='loading']").show();

            //获取图片地址
            var otherPicSrc=getOtherPicSrc();
            var picSrc=getPicSrc();

            console.log("otherPicSrc: "+otherPicSrc);
            console.log("picSrc: "+picSrc);

            jQuery.ajax({
                url: "admin?method=insertOrUpdateGoods",
                data: {
                    "id": jQuery("[name='gid']").val()==null?0:jQuery("[name='gid']").val(),
                    "name": jQuery("[name='gname']").val(),
                    "categoryid": jQuery("[name='categoryid']").val(),
                    "price": jQuery("[name='price']").val(),
                    "discount": (jQuery("[name='discount']").val()>1||jQuery("[name='discount']").val()<0)?1:jQuery("[name='discount']").val(),
                    "status": jQuery("[name='status']").val(),
                    "sizes": jQuery("[name='sizes']").val(),
                    "description": jQuery("[name='description']").val(),
                    "others": otherPicSrc,
                    "picture": picSrc,
                },
                type: "POST",
                success: function (data) {
                    jQuery("[id='loading']").hide(0);
                    if(data=="insertSuccess"){
                        console.log("新增商品信息成功");
                        jQuery(location).attr('href', "admin?method=goods");

                    }else if(data=="updateSuccess"){
                        console.log("更新商品信息id-"+jQuery("[name='gid']").val()+"成功");
                        jQuery("[name='updateSuccess']").slideDown(500);
                        //定位锚点
                        jQuery("html,body").animate({scrollTop:0},300);
                        //延迟3秒消失
                        jQuery("[name='updateSuccess']").delay(3000).slideUp(500);
                    }
                    else{
                        alert(data);
                    }

                }
            });
        }




    </script>

    <script type='text/javascript' src='../resources/js/main.js'></script>
    <script type='text/javascript' src='../resources/js/jquery.min.js'></script>


</head>

<body
        class="page-template-default page page-id-49 logged-in wp-custom-logo theme-parlo woocommerce-checkout woocommerce-page woocommerce-no-js woolentor_current_theme_parlo woocommerce-active elementor-default elementor-kit-915">

<div id="page" class="site">


    <!-- 导航 -->
    <%@include file="../commons/aheader.jsp"%>


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
        <div id="primary">
            <main id="main" class="site-main">

                <div class="ht-container">
                    <div class="ht-row">
                        <div class="ht-col-xs-12">

                            <article id="post-49" class="post-49 page type-page status-publish hentry">

                                <div class="entry-content">
                                    <div class="woocommerce">

                                        <div class="woocommerce-notices-wrapper" name="updateSuccess" style="display: none">
                                            <div class="woocommerce-message" role="alert">
                                                更新商品信息成功
                                            </div>
                                        </div>

                                        <input name="gid" type="text" value="${goods.id}" style="display: none;">

                                        <section class="woocommerce-order-details"
                                                 style="width:80%;margin: auto;">

                                            <div class="checkout-area">
                                                <div>
                                                    <table
                                                            class="woocommerce-table woocommerce-table--order-details shop_table order_details"
                                                            style="text-align: center;">


                                                        <tr>
                                                            <th style="width: 50%;"> 商品名称</th>
                                                            <td data-title="商品名称">
                                                                <input type="text" name="gname"
                                                                       value="${goods.name}">
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <th style="width: 50%;">价格</th>
                                                            <td data-title="价格">
                                                                <input type="number" value="${goods.price}" name="price"
                                                                       style="width: 100px;">
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <th>折扣</th>
                                                            <td data-title="折扣">
                                                                <input type="number" name="discount" style="width: 100px;" value="${goods.discount}">
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <th style="width: 50%;">类别</th>
                                                            <td data-title="类别">
                                                                <select name="categoryid" style="width: 100px;">
                                                                    <c:if test="${goods.categoryid==1}">
                                                                        <option value="1"  selected="true"> 运动服饰</option>
                                                                        <option value="2"> 运动用品</option>
                                                                        <option value="3"> 运动补给</option>
                                                                    </c:if>
                                                                    <c:if test="${goods.categoryid==2}">
                                                                        <option value="1"> 运动服饰</option>
                                                                        <option value="2" selected="true"> 运动用品</option>
                                                                        <option value="3"> 运动补给</option>
                                                                    </c:if>
                                                                    <c:if test="${goods.categoryid==3}">
                                                                        <option value="1"> 运动服饰</option>
                                                                        <option value="2"> 运动用品</option>
                                                                        <option value="3" selected="true"> 运动补给</option>
                                                                    </c:if>

                                                                </select>
                                                            </td>
                                                        </tr>


                                                        <tr>
                                                            <th>首页图片</th>
                                                            <td data-title="首页图片">
                                                                <div id="pic">
                                                                    <c:if test="${not empty goods.picture}">
                                                                        <div class="picDiv">
                                                                            <img src="${goods.picture}" class="m-pic" loading="lazy">
                                                                            <a class="remove" name="remove-btn"><i><img src="../resources/images/delete.png"></i></a>
                                                                        </div>
                                                                    </c:if>
                                                                </div>



                                                                <div id="upload_btn">

                                                                    <a><img style="width: 40px; height: 40px;position:absolute; top: 30%; right: 30%;"
                                                                            src="../resources/images/upload.png"
                                                                            alt="上传图片" loading="lazy"></a>
                                                                </div>


                                                                <div>

                                                                    <input type="file" style="display: none;"
                                                                           id="upload_input" name="picture">

                                                                </div>
                                                            </td>
                                                        </tr>


                                                        <tr>
                                                            <th>其他图片</th>
                                                            <td data-title="其他图片">
                                                                <div id="otherPics"
                                                                     style="float: left;margin-left:15px;">



                                                                    <c:if test="${not empty otherPictures}">
                                                                        <c:forEach items="${otherPictures}" var="picture">
                                                                            <div class="otherPicDiv">
                                                                                <img src="${picture}"
                                                                                     class="m-pic" alt="" loading="lazy">
                                                                                <a class="remove" name="remove-btn">
                                                                                    <i><img src="../resources/images/delete.png"></i>
                                                                                </a>
                                                                            </div>
                                                                        </c:forEach>
                                                                    </c:if>





                                                                </div>
                                                                <div id="uploadOther_btn">

                                                                    <a href="#"><img id="show"
                                                                                     style="width: 40px; height: 40px;position:absolute; top: 30%; right: 30%;"
                                                                                     src="../resources/images/upload.png"
                                                                                     alt="上传图片" loading="lazy">
                                                                    </a>
                                                                </div>


                                                                <div>

                                                                    <input type="file" style="display: none;"
                                                                           id="uploadOther_input" name="coverFile">

                                                                </div>


                                                            </td>
                                                        </tr>


                                                        <tr>
                                                            <th>状态</th>
                                                            <td data-title="状态">
                                                                <select class="ui-select" name="status"
                                                                        style="width: 100px;">
                                                                    <c:if test="${goods.status==1}">
                                                                        <option value="1" selected="true">
                                                                            在售
                                                                        </option>

                                                                        <option value="0">
                                                                            下架
                                                                        </option>
                                                                    </c:if>
                                                                    <c:if test="${empty goods}">
                                                                        <option value="1" selected="true">
                                                                            在售
                                                                        </option>

                                                                        <option value="0">
                                                                            下架
                                                                        </option>
                                                                    </c:if>
                                                                    <c:if test="${goods.status==0}">
                                                                        <option value="0" selected="true">
                                                                            下架
                                                                        </option>
                                                                        <option value="1"
                                                                                style="max-width: 500px;">
                                                                            在售
                                                                        </option>
                                                                    </c:if>

                                                                </select>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <th>尺码/规格 <br>（注意：尺码/规格参数顺序输入用<strong
                                                                    style="color: red;">,</strong>分割）
                                                                <div style="margin-top: 5px;">
                                                                    <a onclick="insertClothesSize()" class="button"
                                                                       style="margin-top: 5px;">
                                                                        服饰类尺码快速插入</a>
                                                                    <a onclick="insertShoesSize()" class=" button"
                                                                       style="margin-top: 5px;">
                                                                        鞋类规格快速插入</a>
                                                                </div>
                                                            </th>
                                                            <td data-title="尺码/规格">
                                                                <input name="sizes" type="text"
                                                                       value="${goods.sizes}">

                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <th>描述</th>
                                                            <td>
                                                                    <textarea name="description" cols="45" rows="8"
                                                                              required="">${goods.description}</textarea>
                                                            </td>
                                                        </tr>




                                                    </table>

                                                    <div class="wc-proceed-to-checkout">

                                                        <a onclick="postData()"
                                                           class="checkout-button button alt wc-forward">
                                                            <c:if test="${not empty goods}">更新</c:if>
                                                            <c:if test="${empty goods}">新增</c:if>
                                                        </a>
                                                    </div>



                                                </div>
                                            </div>

                                        </section>



                                    </div>
                                </div><!-- .entry-content -->

                            </article><!-- #post-49 -->


                        </div>
                    </div>
                </div>

            </main><!-- #main -->
        </div><!-- #primary -->



    </div><!-- #content -->







</div><!-- #page -->





<script type='text/javascript' src='../resources/js/cart.min.js' id='wc-cart-js'></script>

<script type='text/javascript' src='../resources/js/main.js'></script>


<script>
    jQuery(function () {
        otherPicJudge();
        picJudge();
    });

    /** BEGIN-- 上传首页图片 --BEGIN **/
    jQuery('#upload_btn').click(function () {
        jQuery('#upload_input').click();
    });

    jQuery('#upload_input').on('change', function () {
        jQuery("[id='loading']").show();

        var filePath = jQuery(this).val();         //获取到input的value，里面是文件的路径
        var fileFormat = filePath.substring(filePath.lastIndexOf(".")).toLowerCase();
        // 检查是否是图片
        if (!fileFormat.match(/.png|.jpg|.jpeg|.webp/)) {
            alert('上传错误,文件格式必须为：png/jpg/jpeg/webp');
            return;
        }

        //图片的文件字节长度
        var length = this.files[0].size;

        let imgFile = new FileReader();
        imgFile.readAsDataURL(this.files[0]);
        imgFile.onload = res => {
            //图片转base64
            var file = res.target.result
            console.log("file: " + file);
            console.log("length: " + length);

            jQuery.ajax({
                url: "admin?method=uploadPic",
                data: {
                    "file": file,
                    "length": length,
                },
                type: "POST",
                success: function (data) {
                    jQuery("[id='loading']").hide(0);

                    if(data=="error"){
                        alert("图片上传失败");
                    }else {
                        jQuery('#pic').append("<div class='picDiv'><img  src='" + data + "' class='m-pic' loading='lazy'> " +
                            "<a class='remove' name='remove-btn' ><i><img src='../resources/images/delete.png'></i></a></div>");
                        picJudge();

                        //jQuery新增元素原先设置事件会失效，需动态绑定删除事件
                        jQuery("[name='remove-btn']").on('click', function () {
                            removePic(this);
                        });
                    }
                }
            });

        };

    });
    /** END-- 上传首页图片 --END**/




    /** BEGIN-- 上传其他图片 --BEGIN**/

    jQuery('#uploadOther_btn').click(function () {
        jQuery('#uploadOther_input').click();
    });

    jQuery('#uploadOther_input').on('change', function () {
        jQuery("[id='loading']").show();

        var filePath = jQuery(this).val();         //获取到input的value，里面是文件的路径
        var fileFormat = filePath.substring(filePath.lastIndexOf(".")).toLowerCase();
        // 检查是否是图片
        if (!fileFormat.match(/.png|.jpg|.jpeg|.webp/)) {
            alert('上传错误,文件格式必须为：png/jpg/jpeg/webp');
            return;
        }

        //图片的文件字节长度
        var length = this.files[0].size;

        let imgFile = new FileReader();
        imgFile.readAsDataURL(this.files[0]);
        imgFile.onload = res => {
            //图片转base64
            var file = res.target.result
            console.log("file: " + file);
            console.log("length: " + length);

            jQuery.ajax({
                url: "admin?method=uploadPic",
                data: {
                    "file": file,
                    "length": length,
                },
                type: "POST",
                success: function (data) {
                    jQuery("[id='loading']").hide(0);

                    if(data=="error"){
                        alert("图片上传失败");
                    }else {
                        jQuery('#otherPics').append("<div class='otherPicDiv'><img  src='" + data + "' class='m-pic' loading='lazy'>"
                            + " <a class='remove' name='remove-btn' ><i><img src='../resources/images/delete.png'></i></a></div>");
                        otherPicJudge();

                        //jQuery新增元素原先设置事件会失效，需动态绑定删除事件
                        jQuery("[name='remove-btn']").on('click', function () {
                            removeOtherPic(this);
                        });
                    }
                }
            });

        };


    });
    /** END-- 上传其他图片 --END*/





    function insertClothesSize() {
        jQuery("[name='size']").val("S,M,L,XL,XXL,3XL");
    }
    function insertShoesSize() {
        jQuery("[name='size']").val("36,36.5,37,38,39,40,40.5,41,42,42.5,43,44,45,46.47,48");
    }



    jQuery("[name='remove-btn']").click(function () {
        removeOtherPic(this);
    });


    //移除首页图片
    function removeOtherPic(obj) {
        jQuery(obj).parent().remove();
        picJudge();
    }


    //移除其他图片
    function removePic(obj) {
        jQuery(obj).parent().remove();
        otherPicJudge();
    }




    /** BEGIN -- 动态显示图片上传按钮 --BEGIN **/
    function otherPicJudge() {
        if ((jQuery('#otherPics').children().length) >= 4) {
            jQuery("#uploadOther_btn").hide(0);
        } else {
            jQuery("#uploadOther_btn").show();
        }
    }


    function picJudge() {
        if ((jQuery('#pic').children().length) >= 1) {
            jQuery("#upload_btn").hide(0);
        } else {
            jQuery("#upload_btn").show();
        }

    }
    /** END-- 动态显示图片上传按钮 --END **/



    //获取其他图片地址合集 用,,,分割
    function getOtherPicSrc() {
        var otherPicSrc = "";

        var otherPics = jQuery("[id='otherPics']").children();
        for (i = 0; i < otherPics.length; i++) {
            otherPicSrc += (jQuery(otherPics[i]).find("img").attr("src") + ",,,");

        }

        return otherPicSrc;
    }

    //获取首页图片地址
    function getPicSrc() {
        return jQuery("[id='pic']").find("img").attr("src");
    }


</script>



</body>


</html>
