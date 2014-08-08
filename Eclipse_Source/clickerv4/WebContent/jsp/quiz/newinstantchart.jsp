<%--@author Dipti.G  from Clicker Team, IDL LAB -IIT Bombay
This jsp file is used to display quiz response chart after end of quiz for instant quiz
--%>
<%--
@Credit - Highcharts
	http://api.highcharts.com/highcharts
--%>
<%@page import="clicker.v4.quiz.QuizResponseHelper"%>
<%@page import="clicker.v4.global.Global"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
String InstructorID = (String) session.getAttribute("InstructorID");
if (InstructorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
String courseID = session.getAttribute("courseID").toString();
boolean isShowAns = Boolean.parseBoolean(request.getParameter("isShowAns"));
int quizrecordid = Global.quizrecordids.get(courseID);
QuizResponseHelper quizResponseHelper = new QuizResponseHelper();
String questionids = quizResponseHelper.getInstantQuestionIDs(quizrecordid);
String chartString=quizResponseHelper.getInstantQuestionResponseCount(quizrecordid);
String[] countString= chartString.split("@");
String rightvalue=countString[0];
String wrongvalue=countString[1].toString();
String noreponsevalue=countString[2];
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Quiz Response</title>
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<script src="../../js/instantresponse.js"></script>
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>
<script src="../../js/jquery-ui.css"></script>
<style type="text/css">
ol {
	list-style-type: upper-alpha;
}
</style>
</head>
<body
	onload="overallGraph('<%=questionids %>','<%=rightvalue%>','<%=wrongvalue%>','<%=noreponsevalue%>','<%=InstructorID%>', <%=isShowAns%>)"
	class="ui-Mainbody"
	style="width: 100%; height: 100%; text-align: center;background-color: white;">
	<%@ include file="../../jsp/includes/menuheader.jsp"%>
	<script src="../../js/highcharts.js"></script>
	<table class="table1">
			<tr><td>
				<div class="ui-header-text" id="loading">
					<h2 style="display: inline;">Please wait responses are still getting collected hence chart will get update...  <img style='margin-left: 10px; margin-top: 0px; width : 73px; height : 73px;' src='../../img/ajax_loader_green_512.gif'></img>  </h2>
				</div>
				<br>
				<div style="color: #000; display: inline;font-size: 20px; margin-left: 50px;">
					<input type="checkbox" id="showCorrectAnsChart" name="showCorrectAnsChart" checked="checked" onchange="showCAnsChart(this)"> Show Answer
				</div>						
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
	<div style="margin-top: -600px;">
		<%@ include file="../../jsp/includes/menufooter.jsp"%>
	</div>
</body>
</html>