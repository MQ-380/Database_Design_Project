<%@ page import="clinic.login.DBConc" %>
<%@ page import="java.util.*" %>
<%@ page import="JavaBean.DoctorReceipt" %>
<%@ page import="JavaBean.Doctor" %><%--
  Created by IntelliJ IDEA.
  User: mouizumi
  Date: 2017/3/9
  Time: 23:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>添加新用户</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <!-- Main Style Sheet -->
    <link rel="stylesheet" href="../styles/admin.css">
    <link rel="stylesheet" href="../styles/bootstrap-datepicker3.min.css">
    <link rel="stylesheet" href="../styles/bootstrapValidator.css">
    <link rel="stylesheet" href="../styles/bootstrap-table.css">
    <!-- Modernizr -->
    <script src="../js/vendor/modernizr-2.6.2.min.js"></script>
</head>
<body>
<header role="banner">
    <div class="container">
        <a class="banner-brand visible-md visible-lg" href="AdminHome.jsp"><img src="../img/logo.png" alt="Hospital" width="50" height="50"></a>
    </div><!-- /.container -->
    <nav role="navigation" class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand visible-xs visible-sm" href="AdminHome.jsp"><img src="../img/logo.png" alt="Hospital" width="30"></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><strong>系统</strong><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../Admin/registerAdmin.jsp">创建新管理员账户</a></li>
                            <li class="divider"></li>
                            <li><a href="../Admin/register.jsp">创建新收费员账户</a></li>
                            <li class="divider"></li>
                            <li><a href="../LoginHome.jsp">退出登录</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><strong>管理基础数据</strong><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../Data/Room.jsp">科室数据</a></li>
                            <li class="divider"></li>
                            <li><a href="../Data/Doctor.jsp">医生数据</a></li>
                            <li class="divider"></li>
                            <li><a href="../Data/Item.jsp">药品与检查数据</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><strong>生成收费报表</strong> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../Admin/DoctorTable.jsp">生成医生报表</a></li>
                            <li class="divider"></li>
                            <li><a href="../Admin/CTTable.jsp">生成收费员报表</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><strong>查询收费数据与发票</strong> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../Data/Pays.jsp">查询全部收费数据</a></li>
                            <li class="divider"></li>
                            <li><a href="../Data/Receipt.jsp">按发票号查询数据</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!--/.nav-collapse -->
        </div><!--/.container -->
    </nav>
</header>


<%
    Boolean success = (Boolean)session.getAttribute("registerSuccess");
    String type = (String)session.getAttribute("type");
    if(success!=null && success){
        String notice = new String();
        if(type.equals("0")) {notice = "您成功注册了账号名为<b>"+session.getAttribute("name")+"</b>的管理员账户。";}
        if(type.equals("1")) {notice = "您成功注册了账号名为<b>"+session.getAttribute("name")+"</b>的收费员账户。";}
%>

<div class="modal fade" tabindex="-1" role="dialog" id="open">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">成功注册</h4>
            </div>
            <div class="modal-body">
                <p><%=notice%></p>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" data-dismiss="modal">确认</button>
            </div>
        </div>
    </div>
</div>
<%
}else if(success!=null && !success){
%>
<div class="modal fade" tabindex="-1" role="dialog" id="open">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">注册失败</h4>
            </div>
            <div class="modal-body">
                <p>注册失败,已有同名账户  </p>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" data-dismiss="modal">确认</button>
            </div>
        </div>
    </div>
</div>
<%
    }
%>

<% session = request.getSession(); session.invalidate(); %>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="../js/vendor/jquery-1.10.2.min.js"><\/script>')</script>

<!-- Holder.js for project development only -->
<script src="../js/vendor/holder.js"></script>

<!-- Essential Plugins and Main JavaScript File -->
<script src="../js/plugins.js"></script>
<script src="../js/main.js"></script>
<script src="../js/bootstrap-datepicker.js"></script>
<script src="../js/bootstrap-datepicker.min.js"></script>
<script src="../js/bootstrapValidator.js"></script>
<script src="../js/bootstrapValidator.min.js"></script>
<script src="../js/bootstrap-table.js"></script>
<script src="../js/bootbox.min.js"></script>
<script>
    $(function () {
        $('#open').modal();
    })
</script>

</body>
</html>