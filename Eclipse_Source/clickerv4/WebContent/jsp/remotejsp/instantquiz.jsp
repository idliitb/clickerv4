<!-- Author: Rajavel,Dipti from Clicker Team, IDL LAB ,IIT Bombay
	Receive the quiz json from main server and display the questions
-->

<%@page import="clicker.v4.global.Global"%>
<%@page import="clicker.v4.wrappers.*"%>
<%@page import="clicker.v4.rest.*"%>
<%@page import="clicker.v4.remote.*"%>
<%@page import="java.net.URL"%>
<%@page import = "clicker.v4.admin.*" %>
<%@page import="java.sql.*"%> 
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<script src="../../js/remotequiz.js"></script>
<script src="../../js/jquery-1.9.1.js"></script>	
<title>Remote Instant Quiz</title>
</head>    
<%
String CoordinatorID = (String) session.getAttribute("CoordinatorID");
if (CoordinatorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}

String WorkshopID=(String) session.getAttribute("WorkshopID");
String Coordinator=(String) session.getAttribute("CoordinatorID");
RemoteDBHelper rdh= new RemoteDBHelper();
String MainCenterURL=(String)session.getAttribute("MainCenterURL");
ArrayList<String> storeall = new AddRemoteCenter( ).getAll( );
int centerid = Integer.parseInt(storeall.get(0));
JSONReadandparse reader = new JSONReadandparse();
Quiz json = reader.readQuizJsonFromUrl(MainCenterURL,WorkshopID, "instant", Coordinator,Integer.toString(centerid));
String QuizType=json.getQuiztype() + "quiz";
int QuizTime=Integer.parseInt(json.getQuizTime());
Global.isInstantResponseSent.put(WorkshopID, "no");
int mins=QuizTime/60;
int sec=QuizTime%60;
int QuizID=json.getQuizId();
%>    
    

<body onload="startTimer('<%=QuizType%>')"  class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
<%@ include file= "../../jsp/includes/remotemenuheader.jsp" %>
<input type="hidden" style="width: 30px" id="minutes" value="<%=mins%>" /> 
<input type="hidden" style="width: 30px"id="seconds" value="<%=sec %>"/>
	<table class="table1">
		<tr>
		<td width="40%">
		</td>
		<td width="20%">
		<div class="ui-createquiz-text" >
				<h2>Instant quiz</h2></div>
		</td>
		<td width="40%">
		<div id="quizresponsestatus" style="margin-left: 50px;float: left;margin-top: 25px">Responses : 0 / <%=rdh.getNoofParticipant(WorkshopID)%>	</div>
		<div id="endquiz_div" style="display: inline;">
			<!-- <button class="ui-conductquiz-button"  id="endquiz" type="button" onclick="onlySendInstantResponse()" style="margin-left: 20px;" >
				<span>End Quiz</span>
			</button> -->
		</div>
		<div class="ui-header-text" style="float: right;"><h1 id="timer">00 : 00 </h1></div>
		</td></tr>
	</table>	
	<table class="table1" style="margin-top:5px; text-align: center;" border="1" >
		<tr><td>
			<div id="quizPreview" style="font-size: 18px; height:400px;overflow:auto ; padding-left:10px ; text-align: justify;">
				<%
					ArrayList<Question> ques=json.getquestions();
					for(int i=0;i<ques.size();i++){
		  				Question question=ques.get(i);
				%>
	  			<br/><br/><div class='question'> <%=i+1+" . " %> <%=question.getText().replace("<", "&lt;") %> </div>
	  			<div  style="padding-left:25px" class='optns'>
					<%  
					if(question.getType()!=3){
	  					ArrayList<Option> options=question.getOptions();
	  					for(int j=0;j<options.size();j++){
		  					String optionvalue=(char)(j+1+64) + ". " +  options.get(j).getOptiontext().replace("<", "&lt;");
		  			%>
			 			<%=optionvalue%><br/>
						<% } }%>
				</div>
	  			<%}%>
			</div>
		</td></tr>
	</table>
	<div id="tempdata" style="display: none;"></div>
	<div style="margin-top:-600px;">
		<%@ include file= "../../jsp/includes/menufooter.jsp" %>
	</div>
	</body>
</html>