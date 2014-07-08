<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! String InstrID; %>
<%
String instrid=(String)session.getAttribute("InstructorID"), courseid = (String)session.getAttribute("courseID");
InstrID = instrid;
System.out.println("instrid: " + instrid);
//session.setAttribute("instrid",insid);
if (instrid == null) {
	request.setAttribute("Error","Your session has expired.");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
}

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Create Quiz</title>
<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<script type="text/javascript" src="createquiz.js"></script>
<style type="text/css">
._css3m{
display:none
}
</style>

<script type="text/javascript">
function validate(InstrID) {
	document.getElementById('InstrID').value=InstrID;
	//var quiztype = document.getElementById('QuizTypeName').value;
	var x = document.forms["createquiz"].elements["quizName"].value;
	var z = document.getElementById("select2").value;
	var y = document.forms["createquiz"].elements["durationM"].value;
	var w = document.forms["createquiz"].elements["durationS"].value;
	var i = 1;
	var cnt = document.getElementById("count").value;
	//alert("count: " + cnt);
	if (cnt == 0) {
		alert("Please add some questions");
		return false;
	}
	else if (x == null || x == "" || x.trim() == "") {
		alert("Please Fill Quiz name!!!");
		return false;

	} else if (((y == null || y == "" || y.trim() == "") && 
			(w == null || w == "" || w.trim() == "")) || isNaN(w) == true 
			|| isNaN(y) == true || (w < 0) || (y < 0) || (w.indexOf(".") != -1) || (y.indexOf(".") != -1)) {
		alert("Invalid time");
		return false;
	}
	 else {
		alert("You have successfully Added a new Quiz.\nThank you");
		
	}
	
}
</script>
</head>

<body class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
<%@ include file= "../../jsp/includes/menuheader.jsp" %>
<!--  <form class="form-4" >-->
<div id = "cq" class = "form-4">
<table class="table1" border = '0'>

<tr >
<td style="margin:10px 0 0 0px">
<div class="ui-createquiz-text" >
<h2><label> Create quiz</label></h2></div>
</td>
</tr>
<tr>
<td>
<input id="searchbox"  style="width:380px; font-size:14px;margin:0px 0 0 320px" type="search" name="searchopt"  placeholder="Search" onkeyup="loadQuestions('<%=instrid%>', '<%=courseid%>')"/>
</td>
</tr>

<tr>
	<td style="margin-top:20px;padding-left:80px;"> <br>
<p style="margin-bottom: -20px;">Select the Question Type :</p>
 	<div>	
				<section style="margin:0px 0 0 210px;margin-top:0px">
			
				<div id = "selectq-type">
					 <select id = "questiontype" onchange = "loadQuestions('<%=InstrID%>', '<%=courseid%>');" name="cd-dropdown" class="cd-select">
						<option value="0" >All Questions</option>
						<option value="1" >Single Choice correct</option>
						<option value="2" >Multiple Choice correct</option>
						<option value="3" >Numerical Answer</option>
						<option value="4" >True or False</option>
					</select>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input id = "allquest" name = "allquest" type = "checkbox" onclick="loadQuestions('<%=InstrID%>', '<%=courseid%>');"/>&nbsp;Show All Questions in the course <font color="green"><%=courseid %> </font>
				</div>				
			</section>
			
	</div> 
</td>
</tr>
</table>

<form id="createquiz" action="../../quizCreator" name="createquiz" method="POST" onsubmit= "return validate('<%=InstrID%>');">
				<input type="hidden" name="QuizTypeName" id="QuizTypeName">
				<input type="hidden" name="InstrID" id="InstrID">
				
<table class="table1" style=" margin:auto;margin-top:2px;">

<tr>
	<td>
		<div style=" margin: 10px 0 0 25px;" >
			<label style = "margin-left: 175px; font-weight: bold;">All Questions</label><br>
			<select class="" size="14" name="select1" id="select1" style="width: 450px; height:250px;" onchange="loadOptions(1)">
			<script type="text/javascript">
					loadQuestions('<%=instrid%>', '<%=courseid%>');
			</script>
			</select>
		</div>
	</td>

<td style="padding-right:5px">
<div>
<button id="logbtn1" type="button" class=" ui-rightbutton " onclick="addOrRemove(1)" value= " >> " >
<span style="font-size:10px;font-weight:bold;"> >> </span>
</button>
</div>
<br>
<div>
<button id="logbtn2" type="button" class=" ui-leftbutton " onclick="addOrRemove(2)" value= " << " >
<span style="font-size:10px;font-weight:bold;"> << </span>
</button>
</div>
</td>

<td style="padding-right:20px"> 
<div style=" margin: 10px 0 0 0px;" >
<label style = "margin-left: 165px; font-weight: bold;">Selected Questions</label><br>
<select size="10" multiple="multiple" name="select2" id="select2" style="width: 450px; height:250px;" onchange="loadOptions(2)">

</select>
</div>
</td>
</tr>

<tr><td>
		<div style="margin-left:20px; margin-top: 15px;"><label style = "text-align:center; margin-left: 160px; font-weight: bold;">Options</label></div>
			<div id = "optionsDiv" class = "questions" style="font-size: 18px; overflow: auto; text-align: justify;margin-left: 20px;margin-top:10px;">
			<p style = " margin-top: -1px; font-size: 15px; font-weight: bold; text-align: left;"> </p>
		</div>
	</td>

</tr>

</table>

<table class="table1" style="margin-top:10px;">
<tr>
<td style="padding-left:250px;">
<div  style="margin-top:20px;margin-bottom:20px;  margin-left: 80px;" >
<label>Quiz name</label><br>
<input id="quizName" type="text" name="quizName" placeholder = "Enter Quiz Name"/>
</div>
</td>

<td  style="padding-right:10px;">
<div style="margin-top:20px;margin-bottom: -1px;">
<label style = "margin-left: 25px;">Duration</label><br>
<input id="durationM"  style = "width: 40px; margin-left: 20px;" placeholder = "Mins" type="text" name="durationM" size="2" maxlength="2" />&nbsp;
<input id="durationS"  style = "width: 40px;" placeholder = "Sec" type="text" name="durationS" size="2" maxlength="2" /><br>
&nbsp;&nbsp;&nbsp;&nbsp;Mins &nbsp; Sec
<input type="hidden" value="0" id="count" name="count"/>
</div>
</td>

<td style="padding-right:250px">
<div style="margin-top:20px;margin-bottom:20px;">	
<button class="ui-createquiz-button" id="createqbtn1" type="submit">
<span>Create quiz</span>
</button>
</div>
</td>

</tr>
</table>
</form>

<br>
<!-- </form> -->
</div>
<div style="margin:-615px 0 0 0px;">
<%@ include file= "../includes/menufooter.jsp" %>
</div>


</body>
</html>