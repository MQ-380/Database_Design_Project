<%--
  Created by IntelliJ IDEA.
  User: mouizumi
  Date: 2017/3/24
  Time: 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<header role="banner">
    <div class="container">
        <a class="banner-brand visible-md visible-lg" href="../Stay/StayAdmin.jsp"><img src="../img/logo.png" alt="Hospital" width="50" height="50"></a>
    </div><!-- /.container -->
    <nav role="navigation" class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand visible-xs visible-sm" href="../Stay/StayAdmin.jsp"><img src="../img/logo.png" alt="Hospital" width="30"></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><strong>系统</strong><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../Stay/registerAdmin.jsp">创建新管理员账户</a></li>
                            <li class="divider"></li>
                            <li><a href="../Stay/registerResident.jsp">创建新医生账户</a></li>
                            <li class="divider"></li>
                            <li><a href="../LoginHome.jsp">退出登录</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><strong>管理基础数据</strong><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../Stay/StayRoom.jsp">科室数据</a></li>
                            <li class="divider"></li>
                            <li><a href="../Stay/Bed.jsp">床位添加与修改</a></li>
                            <li class="divider"></li>
                            <li><a href="../Stay/StayItem.jsp">药品与检查数据</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><strong>住院信息</strong> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../Stay/ResidentStayInformation.jsp">医生住院查询</a></li>
                            <li class="divider"></li>
                            <li><a href="../Stay/ResidentRoomInformation.jsp">病房住院情况查询</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!--/.nav-collapse -->
        </div><!--/.container -->
    </nav>
</header>

</body>
</html>
