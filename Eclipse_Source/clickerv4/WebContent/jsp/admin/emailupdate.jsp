<!-- Author: Kirti ,Clicker Team, IDL lab, IIT Bombay 
* This file is for admin to update Gmail Id which he/she already created for institute.This id is further used for sending temporary password mail to user in case of forgot password
-->
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@ page import="clicker.v4.login.*" %>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<style type="text/css">
._css3m {
	display: none
}
</style>

<title>Update Email</title>
</head>

<%@ include file="../../jsp/includes/menuheader.jsp"%>

<script type="text/javascript" src="../../js/courses.js"></script>
<script type="text/javascript" src="../../js/LoginValidation.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>

<link href="../../jquery/jquery-ui.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../../jquery-ui-1.8.21.custom.css" rel="stylesheet" type="text/css" />
<link href="../../js/jquery-ui.css" rel="stylesheet"	type="text/css" />
<link rel="stylesheet" media="all" type="text/css"	href="../../jsp/newMenu/dropdown.css" />
<link type="text/css" rel="stylesheet" href="../../css/login.css">
<link rel="stylesheet" type="text/css" href="../../css/logininput.css" />
<link type="text/css" rel="stylesheet" href="../../css/style.css">

<body onload="clearalltext()"  class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">

<%
if(!session.getAttribute("admin").toString().equals("2")){
	request.setAttribute("Error","You are not allow to use this page");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}


String status = (String) session.getAttribute("status"); 
System.out.println("status at emailupdate is....."+status);
%>
<script type="text/javascript">

function clearalltext()
{
	document.getElementById("newgmailid").value="";
	document.getElementById("newpassword").value="";
	
	
}
// this function is used for email id validation 
function echeck(str) {

	var at="@";
	var dot=".";
	var lstr=str.length;
	
	
	
	if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		  
		   return false;
		}

	else if (str.indexOf(dot)==-1 || str.indexOf(dot)==0  || str.indexOf(dot)==lstr-1){
		   
		    return false;
		}
	
	

	else
		return true;
}
// this function is used for validation and storing changed password in database 
function validate()
{
	var emailLegalRegex =  /^([\w-\.]+@(?!gmail.)([\w-]+\.)+[\w-]{2,4})?$/;
	var newemail=document.getElementById("newgmailid").value;
	var	newpassword=document.getElementById("newpassword").value;
	
		
		if(newemail==" " || newpassword== " ")
			{
				alert("Please fill up all the fields");
				return false;
				
			}
		
		else if(echeck(newemail)==false){
			 alert("Invalid E-mail ID");
			 return false;
		}
		
		else if(emailLegalRegex.test(newemail)) {  
			alert("No email apart from gmail is allowed.");
	       
	        return false;
	    } 
		
		else
		{
			return true ;			
			
		}
	
	
}

$(document).ready(function(){
	<%if(request.getParameter("status")!=null){%>
alert("email address does not updated ");
<%}%>

});

</script>
	

	<form class="form-4"  method="post" action="../../EmailUpdate" onsubmit="return validate();">
	<input type="hidden" id="mode" name="mode" value="local">
	<div style="margin-top:40px;">
		<div><label class="ui-text" style="margin:auto;color:#9bbb59; ">Update up your Email System</label></div>
		<br/>
		<div id="note" style="margin:auto;color: red;"><label>Note : Only admin can update this email address and password.  </label></div>
	
		<div style="margin-top:30px">
			<table  style="height:150px;width:400px; margin:auto; " border="0">
				<tr>
					<td >
						<label style=" color: #e46c0a;font-size:18px" >Gmail ID &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
					</td>
					<td >
						<input id="newgmailid"  style="width:220px; font-size:15px; color:black; " type="text" name="newgmailid" autofocus required tabindex="1"  placeholder="Username"/>
					</td>
				</tr>
				<tr>
					<td >
						<label  style=" color: #e46c0a;font-size:18px">Password &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
					</td>
					<td>
						<input id="newpassword"  style="width:220px;  font-size:15px; color:black; " type="password" name="newpassword" required tabindex="2"  placeholder="password"/>
					</td>
				</tr>
			</table>
		</div>
		
		<div style="margin-top:20px">	
			<button style="background:#9bbb59; font-size:21px; color:#ffffff;	margin-right:10px; border-radius:8px; min-width:0.6in; min-height:0.4in; width:100px; margin-top:15px;"  id="update" type="submit" tabindex="3"  >
			<span>Update</span>
			</button>
		</div>
		
		
	</div>
	</form>
	<div style="margin-top:-550px;">
<%@ include file= "../../jsp/includes/menufooter.jsp" %>
</div>
</body>
</html>