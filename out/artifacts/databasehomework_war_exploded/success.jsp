<%--
  Created by IntelliJ IDEA.
  User: mouizumi
  Date: 2017/3/7
  Time: 20:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*,com.* ,javax.servlet.*"%>


<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>Success</title>
</head>
<body>
    登陆成功
    <br/><br>
    <h4>infomation</h4>
    <table>
    <tr>
        <td>id:</td>
        <td>power/name:</td>
    </tr>

<%
    String id = (String)session.getAttribute("id");
    String name = (String)session.getAttribute("name");

%>
<tr>
    <td>${id}</td>
    <td>${name}</td>
</tr>
    </table>
</body>
</html>
