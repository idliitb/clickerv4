<!--  Kirti,Dipti from Clicker Team, IDL LAB ,IIT Bombay-->

<%@page contentType="text/html" import="java.util.*" %>

<%! boolean courseflag = true; %>
<% 
String InstructorID = (String) session.getAttribute("InstructorID");
String CoordinatorID = (String) session.getAttribute("CoordinatorID");
String Mode = "Local";//(String) session.getAttribute("Mode");


if (InstructorID!=null)
{
	if (InstructorID.equals((String) session.getAttribute("InstructorID")))
	{
		response.sendRedirect("./jsp/home/home.jsp");
					
	}
}
else if (InstructorID==null)
{
	System.out.println("Usertype is not there 1");
}
System.out.println("status: " + request.getParameter("status"));

 

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>

<link href="js/jquery-ui.css" rel="stylesheet"	type="text/css" />
<link type="text/css" rel="stylesheet" href="css/login.css">
<link rel="stylesheet" type="text/css" href="css/logininput.css" />
<link type="text/css" rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="js/LoginValidation.js"></script>
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>

<script>
function runScript(e) {
    if (e.keyCode == 13) {
    	xmlload();
        
    }
}

function xmlload()
{
		var InstrID = document.getElementById("uname").value;
		var Password = document.getElementById("pword").value;
		document.getElementById("mode").checked;
		
		if(document.getElementById("mode").checked)
		{
					var mode=document.getElementById("mode").value;
					
					var xmlhttp1;
					if (window.XMLHttpRequest)
			  			{// code for IE7+, Firefox, Chrome, Opera, Safari
			 	 		xmlhttp1=new XMLHttpRequest();
			  			}
					else
			  			{// code for IE6, IE5
			 		 		xmlhttp1=new ActiveXObject("Microsoft.XMLHTTP");
			  			}
				
					xmlhttp1.onreadystatechange=function()
				  	{
							if (xmlhttp1.readyState==4 && xmlhttp1.status==200)
				    		{	
								 if(xmlhttp1.responseText == "0"){
									window.location = "login.jsp?error=error";													
							} 
								else {
									$("#dialog").load("maincentersetter.jsp").dialog({draggable :false,modal:true});
								}	
							}
				  	}
						
				 	xmlhttp1.open("POST","./Login?LoginName=" + InstrID + "&Password=" + Password +"&mode=" + mode ,true);
					xmlhttp1.send();

			
		}
		else
		{
					var xmlhttp;
					if (window.XMLHttpRequest)
			  			{// code for IE7+, Firefox, Chrome, Opera, Safari
			 	 		xmlhttp=new XMLHttpRequest();
			  			}
					else
			  			{// code for IE6, IE5
			 		 		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			  			}
				
					xmlhttp.onreadystatechange=function()
				  	{
							if (xmlhttp.readyState==4 && xmlhttp.status==200)
				    		{	
								if((xmlhttp.responseText == "1")||(xmlhttp.responseText == "-2")){
								   
									window.location = "jsp/home/home.jsp";
								}else if(xmlhttp.responseText== "-4")
									window.location = "jsp/admin/department.jsp";
								
								else if(xmlhttp.responseText == "0"){
									
									window.location = "login.jsp?error=error";
													
							
								}else if(!isNaN(xmlhttp.responseText)){
									$("#dialog").load("coursesetter.jsp").dialog({draggable :false,modal:true});
								}		
							}
				  	}
					
			 	xmlhttp.open("POST","./Login?LoginName=" + InstrID + "&Password=" + Password ,true);
				xmlhttp.send();
		}

}



function validateCourseID(){
	
	try{
		
		if(document.forms["CourseIDform"].elements["courseID"].value=="Select Course"){
			alert("Select a valid course");
			
			return false;
		}
		else{
			
			return true;
		}
	}
	catch(err){
		alert(err.message);
	}
}



function validateWorkshopID(){
	
	try{
		
		if(document.forms["workshopIDform"].elements["workshopID"].value=="Select Workshop"){
			alert("Select a valid workshop");
			
			return false;
		}
		else{
			
			return true;
		}
	}
	catch(err){
		alert(err.message);
	}
}

function validateMainCenterID(){
	
	try{
		
		if(document.forms["Maincenterform"].elements["maincentername"].value=="Select MainCenter"){
			alert("Select a valid MainCenter");
			
			return false;
		}
		else{
			
			return true;
		}
	}
	catch(err){
		alert(err.message);
	}
}



</script>





</head>


<body id="body" onload="checkLoginStatus()" class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">

<form id="LoginForm" class="form-4" > 
<table class="table">
<tr>

	<td style="padding-right:7px">
    <div class=" ui-square " style="text-align: center;">
	<span class="ui-shape-text"><br>Clicker <br>&nbsp;v4</span>
	</div>
	</td>
	
	<td>
	<div class="ui-text">
	<p>IIT Bombay</p>
	</div>
	</td>

	<td style="padding-right:5px">
	<div class="ui-Login-text-username">
	<label>Username</label><br>
	<input id="uname" type="text" name="LoginName" style="color:#ffffff;" placeholder="username" tabindex="1" autofocus required  /><br>
	<input id="mode" type="checkbox" name="mode" value="remoteMode" ><label class="ui-Login-text-remember">Remotecenter Mode</label>
	</div>
	</td>
	
	<td style="padding-right:10px">
	<div class="ui-Login-text-password">
	<label>Password</label><br>
	<input id="pword" type="password" name="Password" placeholder="password" tabindex="2" onkeypress="runScript(event)" required/><br>&nbsp;
	<a href="forgotpassword.jsp" class="ui-Login-text-forgot">Forgot password?</a>
	</div>
	</td>
	
	 <td colspan="0" >
	 <button id="logbtn" type="button" class=" ui-loginbutton " onclick="xmlload();"  tabindex="3">
	 <span ><img src="./img/Login.png"></span>
	 </button>
	 </td>
	 
</tr>

</table>

</form>
<script>



$(document).ready( function() {
    $('#error').delay(3000).fadeOut();
});</script>

<div style="color: #990000; font-weight: bold; font-size: 150%;" id="error"></div>

<div class="ui-mainbody-img">

<img src="img/loginhead.png" style="width:1040px; height:200px;">
</div>






<div class="ui-para-text"  >
<p >In a classroom sessions, an interaction between instructor and students is crucial 
factor of better learning environment. Clicker V.4 is one of the web based student response 
system developed, to make a kind of interaction between students and teacher. As Clicker V.4 is 
web based application, it can be accessed at any place, any time. Web based student response system 
can be used for collecting attendance of students in classroom, conducting quizzes which can include
 questions of various types (like, general, multiple options, numeric, yes/no, true/false, etc.), 
 generating reports based on the performance of students, etc.<br>
 an interaction between instructor and students is crucial 
factor of better learning environment. Clicker V.4 is one of the web based student response 
system developed, to make a kind of interaction between students and teacher. As Clicker V.4 is 
web based application, it can be accessed at any place, any time. Web based student response system 
can be used for collecting attendance of students in classroom, conducting quizzes which can include
 questions of various types (like, general, multiple options, numeric, yes/no, true/false, etc.)
 </p></div>
 
<div class="ui-footer"><br>
<p class="ui-footer-text">Designed and Developed by Clicker Software Team, IIT Bombay</p>
</div>
	<div id="dialog" style="background: #9bbb59; "></div>
	<div id="workshopdialog" style="background: #9bbb59; "></div>
</body>

</html>