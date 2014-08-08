<%--
      @author Gobinath
DESCREPTION: This JSP Page will display when you Press the add remotecenter in menu in remote mode
USE        : to add New remotecenter details

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "clicker.v4.admin.*" %>
<%@ page import = "java.util.ArrayList" %>

<%
	ArrayList<String> storeall = new AddRemoteCenter( ).getAll( );
	int centerid = 0, count = 0;
	String centername = null, state = null, city = null;
	if(storeall.size() > 1)
	{
			centerid = Integer.parseInt(storeall.get(0));
			centername = storeall.get(1);
			state = storeall.get(2);
			city = storeall.get(3);
			count = 1;
		
	}
	else
	{
		count = Integer.parseInt(storeall.get(0));
	}
	System.out.println("Center ID: " + centerid);
	System.out.println("Count: " + count);
	%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>
<title>Add Remote Center</title>
<script>

function trimfield(str) 
{ 
	 	return str.replace(/^\s+|\s+$/g,''); 
}
function validate( )
{
	var check = document.getElementById("check").value;
				
	if(check == 1)
	{
		//alert("in check1");
		var centerid = document.getElementById("centerid").value;
		var centername = document.getElementById("centername").value;
		var state = document.getElementById("state").value;
		var city = document.getElementById("city").value;
		
		if(isNaN(centerid) || (centerid < 0))
		{
			alert("Please enter correct Center ID");
			return false;
			
		}
		else if(centername == null || trimfield(centername) == '')
		{
			alert("Please fill Center Name");
			return false;
		}
		else if(state == null || trimfield(state) == '' || state < 0)
		{
			alert("State field cannot be empty. Please fill this field");
			return false;
		}
		else if(city == null || trimfield(city) == '' || city < 0)
		{
			alert("City field cannot be empty. Please fill this field");
			return false;
		}
		else
			return true;
	}
	else
	{
		//alert("in check2");
		var storedcenterid = document.getElementById("storedcenterid").value;
		//alert(storedcenterid);
		var storedcentername = document.getElementById("storedcentername").value;
		var storedstate = document.getElementById("storedstate").value;
		var storedcity = document.getElementById("storedcity").value;
		
		if(isNaN(storedcenterid) || (storedcenterid < 0))
		{
			alert("Please enter correct Center ID");
			return false;
			
		}
		else if(storedcentername == null || trimfield(storedcentername) == '')
		{
			alert("Please fill Center Name");
			return false;
		}
		else if(storedstate == null || trimfield(storedstate) == '' || storedstate < 0)
		{
			alert("State field cannot be empty. Please fill this field");
			return false;
		}
		else if(storedcity == null || trimfield(storedcity) == '' || storedcity < 0)
		{
			alert("City field cannot be empty. Please fill this field");
			return false;
		}
		else
			return true;
	}
}</script>
</head>
<body>
<%@ include file= "../includes/remotemenuheader.jsp" %>

<form class="form-4" name = "addremotecenter" method="post" action="../../addremotecenter" onsubmit="return validate()">
<%if(count == 0) {%>
<input id = "check" name = "check" type = "hidden" value = "1"/>
<div style="margin-top:40px;">
	<div><label class="ui-text" style="margin:auto;color:#9bbb59; font-size: 25px;">Add Remote Center</label></div>
	<div style="margin-top:30px">
	<table  style="height:150px;margin:auto; " border='0'>
		<tr>
			<td style="height:20px;width:180px;">
				<label style=" color: #e46c0a;font-size:18px" >Enter Center ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="centerid"  style="width:220px; font-size:15px; " type="text" name="centerid" autofocus required tabindex="1"  placeholder="Center ID"/>
			</td>
		</tr>
		<tr>
			<td style="height:20px;width:260px;">
				<label style=" color: #e46c0a;font-size:18px">Enter Center Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="centername"  style="width:220px;  font-size:15px; " type="text" name="centername" required tabindex="2"  placeholder="Center Name"/>
			</td>
		</tr>
		<tr>
			<td style="height:20px;width:50px;">
				<label style=" color: #e46c0a;font-size:18px">Enter State&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="state"  style="width:220px;  font-size:15px; " type="text" name="state" required tabindex="3"  placeholder="State"/>
			</td>
		</tr>
		<tr>
			<td style="height:20px;width:50px;">
				<label style=" color: #e46c0a;font-size:18px">Enter City&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="city"  style="width:220px;  font-size:15px; " type="text" name="city" required tabindex="4"  placeholder="City"/>
			</td>
		</tr>
				
	</table>
	</div>
</div>
<%}else{ %>
	<input id = "check" name = "check" type = "hidden" value = "2"/>
	<p style = "color: red;"> An Entry for this Remote Center already exist with the following information. If you wish you can edit it.</p>
	<div style="margin-top:40px;">
	<div><label class="ui-text" style="margin:auto;color:#9bbb59; font-size: 25px;">Remote Center Information</label></div>
	<div style="margin-top:30px">
	<table  style="height:150px;margin:auto; " border='0'>
		<tr>
			<td style="height:20px;width:180px;">
				<label style=" color: #e46c0a;font-size:18px" >Center ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="storedcenterid"  style="width:220px; font-size:15px;" value = "<%=centerid %>" type="text" name="storedcenterid" autofocus required tabindex="1"  placeholder="Center ID" readonly/>
			</td>
		</tr>
		<tr>
			<td style="height:20px;width:260px;">
				<label style=" color: #e46c0a;font-size:18px">Center Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="storedcentername"  style="width:220px; font-size:15px;" value = "<%=centername %>" type="text" name="storedcentername" required tabindex="2"  placeholder="Center Name"/>
			</td>
		</tr>
		<tr>
			<td style="height:20px;width:50px;">
				<label style=" color: #e46c0a;font-size:18px">State&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="storedstate"  style="width:220px;  font-size:15px;" value = <%=state %> type="text" name="storedstate" required tabindex="3"  placeholder="State"/>
			</td>
		</tr>
		<tr>
			<td style="height:20px;width:50px;">
				<label style=" color: #e46c0a;font-size:18px">City&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="storedcity"  style="width:220px; font-size:15px;" value = "<%=city%>" type="text" name="storedcity" required tabindex="4"  placeholder="City"/>
			</td>
		</tr>
				
	</table>
	</div>
</div>
<%} %>
	
	<div style="margin-top:20px">	
		<button name = "submit" style="background:#9bbb59; font-size:21px; color:#ffffff;	margin-right:10px; border-radius:8px; min-width:0.6in; min-height:0.4in; width:100px; margin-top:15px;"  id="submit" type="submit" tabindex="5" >
		<span>Submit</span>
		</button>
		<button name = "cancel" style="background:#9bbb59; font-size:21px; color:#ffffff;	margin-right:10px; border-radius:8px; min-width:0.6in; min-height:0.4in; width:100px; margin-top:15px;"  id="cancel" type="button" tabindex="6" onclick = "history.back( )">
		<span>Cancel</span>
		</button>
	</div>
</form>
<div style="margin-top: -600px; text-align: center;">
		<%@ include file="../../jsp/includes/menufooter.jsp"%>
	</div>
</body>
</html>