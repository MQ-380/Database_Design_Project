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
    <title>医生报表</title>
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


<main role="main">
    <div class="container">
    <form class="form-inline" action="../ConsultDoctorReceiptServlet" method="post">
        <div class="form-group">

            <label for="DoctorID">医生姓名</label>
            <select class="form-control" id="DoctorID" name="name">
                <%DBConc db = new DBConc();
                    Map<String,String> ans = db.getDoctor();
                    for(Map.Entry<String,String> entry : ans.entrySet()){
                        String name = entry.getValue();
                        String id = entry.getKey();
                        %><option value="<%=id%>"><%=name%></option><%
                    }
                %>
            </select>
        </div>
        <div class="form-group">
            <label for="startTime">开始时间</label>
            <input type="date" class="form-control required" id="startTime" placeholder="2017-01-31" name="start">
        </div>
        <div class="form-group">
            <label for="endTime">结束时间</label>
            <input type="date" class="form-control" id="endTime" placeholder="2017-01-31" name="end">
        </div>
        <button type="submit" class="btn btn-default">查询</button>
    </form>
    </div>

    <div class="container">
        <br>
        <div class="container">
            <%
                String doctorname = (String)session.getAttribute("doctorname");
                String starttime = (String)session.getAttribute("doctorstart");
                String endtime = (String)session.getAttribute("doctorend");
                if(doctorname!=null && !((String) session.getAttribute("doctorname")).isEmpty()){
            %>
            <h4><%=doctorname%>医生<%=starttime%>至<%=endtime%>的收费情况</h4>
            <%
                    session.setAttribute("doctorname","");
                    session.setAttribute("doctorstart","");
                    session.setAttribute("doctorend","");
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
                   >
                <thead>
                    <tr>
                        <th data-field="id" data-sortable="true">序号</th>
                        <th data-field="receipt" data-sortable="true">发票号</th>
                        <th data-field="date" data-sortable="true">开票时间</th>
                        <th data-field="name" data-sortable="true">收费项目名称</th>
                        <th data-field="num" data-sortable="true">数量</th>
                        <th data-field="amount" data-sortable="true">总计金额</th>
                    </tr>

                </thead>
                    <%
                        ArrayList<DoctorReceipt> doctorReceipts = (ArrayList<DoctorReceipt>)session.getAttribute("receipts");
                        double total = 0.0;
                        if(doctorReceipts!=null){
                        DBConc dc = new DBConc();
                        for(int i=0;i<doctorReceipts.size();i++){
                            String id = String.valueOf(doctorReceipts.get(i).getReceipt_id());
                            String date = String.valueOf(doctorReceipts.get(i).getReceiptDate());
                            String item = dc.getItemName(doctorReceipts.get(i).getItem_id());
                            String num = String.valueOf(doctorReceipts.get(i).getNum());
                            total+=doctorReceipts.get(i).getAmount();
                            String amount = String.valueOf(doctorReceipts.get(i).getAmount());
                        %><tr>
                            <td><%=i+1%></td>
                            <td><%=id%></td>
                            <td><%=date%></td>
                            <td><%=item%></td>
                            <td><%=num%></td>
                            <td><%=amount%></td>
                        </tr>
                        <%
                            }
                            doctorReceipts.clear();
                            }
                        %>

            </table>

            <div class="container">
                <h4>总计金额：<%=total%>元</h4>
            </div>


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
                start:{
                    validators:{
                        notEmpty:{
                            message:'起始时间不能为空'
                        }
                    }
                },
                end:{
                    validators:{
                        notEmpty:{
                            message:'结束时间不能为空'
                        }
                    }
                }
            }
        });
    });
</script>

</body>
</html>