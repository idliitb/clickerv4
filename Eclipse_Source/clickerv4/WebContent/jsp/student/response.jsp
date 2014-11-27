<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Instant Report</title>
<%
	if (session.getAttribute("StudentID") == null) {
		response.sendRedirect("studentexit.jsp");
		return;
	}

	String quiz_json = request.getParameter("hdn_quiz").replace("'", "`~");
	String student_response_json = request.getParameter("hdn_responseJSON");
	
	System.out.println("quiz - " + quiz_json);
	System.out.println("responseJSON - " + student_response_json);
%>

<style type="text/css">
body{
	position:relative;
	text-align:center;
	width:100%;
	height:100%;
	margin:auto;
	background-color: #404040;
}

#quizreport-container{
	margin:auto;
	width:1290px; 
	height:590px;	
	background-color: #404040;	
}

#quizreportheader{
	width:1270px; 
	height:120px; 
	margin-top:10px; 
	margin-left:20px; 
	font-size:20px; 
	color:#FFFFFF; 
	text-align:center;
}

#quizreportheader td{
	text-align: left;
	padding-left: 20px;
}

.quizreporttable{
	width:1260px;
	margin-top:0px;
	border-collapse: collapse;
	margin-left:20px;
}

.quizreporttable th{
	background-color: #9bbb59;
	height:60px; 
	font-size:18px;
}

.quizreporttable td{
	background-color: #FFFFFF; 
	border: 2px solid black;
	height:50px;
	max-height:60px; 
	font-size:18px;
}

#quizreport{
		width: 1300px;
		height: 370px;
		overflow: auto;		
}

#quizreport td{
		padding-left: 15px;
}
</style>

<script type="text/javascript">
function showReport( )
{
	var quiz_json = JSON.parse((document.getElementById("quiz_json").value).replace(/`~/g, "'"));
	var student_response_json = JSON.parse(document.getElementById("student_response_json").value);
	var courseid = quiz_json.courseId;
	var studentid = student_response_json.response.studId;
	var quiz_report_table = "<table class='quizreporttable' border = '1'>";
	
	for(var i = 0; i < quiz_json.questions.length; i++)
	{
		var student_response = student_response_json.response.options[i];
		var result, option = "";
					
		if(student_response != "Z")
		{
			if((quiz_json.questions[i].correctAns == student_response))
				result = "Right";
			else
				result = "Wrong";
			
			if(quiz_json.questions[i].type == 3)
				option = student_response;
			else if((quiz_json.questions[i].type == 2))
			{
				for(var j = 0; j < student_response.length; j++)
					option += quiz_json.questions[i].options[(student_response.charCodeAt(j) - "A".charCodeAt(0))].optiontext + ", ";
					
				option = option.substring(0, option.length - 2);						
			}
			else
			option = quiz_json.questions[i].options[(student_response.charCodeAt(0) - "A".charCodeAt(0))].optiontext;
		}			
		else
		{
			result = "No Response";
			option = student_response;
		}
		
		
			quiz_report_table += "<tr style = 'width: 1260px'> <td style = 'width: 85px; text-align: center;'>" + (i + 1) + "</td> <td>" 
								+ quiz_json.questions[i].text + "</td> <td style = 'width: 141px; text-align: center;'>" 
								+ student_response + "</td> <td style = 'width: 286px;'>" + option + 
								"</td> <td style = 'width: 134px'>" + result + "</td> </tr>";
		
	}
	quiz_report_table += "</table>";

	document.getElementById("td_cid").innerHTML = courseid;
	document.getElementById("td_sid").innerHTML = studentid;
	document.getElementById("quizreport").innerHTML = quiz_report_table;
}
</script>	
</head>
<body onload = "showReport();">
<br>	
<div id = "quizreport-container">

	<input id = "quiz_json" type = "hidden" value = '<%= quiz_json %>'/>
	<input id = "student_response_json" type = "hidden" value = '<%= student_response_json %>'/>
	
	<table id="quizreportheader">
	<tr>
		<td>Course ID</td>
		<td id="td_cid"></td>
		<td style="width:140px;">Student ID</td>
		<td style="width:310px;" id="td_sid"></td>		
		<td rowspan="2" style="width:70px;">
			<img src="../../img/Home05.png" style="width: 70px;height: 70px;" 
				onclick="window.location.href='home.jsp'">
		</td>
	</tr>	
	</table>
	
	<table class="quizreporttable">
	<tr>
		<th style="width: 100px;">Question No</th>
		<th style="">Question</th>
		<th style="width:155px;">Your Response</th>
		<th style="width:300px;">Your Response Value</th>
		<th style="width:150px;">Result</th>
	</tr>
	</table>
	<div id = "quizreport"></div>

	</div>
</body>
</html>