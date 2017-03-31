<%@ page import="clinic.DBConc" %>
<%@ page import="java.util.*" %>
<%@ page import="JavaBean.CTReceipt" %>
<%@ page import="JavaBean.Doctor" %>
<%@ page import="JavaBean.Item" %><%--
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
    <title>管理药品和检查数据</title>
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
                <a class="navbar-brand visible-xs visible-sm" href="../Admin/AdminHome.jsp"><img src="../img/logo.png" alt="Hospital" width="30"></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><strong>系统</strong><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../Admin/registerAdmin.jsp">创建新管理员账户</a></li>
                            <li class="divider"></li>
                            <li><a href="../Admin/register.jsp">创建新收费员账户</a></li>
                            <li class="divider"></li>
                            <li><a href="../LoginHome.jsp">退出登录</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><strong>管理基础数据</strong><b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../Data/Room.jsp">科室数据</a></li>
                            <li class="divider"></li>
                            <li><a href="../Data/Doctor.jsp">医生数据</a></li>
                            <li class="divider"></li>
                            <li><a href="../Data/Item.jsp">药品与检查数据</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><strong>生成收费报表</strong> <b class="caret"></b></a>
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
        <div class="btn-toolbar" role="toolbar">
            <div class="btn-group" role="group">
                <botton type="button" class="btn btn-default btn-lg" data-toggle="modal" data-target="#add">
                    <span class="glyphicon glyphicon-plus"></span>
                </botton>


            </div>
        </div>
        <table class="table table-striped table-bordered" data-toggle="table"
               data-sort-name="id" data-sort-order="asc"
               data-pagination="true" data-pagination-loop="true" data-page-size="10" data-page-list="[10,20,30,All]"
               data-search="true" data-show-pagination-switch="true" id="table"
        >
            <thead>
            <tr>

                <th data-field="id" data-sortable="true">序号</th>
                <th data-field="dt_id" data-sortable="true">药品/检查编号</th>
                <th data-field="dt_name" data-sortable="true">药品/检查名称</th>
                <th data-field="dt_room" data-sortable="true">价格</th>
                <th data-field="edit">编辑</th>
                <th data-field="delete">删除</th>
            </thead>
            </tr>
            <%
                DBConc dc = new DBConc();
                ArrayList<Item> items = dc.getAllItems();
                for(int i=0;i<items.size();i++){
                    String id = String.valueOf(i+1);
                    String item_id = String.valueOf(items.get(i).getItem_id());
                    String item_name = items.get(i).getItem_name();
                    String price = String.valueOf(items.get(i).getPrice());
            %>
            <tr>
                <td><%=id%></td>
                <td><%=item_id%></td>
                <td><%=item_name%></td>
                <td><%=price%></td>
                <td><button type="button" data-id="<%=item_id%>" class="btn btn-default edit">
                    <span class="glyphicon glyphicon-edit"></span>
                </button> </td>
                <td><button type="button" data-id="<%=item_id%>" class="btn btn-danger delete">
                    <span class="glyphicon glyphicon-minus"></span>
                </button> </td>
            </tr>
            <%
                }
            %>
        </table>
    </div>



</main>
<!--Add-->
<div class="modal fade" id="add" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">增加药品/项目</h4>
            </div>
            <div class="modal-body">
                <form method="post" action="../AddNewItemServlet" >
                    <div class="form-group">
                        <%
                            int new_id = dc.GetNewId("item","item_id");
                        %>
                        <label for="id">药品/检查编号</label>
                        <input type="text" value=<%=new_id%> class="form-control" id="id" readonly="readonly" name="id">
                    </div>
                    <div class="form-group">
                        <label for="Name">药品/检查名称</label>
                        <input type="input" class="form-control" id="Name" placeholder="药品A" name="name">
                    </div>
                    <div class="form-group">
                        <label for="price">价格</label>
                        <div class="input-group">
                            <span class="input-group-addon">￥</span>
                        <input type="input" class="form-control" id="price" placeholder="1.00" name="price">
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary">确认添加</button>
                </form>
            </div>
        </div>
    </div>
</div>



