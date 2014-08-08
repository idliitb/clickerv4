<%-- @Author Harshavardhan, Clicker Team, IDL, IIT Bombay--%>

<%@page import="java.io.PrintWriter"%>
<%@ page language="java" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>



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
var ctr = 4;
function addOption()
{
	if(ctr<6)
	{
	try
	{
		ctr++;
		var label = document.createElement("span");
		
		var checkButton = document.createElement("input");
		var textbox = document.createElement("input");
		var removeButton = document.createElement("a");		
		
		textbox.setAttribute("name", ""+(ctr));
		textbox.setAttribute("type", "text");
		textbox.setAttribute("id","txt"+(ctr));
		textbox.setAttribute("style", "margin-left: 14px; width: 250px");
		
		checkButton.setAttribute("type", "checkbox");
		checkButton.setAttribute("name", String.fromCharCode(64+ctr));
		checkButton.setAttribute("value", ctr);
		checkButton.style.marginLeft = "10px";
		checkButton.setAttribute("id", "check"+(ctr));
		label.setAttribute("id", "label"+(ctr));
		label.setAttribute("style", "margin-left: 36px;");

	}
	catch(err)
	{
		alert(err.message);
	}
	try
	{
		
		
		removeButton.setAttribute("href", "javascript:removeOption("+(ctr)+")");
		
		removeButton.setAttribute("id","remove"+(ctr));
		removeButton.setAttribute("class","close-btn");
		removeButton.setAttribute("style","color: white; text-decoration: none; margin-left: 6px;");
	}
	catch(err)
	{
		alert(err.message);
	}		
		//alert(ctr);
		try
		{
			var before=document.getElementById("submit");
			var par=before.parentNode;
			
			par.insertBefore(label,before);
			par.insertBefore(checkButton,before);			
			par.insertBefore(textbox,before);			
			par.insertBefore(removeButton, before);			
			label.innerHTML=(String.fromCharCode(64+ctr));
			removeButton.innerHTML = 'X';
			
			document.forms["form"].elements["count"].value=ctr;
			
		}
		catch(err)
		{
			alert('3 '+err.message);
		}
	}
	else
	{
		alert("Options not more than 6! ");
	}
}
function removeOption(opt)
{
	var i=0;
	//alert(ctr);
	if(ctr>4)
	{
		for(i=opt;i<ctr;i++)
		{	
			document.getElementById("txt"+i).value=document.getElementById("txt"+(i+1)).value;
			document.getElementById("check"+i).checked = document.getElementById("check"+(i+1)).checked;
		}
		try
		{
		//	alert("Assigning!");
			var child1=document.getElementById("txt"+ctr);
			var child2=document.getElementById("check"+ctr);
			var child3=document.getElementById("label"+ctr);			
			var child5=document.getElementById("remove"+ctr);

			var parent=document.getElementById("content_in");
			//alert("before removing i="+i);
			parent.removeChild(child1);
			parent.removeChild(child2);
			parent.removeChild(child3);			
			parent.removeChild(child5);
			
		}
		catch(err)
		{
			alert("here---"+err.message);
		}

		ctr--;
		
		document.forms["form"].elements["count"].value=ctr;
	}
	else
	{
		alert("Options must be more than 4!");
	}
}

function validateForm()
{
	var checked=false;
	if((document.forms["form"].elements["Question"].value).trim()=="" || document.forms["form"].elements["Question"].value==null || document.forms["form"].elements["Question"].value == "")
	{
		alert("Please enter the question first");
		return false;
	}
	
	
	for(var i=1;i<=ctr;i++)
		{
		//alert(document.forms["form"].elements["check"+i].checked);
			if((document.forms["form"].elements["txt"+i].value).trim()=="" || document.forms["form"].elements["txt"+i].value==null)
				{
				alert("Please give appropriate value for answer");
				return false;
				}
			if(document.forms["form"].elements["check"+i].checked==true)
				{checked=true;
				}
		}
	if(checked==false)
	{
	alert("Please indicate correct answer");
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
			alert("Question Submitted successfully");
			return true;
		}
		
	}

