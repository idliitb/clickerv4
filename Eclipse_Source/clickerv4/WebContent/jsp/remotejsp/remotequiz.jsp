<!-- Author: Dipti.G 
			 Clicker Team, IDL LAB, IIT Bombay
To get json and display quiz at coordinator server
 -->

<%@page import="clicker.v4.wrappers.*"%>
<%@page import="clicker.v4.rest.*"%>
<%@page import="clicker.v4.remote.*"%>
<%@page import="java.net.URL"%>
<%@ page import = "clicker.v4.admin.*" %>
<%@page import="java.sql.*"%> 
<%@page import="java.util.*"%>
<%@page import="clicker.v4.global.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<script src="../../js/remotequiz.js"></script>
<script src="../../js/jquery-1.9.1.js"></script>	
<title>Quiz</title>
 <style>
table.yui {

    width:80%;
    height:550px;
	font-family: arial;
	border-collapse: collapse;
	border: solid 0px #7f7f7f;
	font-size: small;	
	/*
     Introduced in IE 10.
     See http://ie.microsoft.com/testdrive/HTML5/msUserSelect/
   */
	
}


</style>
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
Global.isnormalresponsesent.put(WorkshopID, "no");
RemoteDBHelper rdh= new RemoteDBHelper();
String MainCenterURL=(String)session.getAttribute("MainCenterURL");
JSONReadandparse reader = new JSONReadandparse();
ArrayList<String> storeall = new AddRemoteCenter( ).getAll( );
int centerid = Integer.parseInt(storeall.get(0));
Quiz json = reader.readQuizJsonFromUrl(MainCenterURL,WorkshopID, "normal", Coordinator,Integer.toString(centerid));
String QuizType=null;

int QuizTime=Integer.parseInt(json.getQuizTime());
int mins=QuizTime/60;
int sec=QuizTime%60;
String quizType=json.getQuiztype();
if(quizType.equals("normal")){
	QuizType="normalquiz";
}else{
	QuizType="instantquiz";
}
%>    
    

<body onload="startTimer('<%=QuizType%>')"  class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
<%@ include file= "../../jsp/includes/remotemenuheader.jsp" %>
<input type="hidden" style="width: 30px" id="minutes" value="<%=mins%>" /> 
<input type="hidden" style="width: 30px"id="seconds" value="<%=sec %>"/>
<div align="center">
	<table class="yui">
		<tr>
			<td style="height: 50px;">
				<table style="width: 100%;height: 100%">
					<tr>
						<td width="33%">
							<div id="quizresponsestatus">Responses : 0 / <%=rdh.getNoofParticipant(WorkshopID)%></div>
						</td>
						<td width="33%" align="center">
							<div class="ui-header-text"><h1 id="timer">00 : 00 </h1></div>
						</td>
						<td width="33%" align="right">
							<div id="endquiz_div" style="display: inline;">
								<!-- <button class="ui-conductquiz-button"  id="endquiz" type="button" onclick="onlySendResponse()" style="margin-left: 20px;" >
									<span>End Quiz</span>
								</button> -->
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<div id="quizPreview" style="border:2px solid;border-radius:25px;font-size: 18px; height:500px;overflow:auto ; padding-left:10px ; text-align: justify;">
						<%

							ArrayList<Question> ques=json.getquestions();
							for(int i=0;i<ques.size();i++){
	  						Question question=ques.get(i);
	  
	  					%>
	  					<br/><br/>
	  					<div class='question'> <%=i+1+" . " %> <%=question.getText().replace("<", "&lt;") %> </div>
	  					<div  style="padding-left:25px" class='optns'>
							<%  
								if(question.getType()!=3){
	  							ArrayList<Option> options=question.getOptions();
	  							for(int j=0;j<options.size();j++){
		  						String optionvalue=(char)(j+1+64) + ". " +  options.get(j).getOptiontext().replace("<", "&lt;");
		  					%>
		 					<%=optionvalue%>
		 					<br/>
							<% }} %>
						</div>
	  					<%
	  
							}
						%>
				</div>
 			</td>
			</tr>
	</table>
</div>
		<div id="tempdata" style="display: none;"></div>
		<div style="margin-top:-600px;">
			<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		</div>
	</body>
</html>