<!--AddSuccessShow-->
<%
    Boolean show =(Boolean)session.getAttribute("addItemSuccess");
    if(show!=null && show){
        String id = (String)session.getAttribute("item_id");
        String name = (String) session.getAttribute("item_name");
        String price = (String) session.getAttribute("item_price");
        session.setAttribute("item_id","");
        session.setAttribute("item_name","");
        session.setAttribute("item_price","");
        session.setAttribute("addItemSuccess","");
%>
<div class="modal fade" tabindex="-1" role="dialog" id="open">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">添加记录成功</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="ids" class="col-sm-2 control-label">药品/检查编号</label>
                        <div class="col-sm-10">
                            <label class="form-control" id="ids"><%=id%></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="names" class="col-sm-2 control-label">药品/检查名称</label>
                        <div class="col-sm-10">
                            <label class="form-control" id="names"><%=name%></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="rooms" class="col-sm-2 control-label">价格</label>
                        <div class="col-sm-10">
                            <label class="form-control" id="rooms"><%=price%></label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" data-dismiss="modal">确认</button>
            </div>
        </div>
    </div>
</div>
<%
}else if(show!=null && !show){
    session.setAttribute("addItemSuccess","");
%>
<div class="modal fade" tabindex="-1" role="dialog" id="open">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">添加记录失败</h4>
            </div>
            <div class="modal-body">
                <p>请检查您所提供的数据。</p>
            </div>
        </div>
    </div>
</div>
<%

    }
%>

<!--EditForm-->
<form id="userForm" method="post" class="form-horizontal" style="display: none;" action="../UpdateItemInformationServlet">
    <div class="form-group">
        <label class="col-xs-3 control-label">药品/检查编号</label>
        <div class="col-xs-3">
            <input type="text" class="form-control" name="itemFormId" readonly="readonly" />
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">药品/检查名称</label>
        <div class="col-xs-5">
            <input type="text" class="form-control" name="itemFormName" />
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">价格</label>
        <div class="col-xs-5">
            <input type="text" class="form-control" name="itemFormPrice" />
        </div>
    </div>

    <div class="form-group">
        <div class="col-xs-5 col-xs-offset-3">
            <button type="submit" class="btn btn-primary">保存</button>
        </div>
    </div>
</form>


<!--EditSuccessShow-->
<%
    String showEdit =(String)session.getAttribute("editItemSuccess");
    if(showEdit!=null && showEdit.equals("true")){
        Map<String,String> newthings = (HashMap<String,String>)session.getAttribute("item_changed");
        Map<String,String> oldthings = (HashMap<String,String>)session.getAttribute("item_old");
        StringBuffer tmp = new StringBuffer();
        tmp.append("编号为"+newthings.get("item_id")+"的药品/检查信息已更改如下：");
        for(Map.Entry<String,String> entry : newthings.entrySet()){
            if(entry.getKey().equals("price")){
                tmp.append("<br>价格由<b>"+oldthings.get(entry.getKey())+"</b>修改为<b>"+entry.getValue()+"</b>");
            }
            if(entry.getKey().equals("item_name")){
                tmp.append("<br>药品/检查名称由<b>"+oldthings.get("item_name")+"</b>修改为<b>"+entry.getValue()+"</b>");
            }
        }
        String notice = tmp.toString();
        session.setAttribute("item_changed","");
        session.setAttribute("item_old","");
        session.setAttribute("editItemSuccess","");
%>
<div class="modal fade" tabindex="-1" role="dialog" id="open">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">修改记录成功</h4>
            </div>
            <div class="modal-body">
                <p><%=notice%></p>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" data-dismiss="modal">确认</button>
            </div>
        </div>
    </div>
</div>
<%
}else if(showEdit!=null && showEdit.equals("no")){
    session.setAttribute("editItemSuccess","");
%>
<div class="modal fade" tabindex="-1" role="dialog" id="open">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">无记录修改</h4>
            </div>
            <div class="modal-body">
                <p>您没有修改任何数据。</p>
            </div>
        </div>
    </div>
</div>
<%
}else if(showEdit!=null && showEdit.equals("false")){
    session.setAttribute("editItemSuccess","");
%>
<div class="modal fade" tabindex="-1" role="dialog" id="open">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">修改记录失败</h4>
            </div>
            <div class="modal-body">
                <p>请检查您输入数据的格式等问题。</p>
            </div>
        </div>
    </div>
</div>
<%
    }
%>


<!--DeleteConfirm-->

