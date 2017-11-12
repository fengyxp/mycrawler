<%@include file="crawlhander.jsp"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
    <% double elapsed=(double)(crawler.getelapsed()/1000.00);%>
	<div><span>当前状态：</span> <span id="state"><font style=" font-weight:bold">未进行采集</font></span></div>
	<div><span>采集消耗时间：</span> <span id="elapsed"><%=elapsed %>s</span></div>
	<div><span>已处理网页：</span> <span id="downloaded"><%=crawler.getvisitedURL() %></span></div>
	<div><span>发现关键词的网页：</span> <span id="saved"><%=crawler.getwanted() %></span></div>
	<div>
	<%
       
       //out.println("6666:"+crawler.getvisitedURL()+"rrr");
	    // out.println("77777"+crawler.getwanted());
	   //double percentage1=0.00;
	   int begin=crawler.getvisitedURL();
	   int end =crawler.getUrlCount();
	   int hh = end - begin;
	   //percentage1 = percentage1*100;
	   int ratio = (int) (100 * begin / end);
	%>
	<span>估计进度：</span> <span id="percentage"></span>
                            <table border="0" cellpadding="0" cellspacing= "0" width="600"> 
                                <tr>
                                    <%-- <td align='right' width="25%">已下载： <%= begin %>&nbsp;</td>--%>
                                    <td class='completedBar' style="background-color:lightgreen;border-right:3px solid orange" 
                                    width="<%= (int)ratio/2 %>%" align="right">
                                    <%= ratio > 50 ? "<b>"+ratio+"</b>%&nbsp;" : "" %>
                                    </td>
                                    <td class='queuedBar' style="background-color:pink;border-left:3px solid orange;" 
                                    align="left" width="<%= (int) ((100-ratio)/2) %>%">
                                    <%= ratio <= 50 ? "&nbsp;<b>"+ratio+"</b>%" : "" %>
                                    </td>
                                    <%-- <td width="25%" nowrap>&nbsp;<%= hh %> 未完成</td>--%>
                                    
	

                                </tr>
                            </table>
                            URL总数：<%= end %> <br>   
	  <script type="text/javascript">
	  //gp = document.getElementById("gpercent");
	  //gp.style.backgroundColor="white";
	  </script>
	  
	  <%
	  //String flag = request.getParameter("flag");
	  //out.print(flag);
	  if(crawler.getstatus()==1)
	  {//修改状态条
	     //out.println("start采集数据");
	     //out.print(time);
	     	     
	     //out.print("start采集数据");
	   %>
	   <script type="text/javascript">
	   //refreshCrawlStatus();
	   //window.setInterval("refreshCrawlStatus()", 1000);
	   
	  // function refreshCrawlStatus(){
	   
	   
	   st = document.getElementById("state");
	   st.innerHTML="<font style='font-weight:bold'>正在采集</font>";
	   
	   //el=document.getElementById("elapsed");
	   //el.innerHTML="<font style='font-weight:bold'>"+time*1+"s</font>";
	   /*
	   dl=document.getElementById("downloaded");
	   dl.innerHTML="<font style='font-weight:bold'>"+crawler.getvisitedURL()+"</font>";
	   
	   sa=document.getElementById("saved");
	   sa.innerHTML="<font style='font-weight:bold'>"+crawler.getwanted()+"</font>";
	   
	   pt=document.getElementById("percentage");
	   var percentage1=0.00;
	   percentage1=crawler.getvisitedURL()/getUrlCount();
	   percentage1 = percentage1*100;
	   pt.innerHTML="<font style='font-weight:bold'>"+percentage1+"%</font>";
	   
	   //修改百分比
	   gp = document.getElementById("gpercent");
	   gp.style.backgroundColor="green";
	   
	   if(percentage1==0)
	   gp.style.backgroundColor="white";
	   else
       gp.style.width = percentage1+"%";*/
       
	   //time=time+1;
	   
	   //}
	   
	   </script>
	   
	   <%
	   
	  //开始爬取
      //StartHeritrix.Start(request.getRealPath("/"));
	   
	   } 
	   else if(crawler.getstatus()==2)
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

