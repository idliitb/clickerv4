<!-- Author : Kirti, Clicker Team, IDL LAB ,IIT Bombay
* This page is used for forgot password.
 -->
<%@ page import="clicker.v4.login.*" %>
<%@ page import ="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>

<%String status = (String) session.getAttribute("status"); 
System.out.println("status is....."+status);
//String s = request.getParameter("status");
//System.out.println(s);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Forgot Password</title>
<link href="js/jquery-ui.css" rel="stylesheet"	type="text/css" />
<link type="text/css" rel="stylesheet" href="css/login.css">
<link rel="stylesheet" type="text/css" href="css/logininput.css" />
<link type="text/css" rel="stylesheet" href="css/style.css">
<script type="text/javascript" src="js/LoginValidation.js"></script>
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>


</head>
<body onload="clearall();" class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">

<script type="text/javascript">
	
	function clearall()
	{
		document.getElementById("usernamefp").value;
		document.getElementById("emailidfp").value="";
		
		
	}
	// this function is used for email id validation 
	function echeck(str) {

		var at="@";
		var dot=".";
		var lstr=str.length;
		
		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
			  
			   return false;
			}

		else if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr-1){
			   
			    return false;
			}
		else
			return true;
	}
	// this function is used for validation and storing changed password in database 
	function allow()
	{
		var username=document.getElementById("usernamefp").value;
		var email=document.getElementById("emailidfp").value;
		
			
			if(username=="" || email=="")
				{
					alert("Please fill up all the fields");
					return false;
					
				}
			
			else if(echeck(email)==false){
				 alert("Invalid E-mail ID");
				 return false;
			}
			else if ( ( form.mode[0].checked == false ) && ( form.mode[1].checked == false ) ) 
			{
			alert ( "Please choose mode Local or Remote" ); 
			return false;
			}
			
			else
			{
				return true ;			
				
			}
		
		
	}
	
	
	
	$(document).ready(function(){
		<%if(request.getParameter("status")!=null){%>
	alert("InstructorID or EmailID invalid");
	<%}%>
	});
	
</script>

<form class="form-4"  method="post" action="./ForgotPassword" onsubmit="return allow()">
<div style="margin-top:30px;">
	<table class="table" >
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
		</tr>
	</table>
</div>
<!-- fp table -->
<div style="margin-top:40px;">
	<div><label class="ui-text" style="margin:auto;color:#9bbb59; ">Forgot Password</label></div>
	<div style="margin-top:30px">
	<table  style="height:150px;width:400px; margin:auto; " border="0">
	<tr>
			<td style="height:20px;width:180px;">
				<label style=" color: #e46c0a;font-size:18px" >Mode &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="localmode"  style="width:220px; font-size:15px; " type="radio" name="mode" value="Local" autofocus required tabindex="1" />Local
				<input id="remotemode"  style="width:220px; font-size:15px; " type="radio" name="mode" value="Remote" autofocus required tabindex="1" />Remote
			</td>
		</tr>
		<tr>
			<td style="height:20px;width:180px;">
				<label style=" color: #e46c0a;font-size:18px" >Username &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="usernamefp"  style="width:220px; font-size:15px; " type="text" name="usernamefp" autofocus required tabindex="1"  placeholder="Username"/>
			</td>
		</tr>
		<tr>
			<td style="height:20px;width:50px;">
				<label style=" color: #e46c0a;font-size:18px">Email ID &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="emailidfp"  style="width:220px;  font-size:15px; " type="text" name="emailidfp" required tabindex="2"  placeholder="email_id"/>
			</td>
		</tr>
		
				
	</table>
	</div>
</div>	
	<div style="margin-top:20px">	
		<button style="background:#9bbb59; font-size:21px; color:#ffffff;	margin-right:10px; border-radius:8px; min-width:0.6in; min-height:0.4in; width:100px; margin-top:15px;"  id="submitfp" type="submit" tabindex="5" >
		<span>Submit</span>
		</button>
	</div>
</br>	
<div style="color:#9bbb59;font-size:18px;text-align:center;margin-right:2px">
	<a style="color:#e46c0a" href="./login.jsp">Back to Login</a>
</div>
</form>
<div class="ui-footer"><br>
<p class="ui-footer-text">Designed and Developed by Clicker Software Team, IIT Bombay</p>
</div>		
</body>
</html>

