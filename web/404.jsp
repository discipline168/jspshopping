<%--
  Created by IntelliJ IDEA.
  User: discipline
  Date: 2021/12/10
  Time: 14:20
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>discipl!ne pro 404</title>
</head>
<style>
    .error {
        margin: auto;
        width: 800px;
        height: 500px;
        text-align: center;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
    }
    .error-1{
        float: left;
        width: 50%;
        text-align: center;
    }
    .error-gif{
        width:100px;height: 300px;float: left;
    }

    @media all and (orientation : portrait) {
        .error-gif{
            display: none;
        }
    }
</style>

<body>
<section class="section">
    <div class="error">
        <div class="error-1">
            <h1 style="font-size: 7em;font-weight: 700;">404!</h1>
            <div style="font-size: 2em;">
                请求资源不存在
            </div>
            <div style="margin-top: 200px;">
                Copyright &copy; <a href="${pageContext.request.contextPath}/">discipl!ne pro</a>
            </div>

        </div>
        <div class="error-gif">
            <img src="resources/images/404.gif" alt="">
        </div>



    </div>

</section>

</body>

</html>