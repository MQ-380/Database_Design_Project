<%@ page import="clinic.DBConc" %>
<%@ page import="java.util.*" %>
<%@ page import="JavaBean.DoctorReceipt" %>
<%@ page import="JavaBean.Doctor" %>
<%@ page import="JavaBean.StayInformation" %>
<%@ page import="JavaBean.BedRoom" %><%--
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
    <title>病房病患查询</title>
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


<main role="main">
    <div class="container">
        <form class="form-inline" action="../ConsultRoomInpatientServlet" method="post">
            <div class="form-group">
                <label for="DoctorID">病房号</label>
                <select class="form-control" id="DoctorID" name="roomId">
                    <%DBConc db = new DBConc();
                       ArrayList<BedRoom> bedRooms = db.getAllBedNumberOfRoom();
                       int size = bedRooms.size();
                       for(int i = 0;i<size;i++){
                           String id = bedRooms.get(i).getBed_room();
                    %><option value="<%=id%>"><%=id%></option><%
                    }
                %>
                </select>
            </div>
            <button type="submit" class="btn btn-default" id="search">查询</button>
        </form>
    </div>

    <div class="container">
        <br>
        <div class="container">
            <%
                String residentName = (String)session.getAttribute("roomId");
                if(residentName!=null && !((String) session.getAttribute("roomId")).isEmpty()){
            %>
            <h4><%=residentName%>病房的住院病患情况</h4>
            <%
                }

            %>
        </div>
    </div>

    <div class="container">
        <div class="table-responsive">
            <table class="table table-striped table-bordered" data-toggle="table"
                   data-sort-name="id" data-sort-order="asc"
                   data-pagination="true" data-pagination-loop="true"
                   data-page-size="10" data-page-list="[10,20,30,All]"
                   data-show-pagination-switch="true"
                   data-show-export="true"
                   id="table"
            >
                <thead>
                <tr>
                    <th data-field="id" data-sortable="true">序号</th>
                    <th data-field="receipt" data-sortable="true">收治医生</th>
                    <th data-field="date" data-sortable="true">住院统编号</th>
                    <th data-field="name" data-sortable="true">病患编号</th>
                    <th data-field="num" data-sortable="true">病患姓名</th>
                    <th data-field="room" data-sortable="true">房间号</th>
                    <th data-field="amount" data-sortable="true">床号</th>
                </tr>

                </thead>
                <%
                    ArrayList<StayInformation> inpatients = (ArrayList<StayInformation>)session.getAttribute("inpatient");
                    if(inpatients!=null){
                        DBConc dc = new DBConc();
                        for(int i=0;i<inpatients.size();i++){
                            String id = String.valueOf(i+1);
                            String resident = dc.getResidentName(String.valueOf(inpatients.get(i).getResident_id()));
                            String stay_id = String.valueOf(inpatients.get(i).getStay_id());
                            String inpatient_id = String.valueOf(inpatients.get(i).getInpatient_id());
                            String inpatient_name = inpatients.get(i).getInpatient_name();
                            Map<String,String> bed = dc.getBedRoomAndNumber(String.valueOf(inpatients.get(i).getBed_id()));
                            String room =  bed.get("room");
                            String bed_no = bed.get("number");
                %><tr>
                <td><%=id%></td>
                <td><%=resident%></td>
                <td><%=stay_id%></td>
                <td><%=inpatient_id%></td>
                <td><%=inpatient_name%></td>
                <td><%=room%></td>
                <td><%=bed_no%></td>
            </tr>
                <%
                        }
                        inpatients.clear();
                    }
                %>

            </table>
        </div>
    </div>
</main>

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
<script src="../js/bootstrap-table-export.js"></script>
<script src="../js/tableExport.js"></script>
</body>
</html>