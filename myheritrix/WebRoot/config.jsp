<%@include file="crawlhander.jsp" %>
<%@include file="head.jsp" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%--@ page language="java" import="java.util.*" pageEncoding="UTF-8"--%>
<%@page import = "java.net.*" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/background.css"/>
</head>
  <body>
   <table border="0" cellspacing="10" cellpadding="10">
    <tr>
    <font size=4 style=" font-weight:bold">配置任务：</font>
    </tr>
    <tr>
    <form action="action.jsp" method="get">
	  <table border="0" cellspacing="10" cellpadding="10">
	    <tr>  
	       <%-- <font size=6 style=" font-weight:bold"></font><br>  --%>
	       <td>线程数: </td><td><input type="text" name="thread" value="5"/>
	    </tr>
	    <tr>
           <td>相关度阈值: </td><td><input type="text" name="threshold" value="0.90"/></td> 
        </tr>
        <tr>    
	       <td>网页下载最大数目:   </td>
	       <td>
	          <input type="text" name="concount" value="1000"/>
	       </td>   
	    </tr>
	    <tr>
	    <% //String creat="创建";
	       //String urlcreat=URLEncoder.encode(creat,"UTF-8");
	    %>
	       <td><input type="submit" name="action" value="提交" /> </td>
	    </tr>
       </table>
     </form>
    </tr>
   </table> 
  </body>
</html>
