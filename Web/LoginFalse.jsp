<%@ page import="clinic.DBConc" %>
<%@ page import="java.util.*" %>
<%@ page import="JavaBean.Item" %>
<%@ page import="JavaBean.ReceiptAndPays" %>
<%--
  Created by IntelliJ IDEA.
  User: mouizumi
  Date: 2017/3/16
  Time: 21:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>首页</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <!-- Main Style Sheet -->
    <link rel="stylesheet" href="styles/admin.css">
    <link rel="stylesheet" href="styles/bootstrap-datepicker3.min.css">
    <link rel="stylesheet" href="styles/bootstrapValidator.css">
    <link rel="stylesheet" href="styles/bootstrap-table.css">
    <!-- Modernizr -->
    <script src="js/vendor/modernizr-2.6.2.min.js"></script>
</head>
<body>
<header role="banner">
    <div class="container">
        <a class="banner-brand visible-md visible-lg" href="LoginHome.jsp"><img src="img/logo.png" alt="Hospital" width="50" height="50"></a>
    </div><!-- /.container -->
    <nav role="navigation" class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand visible-xs visible-sm" href="LoginHome.jsp"><img src="img/logo.png" alt="Hospital'" width="30"></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">选择子系统<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="Login.jsp">门诊收费管理子系统</a></li>
                            <li class="divider"></li>
                            <li><a href="StayinLogin.jsp">住院管理子系统</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!--/.nav-collapse -->
        </div><!--/.container -->
    </nav>
</header>

<div class="container">
    <div class="jumbotron">
        <h1>欢迎使用本系统！</h1>
        <p>欢迎使用A医院管理系统，本系统提供简单的门诊收费管理以及住院管理功能。谢谢使用。</p>
        <p><a class="btn btn-primary btn-lg" href="../Login.jsp">门诊收费管理子系统登录</a></p>
        <p><a class="btn btn-primary btn-lg" href="../StayinLogin.jsp">住院管理子系统登录</a></p>
    </div>
</div>


<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.10.2.min.js"><\/script>')</script>

<!-- Holder.js for project development only -->
<script src="js/vendor/holder.js"></script>

<!-- Essential Plugins and Main JavaScript File -->
<script src="js/plugins.js"></script>
<script src="js/main.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script src="js/bootstrap-datepicker.min.js"></script>
<script src="js/bootstrapValidator.js"></script>
<script src="js/bootstrapValidator.min.js"></script>
<script src="js/bootstrap-table.js"></script>
<script src="js/bootbox.min.js"></script>
<script>
    $(function () {
        bootbox.alert({
            message: "登录错误。请检查您的用户名与密码，以及登录用户组别。",
        });
    })
</script>

</body>
</html>



