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
<title>Insert title here</title>

<link type="text/css" rel="stylesheet" href="../../css/style.css">

<style type="text/css">
._css3m{
display:none
}
</style>

<script>
function validateform()
{
	//var reg=new RegExp("^[a-zA-Z0-9]+[,.!@#$%^&*()_+-=:;,./<>?a-zA-Z0-9]*");
	var x=document.forms["truefalseform"]["tfaddquest"].value;
	if (x==null || x=="" || x.trim()=="")
	{
  		alert("Question must be filled out!!!");
  		return false;
  	}
	else if ((document.getElementById("true").checked==false) && (document.getElementById("false").checked== false) )
	{
		alert("Please select an Option"); 
		return false;
	}
	else if(isNaN(document.getElementById("credits").value) || (document.getElementById("credits").value == "") || (document.getElementById("credits").value < 0)){
		alert("Please Enter a valid number in Credits");
		return false;
	}
	else if(isNaN(document.getElementById("negativemark").value) || (document.getElementById("negativemark").value == "" || (document.getElementById("negativemark").value < 0)))
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
</script>
</head>
<body class="ui-Mainbody" style="width:100%; height:100%;margin-top:20px; text-align: center;">
<div id="single_choice" >
<form class="form-4" action = "../../addtruefalsedb" method = "post" id = "truefalseform" name = "truefalsequest" onsubmit="return validateform();">

<table class="addquestion-subpt" border="1">

<tr >
<td >
<div class="ui-createquiz-text">
<label style="font-size:17px;">True or False questions</label></div>
<br>
<textarea id="addques" cols="25" rows="5" style="width:800px; font-size:14px;margin:0px 0 0 120px"
 type="text" name="tfaddquest"  placeholder="Enter your question here..."></textarea>
<br>
<br>
<span style="margin-left:100px;"></span>
<span style="margin-left:15px;"></span><input id="true" type="radio" value="true" name="option" />
<span style="margin-left:15px;"></span><label>True</label>


<br>
<br>
<span style="margin-left:100px;"></span>
<span style="margin-left:15px;"></span><input id="false" type="radio" value="false" name="option"/>
<span style="margin-left:15px;"></span><label>False</label><br>

<div style="margin:0px 0 0 0px">
<!-- <label>Time</label>
<input id="time" type="datetime" name="Time" style="width:80px"/>
<span style="margin-left:20px;"></span> -->

<span style="margin-left:120px;">Credits: </span><input id = "credits" name = "credits" type = "text" style = "width: 50px; margin-bottom:20px;margin-left:5px;" />
<span style="margin-left:20px;">Negative Marks: </span><input id = "negativemark" name = "negativemark" type = "text" value=0 style = "width: 50px; margin-bottom:20px;margin-left:5px;" />
<input id = "shuffle" name = "shuffle" type = "checkbox" style = "margin-bottom:20px;margin-left:25px;" />No Shuffling

<button class="ui-conductquiz-button" style="height: 38px;margin-left: 45px;" id="tfadd" type="submit" >
<span>Submit</span>
</button>
<!-- <button class="ui-conductquiz-button" style="margin-left: 5px;" id="tfadd" type="button" onclick = "history.back( );">
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