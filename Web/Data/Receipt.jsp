<%@ page import="clinic.login.DBConc" %>
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
    <title>发票号查询与退费</title>
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
        <a class="banner-brand visible-md visible-lg" href="../Admin/AdminHome.jsp"><img src="../img/logo.png" alt="Hospital" width="50" height="50"></a>
    </div><!-- /.container -->
    <nav role="navigation" class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand visible-xs visible-sm" href="../Admin/AdminHome.jsp"><img src="img/logo.png" alt="Bootstrappin'" width="120"></a>
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

    </div>
</main>

<div class="modal fade" tabindex="-1" role="dialog" id="cancel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">退款</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="receiptid" class="col-sm-2 control-label">请输入退款的单号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="receiptid">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" class="btn btn-primary" id="done" >确认</button>
                        </div>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<main role="main">
    <div class="container">
        <form class="form-inline" action="../ConsultReceiptServlet" method="post">
            <div class="form-group">

                <label for="Receipt_ID">发票号</label>
                <input type="text" class="form-control required" id="Receipt_ID" placeholder="1" name="id">
            </div>
            <button type="submit" class="btn btn-default">查询</button>
        </form>
    </div>

    <div class="container">
        <table class="table table-striped table-bordered" data-toggle="table"
               data-pagination="true" data-pagination-loop="true"
               data-page-size="10" data-page-list="[10,20,30,All]"
               data-show-pagination-switch="true"
        >
            <thead>
            <tr>
                <th data-field="id">序号</th>
                <th data-field="receipt">发票号</th>
                <th data-field="paysid">付款编号</th>
                <th data-field="date">开票时间</th>
                <th data-field="item">检查/药品项目名</th>
                <th data-field="price">单价</th>
                <th data-field="amount">项目数量</th>
                <th data-field="total">项目总价</th>
                <th data-field="doctor">开具医生姓名</th>
                <th data-field="ct">收费员姓名</th>
            </tr>

            </thead>
            <%
                ArrayList<ReceiptAndPays> receipts = (ArrayList<ReceiptAndPays>)session.getAttribute("data");

                if(receipts!=null){
                    DBConc dc = new DBConc();
                    int size = receipts.size();
                    for(int i=0;i<size;i++){
                        ReceiptAndPays temp = receipts.get(i);
                        String no = String.valueOf(i+1);
                        String receipt_id = String.valueOf(temp.getReceipt_id());
                        String pays_id = String.valueOf(temp.getPays_id());
                        String receipt_date = temp.getReceipt_Date();
                        String item_name = dc.getItemName(temp.getItem_id());
                        String item_price = dc.getItemInformation(temp.getItem_id()).get("item_price");
                        String item_amount = String.valueOf(temp.getAmount());
                        String item_total = String.valueOf(temp.getTotal());
                        String doctor_name = dc.getDoctorName(temp.getDoctor_id());
                        String ct_name = dc.getCTName(temp.getCt_id());
            %><tr id="<%=no%>">
            <td id="no<%=no%>"><%=no%></td>
            <td id="re<%=receipt_id%>>"><%=receipt_id%></td>
            <td id="pays<%=pays_id%>"><%=pays_id%></td>
            <td><%=receipt_date%></td>
            <td><%=item_name%></td>
            <td><%=item_price%></td>
            <td><%=item_amount%></td>
            <td><%=item_total%></td>
            <td><%=doctor_name%></td>
            <td><%=ct_name%></td>
        </tr>
            <%
                    }
                    receipts.clear();
                }
            %>
        </table>
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
<script src="../js/bootbox.min.js"></script>


