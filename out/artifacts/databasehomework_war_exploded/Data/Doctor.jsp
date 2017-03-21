<%@ page import="clinic.login.DBConc" %>
<%@ page import="java.util.*" %>
<%@ page import="JavaBean.CTReceipt" %>
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
    <title>管理医生数据</title>
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
                <th data-field="dt_id" data-sortable="true">医生工号</th>
                <th data-field="dt_name" data-sortable="true">医生姓名</th>
                <th data-field="dt_room" data-sortable="true">科室</th>
                <th data-field="degree" data-sortable="true">级别</th>
                <th data-field="edit">编辑</th>
                <th data-field="delete">删除</th>
            </thead>
            </tr>
                <%
                    DBConc dc = new DBConc();
                    ArrayList<Doctor> doctors = dc.getAllDoctor();
                    for(int i=0;i<doctors.size();i++){
                        String id = String.valueOf(i+1);
                        String dc_id = String.valueOf(doctors.get(i).getDoctor_id());
                        String dc_name = doctors.get(i).getDoctor_name();
                        String room_name = dc.getRoomName(doctors.get(i).getRoom_id());
                        String degree = doctors.get(i).getDegree();
                %>
                    <tr>
                        <td><%=id%></td>
                        <td><%=dc_id%></td>
                        <td><%=dc_name%></td>
                        <td><%=room_name%></td>
                        <td><%=degree%></td>
                        <td><button type="button" data-id="<%=dc_id%>" class="btn btn-default edit">
                            <span class="glyphicon glyphicon-edit"></span>
                        </button> </td>
                        <td><button type="button" data-id="<%=dc_id%>" class="btn btn-default delete">
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
                <h4 class="modal-title">增加医生</h4>
            </div>
            <div class="modal-body">
                <form method="post" action="../AddNewDoctorServlet" >
                    <div class="form-group">
                        <%
                            int new_id = dc.GetNewId("doctor","doctor_id");
                        %>
                        <label for="id">医生工号</label>
                        <input type="text" value=<%=new_id%> class="form-control" id="id" disabled name="id">
                    </div>
                    <div class="form-group">
                        <label for="Name">医生姓名</label>
                        <input type="input" class="form-control" id="Name" placeholder="张三" name="name">
                    </div>
                    <div class="form-group">
                        <label for="room">所属科室</label>
                        <select class="form-control" id="room" name="room">
                            <%DBConc db = new DBConc();
                                Map<String,String> ans = db.getRoom();
                                for(Map.Entry<String,String> entry:ans.entrySet()){
                                    String name = entry.getValue();
                                    String id = entry.getKey();
                            %><option value="<%=id%>"><%=name%></option><%
                            }
                        %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="degree">医生级别</label>
                        <select class="form-control" id="degree" name="degree">
                            <option value="主任">主任</option>
                            <option value="普通">普通</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">确认添加</button>
                </form>
            </div>
        </div>
    </div>
</div>



<!--AddSuccessShow-->
<%
    Boolean show =(Boolean)session.getAttribute("showAddSuccess");
    if(show!=null && show){
        String id =String.valueOf ((int) session.getAttribute("doctor_id"));
        String name = (String) session.getAttribute("doctor_name");
        String room = String.valueOf ((int) session.getAttribute("doctor_room"));
        String degree = (String) session.getAttribute("doctor_degree");

        session.setAttribute("doctor_id","");
        session.setAttribute("doctor_name","");
        session.setAttribute("doctor_room","");
        session.setAttribute("doctor_degree","");
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
                        <label for="ids" class="col-sm-2 control-label">医生工号</label>
                        <div class="col-sm-10">
                            <label class="form-control" id="ids"><%=id%></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="names" class="col-sm-2 control-label">医生姓名</label>
                        <div class="col-sm-10">
                            <label class="form-control" id="names"><%=name%></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="rooms" class="col-sm-2 control-label">所属科室</label>
                        <div class="col-sm-10">
                            <label class="form-control" id="rooms"><%=room%></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="degrees" class="col-sm-2 control-label">医生级别</label>
                        <div class="col-sm-10">
                            <label class="form-control" id="degrees"><%=degree%></label>
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
<form id="userForm" method="post" class="form-horizontal" style="display: none;" action="../UpdateDoctorInformationServlet">
    <div class="form-group">
        <label class="col-xs-3 control-label">医生工号</label>
        <div class="col-xs-3">
            <input type="text" class="form-control" name="formid" readonly="readonly" />
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">医生姓名</label>
        <div class="col-xs-5">
            <input type="text" class="form-control" name="formname" />
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">所属科室</label>
        <div class="col-xs-5">
            <select class="form-control" name="formroom">
                <%
                    ans = db.getRoom();
                    for(Map.Entry<String,String> entry:ans.entrySet()){
                        String name = entry.getValue();
                        String id = entry.getKey();
                %><option value="<%=id%>"><%=name%></option><%
                }
            %>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">医生级别</label>
        <div class="col-xs-5">
            <select class="form-control" name="formdegree">
                <option value="主任">主任</option>
                <option value="普通">普通</option>
            </select>
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
    String showEdit =(String)session.getAttribute("showEditSuccess");
    if(showEdit!=null && showEdit.equals("true")){
        Map<String,String> newthings = (HashMap<String,String>)session.getAttribute("changed");
        Map<String,String> oldthings = (HashMap<String,String>)session.getAttribute("old");
        StringBuffer tmp = new StringBuffer();
        tmp.append("工号为"+newthings.get("doctor_id")+"的医生信息已更改如下：");
        for(Map.Entry<String,String> entry : newthings.entrySet()){
            if(entry.getKey().equals("degree")){
                tmp.append("<br>医生等级由<b>"+oldthings.get(entry.getKey())+"</b>修改为<b>"+entry.getValue()+"</b>");
            }
            if(entry.getKey().equals("room_id")){
                String oldRoom = dc.getRoomName(Integer.parseInt(oldthings.get(entry.getKey())));
                String newRoom = dc.getRoomName(Integer.parseInt(entry.getValue()));
                tmp.append("<br>所属科室由<b>"+oldRoom+"</b>修改为<b>"+newRoom+"</b>");
            }
            if(entry.getKey().equals("doctor_name")){
                tmp.append("<br>医生姓名由<b>"+oldthings.get(entry.getKey())+"</b>修改为<b>"+entry.getValue()+"</b>");
            }
        }
        String notice = tmp.toString();
        session.setAttribute("changed","");
        session.setAttribute("old","");
        session.setAttribute("showEditSuccess","");
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
    session.setAttribute("showEditSuccess","");
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
        session.setAttribute("showEditSuccess","");
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

<form id="DeleteForm" method="post" class="form-horizontal" style="display: none;" action="../DeleteDoctorServlet">
    <div class="form-group">
        <label class="col-xs-3 control-label">医生工号</label>
        <div class="col-xs-3">
            <input type="text" class="form-control" name="deformid" readonly="readonly" />
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">医生姓名</label>
        <div class="col-xs-5">
            <input type="text" class="form-control" name="deformname" readonly="readonly"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">所属科室</label>
        <div class="col-xs-5">
            <input type="text" class="form-control" name="deformroom" readonly="readonly"/>
        </div>
    </div>

    <div class="form-group">
        <label class="col-xs-3 control-label">医生级别</label>
        <div class="col-xs-5">
            <input type="text" class="form-control" name="deformdegree" readonly="readonly"/>
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
    Boolean showDelete =(Boolean)session.getAttribute("showDeleteSuccess");
    if(showDelete!=null && showDelete){
        String oldName = (String)session.getAttribute("deleteName");
        String notice = "您已经删除<b>"+oldName+"</b>医生的信息<br>";

        session.setAttribute("deleteName","");
        session.setAttribute("showDeleteSuccess","");
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
    session.setAttribute("showDeleteSuccess","");
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
                <p>您需要删除的医生由于已经收过费，在退费之前，您无法完成删除操作。</p>
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
                id:{
                    validators:{
                        notEmpty:{
                            message:'医生工号不能为空'
                        }
                    }
                },
                name:{
                    validators:{
                        notEmpty:{
                            message:'医生姓名不能为空'
                        }
                    }
                },
                formid:{
                    validators:{
                        notEmpty:{
                            message: '医生工号不能为空'
                        }
                    }
                },
                formname:{
                    validators:{
                        notEmpty:{
                            message:'医生姓名不能为空'
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
        var dc_id = $(this).attr('data-id');
        //alert("get")
        $.ajax({
            url:'../ConsultDoctorInformationServlet',
            data:{
                id:dc_id
            },
            method:'POST'
        }).success(function(response) {

                $('[name=formid]').val(response.id).end();
                $('[name=formroom]').val(response.room).end();
                $('[name=formdegree]').val(response.degree).end();
                $('[name=formname]').val(response.name).end();
            //alert(response.id);
            bootbox
                .dialog({
                    title: '编辑医生信息',
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
            var dc_id = $(this).attr('data-id');
            //alert("get")
            $.ajax({
                url:'../ConsultDoctorInformationServlet',
                data:{
                    id:dc_id
                },
                method:'POST'
            }).success(function(response) {

                $('[name=deformid]').val(response.id).end();
                $('[name=deformroom]').val(response.room).end();
                $('[name=deformdegree]').val(response.degree).end();
                $('[name=deformname]').val(response.name).end();
                //alert(response.id);
                bootbox
                    .dialog({
                        title: '确认删除医生信息',
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