<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import = "java.net.*" %>
<%@ page import="java.io.*"%>
<%@page import="search.openfile" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//String sAction = request.getParameter("action");
//String s = new String(sAction.getBytes("iso-8859-1"),"utf-8");
//String s = new String(sAction.getBytes("UTF-8"));
//String s = URLDecoder.decode(sAction,"UTF-8");
//System.out.println(s);
%>
<body>  
<%   openfile op=new openfile();
     //String path1="C:\\Users\\miss\\Desktop\\1.txt";
    // op.open(path1); 
     op.opensystem();
 %>
<%@include file="main.jsp" %>
</body>  

