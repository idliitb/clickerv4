<%--@author  dipti, rajavel
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
if (Coordinator == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
String WorkshopID=(String)session.getAttribute("WorkshopID");
String MainCenterURL=(String)session.getAttribute("MainCenterURL");
int mcquizrecordid = Global.remotemcquizrecordids.get(WorkshopID);
System.out.println("Value of quizrecordid from remoteresponsechart :"+mcquizrecordid);
Quiz quiz = Global.workshopjsonobject.get(WorkshopID);
String questionids ="" ;
System.out.println(quiz.getquestions().size());
for(int i=0;i<quiz.getquestions().size();i++){
	Question question=quiz.getquestions().get(i);
	questionids +=question.getId()+ "@";
}
System.out.println("Values of question id from remoteresponsechart :"+questionids);

String isSent = (Global.isnormalresponsesent.get(WorkshopID)!=null?Global.isnormalresponsesent.get(WorkshopID):"yes");
//Global.isnormalresponsesent.put(WorkshopID,"yes");
/*int check = 0, responsecount = 0, rcount = 0;
while(true)
{
	System.out.println("Count: " + Global.remotecountresponsejson.get(WorkshopID));
	rcount = Global.remotecountresponsejson.get(WorkshopID);
	System.out.println("Rcount: " + rcount);
	if(responsecount != rcount)
	{
		responsecount = rcount;
		check = 0;
	}
	check++;
	if(check >= 5)
	{
		new RemoteQuizResponseHelper( ).createMCResponseJson(quizrecordid,MainCenterURL);
		break;
	}
	Thread.sleep(2000);
}*/
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Quiz Response</title>
		<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
		<link type="text/css" rel="stylesheet" href="../../css/style.css">
		<script src="../../js/remoteresponse.js"></script>
		<script src="../../js/remotequiz.js"></script>
		<script src="../../js/jquery-1.9.1.js"></script>
		<script src="../../js/jquery-ui.js"></script>
		<link type="text/css" rel="stylesheet" href="../../css/jquery-ui.css">
		<style type="text/css">
		ol{
			list-style-type:upper-alpha;
		}
		</style>
		
	</head>
	<body onload="checkResponse('<%=Coordinator%>' , '<%=questionids%>', '<%=isSent %>')" class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
		<%@ include file= "../../jsp/includes/remotemenuheader.jsp" %>
		
		<table class="table1">
			<tr><td>
				<div class="ui-header-text"><br/>
					<h2 style="display: inline;"> Quiz Response Chart </h2>
					<input style="margin-left: 20px;" id = "showcorrect" onchange="showRemoteNormalCorrect('<%=Coordinator%>', '<%=questionids%>', this)" type="checkbox" value="showcorrect" />&nbsp;Show Correct Answer
				</div><br/>
			</td>
			</tr>
		</table>
		<table class="table1" style="margin-top:5px;" border="1">
			<tr><td>
				<div id="quizresponse" style="font-size: 18px; height:400px;overflow: auto; text-align: center;"></div>
			</td></tr>
		</table>
		<div id="ResponseDialog" style="display: none;"></div>
		<div style="margin-top:-600px;">
			<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		</div>
	</body>
</html>