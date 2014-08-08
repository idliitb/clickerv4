<%--@author Dipti.G  from Clicker Team, IDL LAB -IIT Bombay
This jsp file is used to display quiz response chart
--%>

<%@page import="clicker.v4.remote.RemoteQuizResponseHelper"%>
<%@page import="clicker.v4.global.Global"%>
<%@page import="clicker.v4.wrappers.*"%>
<%@page import="clicker.v4.wrappers.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<% 
String Coordinator=(String)session.getAttribute("CoordinatorID");
System.out.println("Coordinator ID in chart page : "+Coordinator);
String WorkshopID=(String)session.getAttribute("WorkshopID");
String MainCenterURL=(String)session.getAttribute("MainCenterURL");

int quizrecordid = Global.remotequizrecordids.get(WorkshopID);
RemoteQuizResponseHelper quizResponseHelper = new RemoteQuizResponseHelper();
Quiz quiz = Global.workshopjsonobject.get(WorkshopID);
boolean isShowAns = quiz.isShowAns();
String questionids ="" ;
System.out.println(quiz.getquestions().size());
for(int i=0;i<quiz.getquestions().size();i++){
	Question question=quiz.getquestions().get(i);
	questionids +=question.getId()+ "@";
}
String chartString=quizResponseHelper.getNormalQuizResponseCount(quizrecordid,WorkshopID);
String[] countString= chartString.split("@");
String rightvalue=countString[0];
String wrongvalue=countString[1].toString();
String noreponsevalue=countString[2];
String isSent = (Global.isnormalresponsesent.get(WorkshopID)!=null?Global.isnormalresponsesent.get(WorkshopID):"yes");
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Quiz Response</title>
		<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
		<link type="text/css" rel="stylesheet" href="../../css/style.css">
		<script src="../../js/remoteresponse.js"></script>
		<script src="../../js/remotequiz.js"></script> <!-- this javascript is included bcoz  one of its function is used by remoteresponse.js -->
		<script src="../../js/jquery-1.9.1.js"></script>
		<script src="../../js/jquery-ui.js"></script>
		<link type="text/css" rel="stylesheet" href="../../css/jquery-ui.css">
		<style type="text/css">
		ol{
			list-style-type:upper-alpha;
		}
		</style>
		
	</head>
	<body onload="checkResponse('<%=Coordinator%>' , '<%=questionids%>', '<%=isSent %>','<%=rightvalue%>','<%=wrongvalue%>','<%=noreponsevalue%>', <%=isShowAns%>)" class="ui-Mainbody" style="width:100%; height:100%; text-align: center;background-color: white;">
		<%@ include file= "../../jsp/includes/remotemenuheader.jsp" %>
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