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
var ctr = 4;
function addOption()
{
	if(ctr<6)
		{
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
			textbox.setAttribute("style", "margin-left: 16px; width: 250px");
			
			radioButton.setAttribute("type", "radio");
			radioButton.setAttribute("name", "option");
			radioButton.setAttribute("value", ctr);
			radioButton.style.marginLeft = "20px";
			radioButton.setAttribute("id", "radio"+ctr);
			label.setAttribute("id", "label"+ctr);
			label.setAttribute("style", "margin-left:120px;");
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
			removeButton.setAttribute("style","color: white; text-decoration: none; margin-left: 15px;");
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
			document.forms["singlechoiceadd"].elements["count"].value=ctr;
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
	//alert(ctr);
	if(ctr>4)
	{
		for(i=opt;i<ctr;i++)
		{	
			document.getElementById("txt"+i).value=document.getElementById("txt"+(i+1)).value;
			document.getElementById("radio"+i).checked = document.getElementById("radio"+(i+1)).checked;
		}
		try
		{
		//	alert("Assigning!");
			var child1=document.getElementById("txt"+ctr);
			var child2=document.getElementById("radio"+ctr);
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
		
		document.forms["singlechoiceadd"].elements["count"].value=ctr;
	}
	else
	{
		alert("Options must be more than 4!");
	}
}

function shuffle( )
{
	if(document.getElementById(shuffle).checked)
		document.getElementById(shuffle).value = 0;
	else
		document.getElementById(shuffle).value = 1;
}

function validateForm()
{
	//alert("ddd");
	var i;
	var checked = false;
	var quest=document.forms["singlechoiceadd"].elements["singleaddquest"].value;
	//var reg=new RegExp("^[a-zA-Z0-9]+[,.!@#$%^&*()_+-=:;,./<>?a-zA-Z0-9]*");
	if(quest.trim()=="")
	{
		alert("Please enter the question first");
		return false;
	}	
	else{
		for(i=1;i<=ctr;i++)
		{
			if((document.getElementById("txt"+i).value).trim()=="" || document.getElementById("txt"+i).value==null)
			{
				alert("Please give appropriate value for option "+i);
				return false;
			}
			if(document.forms["singlechoiceadd"].elements["radio"+i].checked==true)
			{	checked=true;
			}			
		}
		if(checked==false)
		{
			alert("Please indicate correct answer");
			return false;
		}
		else if(isNaN(document.getElementById("credits").value) || (document.getElementById("credits").value == "" || (document.getElementById("credits").value < 0)))
		{
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
			alert("Question submitted successfully");
			return true;
		}
	}
	
}
</script>
</head>
<body class="ui-Mainbody" style="width:100%; height:100%;margin-top:20px; text-align: center;" >

<form class="form-4" id = "singlechoiceadd" action = "../../addsinglechoicedb" method = "post" name = "singlechoiceadd" onsubmit="return validateForm();">

<table class="addquestion-subpt" border="1">

<tr >
<td >
<div id = "content_in">
<div class="ui-createquiz-text">
<label style="font-size:17px;"> Single choice question</label></div>
<br>
<textarea id="addques" cols="25" rows="5" style="width:800px; font-size:14px;margin:0px 0 0 120px"
 type="text" name="singleaddquest"  placeholder="Enter your question here..."></textarea>
<br>
<br>
<span style="margin-left:120px;">A</span>
<span style="margin-left:10px;"></span><input id="radio1" type="radio" value="1" name="option" />
<span style="margin-left:10px;"></span><input id="txt1" type="text" name="1" style="width:250px;"/>
<span style="margin-left:10px;"></span>
<span class="close-btn"><a id = "remove1" href="javascript:removeOption(1)">X</a></span>

<span style="margin-left:120px;">B</span>
<span style="margin-left:10px;"></span><input id="radio2" type="radio" value="2" name="option"/>
<span style="margin-left:10px;"></span><input id="txt2" type="text" name="2" style="width:250px;"/>
<span style="margin-left:10px;"></span>
<span class="close-btn"><a id = "remove2" href="javascript:removeOption(2)">X</a></span>
<br>
<span style="margin-left:120px;">C</span>
<span style="margin-left:10px;"></span><input id="radio3" type="radio" value="3" name="option"/>
<span style="margin-left:10px;"></span><input id="txt3" type="text" name="3" style="width:250px;"/>
<span style="margin-left:10px;"></span>
<span class="close-btn"><a id = "remove3" href="javascript:removeOption(3)">X</a></span>

<span style="margin-left:120px;">D</span>
<span style="margin-left:10px;"></span><input id="radio4" type="radio" value="4" name="option"/>
<span style="margin-left:10px;"></span><input id="txt4" type="text" name="4" style="width:250px;"/>
<span style="margin-left:10px;"></span>
<span class="close-btn"><a id = "remove4" href="javascript:removeOption(4)">X</a></span>
<br>
<input type	="hidden" name="count" value="4"/>



<div id = "singlesubmit" style="margin:0px 0 0 0px">
<!-- <label>Time</label>
<input id="time" type="datetime" name="Time" style="width:80px"/>
<span style="margin-left:20px;"></span> -->

<button style="margin-bottom:20px;margin-left:120px;" class="ui-add-button" id="singleadd" type="button" onclick = "addOption( );">
<span  style = "font-size: 30px;  margin-top:-50px; font-weight: bold;">+</span>
</button>
<span style = "margin-left: 20px;">Credits: </span><input id = "credits" name = "credits" type = "text" style = "width: 50px; margin-bottom:20px;margin-left:5px;" />
<span style = "margin-left: 20px;">Negative Marks: </span><input id = "negativemark" name = "negativemark" type = "text" value=0 style = "width: 50px; margin-bottom:20px;margin-left:5px;" />
<input id = "shuffle" name = "shuffle" type = "checkbox" style = "margin-bottom:20px;margin-left:25px;" />No Shuffling

<button class="ui-conductquiz-button" style="height: 38px;margin-left: 50px;" id="conductqbtn1" type="submit" >
<span>Submit</span>
</button>
<!-- <button class="ui-conductquiz-button" style="margin-left: 5px;" id="tfadd" type="button" onclick = "history.back( );">
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