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
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
var ctr = 4;
function addOption()
{
	if(ctr<6)
		{//alert("in add: ");
		try
		{
			ctr++;
			var label = document.createElement("span");
			var radioButton = document.createElement("input");
			var textbox = document.createElement("input");
			var removeButton = document.createElement("a");			
			
			textbox.setAttribute("name", ""+ctr);
			textbox.setAttribute("type", "text");
			textbox.setAttribute("id","txt"+ctr);
			textbox.setAttribute("class", "inputtext");
			textbox.setAttribute("style", "margin-left: 14px; width: 250px");
			
			radioButton.setAttribute("type", "radio");
			radioButton.setAttribute("name", "option");
			radioButton.setAttribute("value", ctr);
			radioButton.style.marginLeft = "11px";
			radioButton.setAttribute("id", "radio"+ctr);
			label.setAttribute("id", "label"+ctr);
			label.setAttribute("style", "margin-left:41px;");
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
		
		try
		{
			var before=document.getElementById("singlesubmit");
			var par=before.parentNode;
			par.insertBefore(label,before);
			par.insertBefore(radioButton,before);
			
			par.insertBefore(textbox,before);
			
			par.insertBefore(removeButton, before);
			//par.insertBefore(newLine, before);
			//par.insertBefore(newLine2,before);
			label.innerHTML=(String.fromCharCode(64+ctr));
			removeButton.innerHTML = 'X';
			document.forms["singleform"].elements["count"].value=ctr;
		}
		catch(err)
		{
			alert(err.message);
		}
	}
	else
	{
		alert("Options not more than 6!");
	}
}
function removeOption(opt)
{
	var i=0;
	//alert("option: " + opt);
	//alert(ctr + " " + opt);
	if(ctr>4)
	{
		for(i=opt;i<ctr;i++)
		{	
			document.getElementById("txt"+i).value=document.getElementById("txt"+(i+1)).value;
			document.getElementById("radio"+i).checked = document.getElementById("radio"+(i+1)).checked;			
		}
		try
		{
			var child1=document.getElementById("txt"+ctr);
			var child2=document.getElementById("radio"+ctr);
			var child3=document.getElementById("label"+ctr);			
			var child5=document.getElementById("remove"+ctr);
			var parent=document.getElementById("content_in");
			
 			parent.removeChild(child1);
			parent.removeChild(child2);
			parent.removeChild(child3);			
			parent.removeChild(child5);			
		}
		catch(err)
		{
			alert("here: "+err.message);
		}

		ctr--;
		document.forms["singleform"].elements["count"].value=ctr;
	}
	else
	{
		alert("Options must be more than 4!");
	}
}

function validateForm()
{
	var checked=false;
	if((document.forms["singleform"].elements["singlechoicequest"].value).trim()==""|| document.forms["singleform"].elements["singlechoicequest"].value==null)
	{
		alert("Please enter the question first");
		return false;
	}
	var i;
	for(i=1;i<=ctr;i++)
		{
			if(document.getElementById("txt"+i).value=="" || document.getElementById("txt"+i).value==null || (document.getElementById("txt"+i).value).trim()=="")
			{
				alert("Please give appropriate value for option "+i);
				return false;
			}
			if(document.forms["singleform"].elements["radio"+i].checked==true)
				checked=true;
		
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
		alert("Question Submitted Successfully!");
		return true;
	    
	}
}
</script>

<title>Single Choice Correct</title>
</head>
<body class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">

<%
Connection conn = null;
DatabaseConnection dbconn = new DatabaseConnection();
conn = dbconn.createDatabaseConnection();
Statement st = conn.createStatement();
%>


<form class="form-4" action="../../singlechoice_editdb" id="singleform" name = "singleform" method="post" onsubmit="return validateForm()">
<table class="addquestion-subpt" border="1" style = "width: 710px;">

<tr >
<td >
<div id="content_in" >
<div class="ui-createquiz-text" style = "margin-left:auto;">
<% 
PrintWriter pw = response.getWriter();
String qid=request.getParameter("qid");
String query = "SELECT Question, NegativeMark, Shuffle FROM question WHERE QuestionID='"+qid+"'";
String question = null;
int shuffle = 1;
float negativemarks = 0;
ResultSet rs = st.executeQuery(query);
if(rs.next())
{
	question = rs.getString("Question");
	shuffle = rs.getInt("Shuffle");
	negativemarks = rs.getFloat("NegativeMark");
	
}
rs.close();
%>
	 <label style="font-size:16px;"> Single choice question</label></div> 
<br>
	<textarea id="addques" cols="25" rows="5" style="width:800px; font-size:14px;margin:0px 0 0 0px"
 	type="text" name="singlechoicequest"  placeholder="Enter your question here..."><%=question %></textarea>

	<br>
<%
int i=0;
char label = 'A';
float credits = 0;
query = "select OptionValue, OptionID, OptionCorrectness, Credit from options where QuestionID="+qid+"";
ResultSet rs1=st.executeQuery(query);
String optionIDs ="";
while(rs1.next())
{
	optionIDs += rs1.getInt("OptionID") + ";";
	credits = rs1.getFloat("Credit");
	i++;
	
	if(i % 2 != 0)
	{
%>
	<br>
	<%} %>
<span style="margin-left:41px;" id="label<%=i %>"><%=(label++) %></span>
<input id="radio<%=i %>" <%if(rs1.getInt("OptionCorrectness")==1){ %> checked="checked" <%} %> type="radio" value="<%=i %>" name="option" />
<input id="txt<%=i %>" type="text" name="<%=i %>" style="width:250px; margin-left:10px;" value="<%=rs1.getString(1) %>"/>
 
<a id='remove<%=i %>' class="close-btn" href="javascript:removeOption(<%=i %>)" style = "color: #ffffff; text-decoration: none;">X</a>


<% }

rs1.close();
st.close();
dbconn.closeLocalConnection(conn); %>
<script type="text/javascript">ctr = <%=i%> </script>	
	<input type	="hidden" name="count" value="<%=i%>"/>
	<input type	="hidden" name="old_count" value="<%=i%>"/>
	<input type	="hidden" name="optionIDs" value="<%=optionIDs%>"/>
	<input type = "hidden" name="qid" value="<%=qid%>" />
	

<div id = "singlesubmit" style="margin:0px 0 0 0px;margin-bottom:5px;">
	
	<button style="margin-bottom:20px;margin-left:120px;" class="ui-add-button" id="singleadd" type="button" onclick = "addOption( );">
		<span  style = "font-size: 30px;  margin-top:-50px; font-weight: bold;">+</span>
	</button>
	
	<font style = "margin-left: 20px;">Credits:</font> <input id = "credits" name = "credits" type = "text" style = "width: 50px; margin-bottom:20px;margin-left:5px;" value = "<%=credits%>" />
	
	<span style = "margin-left: 20px;">Negative Marks: </span> <input id = "negativemarks" name = "negativemarks" type = "text" style = "width: 50px; margin-bottom:20px;margin-left:5px;" value = "<%=negativemarks%>" />
	<input id = "shuffle" name = "shuffle" type = "checkbox" <%if(shuffle == 0) {%> checked = "checked" <%} %> style = "margin-bottom:20px;margin-left:40px;" />No Shuffling
	
	<button class="ui-conductquiz-button" style = "height: 38px;margin-left: 30px;" id="singlechoicesubmit" type="submit" >
		<span>Save</span>
	</button>
	<!-- <button class="ui-conductquiz-button" id="singlechoicecancel" type="button" onclick = "history.back( );">
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