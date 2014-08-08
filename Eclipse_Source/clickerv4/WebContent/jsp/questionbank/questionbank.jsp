<%-- @Author Harshavardhan, Clicker Team, IDL, IIT Bombay--%>

<%@ page language="java" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>



<%

String InstructorID = (String) session.getAttribute("InstructorID");
String courseid = (String) session.getAttribute("courseID");
//session.setAttribute("instructorid",InstructorID);
//System.out.println("Instructor ID is : " + InstructorID);
//InstrID=InstructorID;
System.out.println("Instructor ID is : " + InstructorID);

if (InstructorID == null) {
	request.setAttribute("Error","Your session has expired.");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
}

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Question Bank</title>
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>
<script type="text/javascript" src="questionbank.js"></script>


<style type="text/css">
._css3m{
display:none
}
</style>

</head>

<script>
$(document).ready(function(){
	<%if(request.getParameter("fileUploadStatus")!=null){%>
	alert('<%=request.getParameter("fileUploadStatus")%>');
	<%}%>
});
</script>

<body class="ui-Mainbody" style="width:100%; text-align: center;" onload = "loadQuestion('<%=InstructorID%>', '<%=courseid%>');">

<%
	int sumcount=0; 	
	String question= "";
	if(request.getParameter("question")!=null && request.getParameter("question")!="")
    {
		question = request.getParameter("question").toString();
	}
%>
<%@ include file= "../includes/menuheader.jsp" %>
<div class="form-4">
<table class="table1" style="background-color:disable;">
<tr >
<td >
<div class="ui-header-text" >
<h2><label>Question Bank</label></h2></div>
</td>
</tr>
</table>

<table class="table1" style="margin-top:2px;" border='0'>
<tr>
<td style="margin:auto;padding-left:80px;">
<p style="margin-bottom:-20px">Select the Question Type :</p>
 	<div style="margin-bottom:-15px;">	

			<section style="margin:0px 0 0 210px;margin-top:0px">
			
				<div id = "selectq-type">
					 <select id = "questiontype" onchange = "getQuestions('<%=InstructorID%>', '<%=courseid %>');" name="cd-dropdown" class="cd-select">
						<option value="0" >All Questions</option>
						<option value="1" >Single Choice correct</option>
						<option value="2" >Multiple Choice correct</option>
						<option value="3" >Numerical Answer</option>
						<option value="4" >True or False</option>
					</select>
				</div>				
			</section>
	</div> <br>
	<input id = "allquest" name = "allquest" type = "checkbox" onclick="getQuestions('<%=InstructorID%>', '<%=courseid%>');"/>&nbsp;Show All Questions by other Instructors in <font color="green"><%=courseid %> </font>
</td>

<td rowspan = 2>
	<input id="searchbox"  style="width:400px; font-size:15px;margin:0px 0 0 0px" type="search" name="searchopt"  placeholder="Search" value="<%=question%>" onkeyup="filterQuestions(1);"/>
	<br><br>
		
	<div style = "margin-top: -25px;">	
		<button class="ui-createquiz-button" id="addbox" type="button" value = "Add" onclick = "displayAddbox( );">
		<span style="font-size:15;font-weight:bold">Add Question</span>
		</button>		
	</div>
	
	<div id = "createquiz" style = "margin-left: 140px; margin-top: -54px;">
		<button class="ui-createquiz-button" type = "button" id = "cq_button" style = "background-color: #f1690a; width: 120px; height: 10px;" onclick = "createquiz( );">
			<span id = "cq_span" style = "margin-left: -6px; font-weight: bold;">Create Quiz</span>
		</button>
	</div>  
	
	<div id = "deletequizdiv" style = "margin-left: 278px; margin-top: -54px">
		<button class="ui-createquiz-button" type = "button" id = "deletequizbutton" style = "background-color: #f1690a; width: 120px; height: 10px;" onclick = "deleteQuiz( );">
			<span style = "font-weight: bold;">Delete Quiz</span>
		</button>
	</div>
