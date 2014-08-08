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

<script>
function validateForm1()
{
	//alert("hi");
	var x=document.forms["tfeditform"]["edittfquest"].value;
	if (x==null || x=="" || x.trim()=="")
	{
  		alert("Question must not be empty!");
  		return false;
  	}
	if ( ( tfeditform.option[0].checked == false ) && ( tfeditform.option[1].checked == false ) )
	{
		alert("Please select an Option!"); 
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
%>
<body class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">

<form class="form-4" action="../../truefalseeditdb" name="tfeditform"  method="post" onsubmit="return validateForm1()">

<table class="addquestion-subpt" border="1" style = "width: 710px;">

<tr >
<td >
<div class="ui-createquiz-text" style="margin-left:auto;" >
<% 
PrintWriter pw = response.getWriter();
String qid=request.getParameter("qid");
System.out.println("tf qid: " + qid);
String query1 = "SELECT Question, NegativeMark, Shuffle FROM question WHERE QuestionID='"+qid+"'";
String question = null;
int shuffle = 1;
float negativemarks = 0;
ResultSet rs22 = st.executeQuery(query1);
while(rs22.next())
{
	question = rs22.getString("Question");
	shuffle = rs22.getInt("Shuffle");
	negativemarks = rs22.getFloat("NegativeMark");
}
%>
<label style="font-size:16px;">True or False questions</label></div>
<br>
<textarea id="addques" cols="25" rows="5" style="width:800px; font-size:14px;margin:0px 0 0 0px"
 type="text" name="edittfquest"  placeholder="Enter your question here..."><%= question %></textarea>
<br>
<br>
<%
int i=0;
float credits = 0;
String query = "select OptionValue, OptionID, OptionCorrectness, Credit from options where QuestionID="+qid+"";
ResultSet rs=st.executeQuery(query);
while(rs.next())
{
	credits = rs.getFloat("Credit");
	i++;
%>
<span style="margin-left:100px;"></span>
<span style="margin-left:15px;"></span><input id="radio<%=i %>" <%if(rs.getInt("OptionCorrectness")==1){ %> checked="checked" <%} %> type="radio" value="<%=rs.getString(1)%>" name="option" /><label id="txt<%=i %>" > &nbsp; <%=rs.getString(1)%></label><br id="br<%=i %>" ><br id="2br<%=i %>" >
<% } dbconn.closeLocalConnection(conn); %>
<input type = "hidden" name="qid" value="<%=qid%>" />

<div style="margin:0px 0 0 0px;margin-bottom:5px;">
	
	<span style="margin-left:100px;">Credits: </span><input id = "credits" name = "credits" type = "text" style = "width: 50px; margin-bottom:20px;margin-left:5px;" value = "<%=credits%>" />
	
	<span style = "margin-left: 20px;"> Negative Marks: </span> <input id = "negativemarks" name = "negativemarks" type = "text" style = "width: 50px; margin-bottom:20px;margin-left:5px;" value = "<%=negativemarks%>" />
	
	<input id = "shuffle" name = "shuffle" type = "checkbox" <%if(shuffle == 0) {%> checked = "checked" <%} %> style = "margin-bottom:20px;margin-left:25px;" />No Shuffling
	
	<button class="ui-conductquiz-button" style = "height: 38px;margin-left: 30px;" id="tfeditsubmit" type="submit" >
		<span>Save</span>
	</button>
<!-- <button class="ui-conductquiz-button" id="tfeditcancel" type="button" onclick="javascript:history.back();" >
<span>Cancel</span>
</button> -->
</div>

</td>
</tr>

</table>
</form>

</body>
</html>