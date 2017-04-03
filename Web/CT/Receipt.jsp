<%@ page import="clinic.DBConc" %>
<%@ page import="java.util.*" %>
<%@ page import="JavaBean.Item" %>
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
    <title>收费</title>
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
        <a class="banner-brand visible-md visible-lg" href="../CT/CTHome.jsp"><img src="../img/logo.png" alt="Hospital" width="50" height="50"></a>
    </div><!-- /.container -->
    <nav role="navigation" class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand visible-xs visible-sm" href="../CT/CTHome.jsp"><img src="../img/logo.png" alt="Hospital'" width="30"></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">系统<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../LoginHome.jsp">退出登录</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">收费与退费<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../CT/Receipt.jsp">收费开票</a></li>
                            <li class="divider"></li>
                            <li><a href="../CT/Cancel.jsp">退费</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!--/.nav-collapse -->
        </div><!--/.container -->
    </nav>
</header>

<%DBConc dc = new DBConc();
String nowName = dc.getNowCT();
int receiptid = dc.GetNewId("receipt","receipt_id");
String nowId = dc.getNowCTID();
ArrayList<Item> items = dc.getAllItems();
%>


<main role="main">
    <div class="container">
        <p>当前收费员姓名： <%=nowName%></p>

        <form class="form-inline">
            <div class="form-group">
                <label for="DoctorID">开票医生</label>
                <select class="form-control" id="DoctorID" name="name">
                    <%
                        Map<String,String> ans = dc.getDoctor();
                        for(Map.Entry<String,String> entry : ans.entrySet()){
                            String name = entry.getValue();
                            String id = entry.getKey();
                    %><option value="<%=id%>"><%=name%></option><%
                    }
                %>
                </select>
            </div>
            <div class="form-group">
                <label for="payer">付款方</label>
                <input type="date" class="form-control required" id="payer" placeholder="张三" name="payer">
            </div>
            <div class="form-group">
                <label for="receipt_id">付款编号</label>
                <input type="date" class="form-control" id="receipt_id" readonly="readonly" name="receipt_id" value="<%=receiptid%>">
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

        <form class="form-inline">
            <div class="form-group">
                <label for="sumPrice">总计</label>
                <label id="sumPrice">0元</label>
            </div>
            <button type="button" class="btn btn-primary" id="submit">确定</button>
        </form>

    </div>
</main>

<div class="modal fade" tabindex="-1" role="dialog" id="back">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">找零计算</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="totalPriceBack" class="col-sm-2 control-label">总计</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="totalPriceBack" readonly="readonly">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="give" class="col-sm-2 control-label">实收</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="give" placeholder="0.00" name="give">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="change" class="col-sm-2 control-label">找零</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="change" readonly="readonly" name="change">
                        </div>
                        <div class="hidden" id="notEn">
                            <p class="text-danger">不足以支付费用，请检查。</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" class="btn btn-primary" id="done" >完成</button>
                        </div>
                    </div>
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



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


       $('#submit').click(function () {
           var today = new Date();
           var dd = today.getDate();
           var mm = today.getMonth()+1; //January is 0!
           var yyyy = today.getFullYear();

           if(dd<10) {
               dd='0'+dd
           }

           if(mm<10) {
               mm='0'+mm
           }

           today = yyyy+'-'+mm+'-'+dd;
            var receipt = {
                receipt_id : $('#receipt_id').val(),
                date : today,
                receipt_name :  $('#payer').val(),
                pays :[],
                doctor : $('#DoctorID').val(),
                ct : '<%=nowId%>'
            };


            for(var j=0;j<(i-1);j++){
                var tempItem = {
                  item_id : $('#selector'+(j+1)).val(),
                  amount : $('#amount'+(j+1)).val(),
                  total : $('#total'+(j+1)).val()
                };
                receipt.pays.push(tempItem);
            }
           $.ajax({
               url: "../AddPaysAndReceipts",
               data: {
                    receiptInfo: JSON.stringify(receipt)
               },
               method: 'post'
           }).success(function(response){
               if(Number(response)!=-1) {
                   $('#totalPriceBack').val(response);
                   $('#back').modal();
               }
           });
       });

        $('#give').bind('input',function(){
            var total = $('#totalPriceBack').val();
            var now = $(this).val();
            if(now-total > 0){
                $('#notEn').attr("class","hidden");
                $('#change').val(now-total);
            }
        });

        $('#done').on('click',function () {
            var total = $('#totalPriceBack').val();
            var now = $('#give').val();
            if(now-total < 0){
                $('#notEn').attr("class","show");
                return false;
            }else{
                $('#notEn').attr("class","hidden");
                $('#change').val(now-total);
                return true;
            }

        });



    });
</script>