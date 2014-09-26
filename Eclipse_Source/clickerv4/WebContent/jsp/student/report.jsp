<%--@author rajavel, Clicker Team, IDL Lab - IIT Bombay
	This jsp file is used for student quiz results--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Student Report</title>
<%
	if (session.getAttribute("StudentID") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	String studentID = session.getAttribute("StudentID").toString();	
	if(request.getParameter("cid")==null){
		response.sendRedirect("home.jsp");
		return;
	}
	String CourseID = request.getParameter("cid");
%>
<style>
	body{
		position:relative;
		text-align:center;
		margin:auto;
		background-color: #404040;
		}
	#report-container{
		margin:auto;
		width:1290px; 
		height:610px;	
		background-color: #404040;
	}
	#reportheader{
		width:1270px; 
		height:120px; 
		margin-top:10px; 
		margin-left:20px; 
		font-size:20px; 
		color:#FFFFFF; 
		text-align:center;
	}
	#reportheader td{
		text-align: left;
		padding-left: 20px;
	} 
	#report{
		width: 1300px;
		height: 370px;
		overflow: auto;		
	}
	#report td{
		padding-left: 15px;
	}
	.reporttable{
		width:1260px;
		margin-top:0px;
		border-collapse: collapse;
		margin-left:20px;
	}
	.reporttable th{
		background-color: #9bbb59;
		height:60px; 
		font-size:18px;
	}
	.reporttable td{
		background-color: #FFFFFF; 
		border: 2px solid black;
		height:50px;
		max-height:60px; 
		font-size:18px;
	}	
</style>

<script type="text/javascript">
var xmlhttp;
//This method will get the XMLHTTP object for work with ajax
function getXMLhttp() {
	if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else if (window.ActiveXObject) { // IE
		try {
			xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
			}
		}
	}
}
function getStudentReport(cid, sid, mode){
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var report = JSON.parse(xmlhttp.responseText);
			if(report.studentID=="" || report.studentID == null){
				alert("Report not found");
				return;
			}			
			document.getElementById("rptDownload").style.display="block";
			document.getElementById("td_sid").innerHTML = report.studentID;
			document.getElementById("td_sname").innerHTML = report.studentName;
			document.getElementById("td_cid").innerHTML = report.courseID;
			document.getElementById("td_cname").innerHTML = report.courseName;
			var reporttable = "<table class='reporttable'>";
			for(var i=0;i<1;i++){
				reporttable += "<tr style='width: 600px'><td>" + report.quizMarks[i].quizName + 
				"</td><td style='width: 210px'>" + report.quizMarks[i].quizTime + 
				"</td><td style='width: 120px'>" + report.quizMarks[i].totalMark + 
				"</td><td style='width: 120px'>" + report.quizMarks[i].totalMark + 
				"</td><td style='width: 140px'>" + report.quizMarks[i].percentage + "</td></tr>";				
			}
			for(var i=1;i<report.quizMarks.length;i++){
				reporttable += "<tr ><td>" + report.quizMarks[i].quizName + 
				"</td><td>" + report.quizMarks[i].quizTime + 
				"</td><td>" + report.quizMarks[i].totalMark + 
				"</td><td>" + report.quizMarks[i].totalMark + 
				"</td><td>" + report.quizMarks[i].percentage + "</td></tr>";
			}
			reporttable += "<table>";
			document.getElementById("report").innerHTML = reporttable;			
		}
	};	
	xmlhttp.open("GET", "../../rest/quiz/result/"+cid+"/"+sid+"/local", false);
	xmlhttp.send();
}
</script>
</head>
<body onload="getStudentReport('<%=CourseID%>', '<%=studentID%>', 'local')">
<div id="report-container">
	<table id="reportheader">
	<tr>
		<td style="width:140px;">Student ID</td>
		<td style="width:310px;" id="td_sid"></td>
		<td style="width:180px;">Student Name</td>
		<td style="width:370px;" id="td_sname"></td>
		<td rowspan="2" style="width:70px;">
			<img src="../../img/Home05.png" style="width: 70px;height: 70px;" 
				onclick="window.location.href='home.jsp'">
		</td>
	</tr>
	<tr>
		<td>Course ID</td>
		<td id="td_cid"></td>
		<td>Course Name</td>
		<td id="td_cname"></td>
	</tr>
	</table>
	<table class="reporttable">
	<tr>
		<th style="width: 560px">Quiz Name</th>
		<th style="width: 180px">Quiz Time</th>
		<th style="width: 120px">Total Marks</th>
		<th style="width: 120px">Marks Obtained</th>
		<th style="width: 140px">Percentage(%)</th>
	</tr>
	</table>
	<div id="report">			
	</div>
	<div id="rptDownload" style="margin-left: 1180px;display: none;">
		<a href="../../DownloadPDF?reptype=stud&cid=<%=CourseID%>&sid=<%=studentID%>&repname=StudentResult_Chart" target='_blank'> 
			<img style="width:80px;height: 60px;" src="../../img/Download05.png">
		</a>
	</div>
</div>
</body>
</html>