function getCorrectoptionID(){
	var j="";
	for(var i=1;i<=ctr;i++)
	{
	//alert(document.forms["form"].elements["check"+i].checked);
		
		if(document.forms["form"].elements["check"+i].checked==true)
			{
			j+=document.forms["form"].elements["check"+i].value+";";
			}
	}
	document.getElementById("correctcount").value=j;
	
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

<form class="form-4" id="form" name = "form" method="post" action="../../multchoice_editdb" onsubmit="return validateForm()">

<table class="addquestion-subpt" border="1" style = "width: 710px;">
<tr >
<td >
<div id="content_in">
<div class="ui-createquiz-text" style="margin-left:auto;" >

<% 
PrintWriter pw = response.getWriter();
String qid = request.getParameter("qid");
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
rs22.close();
%>

<label style="font-size:16px;"> Multiple Choice Correct</label></div>
<br>
<textarea id="addques" cols="25" rows="5" style="width:800px; font-size:14px;" 
type="text" name="Question"  placeholder="Enter your question here..."> <%=question %> </textarea>
<br>

<% 
int i=0;
char label = 'A';
String query = "select OptionValue, OptionID, OptionCorrectness, Credit from options where QuestionID="+qid+"";
ResultSet rs=st.executeQuery(query);
String optionIDs ="";
String CorrectOptionIds="";
float credits = 0;
while(rs.next())
{
	optionIDs += rs.getInt("OptionID") + ";";
	credits = rs.getFloat("Credit");
	i++;
	
	if(i % 2 != 0)
	{
%>

	<br>
	<%} %>
<span style="margin-left: 35px;" id="label<%=i %>"><%=(label++) %></span>
<input id="check<%=i %>" <%if(rs.getInt("OptionCorrectness")==1){ %> checked="checked" <%} %> type="checkbox" value="<%=i %>" name="option" />
<span style="margin-left:10px;"></span><input id="txt<%=i %>" type="text" name="<%=i %>" style="width:250px;" value="<%=rs.getString(1) %>"/>

<a class="close-btn" id='remove<%=i %>' href="javascript:removeOption(<%=i %>)" style = "color: #ffffff; text-decoration: none;" >X</a></span>

<% }
rs.close();
st.close();
dbconn.closeLocalConnection(conn); 
%>

<script type="text/javascript">ctr = <%=i %> </script>

<input type="hidden" name="count" value=<%=i%> />
<input type="hidden" name="correctcount" id="correctcount"/>
<input type	="hidden" name="old_count" value="<%=i%>"/>
<input type	="hidden" name="optionIDs" value="<%=optionIDs%>"/>
<input type = "hidden" name="qid" value="<%=qid %>" />
<br>


<div id = "submit" style="margin:0px 0 0 0px;margin-bottom:5px;">
	<button style="margin-bottom:20px; margin-top: 40px;margin-left:120px;" class="ui-add-button" id="add" type="button" onclick="addOption();" value="  Add Option  ">
		<span  style = "font-size: 30px;  margin-top:-50px; font-weight: bold;">+</span>
	</button>
	 <font style = "margin-left: 20px;">Credits: </font><input id = "credits" name = "credits" type = "text" style = "width: 50px; margin-bottom:20px;margin-left:5px;" value = "<%=credits%>" />
	<span style = "margin-left: 20px;">Negative Marks: </span><input id = "negativemarks" name = "negativemarks" type = "text" style = "width: 50px; margin-bottom:20px;margin-left:5px;" value = "<%=negativemarks%>" />
	<input id = "shuffle" name = "shuffle" type = "checkbox" <%if(shuffle == 0) {%> checked = "checked" <%} %> style = "margin-bottom:20px;margin-left:40px;" />No Shuffling

	<button class="ui-conductquiz-button" style = "margin-left: 30px; height: 38px;" id="multichoicesubmit" type="submit" onclick="getCorrectoptionID();" >
		<span>Save</span>
	</button>
<!-- <button class="ui-conductquiz-button" id="multichoicecancel" type="button" onclick = "history.back( );" >
<span>Cancel</span>
</button> -->
</div>
</div>
</td>
</tr>

</table>

</form>

</body>
</html>