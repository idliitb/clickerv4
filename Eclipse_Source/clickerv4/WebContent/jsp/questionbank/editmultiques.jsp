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
	var math_select = document.getElementById("maths_select").value;
	if(ctr<6)
	{
	try
	{
		ctr++;
		var before=document.getElementById("submit");
		var par=before.parentNode;
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
		
		removeButton.setAttribute("id","remove"+(ctr));
		removeButton.setAttribute("class","close-btn");
		removeButton.setAttribute("style","color: white; text-decoration: none; margin-left: 6px;");

		if(math_select != 1)
		{
			var preview_div = document.createElement("div");
			var outer_div = document.createElement("div");

			label.setAttribute("style", "margin-left:36px;");
			removeButton.setAttribute("href", "javascript:removeOption(" + (ctr) + ", " + (ctr) +"6)");
			
			preview_div.setAttribute("id", "option" + (String.fromCharCode(64+ctr)) + "_preview");
			preview_div.setAttribute("style", "overflow: auto; margin-left: 90px; width: 250px; height: 50px;");
			preview_div.setAttribute("class", "preview_div");

			textbox.setAttribute("onclick", "toggleTextPreview('option" + (String.fromCharCode(64+ctr)) + 
								"_preview', 'txt" + ctr + "');");
			textbox.setAttribute("onkeyup", "showPreviewText('option" + (String.fromCharCode(64+ctr)) +
								"_preview', 'txt" + ctr + "');");

			outer_div.setAttribute("id", "outer_div" + ctr);
			outer_div.setAttribute("style", "float: left; width: 380px; margin-left: 0px;");
			outer_div.appendChild(preview_div);
			outer_div.appendChild(label);
			outer_div.appendChild(checkButton);
			outer_div.appendChild(textbox);
			outer_div.appendChild(removeButton);

			par.insertBefore(outer_div, before);
		}
		else
		{
			label.setAttribute("style", "margin-left: 36px;");

			removeButton.setAttribute("href", "javascript:removeOption("+(ctr)+")");
			
			par.insertBefore(label,before);
			par.insertBefore(checkButton,before);			
			par.insertBefore(textbox,before);			
			par.insertBefore(removeButton, before);
		}

		label.innerHTML=(String.fromCharCode(64+ctr));
		removeButton.innerHTML = 'X';		
		document.forms["form"].elements["count"].value=ctr;

	}
	catch(err)
	{
		alert(err.message);
	}
	/*try
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
		}*/
	}
	else
	{
		alert("Options not more than 6! ");
	}
}
function removeOption(opt, qtype_option_number)
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
			var parent=document.getElementById("content_in");

			if(qtype_option_number >= 16)
			{
				var child1=document.getElementById("outer_div"+ctr);
				parent.removeChild(child1);
			}
			else
			{
				var child1=document.getElementById("txt"+ctr);
				var child2=document.getElementById("check"+ctr);
				var child3=document.getElementById("label"+ctr);			
				var child5=document.getElementById("remove"+ctr);
	
				
				//alert("before removing i="+i);
				parent.removeChild(child1);
				parent.removeChild(child2);
				parent.removeChild(child3);			
				parent.removeChild(child5);
			}
			
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

function toggleTextPreview(id, option_text)
{
	var preview_div = document.getElementsByClassName('preview_div');
	var selected_div = document.getElementById(id);
	var option_data = document.getElementById(option_text);
	//alert(id);
	for(var i = 0; i < preview_div.length; i++)
		if(document.getElementById(preview_div[i].id) != selected_div)
			if(preview_div[i].id == "quest_div")
			{
				document.getElementById(preview_div[i].id).innerHTML = "";
				document.getElementById(preview_div[i].id).style.display = "none";
			}	
			else
			{
				document.getElementById(preview_div[i].id).innerHTML = "";
				document.getElementById(preview_div[i].id).style.border = "";
			}
		else
			if(id == "quest_div")
			{	
				document.getElementById(id).style.display = "block";
				document.getElementById(id).innerHTML = option_data.value;
				MathJax.Hub.Queue(["Typeset",MathJax.Hub,id]);
			}
			else
			{
				document.getElementById(id).style.border = "1px solid black";
				document.getElementById(id).innerHTML = option_data.value;
				MathJax.Hub.Queue(["Typeset",MathJax.Hub,id]);
			}
}

