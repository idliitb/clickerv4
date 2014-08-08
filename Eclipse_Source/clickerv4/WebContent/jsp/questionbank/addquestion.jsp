<%-- @Author Harshavardhan, Clicker Team, IDL, IIT Bombay--%>

<%
String instructorID = (String) session.getAttribute("InstructorID");
if (instructorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Question</title>
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
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
function addQ()
{
	
try
{
	var qtype = (document.getElementById("qtypeselect").options[document.getElementById("qtypeselect").selectedIndex].value);
	//alert("qtype: " + qtype);
	
	switch(qtype)
	{
		case '1': $('#addq').load("singlechoice.jsp");
		break;
		case '2': $('#addq').load("multichoice.jsp");
		break;
		case '3': $('#addq').load("numeric.jsp");
		break;
		case '4': $('#addq').load("truefalse.jsp");
		break;
	}
	
}
catch(err)
{
	alert("Error: " + err.message);
}
}

$(document).ready(function(){
	<%if(request.getParameter("fileUploadStatus")!=null){%>
	alert('<%=request.getParameter("fileUploadStatus")%>');
	<%}%>
});
</script>
<body class="ui-Mainbody" style="width:100%; height:100%; text-align: center;" onload = "addQ( );">
<%@ include file= "../includes/menuheader.jsp" %>

<table class="table1">
<tr >
<td >
<div class="ui-header-text" >
<h2><label>Add Question</label></h2></div>
</td>
</tr>
</table>

<table class="table1" style="margin-top:2px;" >
<tr>
<td style="margin:auto;padding-left:20px;">
<p style="margin:-8px 0 0 180px">Select Question Type</p>
 	<div>	

			<section style="margin:10px 0 0 180px;margin-bottom:50px;">
			
				<div>
					<select id="qtypeselect" name="cd-dropdown" class="cd-select" onchange = "addQ( );">
						<option value="1" >Single Choice correct</option>
						<option value="2" >Multiple Choice correct</option>
						<option value="3" >Numerical Answer</option>
						<option value="4" >True or False</option>
					</select>
				</div>				
			</section>
	</div>
</td>

<td class="table2" >
</td>

<td style="margin:auto;margin-left:20px;">
<p style="margin-top:0px;margin-left:100px;">Upload question</p>

<div style="margin:0px 0 0 100px;">

<input id="file" type="file" name="xls"  />
<br>
<a href="../../xlstemplates/Question_Template.xls">Question Template</a>
<button class="ui-conductquiz-button"  id="pre" type="button" style="margin-left:45px;" onclick = "uploadXLS();">
<span>Preview</span>
</button>
</div>
</td>

  
</tr>
</table>


<div id="dialog" title="File Preview" style = "visibility: hidden;">
<form action="xlsupload.jsp" method="get" id="uploadForm">
	<iframe id="frame" style = "height: 0px;width: 0px;">
	</iframe ><br/><br/>
	
		<input type="hidden" name=xls id="xls">
		<input type="submit" value=" Add Questions "/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value=' Cancel ' onclick="closeDialog();"/>
	
</form>
</div>

<div id = "addq"></div>

<div style="margin-top:-605px;"> 
<%@ include file= "../includes/menufooter.jsp" %>
</div>
</body>
</html>