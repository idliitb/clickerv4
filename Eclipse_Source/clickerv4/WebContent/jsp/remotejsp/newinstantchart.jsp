<%--@author Dipti.G  from Clicker Team, IDL LAB -IIT Bombay
This jsp file is used for display instant response chart 
--%>
<%@page import="clicker.v4.remote.RemoteQuizResponseHelper"%>
<%@page import="clicker.v4.remote.RemoteDBHelper"%>
<%@page import="clicker.v4.global.Global"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<% 
String CoordinatorID = (String) session.getAttribute("CoordinatorID");
if (CoordinatorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
String workshopID = session.getAttribute("WorkshopID").toString();
int quizrecordid = Global.remotequizrecordids.get(workshopID);
RemoteDBHelper remoteDBHelper =new RemoteDBHelper();
String questionids = remoteDBHelper.getInstantQuestionIDs(quizrecordid);
RemoteQuizResponseHelper quizResponseHelper = new RemoteQuizResponseHelper();
boolean isShowAns = Global.workshopjsonobject.get(workshopID).isShowAns();
String chartString=quizResponseHelper.getInstantQuestionResponseCount(quizrecordid);
String[] countString= chartString.split("@");
String rightvalue=countString[0];
String wrongvalue=countString[1].toString();
String noreponsevalue=countString[2];
String isSent = (Global.isInstantResponseSent.get(workshopID)!=null?Global.isInstantResponseSent.get(workshopID):"yes");
Global.isInstantResponseSent.put(workshopID,"yes");
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Instant Quiz Response</title>
		<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
		<link type="text/css" rel="stylesheet" href="../../css/style.css">
		<script src="../../js/remoteinstantresponse.js"></script>
		<script src="../../js/jquery-1.9.1.js"></script>
		<script src="../../js/jquery-ui.js"></script>
		<script src="../../js/remotequiz.js"></script> <!-- this javascript is included bcoz  one of its function is used by remoteresponse.js -->
		<link type="text/css" rel="stylesheet" href="../../css/jquery-ui.css">
	</head>
	<body onload="checkResponse('<%=CoordinatorID%>' , '<%=questionids%>', '<%=isSent %>','<%=rightvalue%>','<%=wrongvalue%>','<%=noreponsevalue%>', <%=isShowAns%>)"
	 class="ui-Mainbody" style="width:100%; height:100%; text-align: center;background-color: white;">
		<%@ include file= "../../jsp/includes/remotemenuheader.jsp" %>
		<!-- <script>InsideResponseReadForQuizPoll();</script> -->
		<script src="../../js/highcharts.js"></script>
	<table class="table1">
			<tr><td>
				<div class="ui-header-text" id="loading">
				<br>
					<h2 style="display: inline;">Please wait responses are still getting collected hence chart will get update...  <img style='margin-left: 10px; margin-top: 0px; width : 73px; height : 73px;' src='../../img/ajax_loader_green_512.gif'></img>  </h2>
				</div><br/>
				<br>
			</td>
			</tr>
		</table>
		<br>
	<table class="table1">
		<tr>
			<td>
				<div id="overallchart" style=" float:left; width: 810px; height: 250px;"></div>
				<div style="float:right; width: 200px; height: 250px;">
				<div id="percentage" style="float:right; width: 200px; height: 70px; background-color: white;">
				
				</div>
				<div id="performance" style="float:right; width: 200px; height: 180px;"></div>
				</div>
			</td>
			
		</tr>
		<tr>
			<td>
			<br>
			<table class="table1 ">
				<tr>
					<td>
  						<div id="questiondetails"></div> 
					</td>
					<td>
					<div id="Questionchart"></div>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<div id="ResponseDialog" style="display: none;"></div>
		<div style="margin-top:-600px;">
			<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		</div>
	</body>
</html>