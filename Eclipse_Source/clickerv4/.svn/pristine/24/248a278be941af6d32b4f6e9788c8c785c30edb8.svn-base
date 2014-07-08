<%--@author rajavel 
This jsp file is used for quiz dashboard
--%>
<%--
@Credit - Highcharts
	http://api.highcharts.com/highcharts
--%>
<%@page import="clicker.v4.report.ReportHelper"%>
<%
String InstructorID = (String) session.getAttribute("InstructorID");
if (InstructorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}else if(!session.getAttribute("admin").toString().equals("2")){
	request.setAttribute("Error","You dont have privelage to access this page");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>HOD Dash-board</title>
		<link type="text/css" rel="stylesheet" href="../../css/style.css">
		<link type="text/css" rel="stylesheet" href="../../css/reportdashboard.css">
		<link type="text/css" rel="stylesheet" href="../../css/jquery-ui.css">
		<script src="../../js/jquery-1.9.1.js"></script>
		<script src="../../js/jquery-ui.js"></script>
		<script src="../../js/hodreportdashboard.js"></script>		
	</head>
	<body onload="loadDOMCoursesData('<%=InstructorID%>')" class="ui-Mainbody" style="width:100%; height:100%; text-align: center; background-color: #fff;">
		<%@ include file= "../../jsp/includes/menuheader.jsp" %>
		<script src="../../js/highcharts.js"></script>		
		<table class="table1">
			<tr ><td >
				<div id="qtype" style="display: inline; margin-left: 20px;">
					<input type="radio" checked="checked" name="reporttype" value="QuizResponse" />Quiz Report
					<input type="radio" name="reporttype" value="QuizResult" />Quiz Result
				</div>
				<div class="ui-header-text"  style="display: inline;margin-left: 240px;"><h2 style="display: inline;">HOD Dash-board</h2></div>
			</td></tr>
		</table>
		<div id="HODDashboard">
		</div>		
		<div id="tempdiv" style="display: none;"></div>
		<div id="quizreport"> 
			<div id="dlg_header"></div>
			<div id="dlg_body"></div>
		</div>
		<div style="margin-top: -600px;">
			<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		</div>
	</body>
</html>