<%@ page import="clinic.DBConc" %>
<%@ page import="JavaBean.Bed" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: mouizumi
  Date: 2017/3/31
  Time: 10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>增加住院患者</title>
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
        <a class="banner-brand visible-md visible-lg" href="../Stay/Resident.jsp"><img src="../img/logo.png" alt="Hospital" width="50" height="50"></a>
    </div><!-- /.container -->
    <nav role="navigation" class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand visible-xs visible-sm" href="../Stay/Resident.jsp"><img src="../img/logo.png" alt="Hospital" width="30"></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><strong>系统</strong><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../LoginHome.jsp">退出登录</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><strong>住院管理</strong><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../Stay/AddNewInpatient.jsp">添加新住院患者</a></li>
                            <li class="divider"></li>
                            <li><a href="../Stay/AddNewPrescription.jsp">住院患者处方开立</a></li>
                            <li class="divider"></li>
                            <li><a href="../Stay/Cancel.jsp">出院办理</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><strong>住院信息查询</strong> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../Stay/InpatientInformation.jsp">根据床号查询信息</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!--/.nav-collapse -->
        </div><!--/.container -->
    </nav>
</header>

<%

    String success = (String)session.getAttribute("AddSuccess");
    if(success!=null && success.equals("true")){
        String id = (String)session.getAttribute("id");
        String name = (String)session.getAttribute("name");
        %>
<div class="modal fade" tabindex="-1" role="dialog" id="in">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">登记成功</h4>
            </div>
            <div class="modal-body">
                    <div class="form-group">
                        <label for="inpatient_name" class="control-label">患者姓名</label>
                        <label class="form-control" id="inpatient_name" ><%=name%></label>
                    </div>
                    <div class="form-group">
                        <label for="inpatient_id" class="control-label">住院编号</label>
                        <label class="form-control" id="inpatient_id" ><%=id%></label>

                    </div>
            </div>
            <div class="modal-footer">
                <button onclick="window.location.href='../Stay/AddNewPrescription.jsp'" class="btn btn-default">添加处方</button>
                <button class="btn btn-primary" data-dismiss="modal">确认</button>
            </div>
        </div>
    </div>
</div>


<%

    }else if(success!=null && success.equals("false")){
        %>

<div class="modal fade" tabindex="-1" role="dialog" id="in">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">登记失败</h4>
            </div>
            <div class="modal-body">
                <p>很抱歉，登记失败。</p>
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
        $('#in').modal();
    })
</script>
</body>
</html>
