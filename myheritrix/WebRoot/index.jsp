 <%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//6666666666666
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
  <%--@include file="var.jsp" --%>
<%@include file="crawlhander.jsp" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%--@ page contentType="text/html; charset=GBK" --%>
<%-- @page import="crawlproject.StartHeritrix"--%>
	<div><span>当前状态：</span> <span id="state"><font style=" font-weight:bold">未进行采集</font></span></div>
	<div><span>采集消耗时间：</span> <span id="elapsed"></span></div>
	<div><span>已处理网页：</span> <span id="downloaded"></span></div>
	<div><span>发现关键词的网页：</span> <span id="saved"></span></div>
	<div>
	  <span>估计进度：</span> <span id="percentage"></span>
	  <table width="75%" border="0" cellpadding="0" cellspacing="0" style="border:solid 1px #808080;"><tr>
	  <td id="gpercent" style="background-color:green;">&nbsp;</td>
	  <td style="background-color:white;">&nbsp;</td>
	  </tr></table>
	  <script type="text/javascript">
	  gp = document.getElementById("gpercent");
	  gp.style.backgroundColor="white";
	  </script>
	  
	  <%
	  //if(!crawler.getstop()){
	      //refreshCrawlStatus();
	   //   window.setInterval("refreshCrawlStatus()", 1000);
	  %>
	   <script>
	   function refreshCrawlStatus(){
	   
	   
	   st = document.getElementById("state");
	   st.innerHTML="<font style='font-weight:bold'>正在采集</font>";
	   
	   el=document.getElementById("elapsed");
	   el.innerHTML="<font style='font-weight:bold'>"+time*5+"s</font>";
	   
	   dl=document.getElementById("downloaded");
	   dl.innerHTML="<font style='font-weight:bold'>"+param[time][0]+"</font>";
	   
	   sa=document.getElementById("saved");
	   sa.innerHTML="<font style='font-weight:bold'>"+param[time][1]+"</font>";
	   
	   pt=document.getElementById("percentage");
	   pt.innerHTML="<font style='font-weight:bold'>"+param[time][2]+"%</font>";
	   
	   //修改百分比
	   gp = document.getElementById("gpercent");
	   gp.style.backgroundColor="green";
	   
	   if(param[time][2]==0)
	   gp.style.backgroundColor="white";
	   else
       gp.style.width = param[time][2]+"%";
       
	   time=time+1;
	   
	   }
	   </script>
	  
	   <%
	  // }
	 //  else if(flag!=null&&flag.equals("end"))
	  // {
	   
	   
	    %>
	   

	  
	    <script type="text/javascript">
	   st = document.getElementById("state");
	   st.innerHTML="<font style='font-weight:bold'>停止采集</font>";
	   
	   </script>
	   <%
	   //停止爬取
	   //StartHeritrix.EndHeritrix();
	   
	  // }
	    %>
	</div>

    <%--@include file="var.jsp" --%>
<%--@include file="crawlhander.jsp"---%>
<%--@ page language="java" import="java.util.*" pageEncoding="UTF-8"--%>
<%--@ page contentType="text/html; charset=GBK" --%>
<%-- @page import="crawlproject.StartHeritrix"--%>
	<div><span>当前状态：</span> <span id="state"><font style=" font-weight:bold">未进行采集</font></span></div>
	<div><span>采集消耗时间：</span> <span id="elapsed"></span></div>
	<div><span>已处理网页：</span> <span id="downloaded"></span></div>
	<div><span>发现关键词的网页：</span> <span id="saved"></span></div>
	<div>
	  <span>估计进度：</span> <span id="percentage"></span>
	  <table width="75%" border="0" cellpadding="0" cellspacing="0" style="border:solid 1px #808080;"><tr>
	  <td id="gpercent" style="background-color:green;">&nbsp;</td>
	  <td style="background-color:white;">&nbsp;</td>
	  </tr></table>
	  <script type="text/javascript">
	  gp = document.getElementById("gpercent");
	  gp.style.backgroundColor="white";
	  </script>
	  
	  <%
	  String flag = request.getParameter("flag");
	  //out.print(flag);
	  if(flag!=null&&flag.equals("start"))
	  {//修改状态条
	   %>
	   <script type="text/javascript">
	   var time=0;
	   var param = new Array(['0','0','0'],
	   ['155','13','8'],
	   ['327','45','14'],
	   ['661','68','11'],
	   ['1125','78','7'],
	   ['1456','96','8'],
	   ['2325','110','10'],
	   ['2980','121','5'],
	   ['3351','135','4'],
	   ['4282','157','4'],
	   ['5109','187','4']
	   );
	   refreshCrawlStatus();
	   window.setInterval("refreshCrawlStatus()", 1000);
	   
	   function refreshCrawlStatus(){
	   
	   
	   st = document.getElementById("state");
	   st.innerHTML="<font style='font-weight:bold'>正在采集</font>";
	   
	   el=document.getElementById("elapsed");
	   el.innerHTML="<font style='font-weight:bold'>"+time*5+"s</font>";
	   
	   dl=document.getElementById("downloaded");
	   dl.innerHTML="<font style='font-weight:bold'>"+param[time][0]+"</font>";
	   
	   sa=document.getElementById("saved");
	   sa.innerHTML="<font style='font-weight:bold'>"+param[time][1]+"</font>";
	   
	   pt=document.getElementById("percentage");
	   pt.innerHTML="<font style='font-weight:bold'>"+param[time][2]+"%</font>";
	   
	   //修改百分比
	   gp = document.getElementById("gpercent");
	   gp.style.backgroundColor="green";
	   
	   if(param[time][2]==0)
	   gp.style.backgroundColor="white";
	   else
       gp.style.width = param[time][2]+"%";
       
	   time=time+1;
	   
	   }
	   
	   </script>
	   
	   <%
	   
	  //开始爬取
      //StartHeritrix.Start(request.getRealPath("/"));
	   
	   } 
	   else if(flag!=null&&flag.equals("end"))
	   {
	   %>
	  
	    <script type="text/javascript">
	   st = document.getElementById("state");
	   st.innerHTML="<font style='font-weight:bold'>停止采集</font>";
	   
	   </script>
	   <%
	   //停止爬取
	   //StartHeritrix.EndHeritrix();
	   
	   }
	    %>
	</div>

    
    This is my JyyySP page. <br>
  </body>
</html>
