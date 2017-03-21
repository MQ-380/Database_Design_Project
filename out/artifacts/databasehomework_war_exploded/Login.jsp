<%@ page import="clinic.login.DBConc" %>
<%@ page import="sun.util.resources.cldr.bo.CalendarData_bo_CN" %><%--
  Created by IntelliJ IDEA.
  User: mouizumi
  Date: 2017/3/7
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
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
                  <a class="navbar-brand visible-xs visible-sm" href="LoginHome.jsp"><img src="img/logo.png" alt="Hospital'" width="120"></a>
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

  <div class="modal fade" tabindex="-1" role="dialog" id="login">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h4 class="modal-title">用户登录</h4>
              </div>
              <div class="modal-body">
                  <form action="LoginServlet" method="post" name="form1" class="form-horizontal">
                      <div class="form-group">
                          <label for="item" class="col-sm-2 control-label">用户名</label>
                          <div class="col-sm-10">
                              <input type="text" class="form-control" id="item"  name="username">
                          </div>
                      </div>
                      <div class="form-group">
                          <label for="passwd" class="col-sm-2 control-label">账户密码</label>
                          <div class="col-sm-10">
                              <input type="password" class="form-control" id="passwd" name="passwd">
                          </div>
                      </div>
                      <div class="form-group">
                          <label for="power1" class="col-sm-2 control-label">用户类型</label>
                          <div class="col-sm-10">
                              <label class="radio-inline">
                              <input type="radio" name="power" id="power1" value="0">管理员
                                  </label>
                              <label class="radio-inline">
                              <input type="radio" name="power" id="power2" value="1">收费员
                              </label>
                          </div>
                      </div>
                      <div class="form-group">
                          <div class="col-sm-offset-2 col-sm-10">
                              <button type="submit" class="btn btn-primary" id="done" >登录</button>
                          </div>
                      </div>
                  </form>
              </div>
          </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->

  </body>
</html>







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
       $('#login').modal();
    });
</script>