<form id="DeleteForm" method="post" class="form-horizontal" style="display: none;" action="../DeleteItemServlet">
    <div class="form-group">
        <label class="col-xs-3 control-label">药品/检查编号</label>
        <div class="col-xs-3">
            <input type="text" class="form-control" name="deleteFormItemId" readonly="readonly" />
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">药品/检查名称</label>
        <div class="col-xs-5">
            <input type="text" class="form-control" name="deleteFormItemName" readonly="readonly"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">价格</label>
        <div class="col-xs-5">
            <input type="text" class="form-control" name="deleteFormItemPrice" readonly="readonly"/>
        </div>
    </div>

    <div class="form-group">
        <div class="col-xs-5 col-xs-offset-3">
            <button type="submit" class="btn btn-danger">确认</button>
        </div>
    </div>
</form>


<!--DeleteSuccessShow-->
<%
    Boolean showDelete =(Boolean)session.getAttribute("deleteItemSuccess");
    if(showDelete!=null && showDelete){
        String oldName = (String)session.getAttribute("deleteItemName");
        String notice = "您已经删除<b>"+oldName+"</b>的信息<br>";

        session.setAttribute("deleteItemName","");
        session.setAttribute("deleteItemSuccess","");
%>
<div class="modal fade" tabindex="-1" role="dialog" id="open">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">删除记录成功</h4>
            </div>
            <div class="modal-body">
                <p><%=notice%></p>
            </div>
            <div class="modal-footer">
                <button class="btn btn-primary" data-dismiss="modal">确认</button>
            </div>
        </div>
    </div>
</div>
<%
}else if(showDelete!=null && !showDelete){
    session.setAttribute("deleteItemSuccess","");
%>
<div class="modal fade" tabindex="-1" role="dialog" id="open">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">删除记录失败</h4>
            </div>
            <div class="modal-body">
                <p>您需要删除的药品/检查由于已经收过费，在退费之前，您无法完成删除操作。</p>
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
    $(function(){
        $('#open').modal({
            show:true,
            backdrop:true
        })
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
                name:{
                    validators:{
                        notEmpty:{
                            message:'药品/检查名称不能为空'
                        }
                    }
                },
                id:{
                    validators:{
                        notEmpty:{
                            message:'药品/检查编号不能为空'
                        }
                    }
                },
                price:{
                    validators:{
                        notEmpty:{
                            message:'价格不能为空'
                        }
                    }
                },
                itemFormName:{
                    validators:{
                        notEmpty:{
                            message:'药品/检查名称不能为空'
                        }
                    }
                },
                itemFormId:{
                    validators:{
                        notEmpty:{
                            message:'药品/检查编号不能为空'
                        }
                    }
                },
                itemFormPrice:{
                    validators:{
                        notEmpty:{
                            message:'价格不能为空'
                        }
                    }
                }
            }
        });
    });
</script>
<script>
    $(document).ready(function(){
        $('#table').on('click','.edit',function(){
            var item_id = $(this).attr('data-id');
            //alert("get")
            $.ajax({
                url:'../ConsultItemInformationServlet',
                data:{
                    id:item_id
                },
                method:'POST'
            }).success(function(response) {

                $('[name=itemFormId]').val(response.item_id).end();
                $('[name=itemFormName]').val(response.item_name).end();
                $('[name=itemFormPrice]').val(response.item_price).end();
                //alert(response.id);
                bootbox
                    .dialog({
                        title: '编辑药品/检查信息',
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
        });
    });
</script>

<script>
    $(document).ready(function(){
        $('#table').on('click','.delete',function(){
            var item_id = $(this).attr('data-id');
            //alert("get")
            $.ajax({
                url:'../ConsultItemInformationServlet',
                data:{
                    id:item_id
                },
                method:'POST'
            }).success(function(response) {

                $('[name=deleteFormItemId]').val(response.item_id).end();
                $('[name=deleteFormItemName]').val(response.item_name).end();
                $('[name=deleteFormItemPrice]').val(response.item_price).end();
                //alert(response.id);
                bootbox
                    .dialog({
                        title: '确认删除药品/检查信息',
                        message: $('#DeleteForm'),
                        show: false
                    })
                    .on('shown.bs.modal', function () {
                        $('#DeleteForm')
                            .show();                      // Show the login form
                        // Reset form
                    })
                    .on('hide.bs.modal', function (e) {
                        // Bootbox will remove the modal (including the body which contains the login form)
                        // after hiding the modal
                        // Therefor, we need to backup the form
                        $('#DeleteForm').hide().appendTo('body');
                    })
                    .modal('show');
            });
        });
    });
</script>
</body>
</html>