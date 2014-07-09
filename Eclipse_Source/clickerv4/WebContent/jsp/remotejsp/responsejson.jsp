<!-- Author: Kirti ,Clicker Team, IDL lab, IIT Bombay 
* This file is used for creating response json that to be sent to main centre. 
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="clicker.v4.global.Global" %>
 <%@page import="clicker.v4.rest.*"%>
 <%@ page import="clicker.v4.poll.*" %>
 <%@page import="clicker.v4.remote.RemoteDBHelper"  %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Poll Response</title>
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
<title>Insert title here</title>
</head>
<body>
<%
String Coordinator = (String) session.getAttribute("CoordinatorID");
String WorkshopID=(String) session.getAttribute("WorkshopID");
String pollquestion= request.getParameter("pollquestion");
String MainCenterURL=(String)session.getAttribute("MainCenterURL");

RemoteDBHelper dbh=new RemoteDBHelper();
dbh.getRemoteCenterID(WorkshopID,Coordinator);
String centerid=dbh.getRemoteCenterID(WorkshopID,Coordinator);	


JSONReadandparse js=new JSONReadandparse();
js.newPollJsonForMain(WorkshopID,Coordinator,centerid,pollquestion,MainCenterURL);


%>
</body>
</html>