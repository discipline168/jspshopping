<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/12/17
  Time: 13:25
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>discipl!ne pro 后台管理  &#8211; 总览</title>
    <meta name='robots' content='noindex, nofollow' />


    <link rel='stylesheet' id='simple-line-icons-wl-css' href='resources/css/simple-line-icons.css' type='text/css'
          media='all' />

    <link rel='stylesheet' id='htflexboxgrid-css' href='resources/css/htflexboxgrid.css' type='text/css'
          media='all' />
    <link rel='stylesheet' id='woolentor-widgets-css' href='resources/css/woolentor-widgets.css' type='text/css'
          media='all' />



    <link rel='stylesheet' id='elementor-frontend-legacy-css' href='resources/css/frontend-legacy.min.css'
          type='text/css' media='all' />
    <link rel='stylesheet' id='elementor-frontend-css' href='resources/css/frontend.min.css' type='text/css'
          media='all' />

    <link rel='stylesheet' id='elementor-post-11-css' href='resources/css/post-11.css' type='text/css' media='all' />


    <link rel="stylesheet" href="resources/css/woocommerce.css">



    <link rel='stylesheet' id='woocommerce-layout-css' href='resources/css/woocommerce-layout.css' type='text/css'
          media='all' />

    <link rel="stylesheet" id="woocommerce-smallscreen-css" href="resources/css/woocommerce-smallscreen.css"
          type="text/css" media="only screen and (max-width: 768px)">

    <link rel="stylesheet" href="resources/css/admin/bootstrap.min.css">

    <link rel="stylesheet" href="resources/css/admin/style.css">
    <link rel="stylesheet" href="resources/css/admin/components.css">


    <script type='text/javascript' src='resources/js/jquery.min.js' id='jquery-core-js'></script>



    <style id='woocommerce-inline-inline-css' type='text/css'>
        .woocommerce form .form-row .required {
            visibility: visible;
        }
    </style>


    <link rel='stylesheet' id='parlo-style-css' href='resources/css/style.css' type='text/css' media='all' />




</head>

<body
        class="page-template-default page page-id-50 logged-in wp-custom-logo theme-parlo woocommerce-account woocommerce-page woocommerce-orders woocommerce-no-js woolentor_current_theme_parlo woocommerce-active elementor-default ">

<div id="page" class="site">
    <a class="skip-link screen-reader-text" href="#content">Skip to content</a>

    <!-- 导航 -->
    <%@include file="../commons/aheader.jsp"%>




    <div class="site-content">


        <div id="primary">
            <main id="main" class="site-main">

                <div class="ht-container">
                    <div class="ht-row">
                        <div class="ht-col-xs-12">


                            <article id="post-50" class="post-50 page type-page status-publish hentry">


                                <div class="entry-content">
                                    <div class="woocommerce">
                                        <div id="content" class="site-content">
                                            <div class="main-content">


                                                <div class="container" id="custom-cards">

                                                    <div
                                                            class="row row-cols-1 row-cols-lg-3 align-items-stretch g-4 py-5">
                                                        <div class="col" style="margin-top: 10px;">
                                                            <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg"
                                                                 style="background-image: url('http://cdn.discipline168.cn/unsplash-photo-1.jpg');background-position:center">
                                                                <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1"
                                                                     style="text-align: center;">
                                                                    <h2 class="mt-5 mb-4 display-6 lh-1 fw-bold">
                                                                        总用户数：${userNum}</h2>

                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col" style="margin-top: 10px;">
                                                            <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg"
                                                                 style="background-image: url('http://cdn.discipline168.cn/unsplash-photo-2.jpg');background-position:center">
                                                                <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1"
                                                                     style="text-align: center;">
                                                                    <h2 class="mt-5 mb-4 display-6 lh-1 fw-bold">
                                                                        今日订单数：${todayOrderNum}</h2>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col" style="margin-top: 10px;">
                                                            <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg"
                                                                 style="background-image: url('http://cdn.discipline168.cn/unsplash-photo-3.jpg');background-position:center">
                                                                <div class="d-flex flex-column h-100 p-5 pb-3 text-shadow-1"
                                                                     style="text-align: center;">
                                                                    <h2 class="mt-5 mb-4 display-6 lh-1 fw-bold">
                                                                        <a href="admin?method=orders&status=1" style="color: white;">代发货数：${toDeliverOrderNum}</a>
                                                                    </h2>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>


                                                <section class="section">


                                                    <div class="row">
                                                        <div class="col-lg-12 col-md-12 col-12 col-sm-12">
                                                            <div class="card" style="width: 80%;margin: auto;">
                                                                <h2 class="h5" style="margin: 1rem;">近7天成交额</h2>
                                                                <div class="card-body">
                                                                    <canvas id="myChart" height="182"></canvas>
                                                                    <div class="statistic-details mt-sm-4">
                                                                        <div class="statistic-details-item">

                                                                            <div class="detail-value">&#165;${today}</div>
                                                                            <div class="detail-name">当日成交额</div>
                                                                        </div>
                                                                        <div class="statistic-details-item">

                                                                            <div class="detail-value">&#165;${week}
                                                                            </div>
                                                                            <div class="detail-name">当周成交额</div>
                                                                        </div>
                                                                        <div class="statistic-details-item">

                                                                            <div class="detail-value">&#165;${month}
                                                                            </div>
                                                                            <div class="detail-name">当月成交额</div>
                                                                        </div>
                                                                        <div class="statistic-details-item">
                                                                            <div class="detail-value">&#165;${year}
                                                                            </div>
                                                                            <div class="detail-name">当年成交额</div>
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
                                </div><!-- .entry-content -->

                            </article><!-- #post-50 -->

                        </div>
                    </div>
                </div>

            </main><!-- #main -->
        </div><!-- #primary -->


    </div><!-- #content -->

    <div style="width: 100%;height: 50px;"></div>


</div><!-- #page -->


<script type='text/javascript' src='resources/js/main.js'></script>

<script src="resources/js/admin/chart.min.js"></script>

<script>

    //初始化线性图表信息
    var statistics_chart = document.getElementById("myChart").getContext('2d');

    var myChart = new Chart(statistics_chart, {
        type: 'line',
        data: {
            labels: ${arr1},
            datasets: [{
                label: '成交额',
                data:  ${arr2},
                borderWidth: 5,
                borderColor: '#6777ef',
                backgroundColor: 'transparent',
                pointBackgroundColor: '#fff',
                pointBorderColor: '#6777ef',
                pointRadius: 4
            }]
        },
        options: {
            legend: {
                display: false
            },
            scales: {
                yAxes: [{
                    gridLines: {
                        display: false,
                        drawBorder: false,
                    },
                    ticks: {
                        stepSize: 150
                    }
                }],
                xAxes: [{
                    gridLines: {
                        color: '#fbfbfb',
                        lineWidth: 2
                    }
                }]
            },
        }
    });
</script>





</body>

</html>
