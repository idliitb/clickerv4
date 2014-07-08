<%--@author rajavel 
This jsp file is used to display instant quiz
--%>

<%
String InstructorID = (String) session.getAttribute("InstructorID");
if (InstructorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
String courseID = session.getAttribute("courseID").toString();
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Instant Quiz</title>
		<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
		<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
		<link type="text/css" rel="stylesheet" href="../../css/style.css">
		<link type="text/css" rel="stylesheet" href="../../css/radio.css">
		<script src="../../js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="../../js/quiz.js"></script>
		<style type="text/css">
			._css3m{
				display:none
			}			
		</style>
	</head>
	<body onload="displayOptions('4')" class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
		<%@ include file= "../../jsp/includes/menuheader.jsp" %>
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
		<table class="table1" style="margin-top:2px;">
			<tr><td>
				<div class="ui-createquiz-text" >
					<h3>Select number of options</h3>
				</div>
				<div style="text-align: center;">	
					<select name="noofOptions" id="noofOptions" onclick="displayOptions(this.value)">
						<option value="2">&nbsp;2&nbsp;</option>
						<option value="3">&nbsp;3&nbsp;</option>
						<option value="4" selected>&nbsp;4&nbsp;</option>
						<option value="5">&nbsp;5&nbsp;</option>
						<option value="6">&nbsp;6&nbsp;</option>
					</select>
				</div><br/><br/>
				<div  id= "optionscorrect" style="text-align: center;">					
				</div>
			</td></tr>
		</table>
		<table class="table1" id="quizLauncher" style="margin-top:5px; display: block;">
			<tr><td>
				<div id = "launcher" style="text-align: center;">
				<form name="Timer" ><br>
					<div style="font-size: 14px; font-weight: bold;margin-left:430px;">Select Time for Quiz</div><br>
					<div style="font-weight: normal; margin-left:410px;">
						Minutes <input type="text" style="width: 30px" id="minutes" value="00" /> 
						Seconds <input type="text" style="width: 30px"id="seconds" value="40" />
					</div>
					<button class="ui-conductquiz-button"  id="pre" type="button" onclick="launchInstantQuiz('<%=courseID%>', '<%=InstructorID%>')" style="margin-left:460px;">
						<span>Launch quiz</span>
					</button>
				</form>
				</div>
			</td></tr>
		</table><br><br>
		<div id="quizrecordid" style="display: none;"></div>
		<div id="tempdata" style="display: none;"></div>
		<div style="margin-top:-600px;">
			<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		</div>
	</body>
</html>