<%--
  Created by IntelliJ IDEA.
  User: mouizumi
  Date: 2017/3/31
  Time: 10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="clinic.DBConc" %>
<%@ page import="java.util.*" %>
<%@ page import="JavaBean.Item" %>

<%@ page contentType="text/html;charset=utf-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>开立处方</title>
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
</header>

    <%DBConc dc = new DBConc();
String nowName = dc.getNowResident().get(0);
String nowId = dc.getNowResident().get(1);
int prescriptionId = dc.GetNewPrescriptionId();
ArrayList<Item> items = dc.getAllItems();
%>


<main role="main">
    <div class="container">
        <p>当前医生姓名： <%=nowName%></p>

        <form class="form-inline">
            <div class="form-group">
                <label for="InpatientID">选择开立的住院病人</label>
                <select class="form-control" id="InpatientID" name="inpatientName">
                    <%
                        Map<String,String> ans = dc.getAllInpatient();
                        for(Map.Entry<String,String> entry : ans.entrySet()){
                            String name = entry.getValue();
                            String id = entry.getKey();
                    %><option value="<%=id%>"><%=name%>(住院号为：<%=id%>)</option><%
                    }
                %>
                </select>
            </div>
            <div class="form-group">
                <label for="prescription_id">处方编号</label>
                <input type="date" class="form-control" id="prescription_id" readonly="readonly" name="receipt_id" value="<%=prescriptionId%>">
            </div>
        </form>
        <br>

        <div class="btn-toolbar" role="toolbar">
            <div class="btn-group" role="group">
                <botton type="button" class="btn btn-default btn-lg" id="addRow">
                    <span class="glyphicon glyphicon-plus"></span>
                </botton>
            </div>
        </div>
        <table class="table table-striped table-bordered" data-toggle="table"
               data-sort-name="id" data-sort-order="asc"
               id="table"
        >
            <thead>
            <tr>
                <th data-field="id">序号</th>
                <th data-field="dt_id">项目名称</th>
                <th data-field="dt_room">数量</th>
                <th data-field="dt_name">单价</th>
                <th data-field="degree">总价</th>
                <th data-field="delete">删除</th>
            </tr>
            </thead>
            <tr class="item" id="pays1">
            </tr>
        </table>
        <br>

        <form class="form">
            <div class="form-group">
                <label for="sumPrice">总计</label>
                <label id="sumPrice">0元</label>
            </div>
            <div class="form-group">
            <button type="button" class="btn btn-primary" id="submit">确定</button>
            </div>
        </form>
    </div>
</main>

<div class="modal fade" tabindex="-1" role="dialog" id="info">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">添加成功</h4>
            </div>
            <div class="modal-body">
                <p>成功添加处方</p>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary" data-dismiss="modal" id="closed">Close</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" tabindex="-1" role="dialog" id="false">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">添加失败</h4>
            </div>
            <div class="modal-body">
                <p>处方添加失败</p>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary" data-dismiss="modal" id="close">Close</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

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
    var items =[{itemId:'-1', itemName: '选择诊疗项目', itemPrice: 0}];
    <%for(int i=0;i<items.size();i++){
        %>
    items.push({
        itemId : '<%=items.get(i).getItem_id()%>',
        itemName : '<%=items.get(i).getItem_name()%>',
        itemPrice: <%=items.get(i).getPrice()%>
    });
    <%
    }
    %>
</script>

