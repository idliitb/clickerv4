<!-- Author: rajavel, Clicker Team, IDL Lab - IIT Bombay
	Receive the auto test quiz json from main server and display the questions
-->

<%@page import="clicker.v4.global.Global"%>
<%@page import="clicker.v4.wrappers.*"%>
<%@page import="clicker.v4.rest.*"%>
<%@page import="clicker.v4.remote.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<script src="../../js/remotequiz.js"></script>
<script src="../../js/jquery-1.9.1.js"></script>	
<title>Remote Instant Quiz</title>
<script>
function readMainCenter1()
{
	var listenerInterval=1;
	$(document).ready(function() {
		listenerInterval=setInterval(function() {
	    	 jQuery.get("remoteListener.jsp", function (response) {
	        	if(response.trim()!=null){
	        		if(response.trim()=="quizlaunch"){
	        			clearInterval(listenerInterval);
	            		window.location.href="remotequiz.jsp";
	                	}
	        		else if(response.trim()=="launchinstantquiz"){
	        			clearInterval(listenerInterval);
	            		window.location.href="instantquiz.jsp";
	        		}
	        	}
	    	});
	    }, 1000);
	});
}</script>
</head>    
<%
String CoordinatorID = (String) session.getAttribute("CoordinatorID");
if (CoordinatorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
String workshopid = (String) session.getAttribute("WorkshopID");
String Coordinator=(String) session.getAttribute("CoordinatorID");
RemoteDBHelper rdh= new RemoteDBHelper();
String centerid = rdh.getRemoteCenterID("", Coordinator);
String MaincenterName = session.getAttribute("maincentername").toString();
String MainCenterURL = new AutoTestHelper().getMainCenterURL(MaincenterName);
java.util.Date date = new Date();
String activeTime = (new Timestamp(date.getTime())).toString();
Global.activeworkshop.put("autotest", activeTime);
JSONReadandparse reader = new JSONReadandparse();
Quiz json = reader.readAutoTestQuizJsonFromUrl(MainCenterURL, centerid, workshopid,getServletContext().getInitParameter("war_version"), getServletContext().getInitParameter("db_version"));
String autoteststatus = json.getcourseId();
int mins = 0, sec = 0, autotestflag = 0;
if(!autoteststatus.equals("noautotest"))
{
	autotestflag = 1;
	Global.workshopjsonobject.put("autotest", json);
	Global.remotecountrequestjson.put("autotest","0");
	Global.remotequizrecordids.put("autotest", -1);	
	Global.remotecountresponsejson.put("autotest", 0);
	String QuizType=json.getQuiztype() + "quiz";
	int QuizTime=Integer.parseInt(json.getQuizTime());
	mins=QuizTime/60;
	sec=QuizTime%60;
	int QuizID=json.getQuizId();
}
%>    
    

<body onload="startautoTimer('autotest'), readMainCenter1();"  class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
<%@ include file= "../../jsp/includes/remotemenuheader.jsp" %>
<input type = "hidden" id = "autostatus" value = '<%=autotestflag %>' />

<%if(autotestflag == 1){ %>
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
<%}
else
{%>
	<p style = "color: red; font-size: 15px;"> Auto Test is disabled from the Main Center. </p>
<%} %>
	<div style="margin-top:-600px;">
		<%@ include file= "../../jsp/includes/menufooter.jsp" %>
	</div>
	</body>
</html>