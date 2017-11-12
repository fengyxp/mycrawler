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
    <font size=4 style=" font-weight:bold">创建任务：</font>
    </tr>
    <tr>
    <form action="action.jsp" method="get">
	  <table border="0" cellspacing="10" cellpadding="10">
	    <tr>  
	       <%-- <font size=6 style=" font-weight:bold"></font><br>  --%>
	       <td>主题: </td><td><input type="text" name="theme" value="食品安全"/>
	    </tr>
	    <tr>
           <td>网址: </td><td><input type="text" name="url" value="http://www.zccw.info/"/></td> 
        </tr>
        <tr>    
	       <td>网页下载最大数目:   </td>
	       <td>
	          <input type="text" name="count" value="1000"/>
	       </td>   
	    </tr>
	    <tr>
	       <td>关键词:</td> <td><input type="text" size="60" name="keywords" value="产品不合格|不达标|添加剂|造假|无证经营|安全|检疫不合格"/></td>
	    </tr>
	    <tr>
	    <% //String creat="创建";
	       //String urlcreat=URLEncoder.encode(creat,"UTF-8");
	    %>
	       <td><input type="submit" name="action" value="创建" /> </td>
	    </tr>
       </table>
     </form>
    </tr>
    <tr>
      <%--<font size=4 style=" font-weight:bold">已完成任务：</font>--%>
    </tr>
   </table> 
  </body>
</html>
