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
                <a class="navbar-brand visible-xs visible-sm" href="AdminHome.jsp"><img src="img/logo.png" alt="Bootstrappin'" width="120"></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">系统<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../Admin/registerAdmin.jsp">创建新管理员账户</a></li>
                            <li class="divider"></li>
                            <li><a href="../Admin/register.jsp">创建新收费员账户</a></li>
                            <li class="divider"></li>
                            <li><a href="../Login.jsp">退出登录</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">管理基础数据<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../Data/Room.jsp">科室数据</a></li>
                            <li class="divider"></li>
                            <li><a href="../Data/Doctor.jsp">医生数据</a></li>
                            <li class="divider"></li>
                            <li><a href="../Data/Item.jsp">药品与检查数据</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">生成收费报表 <b class="caret"></b></a>
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




<form id="userForm" method="post" class="form-horizontal" style="display: none;" action="../RegisterServlet">
    <div class="form-group">
        <label class="col-xs-3 control-label">收费员工号</label>
        <div class="col-xs-3">
            <%DBConc dc = new DBConc();
                int newId = dc.GetNewId("toll_collector","ct_id");
            %>
            <input type="text" class="form-control" name="id" readonly="readonly" value="<%=newId%>"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">收费员账号</label>
        <div class="col-xs-5">
            <input type="text" class="form-control" name="name" />
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">收费员密码</label>
        <div class="col-xs-5">
            <input type="password" class="form-control" name="passwd" />
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">确认密码</label>
        <div class="col-xs-5">
            <input type="password" class="form-control" name="passwds" />
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">用户姓名</label>
        <div class="col-xs-5">
            <input type="text" class="form-control" name="username" value="1"/>
        </div>
    </div>

    <div class="form-group">
        <div class="col-xs-5 col-xs-offset-3">
            <button type="submit" class="btn btn-primary">注册</button>
        </div>
    </div>
</form>



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
    $('[type="date"]').datepicker({
        format:"yyyy-mm-dd",
        autoclose:true,
        startDate:"2010-01-01",
        clearBtn: true,
        calendarWeeks:false,
        todayHighlight:false
    });
</script>

<script>
    $(function (){
        $('form').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons:{
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating:'glyphicon glyphicon-refresh'
            },
            fields:{
                id:{
                    validators:{
                        notEmpty:{
                            message:'用户账号不能为空'
                        }
                    }
                },
                passwd:{
                    validators:{
                        notEmpty:{
                            message:'密码不能为空'
                        }
                    }
                },
                passwds:{
                    validators:{
                        notEmpty:{
                            message:'确认密码不能为空'
                        },
                        identical: {
                            field: 'passwd',
                            message: '两次密码输入不一致，请检查'
                        }
                    }
                }
            }
        });
    });
</script>

<script>
    $(function () {
        bootbox
            .dialog({
                title: '注册收费员',
                message: $('#userForm'),
                show: false
            })
            .on('shown.bs.modal', function () {
                $('#userForm')
                    .show();                      // Show the login form
                // Reset form
            })
            .on('hide.bs.modal', function (e) {
                // Bootbox will remove the modal (including the body which contains the login form)
                // after hiding the modal
                // Therefor, we need to backup the form
                $('#userForm').hide().appendTo('body');
            })
            .modal('show');
    });
</script>
</body>
</html>