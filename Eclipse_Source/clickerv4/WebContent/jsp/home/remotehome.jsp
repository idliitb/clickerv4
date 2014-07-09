
<!--  
    Author       : Dipti.G  
    			   Clicker Team, IDL LAB ,IIT Bombay
 -->
<%@page import="clicker.v4.util.*"%>
<%@page import="clicker.v4.global.*"%>
<%@page import="clicker.v4.remote.*"%>
<%@page import="java.net.URL"%>
<%@page import="java.sql.*"%> 
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/menu.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<link href="inettuts.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../../css/jquery-ui.css" />
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>
<script src="../../js/remotequiz.js"></script>
<script type="text/javascript" src="excanvas.min.js"></script>
<script type="text/javascript" src="jquery.flot.js"></script>



<script type="text/javascript">
	var $j = jQuery.noConflict();	
</script>


<style type="text/css">
._css3m {
	display: none
}

.Present_Select {
	
}

.sample {
    cursor:pointer;
	background-color: #9bbb59;
	border: 2px solid;
	border-radius: 10px;
	width: 230px;
	height: 25px;
	padding: 5px;
	margin-top: 3px;
	font-weight: bold;
}
</style>


</head>
<%!String Status="ok";  %>

<%/*  */
	if (session.getAttribute("CoordinatorID") == null) {
		request.setAttribute("Error", "Your session has expired.");
		RequestDispatcher rd = request
				.getRequestDispatcher("../../error.jsp");
		rd.forward(request, response);
		return;
	}

String maincenter=session.getAttribute("maincentername").toString();
String WorkshopID=(String) session.getAttribute("WorkshopID");
String MainCenterURL=(String)session.getAttribute("MainCenterURL");
if((maincenter=="MainCenter not added")||WorkshopID=="No Workshop,As No MainCenter"||maincenter.equals("MainCenter not added")){
	System.out.println("No main center is added and so no workshop is available");
	Status="nomaincenter";
}
else if(MainCenterURL.equals("Wrong URL")||(MainCenterURL=="Wrong URL")){
	Status="notreachable";
	System.out.println("inside remote Listener... Wrong URL");
}

else if(WorkshopID.equals("No workshop Available")){
	Status="noworkshopavailable";
	System.out.println("inside remote Listener...No workshop Available ");
}
else{	
	String workshopID=session.getAttribute("WorkshopID").toString();
	java.util.Date date = new Date();
	String activeTime = (new Timestamp(date.getTime())).toString();
	Global.activeworkshop.put(workshopID, activeTime);
	HashSet<String> activeparticipant = new HashSet<String>();
	Global.activeparticipantlist.put(workshopID, activeparticipant);
	System.out.println("Active Workshop List : " +  Global.activeworkshop);
	Status="ok";
}

String Coordinator=(String) session.getAttribute("CoordinatorID");

%>

<body>
	<%@ include file="../../jsp/includes/remotemenuheader.jsp"%>
	<% if(Status=="ok"){ 
	%>
	<script>readMainCenter();</script>
	<%
	}else{
		
		%>
		<script>readstatus('<%=Status%>');</script>
		<% 
	}
	%>
	<table class="table1">
	<tr>
	<td>
	<input type="hidden" id="response" name="response"> 
	<div id="listenerDiv"  style="height:540px;text-align:center;padding-top:10px ;">
			
	</div>
	</td>
	</tr>
	</table>
	
	<div style="margin-top: -600px; text-align: center;">
		<%@ include file="../../jsp/includes/menufooter.jsp"%>
	</div>
</body>
</html>