<%--@author rajavel, Clicker Team, IDL Lab - IIT Bombay  
This jsp file is used to display normal quiz
--%>

<%@page import="clicker.v4.quiz.QuizHelper"%>
<%
String InstructorID = (String) session.getAttribute("InstructorID");

if (InstructorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
if(request.getParameter("quizname")==null){
	response.sendRedirect("../../jsp/quiz/conductquiz.jsp");
	return;
}
session.setAttribute("quizname", request.getParameter("quizname"));
String quizid = request.getParameter("quizname").split("~")[0];
String quizname = request.getParameter("quizname").split("~")[1].replace("<", "&lt;");
String courseID = session.getAttribute("courseID").toString();
//System.out.println("quizid quizname courseID ~~~~~~~~~~~~~~"+quizid +" "+quizname +" "+courseID);
QuizHelper quizHelper = new QuizHelper();
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Quiz</title>
		<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
		<link type="text/css" rel="stylesheet" href="../../css/style.css">
		<script src="../../js/quiz.js"></script>
		<script src="../../js/jquery-1.9.1.js"></script>		
		<style type="text/css">
			._css3m{
				display:none
			}
			.question{
				margin-left: 10px;
			}
			.optns{
				margin-left: 30px;
				display: none;
			}
			
		</style>		
	</head>
	<body onload="quizPreview('<%=quizid%>', '<%=courseID%>')" class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
		<%@ include file= "../../jsp/includes/menuheader.jsp" %>
		<table class="table1">
			<tr><td width="40%">
				<div style="margin-top: 10px;margin-left:30px; float: left;width: 220px;">
					Quiz ID : <%=quizid%><br/>
					Quiz Name : <%=quizname%>				
				</div>
				<div style="margin-top: 15px;margin-left:0px; float: left;"><input id="isShowAns" type="checkbox" value="Answer" checked="checked"/>Show Answer</div>
				</td>
			<td width="20%">
				<div class="ui-header-text"><h2 style="display: inline;">Quiz</h2><input id="showQOptions" style="margin-left: 20px;" onchange="showOptions(this)" type="checkbox" value="showoption" />&nbsp;Show Option</div>
			</td>
			<td width="40%">				
				<div id="quizresponsestatus" style="margin-left: 60px;float: left;margin-top: 30px">Responses : 0 / <%=quizHelper.getNoofStudent(courseID)%>	</div>
				<div id="endquiz_div" style="display: inline; display: none;">
					<button class="ui-conductquiz-button"  id="endquiz" type="button" onclick="endQuiz('<%="normalquiz"%>')" style="margin-left: 20px;" >
						<span>End Quiz</span>
					</button>
				</div>
				<div class="ui-header-text" style="float: right;"><h1 id="timer">00 : 00 </h1></div>
				</td>
			</tr>
		</table>
		<table class="table1" style="margin-top:5px;" border="1">
			<tr><td>
				<div id="quizPreview" style="font-size: 18px; height:400px;overflow: auto; text-align: justify;"></div>
			</td></tr>
		</table>
		<table class="table1" id="quizLauncher" style="margin-top:5px; display: block;">
			<tr><td>
				<div id = "launcher">
				<form name="Timer" ><br>
					<div style="font-size: 14px; font-weight: bold;margin-left:430px;">Select Time for Quiz</div><br>
					<div style="font-weight: normal; margin-left:410px;">
						Minutes <input type="text" style="width: 30px" id="minutes" value="00" /> 
						Seconds <input type="text" style="width: 30px"id="seconds" value="40" />
						<div class="ui-header-text" style="display: inline"><input style="margin-left: 20px;" id="negativemarking" type="checkbox" value="negativemarking" />&nbsp;Negative Marking</div> 
					</div>
					<button class="ui-conductquiz-button"  id="pre" type="button" onclick="launchQuiz('<%=courseID%>')" style="margin-left:460px;">
						<span>Launch quiz</span>
					</button>
				</form>
				</div>
			</td></tr>
		</table>
		<div id="quizrecordid" style="display: none;"></div>
		<div id="tempdata" style="display: none;"></div>
		<div style="margin-top:-600px;">
			<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		</div>
	</body>
</html>