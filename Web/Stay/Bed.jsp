<%--
  Created by IntelliJ IDEA.
  User: mouizumi
  Date: 2017/3/26
  Time: 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="clinic.DBConc" %>
<%@ page import="java.util.*" %>
<%@ page import="JavaBean.BedRoom" %>
<%@ page import="JavaBean.Doctor" %>
<%@ page import="JavaBean.Item" %>
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
        <div class="btn-toolbar" role="toolbar">
            <div class="btn-group" role="group">
                <botton type="button" class="btn btn-default btn-lg" data-toggle="modal" data-target="#add">
                    <span class="glyphicon glyphicon-plus"></span>
                </botton>


            </div>
        </div>
    </div>
    <div class="container">
        <div class="table-responsive">
            <table class="table table-striped table-bordered"
                   data-toggle="table"
                   data-sort-name="id" data-sort-order="asc"
                   data-pagination="true" data-pagination-loop="true"
                   data-page-size="10" data-page-list="[10,20,30,All]"
                   data-show-pagination-switch="true"
                   id="table"

            >
                <thead>
                <tr>

                    <th data-field="id" data-sortable="true">序号</th>
                    <th data-field="dt_id" data-sortable="true">房间号</th>
                    <th data-field="dt_name" >房间内床位数</th>
                    <th data-field="edit">编辑</th>
                    <th data-field="delete">删除</th>

                </tr>
                </thead>

                <%
                    DBConc dc = new DBConc();
                    ArrayList<BedRoom> rooms = dc.getAllBedNumberOfRoom();
                    int size = rooms.size();
                    for(int i=0;i<size;i++){
                        int id = i+1;
                        String room_id = rooms.get(i).getBed_room();
                        int room_number = rooms.get(i).getBed_room_count();
                %>
                <tr>
                    <td><%=id%></td>
                    <td><%=room_id%></td>
                    <td><%=room_number%></td>
                    <td><button type="button" data-id="<%=room_id%>" class="btn btn-default edit" id="<%=room_number%>">
                        <span class="glyphicon glyphicon-edit"></span>
                    </button> </td>
                    <td><button type="button" data-id="<%=room_id%>" class="btn btn-danger delete" id="<%=room_number%>">
                        <span class="glyphicon glyphicon-minus"></span>
                    </button> </td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
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
                <h4 class="modal-title">增加床位</h4>
            </div>
            <div class="modal-body">
                <form method="post" action="../AddNewStayRoomServlet" >
                    <div class="form-group">
                        <label for="Name">床位所在房间</label>
                        <input type="input" class="form-control" id="Name" placeholder="2001" name="roomId">
                    </div>
                    <div class="form-group">
                        <label for="price">房间内床位数量</label>
                        <div class="input-group">
                            <input type="input" class="form-control" id="price" placeholder="1" name="roomNumber">
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
    String show =(String)session.getAttribute("addStayRoomSuccess");
    if(show!=null && show.equals("true")){
        String id = (String)session.getAttribute("RoomId");
        String number = (String) session.getAttribute("RoomNumber");
%>
<div class="modal fade" tabindex="-1" role="dialog" id="open">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">添加房间成功</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="ids" class="col-sm-2 control-label">房间号</label>
                        <div class="col-sm-10">
                            <label class="form-control" id="ids"><%=id%></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="names" class="col-sm-2 control-label">所含床位数</label>
                        <div class="col-sm-10">
                            <label class="form-control" id="names"><%=number%></label>
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
}else if(show!=null && show.equals("false")){
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
                <p>请检查您的数据，所有数据均需为数字</p>
            </div>
        </div>
    </div>
</div>
    <%

    }else if(show!=null && show.equals("noZero")){
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
                <p>请输入大于零的房间容量</p>
            </div>
        </div>
    </div>
</div>
    <%}
%>

<!--EditForm-->
<form id="userForm" method="post" class="form-horizontal" style="display: none;" action="../UpdateStayRoomServlet">

    <div class="form-group">
        <label class="col-xs-3 control-label">房间号</label>
        <div class="col-xs-5">
            <input type="text" class="form-control" name="RoomId" readonly="readonly"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">房间所含床位数</label>
        <div class="col-xs-5">
            <input type="text" class="form-control" name="RoomNumber" />
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
    String showEdit =(String)session.getAttribute("UpdateStayRoomSuccess");
    if(showEdit!=null && showEdit.equals("true")){
        String room = (String)session.getAttribute("room");
        String newCapacity = (String)session.getAttribute("newCapacity");
        String oldCapacity = (String)session.getAttribute("oldCapacity");
        String notice = "房间号为<b>"+room+"</b>病房的床位容量已由<b>"+oldCapacity+"</b>张更改为<b>"+newCapacity+"</b>张";
%>
<div class="modal fade" tabindex="-1" role="dialog" id="open">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">修改成功</h4>
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
}else if(showEdit!=null && showEdit.equals("noChange")){
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
    }else if(showEdit!=null && showEdit.equals("CanNotReduce")){
        String notice = "无法删减容量，因为本房间靠后的几张床位已经有人入住";
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
                <p><%=notice%></p>
            </div>
        </div>
    </div>
</div>
    <%
    }
%>


<!--DeleteConfirm-->

<form id="DeleteForm" method="post" class="form-horizontal" style="display: none;" action="../DeleteStayRoomServlet">
    <div class="form-group">
        <label class="col-xs-3 control-label">房间号</label>
        <div class="col-xs-5">
            <input type="text" class="form-control" name="RoomId" readonly="readonly"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">房间所含床位数</label>
        <div class="col-xs-5">
            <input type="text" class="form-control" name="RoomNumber" />
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
    Boolean showDelete =(Boolean)session.getAttribute("DeleteStayRoomSuccess");
    if(showDelete!=null && showDelete){
        String oldName = (String)session.getAttribute("DeleteRoomId");
        String notice = "您已经删除房间号为<b>"+oldName+"</b>的病房<br>";

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
    session.setAttribute("DeleteStayRoomSuccess","");
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
                <p>您需要删除的房间已经住有病人，在出院之前，您无法完成删除操作。</p>
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
                RoomNumber:{
                    validators:{
                        notEmpty:{
                            message:'房间容量不能为空'
                        }
                    }
                },
                RoomId:{
                    validators:{
                        notEmpty:{
                            message:'房间号不能为空'
                        }
                    }
                },
                roomNumber:{
                    validators:{
                        notEmpty:{
                            message:'房间容量不能为空'
                        }
                    }
                },
                roomId:{
                    validators:{
                        notEmpty:{
                            message:'房间号不能为空'
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
            var room_number = $(this).attr('id');
            //alert("get")


            $('[name=RoomId]').val(item_id).end();
            $('[name=RoomNumber]').val(room_number).end();
            //alert(response.id);
            bootbox
                .dialog({
                    title: '编辑房间容量信息',
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
</script>

<script>
    $(document).ready(function(){
        $('#table').on('click','.delete',function(){
            var item_id = $(this).attr('data-id');
            var room_number = $(this).attr('id');
            //alert("get")


            $('[name=RoomId]').val(item_id).end();
            $('[name=RoomNumber]').val(room_number).end();
            bootbox
                .dialog({
                    title: '确认删除病房',
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
</script>
</body>
</html>