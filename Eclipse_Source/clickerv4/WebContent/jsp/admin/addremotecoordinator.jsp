<%--
      @author Gobinath
DESCREPTION: This JSP Page will display when you Press the add remoteCoordinator in menu in remote mode
USE        : to add remote cordinator details

--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "clicker.v4.admin.*" %>
<%@ page import = "java.util.ArrayList" %>

<%
	ArrayList<String> storeall = new AddRemoteCenter( ).getAll( );
	int centerid = Integer.parseInt(storeall.get(0));
	System.out.println("Center ID: " + centerid);
	%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
<link type="text/css" rel="stylesheet" href="../../css/login.css">
<link type="text/css" rel="stylesheet" href="../../css/logininput.css">
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>





<script type="text/javascript">


function check_forRC()
{
	var  centerid= document.getElementById("centerid").value;
	
	if(centerid == "0")
		{
		alert("First Enter the Remote Center Details");
	    window.location.assign("../../jsp/admin/addremotecenter.jsp");
		}
	}
function trimfield(str) 
{ 
	 	return str.replace(/^\s+|\s+$/g,''); 
}
function validate()
{
	//alert("in alert");
	var coord_id = document.getElementById("coordinatorid").value;
	var uname = document.getElementById("username").value;
	var password = document.getElementById("password").value;
	//alert("password" + password);
	var cpassword = document.getElementById("confirmpassword").value;
	//alert("cpassword" + cpassword);
	var privilege = document.getElementById("privilege").value;
	
	if(isNaN(coord_id) || trimfield(coord_id) == '' || coord_id < 0)
	{
		alert("Please Enter valid Co-ordinator ID");
		return false;
	}
	else if(trimfield(uname) == '' || uname < 0)
	{
		alert("Username cannot be empty. Please enter correct Username");
		return false;
	}
	else if(password == null || trimfield(uname) == '')
	{
		alert("Password cannot be empty. Please enter a password");
		return false;
	}
	else if(cpassword == null || trimfield(uname) == '')
	{
		alert("Confirm Password field cannot be empty");
		return false;
	}
	else if(password != (cpassword))
	{
		alert("Password and Confirm Password fields do not match. Please enter the same password in both the fields");
		return false;
	}
	else if(isNaN(privilege) || !(privilege == 1 || privilege == 2))
	{
		alert("Please enter the Privilege value as 1 or 2");
		return false;
	}
	else
		return true;
}

$(document).ready(function(){
	<%if(request.getParameter("status")!=null){%>
	alert('<%=request.getParameter("status")%>');
	<%}%>
});
</script>
<title>Add Co-Ordinator</title>

</head>
<body onload="check_forRC()">
<%@ include file= "../includes/remotemenuheader.jsp" %>

<form class="form-4"  method="post" action="../../addremotecoordinator" onsubmit = "return validate()">
<div style="margin-top:40px;">
	<div><label class="ui-text" style="margin:auto;color:#9bbb59; font-size: 25px;">Add Co-ordinator</label></div>
	<div style="margin-top:30px">
	<table  style="height:150px;margin:auto; " border='0'>
		
		<tr>
			<td style="height:20px;width:260px;">
				<label style=" color: #e46c0a;font-size:18px">Enter User Name</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="username"  style="width:220px;  font-size:15px; color:black" type="text" name="username" required tabindex="2"  placeholder="User Name"/>
			</td>
		</tr>
		<tr>
			<td style="height:20px;width:50px;">
				<label style=" color: #e46c0a;font-size:18px">Enter Password</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="password"  style="width:220px;  font-size:15px; color:black" type="password" name="password" required tabindex="3"  placeholder="Enter Password"/>
			</td>
		</tr>
		<tr>
			<td style="height:20px;width:50px;">
				<label style=" color: #e46c0a;font-size:18px">Confirm Password</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="confirmpassword"  style="width:220px;  font-size:15px; color:black" type="password" name="confirmpassword" required tabindex="4"  placeholder="Confirm Password"/>
			</td>
		</tr>
		<tr>
			<td style="height:20px;width:470px;">
				<label style=" color: #e46c0a;font-size:18px">Give Privilege(1:Normal; 2: Admin)</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="privilege"  style="width:220px;  font-size:15px; color:black" type="text" name="privilege" required tabindex="5"  placeholder="Enter Privilege"/>
			</td>
		</tr>
		<tr>
			<td style="height:20px;width:50px;">
				<label style=" color: #e46c0a;font-size:18px">Email Address</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="email"  style="width:220px; font-size:15px;color:black;" type="text" name="email" tabindex="6"  placeholder="Email Address"/>
			</td>
		</tr>
		<tr>
			<td style="height:20px;width:50px;">
				<label style=" color: #e46c0a;font-size:18px">Center ID</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="centerid"  style="width:220px;  font-size:15px; color:black" type="text" name="centerid" value = '<%=centerid%>' placeholder="Center ID" readonly/> 
			</td>
		</tr>
				
	</table>
	</div>
</div>	
	<div style="margin-top:20px">	
		<button name = "submit" style="background:#9bbb59; font-size:21px; color:#ffffff;	margin-right:10px; border-radius:8px; min-width:0.6in; min-height:0.4in; width:100px; margin-top:15px;"  id="submit" type="submit" tabindex="7" >
		<span>Submit</span>
		</button>
	</div>
</form>
<div style="margin-top: -600px; text-align: center;">
		<%@ include file="../../jsp/includes/menufooter.jsp"%>
		
	</div>
</body>
</html>