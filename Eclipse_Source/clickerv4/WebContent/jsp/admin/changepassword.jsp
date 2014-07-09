<!-- Author: Kirti ,Clicker Team, IDL lab, IIT Bombay 
* This file is used for changing the login password of user.
-->
<%@ page import="clicker.v4.login.*" %>
<%@ page import ="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>

<%
String InstructorID = (String) session.getAttribute("InstructorID");
System.out.println("intr id: "+InstructorID);
String status = (String) session.getAttribute("status"); 
System.out.println("status is....."+status);
//String s = request.getParameter("status");
//System.out.println(s);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Change Password</title>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="../../css/login.css">
<link rel="stylesheet" type="text/css" href="../../css/logininput.css" />
<link type="text/css" rel="stylesheet" href="css/style.css">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/menu.css">
<script type="text/javascript" src="../../js/LoginValidation.js"></script>
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>


</head>
<body onload="clearall();" class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
<%@ include file= "../../jsp/includes/menuheader.jsp" %>
<script type="text/javascript">
	
	function clearall()
	{
		document.getElementById("usernamefp").value;
		document.getElementById("currentpassword").value="";
		document.getElementById("newpassword").value="";
		document.getElementById("confirmpassword").value="";
		
	}
	// this function is used for email id validation 
	/*function echeck(str) {

		var at="@";
		var dot=".";
		var lstr=str.length;
		
		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
			  
			   return false;
			}

		else if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || (str.indexOf(dot) < (str.indexOf(at)+2)) || str.indexOf(dot)==lstr-1){
			   
			    return false;
			}
		else
			return true;
	}*/
	// this function is used for validation and storing changed password in database 
	function allow()
	{
		var username=document.getElementById("usernamefp").value;
		var currentpswd=document.getElementById("currentpassword").value;
		var newpswd=document.getElementById("newpassword").value;
		var confirmpswd=document.getElementById("confirmpassword").value;
			
			if(username=="" || currentpswd=="" || newpswd=="" || confirmpswd=="")
				{
					alert("Please fill up all the fields");
					return false;
					
				}
			else if(newpswd!=confirmpswd)
			{
				alert("confirm passoword does not match with new password!");
				document.getElementById("newpassword").value="";
				document.getElementById("confirmpassword").value="";
				return false;
			}
			
			
			else
			{
				return true ;			
				
			}
		
		
	}
	
	
	
	$(document).ready(function(){
		<%if(request.getParameter("status")!=null){%>
	alert("InstructorID or Current_Password invalid");
	<%}%>
	});
	
</script>

<form class="form-4"  method="post" action="../../changepassword" onsubmit="return allow()">
<input type="hidden" id="mode" name="mode" value="local">
<!-- cp table -->
<div style="margin-top:40px;">
	<div><label class="ui-text" style="margin:auto;color:#9bbb59; ">Change Password</label></div>
	<div style="margin-top:30px">
	<table  style="height:200px;width:500px; margin:auto; " border="0">
		<tr>
			<td style="height:20px;width:180px;">
				<label style=" color: #e46c0a;font-size:18px" >Username &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="usernamefp"  style="width:220px; font-size:15px; color:black; " type="text" name="usernamefp" autofocus required tabindex="1"   value="<%=InstructorID %>" readonly/>
			</td>
		</tr>
		<tr>
			<td style="height:20px;width:50px;">
				<label style=" color: #e46c0a;font-size:18px">Current Password &nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="currentpassword"  style="width:220px;  font-size:15px; color:black; " type="password" name="currentpassword" required tabindex="2"  placeholder="current password"/>
			</td>
		</tr>
		
		<tr>
			<td >
				<label  style=" color: #e46c0a;font-size:18px">New Password &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td>
				<input id="newpassword"  style="width:220px;  font-size:15px; color:black; " type="password" name="newpassword" required tabindex="3"  placeholder="password"/>
			</td>
		</tr>
		
		<tr>
			<td >
				<label style=" color: #e46c0a;font-size:18px">Confirm Password &nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td>
				<input id="confirmpassword"  style="width:220px;  font-size:15px; color:black; " type="password" name="confirmpassword" required tabindex="4"  placeholder="confirm password"/>
			</td>
		</tr>
		
	</table>
	</div>
</div>	
	<div style="margin-top:40px">	
		<button style="background:#9bbb59; font-size:21px; color:#ffffff;	margin-right:10px; border-radius:8px; min-width:0.6in; min-height:0.4in; width:100px; margin-top:15px;"  id="submitfp" type="submit" tabindex="5" >
		<span>Submit</span>
		</button>
	</div>

</form>
<div style="margin-top:-600px;">
<%@ include file= "../../jsp/includes/menufooter.jsp" %>
</div>
</body>
</html>

