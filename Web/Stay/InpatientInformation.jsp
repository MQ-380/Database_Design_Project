<%--
  Created by IntelliJ IDEA.
  User: mouizumi
  Date: 2017/3/31
  Time: 09:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="clinic.DBConc" %>
<%@ page import="JavaBean.BedRoom" %>
<%@ page import="JavaBean.StayInformation" %>
<%@ page import="JavaBean.PrescriptionsInformation" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>病患查询</title>
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


<main role="main">
    <div class="container">
        <form class="form-inline" action="../ConsultInpatientInformationServlet" method="post">
            <div class="form-group">
                <input type="hidden" name="from" value="consult">
                <label for="roomID">选择病房号</label>
                <select class="form-control" id="roomID" name="roomId">
                    <option value="-1">请选择病房号</option>
                    <%DBConc db = new DBConc();
                        ArrayList<BedRoom> bedRooms = db.getAllBedNumberOfRoom();
                        Map<String,Integer> rooms = new HashMap<>();
                        for(int i = 0; i<bedRooms.size();i++) {
                            String thisRoom =bedRooms.get(i).getBed_room();
                            Integer roomSize = bedRooms.get(i).getBed_room_count();
                            rooms.put(thisRoom,roomSize);
                        }

                        for(Map.Entry<String,Integer> entry : rooms.entrySet()){
                            String room = entry.getKey();
                            Integer capability = entry.getValue();
                    %><option value="<%=room%>" id="<%=capability%>" name="<%=room%>"><%=room%></option><%
                    }
                %>
                </select>
            </div>
            <div class="form-group">
                <label for="roomID">选择床号</label>
                <select class="form-control" id="bedID" name="bedId">
                    <option value="-1">请选择床号</option>
                </select>
            </div>
            <div class="form-group">
            <button type="submit" class="btn btn-default" id="search">查询</button>
            </div>
        </form>
    </div>

    <%
        String isSuccess = (String)session.getAttribute("getSuccess");
        if(isSuccess!=null && isSuccess.equals("true")){
            StayInformation stayInformation = (StayInformation)session.getAttribute("stayInformation");
            String bed_id = String.valueOf(stayInformation.getBed_id());
            String inpatient_id = String.valueOf(stayInformation.getInpatient_id());
            String inpatient_name = stayInformation.getInpatient_name();
            String stay_id = String.valueOf(stayInformation.getStay_id());
            ArrayList<PrescriptionsInformation> prescriptionsInformations = (ArrayList<PrescriptionsInformation>)session.getAttribute("prescriptions");
            Integer prescription = prescriptionsInformations.size();
    %>
    <div class="container">
    <h4>病床号为<%=bed_id%>的病人信息</h4>
    </div>

    <div class="container">
        <div class="table-responsive">
            <table class="table table-striped table-bordered"
                   id="information"
            >
                <thead>
                <tr>
                    <th data-field="stayId" >住院号</th>
                    <th data-field="patientId" >病人编号</th>
                    <th data-field="name" >病人姓名</th>
                    <th data-field="prescription">处方数量</th>
                </tr>

                </thead>

                <tr>
                    <td><%=stay_id%></td>
                    <td><%=inpatient_id%></td>
                    <td><%=inpatient_name%></td>
                    <td><%=prescription%></td>
                </tr>
            </table>
        </div>
    </div>


    <div class="container">
        <div class="table-responsive">
            <table class="table table-striped table-bordered"
                   id="prescription"
            >
                <thead>
                <tr>
                    <th data-field="stayId" >序号</th>
                    <th data-field="patientId" >处方号</th>
                    <th data-field="name" >处方项目</th>
                    <th data-field="piece">单价</th>
                    <th data-field="count">数量</th>
                    <th data-field="total">总价</th>
                </tr>
                </thead>

                <%
                    for(int i=0;i<prescription;i++){
                        PrescriptionsInformation thisInfo = prescriptionsInformations.get(i);
                        String pId = String.valueOf(i+1);
                        String prescriptionId = String.valueOf(thisInfo.getPrescription_id());
                        int item = thisInfo.getItem_id();
                        String itemName = db.getItemName(item);
                        String itemPrice = db.getItemInformation(item).get("item_price");
                        String itemCount = String.valueOf(thisInfo.getItem_count());
                        String itemTotal = String.valueOf(thisInfo.getItem_total());
                        %>

                <tr>
                    <td><%=pId%></td>
                    <td><%=prescriptionId%></td>
                    <td><%=itemName%></td>
                    <td><%=itemPrice%></td>
                    <td><%=itemCount%></td>
                    <td><%=itemTotal%></td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
    </div>
    <%
        }else if(isSuccess!=null && isSuccess.equals("false")) {
    %>


    <div class="modal fade" tabindex="-1" role="dialog" id="info">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">错误</h4>
                </div>
                <div class="modal-body">
                    <p>查询错误，请确认您给出的床号无误。</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <%

        }else if(isSuccess!=null && isSuccess.equals("noInpatient")) {
    %>
    <div class="modal fade" tabindex="-1" role="dialog" id="info">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">错误</h4>
                </div>
                <div class="modal-body">
                    <p>经查询，此病床暂无病人，请重新查询。</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <%

        }

    %>

    <% session = request.getSession(); session.invalidate(); %>

</main>
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
    $(function(){
        $('#info').modal();
        $('#roomID').change(function(){
            var $bedId = $('#bedID');
            $bedId.empty();
            var selected = $(this).val();
            var roomCapability = $(this).find('[name='+selected+']').attr("id");
            for(var i = 0;i<roomCapability;i++){
                var option = $('<option value='+(i+1)+'>'+(i+1)+'</option>');
                $bedId.append(option);
            }
        })
    });
</script>


</body>
</html>