<script>
    $(function () {
        var i = 1;
        var option="";
        var item;
        function setOption(){
            option="";
            for(var i=0;i<items.length;i++){
                item = items[i];
                option = option + '<option value= \''+item.itemId+'\'>'+item.itemName+'</option>';

            }
        }

        function getId(name){
            var id="";
            for(var i=0;i<name.length;i++){
                if(name[i]>='0' && name[i]<='9'){
                    id+=name[i];
                }
            }
            return id;
        }

        $('#addRow').click(function(){
            setOption();
            $('#pays'+i).html(
                '<td id="paysId'+i+'">'+i+'</td>' +
                '<td><select id="selector'+i+'">'+option+'</select></td>' +
                '<td><input type="text" id="amount'+i+'" name="amount"></td> '+
                '<td><input type="text" readonly="readonly" id="price'+i+'"></td>' +
                '<td><input type="text" readonly="readonly" id="total'+i+'"></td>' +
                '<td><button type="button" data-id="1" class="btn btn-default delete" id="delete'+i+'"> <span class="glyphicon glyphicon-minus"></span> </button> </td>'
            );
            $('#table').append('<tr class="item" id="pays'+(i+1)+'"></tr>');
            i++;
        });
        var price;
        var totalPrice = 0;
        $("#table").on('change',"select",function(){

            for(var j=0;j<items.length;j++){
                if(items[j].itemId == $(this).val()){
                    price = items[j].itemPrice;
                    break;
                }
            }
            var nameChanged = $(this).attr("id");
            var num = getId(nameChanged); //GET ID
            $('#price'+num).val(price);
            var amount = $('#amount'+num).val();
            $('#total'+num).val(price*amount);
            var totalArray = $('[id^=total]');
            totalPrice = 0;
            for(var p = 0;p<totalArray.length;p++){
                var temp =totalArray[p];
                totalPrice += Number(temp.value);
            }
            $('#sumPrice').html(totalPrice + "元");
        });

        $("#table").on('change',"[id^=amount]",function () {
            var nameChanged = $(this).attr("id");
            var num = getId(nameChanged);
            var amount = $(this).val();
            $('#total'+num).val(price*amount);
            var totalArray = $('[id^=total]');
            totalPrice = 0;
            for(var p = 0;p<totalArray.length;p++){
                var temp =totalArray[p];
                totalPrice += Number(temp.value);
            }
            $('#sumPrice').html(totalPrice + "元");
        });

        $('#table').on('click','[id^=delete]',function () {
            var nameChanged = $(this).attr("id");
            var num = getId(nameChanged);
            var n = Number(num);
            for(var j=n;j<i-1;j++){
                //$('#pays'+j).html('');
                var selectone = $('#selector'+(j+1)).val();
                var priceone = $('#price'+(j+1)).val();
                var totalone = $('#total'+(j+1)).val();
                var amountone = $('#amount'+(j+1)).val();

                $('#selector'+(j+1)).attr("id","selector"+j);
                $('#price'+(j+1)).attr("id","price"+j);
                $('#pays'+(j+1)).children("[id^=paysId]").attr("id","paysId"+j);
                $('#pays'+(j+1)).children("[id^=paysId]").html(j);
                $('#total'+(j+1)).attr("id","total"+j);
                $('#amount'+(j+1)).attr("id","amount"+j);
                $('#delete'+(j+1)).attr("id","delete"+j);
                var nextHtml = $('#pays'+(j+1)).html();
                $('#pays'+(j+1)).html('');
                $('#pays'+j).html(nextHtml);
                $('#selector'+(j)).val(selectone);
                $('#price'+(j)).val(priceone);
                $('#total'+(j)).val(totalone);
                $('#amount'+(j)).val(amountone);

            }
            $('#pays'+i).remove();
            $('#pays'+(i-1)).html('');
            i--;
            var totalArray = $('[id^=total]');
            totalPrice = 0;
            for(var p = 0;p<totalArray.length;p++){
                var temp =totalArray[p];
                totalPrice += Number(temp.value);
            }
            $('#sumPrice').html(totalPrice + "元");
        });

        $('#close').on('click',function () {
            location.reload();
        });

        $('#closed').on('click',function () {
            location.reload();
        });


        $('#submit').click(function () {

            var prescription = {
                pays :[]
            };


            for(var j=0;j<(i-1);j++){
                var tempItem = {
                    prescription_id : <%=prescriptionId%>,
                    item_id : $('#selector'+(j+1)).val(),
                    resident_id : <%=nowId%>,
                    stay_id : $('#InpatientID').val(),
                    item_count: $('#amount'+(j+1)).val(),
                    item_total : $('#total'+(j+1)).val()
                };
                prescription.pays.push(tempItem);
            }
            $.ajax({
                url: "../AddNewPrescription",
                data: {
                    prescriptionInfo: JSON.stringify(prescription)
                },
                method: 'post'
            }).success(function(response){
                if(response === "true") {
                    $('#info').modal();
                }else{
                    $('#false').modal();
                }
            });
        });
    });
</script>