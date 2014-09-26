<!-- Author: Kirti ,Clicker Team, IDL lab, IIT Bombay
This page is used for launching the poll.
-->
<%@ page import="clicker.v4.global.Global" %>
<html>
<head>
<% String courseId=(String)session.getAttribute("courseID");
String isactive = "inactive";
if(session.getAttribute("isactive")!=null)
isactive = "active";

%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Poll</title>
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>
<script src="../../js/poll.js"></script>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
</head>
<body class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
<%@ include file= "../../jsp/includes/menuheader.jsp" %>

<form class="form-4" >
	
	<table class="table1">
		<tr >
			<td >
			<div class="ui-header-text" >
			<h2><lable>Poll</lable></h2></div>
			</td>
		</tr>
		
		<tr>
			<td>
			<input id="searchbox"  style="width:500px; font-size:14px;margin:0px 0 0 280px" type="search" name="searchbox" autofocus tabindex="1"  placeholder="Enter your question here..."/>
			</td>
		</tr>
		
		<tr>
			<td style="padding-right:250px">
			<div style="margin-left:465px;margin-bottom:20px;">	
			<button class="ui-createquiz-button" id="createqbtn1" type="button" tabindex="2" onclick="Validate('<%=courseId%>');" >
			<span>Conduct poll</span>
			</button>
			</div>
			</td>
		</tr>
	</table>
	
	
	
	<table class="table1" style="margin-top:2px; background-color:#ffffff;" overflow="true"   border="1">
		<tr >
			<td >
			<div id="chart_div" style="width: 1030px; height: 470px;margin-left:0px;"></div>
			</td>
		</tr>
	</table>
	
	<div id="tempdatapoll" style="display: none;"></div>
</form>

<div style="margin-top:-600px;">
<center><%@ include file= "../../jsp/includes/menufooter.jsp" %></center>
</div>

</body>
</html>