function showPreviewText(id, option_text)
{
	//alert(id);
	var preview_div = document.getElementsByClassName('preview_div');
	var selected_div = document.getElementById(id);
	var option_data = document.getElementById(option_text);
	
	for(var i = 0; i < preview_div.length; i++)
		if(document.getElementById(preview_div[i].id) == selected_div){
			document.getElementById(preview_div[i].id).innerHTML = option_data.value;
			MathJax.Hub.Queue(["Typeset",MathJax.Hub,preview_div[i].id]);
		}
		else{
			if(preview_div[i].id == "quest_div"){
				document.getElementById(preview_div[i].id).innerHTML = "";
			}
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

<form class="form-4" id="form" name = "form" method="post" action="../../multchoice_editdb" onsubmit="return validateForm()">

<table class="addquestion-subpt" border="1" style = "width: 710px;">
<tr >
<td >
<div id="content_in">
<div class="ui-createquiz-text" style="margin-left:auto;" >
<label style="font-size:16px;"> Multiple Choice Correct</label></div>
<br>
<% 
PrintWriter pw = response.getWriter();
String qid = request.getParameter("qid");
String query1 = "SELECT Question, MathSelect, NegativeMark, Shuffle FROM question WHERE QuestionID='"+qid+"'";
String question = null;
int shuffle = 1, question_type = Integer.parseInt(request.getParameter("question_type")), math_select = 1;
float negativemarks = 0;
//String question_split[ ] = null;
ResultSet rs22 = st.executeQuery(query1);


while(rs22.next())
{
	math_select = rs22.getInt("MathSelect");
	//if(rs22.getInt("MathSelect") == 1)
		question = rs22.getString("Question");
	/*else
	{
		question = rs22.getString("Question").replace("\r\n", "!@");
		//System.out.println("{{{{{{{{{{{: " + question);
		question_split = question.split("!@");
	}*/
	shuffle = rs22.getInt("Shuffle");
	negativemarks = rs22.getFloat("NegativeMark");
}
rs22.close();
if(math_select == 1)
{%>
	<textarea id="addques" cols="25" rows="5" style="width:800px; font-size:14px;" 
	name="Question"  placeholder="Enter your question here..."> <%=question %> </textarea>
<br>
<%}
else
{%>
	<div id = quest_div  class = "preview_div" style = "margin-left: 0px; border: 1px solid black; width: 800px; height: 100px; overflow: auto;"> </div>
	<br>
	<textarea id="addques" cols="25" rows="5" style="width:800px; font-size:14px;" 
	name="Question"  placeholder="Enter your question here..." onclick = "toggleTextPreview('quest_div', 'addques')" onkeyup="showPreviewText('quest_div', 'addques');"> <%=question %> </textarea>
	<br>
<%}

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
	<%} 
	if(math_select == 1)
	{%>
	  	
		<span style="margin-left: 35px;" id="label<%=i %>"><%=(label++) %></span>
		<input id="check<%=i %>" <%if(rs.getInt("OptionCorrectness")==1){ %> checked="checked" <%} %> type="checkbox" value="<%=i %>" name="option" />
		<span style="margin-left:10px;"></span><input id="txt<%=i %>" type="text" name="<%=i %>" style="width:250px;" value="<%=rs.getString(1) %>"/>
	
		<a class="close-btn" id='remove<%=i %>' href="javascript:removeOption(<%=i %>)" style = "color: #ffffff; text-decoration: none;" >X</a>


	<%}
	  else
	  {
	  	//String option_strip = question_split[i].replace("Option " + (char) (64 + i) + ": ", "");
	  	//System.out.println(option_strip);%>
	  	
		<div id = "outer_div<%= i %>" style="margin-top: 0px; float:left; width:380px; margin-left:0px;">
			<div id = "option<%= (char) (64 + i) %>_preview" class = "preview_div" style = "overflow: auto; 
		  		margin-left:90px; width: 250px;  height: 50px;"></div>
		  	<span style="margin-left: 35px;" id="label<%=i %>"><%=(label++) %></span>
			<input id="check<%=i %>" <%if(rs.getInt("OptionCorrectness")==1){ %> checked="checked" <%} %> type="checkbox" value="<%=i %>" name="option" />
			<span style="margin-left:10px;"></span><input id="txt<%=i %>" type="text" name="<%=i %>" style="width:250px;" value="<%=rs.getString(1) %>" onclick = "toggleTextPreview('option<%= (char) (64 + i) %>_preview', 'txt<%= i %>');" onkeyup="showPreviewText('option<%= (char) (64 + i) %>_preview', 'txt<%= i%>');"/>
	
			<a class="close-btn" id='remove<%=i %>' href="javascript:removeOption(<%=i %>, '<%= i %>6')" style = "color: #ffffff; text-decoration: none;" >X</a>
		</div>
		
	  <%if(i == 1 || i == 3)
	{%>
		<script> if(<%= i%> == 1)
					document.getElementById("outer_div1").style.height = "95px";
				 else
					document.getElementById("outer_div3").style.height = "95px";
		 </script>
	<%}
	}
}
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
<input type = "hidden" id = "maths_select" name = "math_select" value = "<%= math_select %>" />
<br>


<div id = "submit" style="float: left; margin:0px 0 0 0px;margin-bottom:5px;">
	<button style="margin-bottom:20px; margin-top: 40px;margin-left:120px;" class="ui-add-button" id="add" type="button" onclick="addOption();" value="  Add Option  ">
		<span  style = "font-size: 30px;  margin-top:-50px; font-weight: bold;">+</span>
	</button>
	 <font style = "margin-left: 20px;">Credits: </font><input id = "credits" name = "credits" type = "text" style = "width: 50px; margin-bottom:20px;margin-left:5px;" value = "<%=credits%>" />
	<span style = "margin-left: 20px;">Negative Marks: </span><input id = "negativemarks" name = "negativemarks" type = "text" style = "width: 50px; margin-bottom:20px;margin-left:5px;" value = "<%=negativemarks%>" />
	<input id = "shuffle" name = "shuffle" type = "checkbox" <%if(shuffle == 0) {%> checked = "checked" <%} %> style = "margin-bottom:20px;margin-left:40px;" />No Shuffling

	<button class="ui-conductquiz-button" style = "margin-left: 30px; height: 38px;" id="multichoicesubmit" type="submit" onclick="getCorrectoptionID();">
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