</td>
	<tr>
		<td style="margin:auto;padding-left:80px;">
			 <input type="checkbox" name="archive" id="archived" onclick="getQuestions('<%=InstructorID%>', '<%=courseid%>');">&nbsp;Show Archived
		</td>
	</tr>

</table>

<br>

<div style = "margin:auto; width: 1050px;">
	<label style = "font-weight: bold; color: #e46c0a; font-size: large;text-align: center;">Questions</label><br><br>
	<div id = "accordion" style="width: 1040px; height:400px; overflow: auto;float: left; margin-left:0px;margin-bottom:30px; border-radius: 15px; border: 3px solid #e46c0a;" >
		<div id = "quest" style="margin-left: 12px; width: 1020px; height:400px;  overflow: auto;"></div>			
	</div>
		
	<form id = "createquizform" method = "post" action = "../../quizCreator" onsubmit = "return validateQuiz('<%= InstructorID%>');">
		<div id = "quiz" style="height: 75px;margin-bottom:-600px; clear:both; display: none;">
			<div style="margin-top: 5px; margin-left: -450px;" >
				<label style = "font-weight: bold;">Quiz name</label><br>
			 <input id="quizName" type="text" name="quizName" placeholder = "Enter Quiz Name"/>
			</div>
			
			<input type = "hidden" id = "count" name = "count" value = "0"/>
			
			<div id = "duration" style = "margin-top: -65px; margin-left: -80px;">
				<label style = "margin-left: 25px; font-weight: bold;">Duration</label><br>
				<input id="durationM" style = "width: 40px; margin-left: 20px;" placeholder = "Mins" type="text" name="durationM" size="2" maxlength="2" />&nbsp;
				<input id="durationS" style = "width: 40px;" placeholder = "Sec" type="text" name="durationS" size="2" maxlength="2" />
			</div>
			
			<div id = "addquiz" style="margin-top:19px;">
				<button id = "quizbutton" class="ui-createquiz-button" type = "submit" style = "margin-top: -77px; 
						margin-left: 200px; width: 87px; height: 10px;">
						<span style = "font-weight: bold;"> Add Quiz</span>				
				</button>
			</div>
		</div>
	</form>
</div>

<div id = "addquestions" style = "display: none;">
	<div style = "width: 1035; margin-top: 10px; height: 35px; border: 2px solid orange; border-radius: 10px;">		
		<div style = "text-align: left; margin-top: 3px;">
			Select the Question Type <select id="qtypeselect" name="cd-dropdown" class="cd-select" onchange = "addQuestions( );">
										<option value="1" >Single Choice correct</option>
										<option value="2" >Multiple Choice correct</option>
										<option value="3" >Numerical Answer</option>
										<option value="4" >True or False</option>
									</select>
		</div>
		<div style="margin: -33px 0px 0px 400px; text-align: right; width: 640px; height: 38px;">
			<span style = "font-weight: bold;">Upload Questions:</span> <a href="../../xlstemplates/Question_Template.xls">Question Template</a>
			<input id="file" type="file" name="xls"  />		
			
			<button class="ui-conductquiz-button" style = "height: 30px; margin-top: 5px; margin-left: -20px" id="pre" type="button" onclick = "uploadXLS();">
				<span>Preview</span>
			</button>
			
			<div id="dialog" title="File Preview" style = "visibility: hidden;">
				<form action="xlsupload.jsp" method="get" id="uploadForm">
					<iframe id="frame" style = "height: 0px;width: 0px;">
					</iframe ><br/><br/>
					
					<input type="hidden" name=xls id="xls">
					<input type="submit" value=" Add Questions "/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value=' Cancel ' onclick="closeDialog();"/>
					
				</form>
			</div>
		</div>
	</div>
	<div id = "addquestframe" style = "margin-top: 15px;">
	</div>
</div>

<div id = "editquestions" style = "display: none;">
	<div id = editbox></div>
</div>

<div id = "deletequestions" style = "display: none">
	<div id = "deletebox"></div>
</div>

<div id = "deletequiz">
	<div id = "deletequizbox"></div>
</div>

</div> 

<div  style = "margin-top: -200px;">
<%@ include file= "../includes/menufooter.jsp" %>
</div>

</body>
</html>