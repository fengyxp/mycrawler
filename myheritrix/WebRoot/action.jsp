<%@include file="crawlhander.jsp" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import = "java.net.*" %>
<%@page import="search.openfile" %>
<%
    /*
     * This webpage performs actions that can be performed from the console.
     */
    String sa = request.getParameter("action");
    //String s = request.getParameter("theme");
    String sAction = new String(sa.getBytes("iso-8859-1"),"utf-8");
    System.out.println(sAction);
    if(sAction != null)
    {
        // Need to handle an action    
        if(sAction.equalsIgnoreCase("start"))
        {
           //flag="start";
           if(crawler.getjobcreat()==1){
           		crawler.initialize();
           		System.out.println("changestart");
           		//System.out.println(crawler.getThreadCount());
           		crawler.parallelhandle();
           		/*System.out.println("start");
           		System.out.println( crawler.getstatus());
           		if(crawler.getstatus()==0){
               		crawler.initialize();
               		System.out.println("changestart");
               		System.out.println(crawler.getThreadCount());
		       		crawler.parallelhandle();
		       
           		}else if(crawler.getstatus()==1){
               		crawler.changeelapsed();
           		}
           		else if(crawler.getstatus()==2){
               		//crawler.setstatus(1);
           		}
           		crawler.changecurrent();*/
           		crawler.changecurrent();
           }
           else{
               out.println("changestart");
           }     
        }else if(sAction.equalsIgnoreCase("stop")){
           //if()
           crawler.changeelapsed();
		   crawler.changecurrent();
           crawler.stopSearch();
        }else if(sAction.equalsIgnoreCase("创建")){
            String s = request.getParameter("theme");
            String theme = new String(s.getBytes("iso-8859-1"),"utf-8");
            System.out.println(theme);
            crawler.setTitle(theme);
            String su = request.getParameter("url");
            String url = new String(su.getBytes("iso-8859-1"),"utf-8");
            System.out.println(url);
			crawler.setStartURL(url);
			try {
			    String count = request.getParameter("count");
			    System.out.println(count);
				int urlcount = Integer.parseInt(count);
				crawler.setUrlCount(urlcount);
			} catch (NumberFormatException ee) {
				out.print("Format Error of Url Count!");
			}
			/*try {
			    String str = request.getParameter("threshold");
			    //String thr = new String(str.getBytes("iso-8859-1"),"utf-8");
			    //System.out.println(thr);
				double threshold = Double.parseDouble(str);
				crawler.setThreshold(threshold);
			} catch (NumberFormatException ee) { 
			    out.print("Format Error of Url Count!");				
			}*/
			crawler.removeAllKeyWords();
			String sk = request.getParameter("keywords");
			String words = new String(sk.getBytes("iso-8859-1"),"utf-8");
			System.out.println(words);
			String[] keywords = words.split("\\|");
			for (int i = 0; i < keywords.length; i++) {
				System.out.println(keywords[i]);
				crawler.addKeyWord(keywords[i], 0);
			}
			System.out.print("Succeed to creat a job!");
			crawler.setjobcreat(1);
			//response.sendRedirect("config.jsp");
			
        }else if(sAction.equalsIgnoreCase("提交")){
            try {
                //System.out.println(words);
                String sc = request.getParameter("concount");
			    String words = new String(sc.getBytes("iso-8859-1"),"utf-8");
			    System.out.println(words);
				int urlcount = Integer.parseInt(words);
				crawler.setUrlCount(urlcount);
			} catch (NumberFormatException ee) {
			    %><script type="text/javascript">alert("Format Error of Url Count!");</script>
			    <% 
			    
			}
			try {
				String st = request.getParameter("thread");
			    String th = new String(st.getBytes("iso-8859-1"),"utf-8");
			    System.out.println(th);
				int threadCount = Integer.parseInt(th);
				crawler.setThreadCount(threadCount);
			} catch (NumberFormatException ee) {
				%><script type="text/javascript">alert("Format Error of thread Count!");</script>
				<% 
			    
			}
			try {
			    String str = request.getParameter("threshold");
			    String thr = new String(str.getBytes("iso-8859-1"),"utf-8");
			    System.out.println(thr);
				double threshold = Double.parseDouble(thr);
				crawler.setThreshold(threshold);
			} catch (NumberFormatException ee) {
			    %><script type="text/javascript">alert("Format Error of threshold!");</script>
			    <%  				
			}
			System.out.print("Succeed to set the configuration!");
        
        }else if(sAction.equalsIgnoreCase("refresh")){
            crawler.changeelapsed();
            crawler.changecurrent();
            System.out.print("Refresh");
        }else if(sAction.equalsIgnoreCase("open")){
            openfile op=new openfile(); 
     		op.opensystem();
        }
        response.sendRedirect("main.jsp");
    }
%>
