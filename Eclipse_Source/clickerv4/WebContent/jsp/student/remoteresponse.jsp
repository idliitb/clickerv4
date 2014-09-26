<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Instant Report</title>
<%
	if (session.getAttribute("ParticipantId") == null) {
		response.sendRedirect("login.jsp");
		return;
	}

	String quiz_json = request.getParameter("hdn_quiz").replace("'", "`~");
	String participant_response_json = request.getParameter("hdn_responseJSON");
	
	System.out.println("quiz - " + request.getParameter("hdn_quiz"));
	System.out.println("responseJSON - " + participant_response_json);
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
	height:610px;	
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
	var participant_response_json = JSON.parse(document.getElementById("participant_response_json").value);
	var workshopid = quiz_json.courseId;
	var participantid = participant_response_json.response.studId;
	var quiz_report_table = "<table class='quizreporttable' border = '1'>";
	
	for(var i = 0; i < quiz_json.questions.length; i++)
	{
		var participant_response = participant_response_json.response.options[i];
		var result, option = "";
					
		if(participant_response != "Z")
		{
			if((quiz_json.questions[i].correctAns == participant_response))
				result = "Right";
			else
				result = "Wrong";
			
			if(quiz_json.questions[i].type == 3)
				option = participant_response;
			else if((quiz_json.questions[i].type == 2))
			{
				for(var j = 0; j < participant_response.length; j++)
					option += quiz_json.questions[i].options[(participant_response.charCodeAt(j) - "A".charCodeAt(0))].optiontext + ", ";
					
				option = option.substring(0, option.length - 2);						
			}
			else
			option = quiz_json.questions[i].options[(participant_response.charCodeAt(0) - "A".charCodeAt(0))].optiontext;
		}			
		else
		{
			result = "No Response";
			option = participant_response;
		}
		
		
			quiz_report_table += "<tr style = 'width: 1260px'> <td style = 'width: 85px; text-align: center;'>" + (i + 1) + "</td> <td>" 
								+ quiz_json.questions[i].text + "</td> <td style = 'width: 141px; text-align: center;'>" 
								+ participant_response + "</td> <td style = 'width: 286px;'>" + option + 
								"</td> <td style = 'width: 134px'>" + result + "</td> </tr>";
		
	}
	quiz_report_table += "</table>";

	document.getElementById("td_wid").innerHTML = workshopid;
	document.getElementById("td_pid").innerHTML = participantid;
	document.getElementById("quizreport").innerHTML = quiz_report_table;
}
</script>	
</head>
<body onload = "showReport( );">
	
<div id = "quizreport-container">
	<input id = "quiz_json" type = "hidden" value = '<%= quiz_json %>'/>
	<input id = "participant_response_json" type = "hidden" value = '<%= participant_response_json %>'/>
	
	<table id="quizreportheader">
	<tr>
		<td>Workshop ID</td>
		<td id="td_wid"></td>
		<td style="width:150px;">Participant ID</td>
		<td style="width:310px;" id="td_pid"></td>		
		<td rowspan="2" style="width:70px;">
			<img src="../../img/Home05.png" style="width: 70px;height: 70px;" 
				onclick="window.location.href='remotehome.jsp'">
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