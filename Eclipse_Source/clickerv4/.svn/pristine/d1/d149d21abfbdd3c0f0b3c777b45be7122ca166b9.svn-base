<%--@author rajavel 
This jsp file is used for display instant response chart 
--%>
<%@page import="clicker.v4.quiz.QuizResponseHelper"%>
<%@page import="clicker.v4.global.Global"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<% 
String InstructorID = (String) session.getAttribute("InstructorID");
if (InstructorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}

String courseID = session.getAttribute("courseID").toString();
int quizrecordid = Global.quizrecordids.get(courseID);
QuizResponseHelper quizResponseHelper = new QuizResponseHelper();
String questionids = quizResponseHelper.getInstantQuestionIDs(quizrecordid);
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Instant Quiz Response</title>
		<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
		<link type="text/css" rel="stylesheet" href="../../css/style.css">
		<script src="../../js/instantresponse.js"></script>
		<script src="../../js/jquery-1.9.1.js"></script>
		<script src="../../js/jquery-ui.js"></script>
		<link type="text/css" rel="stylesheet" href="../../css/jquery-ui.css">
	</head>
	<body onload="getInstantChartMQ('<%=InstructorID%>' , '<%=questionids%>', 'withoutcorrect')" class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
		<%@ include file= "../../jsp/includes/menuheader.jsp" %>
		<table class="table1">
			<tr><td>
				<div class="ui-header-text"><br/><h2 style="display: inline;">Instant Quiz Response Chart </h2> <input style="margin-left: 20px;" onchange="showInstantCorrectMQ('<%=InstructorID%>', '<%=questionids%>', this)" type="checkbox" value="showcorrect" />&nbsp;Show Correct Answer </div><br/>
			</td>
			</tr>
		</table>
		<table class="table1" style="margin-top:5px;" border="1">
			<tr><td>
				<div id="quizresponse" style="font-size: 18px; height:400px;overflow: auto; text-align: center;"><img style="margin-top: 150px;" src="../../img/loading.gif"/></div>
			</td></tr>
		</table>
		<div id="ResponseDialog" style="display: none;"></div>
		<div style="margin-top:-600px;">
			<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		</div>
	</body>
</html>