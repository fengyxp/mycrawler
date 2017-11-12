<%@include file="head.jsp" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--@ page import="java.util.*"--%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/background.css"/>

</head>
  <body  >
     
     
	<table border="0" cellspacing="10" cellpadding="10">
	<tr>
	   <td> 
	      <a href="action.jsp?action=start"><font size=5 style=" font-weight:bold">开始采集</font></a><br><br>
	      <a href="action.jsp?action=stop"><font size=5 style=" font-weight:bold">停止采集</font></a><br><br>
	      <a href="action.jsp?action=open"><font size=5 style=" font-weight:bold">数据显示</font></a><br><br>
       </td>
       <td>
       </td>
      <%--<td></td><td></td>--%> 
	   <td> 
	      <%@include file="crawlstatus.jsp" %>
	   </td>  
	 </tr>
	 <tr></tr>
	 <tr>
	    <%-- <input type="button" name="refresh" value="刷新" onclick="javascript:window.location='main.jsp';" />--%>
	   
	 </tr>
    </table>
     <a href="action.jsp?action=refresh"><font size=3 style=" font-weight:bold">刷新</font></a><br><br>
    
  </body>
</html>
