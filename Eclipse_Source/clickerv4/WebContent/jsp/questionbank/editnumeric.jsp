<%-- @Author Harshavardhan, Clicker Team, IDL, IIT Bombay--%>

<%@ page import="java.sql.*" %>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.io.PrintWriter"%>

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
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<style type="text/css">
._css3m{
display:none
}
</style>

<script type="text/javascript">
function validateForm()
{
	var x=document.forms["numericeditform"]["editnumericquest"].value;
	var y=document.forms["numericeditform"]["numericanswer"].value;
	if (x==null || x=="" || x.trim()=="")
	{
	  	alert("Question must be filled!!!");
	  	return false;
  	}
	if (y==null || y=="" || y.trim()=="")
	{
		alert("Answer must be filled!!!");	
		return false;
	}
	if ((isNaN(y)==true) || (y == "^[a-zA-Z]*"))
	{
		alert("Enter answer between 0-9");
		return false;
	}
	if(isNaN(document.getElementById("credits").value) || (document.getElementById("credits").value == "") || (document.getElementById("credits").value < 0)){
		alert("Please Enter a valid number in Credits");
		return false;
	}
	else if(isNaN(document.getElementById("negativemarks").value) || (document.getElementById("negativemarks").value == "" || (document.getElementById("negativemarks").value < 0)))
	{
		alert("Please Enter a valid number in Negative mark");
		return false;
	}
	else
	{
		alert("Question Submitted Successfully!");
		return true;
	}
}
</script>

</head>

<%
Connection conn = null;
DatabaseConnection dbconn = new DatabaseConnection();
conn = dbconn.createDatabaseConnection();
Statement st = conn.createStatement();
String qid=request.getParameter("qid");
%>

<body class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">

<div id="single_choice" >
<form class="form-4" action="../../numericeditdb?qid=<%= qid %>" name="numericeditform"  method="post" onsubmit ="return validateForm()">

<table class="addquestion-subpt" border="1" style = "width: 710px;">

<tr >
<td >
<div class="ui-createquiz-text" style="margin-left:auto;" >
<% 
PrintWriter pw = response.getWriter();

String query1 = "SELECT Question, NegativeMark FROM question WHERE QuestionID='"+qid+"'";
String question = null;
float negativemarks = 0;
ResultSet rs22 = st.executeQuery(query1);
while(rs22.next())
{
	question = rs22.getString("Question");
	negativemarks = rs22.getFloat("NegativeMark");
}
rs22.close();
%>

<label style="font-size:16px;"> Numeric Question</label></div>
<br>
<textarea id="editnumericquest" cols="25" rows="5" style="width:800px; font-size:14px;margin:0px 0 0 0px"
 type="text" name="editnumericquest"  placeholder="Enter your question here..."><%=question %></textarea>
<br>
<%
String ans="";
String query = "select OptionValue, Credit from options where QuestionID="+qid+"";
ResultSet rs=st.executeQuery(query);
float credits = 0;
while(rs.next())
{
	ans = rs.getString("OptionValue");
	credits = rs.getFloat("Credit");
}
rs.close();
st.close();
dbconn.closeLocalConnection(conn); 
%>
<br>
<span style="margin-left:120px;"></span>Answer :
<span style="margin-left:10px;"></span><input id="ans_a" type="text" value = "<%=ans%>" name="numericanswer" style="width:250px;"/>
<span style="margin-left:10px;"></span>
<br>

<div style="margin:0px 0 0 0px;margin-bottom:5px;">
	<span style="margin-left:130px;">Credits:</span> <input id = "credits" name = "credits" type = "text" style = "width: 50px; margin-bottom:20px;margin-left:7px;" value = "<%=credits%>" />
	<span style = "margin-left: 20px">Negative Marks:</span> <input id = "negativemarks" name = "negativemarks" type = "text" style = "width: 50px; margin-bottom:20px;margin-left:5px;" value = "<%=negativemarks%>" />
	
	<button class="ui-conductquiz-button" style = "height: 38px;margin-left: 30px;" id="numericsubmit" type="submit" >
		<span>Save</span>
	</button>
<!--<button class="ui-conductquiz-button" id="numericcancel" type="button" onclick="javascript:history.back()">
<span>Cancel</span>
</button> -->
</div>

</td>
</tr>

</table>
</form>
</div>



</body>
</html>