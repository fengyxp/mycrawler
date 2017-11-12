<%--@ page language="java" import="java.util.*" pageEncoding="UTF-8"--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.*"%>
<%@page import="search.Crawler"%>
<%@page import="search.Download"%>
<%@page import="search.HttpConstants"%>
<%@page import="search.PriorityURL"%>
<%@page import="search.RegularTest"%>
<%@page import="search.openfile" %>
<%  
   Crawler crawler = Crawler.getInstance("食品安全", "http://www.zccw.info/");
   
   /*crawler.addKeyWord("食品", 0);
        crawler.addKeyWord("产品不合格", 0);
		crawler.addKeyWord("不达标", 0);
		crawler.addKeyWord("添加剂", 0);
		crawler.addKeyWord("造假", 0);
		crawler.addKeyWord("无证经营", 0);
		crawler.addKeyWord("安全", 0);
		crawler.addKeyWord("检疫不合格", 0);
		*/
%>