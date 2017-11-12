<%--@include file="var.jsp" --%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<html>
  <body>
    <div align="center"><font size=8 >欢迎使用数据采集系统</font></div><br><br><br>
    <%--<a href=”new.jsp”>跳转</a> --%> 
    <%-- <input type = "button" value = "登陆33" onclick = "window.location.href = 'index.jsp'">--%>
	<%-- <%@include file="index.jsp" %>--%>
	<table border="0" cellspacing="10" cellpadding="10">
	<tr>
	   <td>
	     <a href="main.jsp"><font size=6 style=" font-weight:bold">数据采集</font></a>
	   </td>
	   <td>
	     <a href="job.jsp"><font size=6 style=" font-weight:bold">任务管理</font></a>
	   </td>
	   <td>
	     <a href="config.jsp"><font size=6 style=" font-weight:bold">配置管理</font></a>
       </td>
	 </tr>
    </table>
  </body>
</html>
