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
  
<span style="color:red;font-size:22;" mce_style="color:red;font-size:22;">恭喜您,登录成功!</span>  
<body>  
<%   openfile op=new openfile();
     String path1="C:\\Users\\miss\\Desktop\\1.txt";
    // op.open(path1); 
     op.opensystem();
 %>
 <script type="text/javascript">alert("I am an alert box!!");</script>
 
       
            </body>  

