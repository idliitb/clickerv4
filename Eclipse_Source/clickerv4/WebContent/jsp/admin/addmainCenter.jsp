<%--
      @author Gobinath
DESCREPTION: This JSP Page will display when you Press the add maincenter in menu in remote mode
USE        : to add New maincenter

--%>

<%@page import="clicker.v4.databaseconn.DatabaseConnection" %>
<%@page import="java.sql.*"%>


<% 
String coordinatorid = (String) session.getAttribute("CoordinatorID");

%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Workshop</title>
	<link type="text/css" rel="stylesheet" href="../../css/jquery-ui.css">
	<link type="text/css" rel="stylesheet" href="../../css/login.css">
	<link rel="stylesheet" type="text/css" href="../../css/logininput.css" />
	<link type="text/css" rel="stylesheet" href="../../css/style.css">
	<link type="text/css" rel="stylesheet" href="../../css/style.css">
		<script src="../../js/jquery-1.9.1.js"></script>
		<script src="../../js/jquery-ui.js"></script>
		<script src="add_maincenter.js"></script>

<script type="text/javascript">

	function trimfield(str) 
	{ 
   	 	return str.replace(/^\s+|\s+$/g,''); 
	}

	var filter = /^[A-Z0-9]{4,}$/;
	
	function reset()
	{
		document.getElementById("workshopid").value="";
		document.getElementById("workshopname").value="";
		document.getElementById("Description").value="";
		document.getElementById("startDate_datepicker").value="";
		document.getElementById("endDate_datepicker").value="";	
	}
	

	function validatefield()
	{
		//alert("in validate");
	     var obj1 = document.addremoteworkshop.workshopid;
	     //alert(obj1.value);
	     var workshopname=document.addremoteworkshop.workshopname;
	     var description=document.addremoteworkshop.Description;
		 var StartDate=document.addremoteworkshop.startDate_datepicker;
		 var EndDate=document.addremoteworkshop.endDate_datepicker;
		 var mainurl=document.addremoteworkshop.mainurl;
		 //alert("StartDate "+StartDate.value);
		 //alert("EndDate "+EndDate.value);
			
	         if(trimfield(obj1.value) == '') 
	         {      
	           alert("Please enter Workshop ID");
	           obj1.focus();
	           return false;       
	         }
	         else if(!filter.test(obj1.value)){
	        	 alert("Workshop ID should contain combination of A-Z and 0-9 only");
		           obj1.focus();
		           return false; 
		         }
	         else if(trimfield(workshopname.value) == ''){
	        	 alert("Please enter Workshop Name");
	        	 workshopname.focus();
		           return false;
		         }
	         else if(trimfield(description.value) == ''){
	        	 alert("Please enter Workshop Description");
	        	 description.focus();
		           return false;
		         }
	         else if(trimfield(StartDate.value) == ''){
	        	 alert("Select Start Date for Workshop");
	        	 StartDate.focus();
		           return false;
		         }
	         else if(trimfield(EndDate.value) == ''){
	        	 alert("Select End Date for Workshop");
	        	 EndDate.focus();
		           return false;
		         }
	         else if(new Date(StartDate.value) > new Date(EndDate.value)) {
	             alert(fromdate+ 'is greater than ' + todate);
	             return false;
	     	 	}
	         else if(trimfield(mainurl.value) == '')
	        	{
	        	 	alert("Main Center URL cannot be empty.");
	        	 	return false;
	        	}
	         else{
				return true;
		         }
	}
	
</script>	
<script type="text/javascript">

		Date.format = 'yyyy/mm/dd';
	  	$(function() {
			$( "#startDate_datepicker" ).datepicker({ 
				dateFormat: "yy-mm-dd",
				minDate:0,
				changeMonth: true,
				changeYear: true,  });
			$( "#endDate_datepicker" ).datepicker({ 
				dateFormat: "yy-mm-dd",
				minDate:0,
				changeMonth: true,
				changeYear: true,  });
			
		});	  			
		</script>
</head>

<body onload="reset();" class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">

<div> 	
<%@ include file= "../../jsp/includes/remotemenuheader.jsp" %>
<script>QuizPollListener();</script>
<div style="margin-top:40px;">
	<div><label class="ui-text" style="margin:auto;color:#9bbb59; font-size:24px ">ADD NEW MAINCENTER</label></div>
	<div style="margin-top: 30px" align="center">
	
	<table   border="0" cellpadding="5" width="450">		
				
			<tr height="50px;"><td>Maincenter Name</td><td><input type="text" name="Maincenter_name" id="Maincenter_name" style="outline: none;background: white;box-shadow: 0 0 5px #333;width: 165px;background: white; border: 1px double #DDD; border-radius: 5px;float: left;padding: 5px 10px;"  > </td></tr><br>
			
			<tr height="50px;"><td>Maincenter_city </td><td> <textarea name="Maincenter_city" id="Maincenter_city" style="resize:none;outline: none;background: white;box-shadow: 0 0 5px #333;width: 165px;background: white; border: 1px double #DDD; border-radius: 5px;float: left;padding: 5px 10px;" cols="25" rows="1" ></textarea></td></tr>
			
			<tr height="50px;"><td>Maincenter_state </td><td><input type="text" name="Maincenter_state" id="Maincenter_state" style="outline: none;background: white;box-shadow: 0 0 5px #333;width: 165px;background: white; border: 1px double #DDD; border-radius: 5px;float: left;padding: 5px 10px;" ></td></tr>
			
				
			<tr height="50px;"> <td>Main Center URL <br>(Example: www.it.iitb.ac.in) </td><td> <input type="text" name="mainurl" id="mainurl" style="outline: none;background: white;box-shadow: 0 0 5px #333;width: 165px;background: white; border: 1px double #DDD; border-radius: 5px;float: left;padding: 5px 10px;"></td></tr>
			
		
			</table>
	<!-- <table  style="height:150px;margin:auto; " border="0">
	
	
		<tr>
			<td style="height:20px;width:200px;">
				<label style=" color: #e46c0a;font-size:18px;float: left;">Main Center Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="Maincenter_name"  style="width:220px; font-size:15px; " type="text" name="Maincenter_name"  tabindex="1" required autofocus/> 
			</td>
		</tr>
		
		<tr>
			<td style="height:20px;width:210px;">
				<label style=" color: #e46c0a;font-size:18px;float: left;">City&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="Maincenter_city"  style="width:220px;  font-size:15px; " type="text" name="Description" required tabindex="3"  />
				
			</td>
		</tr>
		
		<!-- <tr>
			<td style="height:20px;width:210px;">
				<label style=" color: #e46c0a;font-size:18px;float: left;">Start Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
			</td>
			<td style="height:20px;width:180px;">
				<span title="Please provide start date of your workshop "><input id="startDate_datepicker"  style="width:220px;  font-size:15px; " type="text" name="startDate_datepicker" required  tabindex="4"  /></span>
			</td>
		</tr> -->
		 
	<!-- 	<tr>
			<td style="height:20px;width:210px;">
				<label style=" color: #e46c0a;font-size:18px;float: left;">State &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :</label>
			</td>
			<td style="height:20px;width:180px;">
				<input id="Maincenter_state"  style="width:220px;  font-size:15px; " type="text" name="workshopname" required tabindex="2"  /> 
			</td>
		</tr>
		
		
		
		<tr>
			<td style="height:20px;width:290px;">
				<label style=" color: #e46c0a;font-size:18px;float: left;margin-top: 20px">Main Center URL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
				<br> <p>(Example: www.it.iitb.ac.in)</p>
			</td>
			<td style="height:20px;width:180px;">
				<input id="mainurl"  style="width:220px;  font-size:15px; " type="text" name="mainurl" required  tabindex="6"  />
			</td>
		</tr>
				
	</table> -->
	</div>
	
	<div style="margin-top:20px;margin-bottom:30px" >	
		<button style="background:#9bbb59; font-size:21px; color:#ffffff;	margin-right:10px; border-radius:8px; min-width:0.6in; min-height:0.4in; width:100px; margin-top:15px;"  tabindex="7" onclick="ADD_Center();" >
		<span>Submit</span>
		</button>
		<!-- <button style="background:#9bbb59; font-size:21px; color:#ffffff;	margin-right:10px; border-radius:8px; min-width:0.6in; min-height:0.4in; width:100px; margin-top:15px;"  id="cancel" type="button"  tabindex="8" onclick = "Clear_data();">
		<span>Clear</span>
		</button> -->
	</div>
	
</div>	
	
	
				

</div>


<div align="center">
	<table border="1" style="align:center; border: solid 3px #7f7f7f;border-collapse:collapse;font-size:15px;padding: 2px;border: solid 1px #7f7f7f;width: 400px;" >
	<thead style="background-color:#9BBB59;font-size: 16;font-weight: bold;">
	<tr>
						<th colspan="3" align="left">
							<div>
								<div style="float: left;">
									&nbsp&nbsp <img
										src="mm.png" onclick="Delete_RC();"
										style="cursor: pointer;" width="15px" height="15px"
										alt="button" border="0" title="Delete" />&nbsp&nbsp&nbsp 
								</div>
								
							</div>
						</th>
						</tr>
	<tr>
	<td>Main Center Name</td>
	<td>Main Center URL</td>
	</tr>
	</thead>
	<%
	
	DatabaseConnection dbconn1 = new DatabaseConnection();
	Connection conn1 = dbconn1.createRemoteDatabaseConnection();
	Statement st1 = conn1.createStatement();
	String query2 = "SELECT MainCenterID,MainCName,URL FROM maincenter";
	ResultSet rs1 = st1.executeQuery(query2);
	
	while (rs1.next()) {
        String m_ID=rs1.getString(1);
		String m_name = rs1.getString(2);
		String m_url = rs1.getString(3);
		%>
		<tr id=<%=m_ID%> onclick="rowSelected(id)" ondblclick="" >
	<td><%=m_name %></td>
	<td><%=m_url %></td>
	</tr>	
		<%
	}
	dbconn1.closeRemoteConnection(conn1);
	%>
	
	</table>
	
	</div>
	<div id="u_MC" style="visibility: hidden;"></div>
<div style="margin:-590px 0 0 0px;">
<%@ include file= "../../jsp/includes/menufooter.jsp" %>
</div>
</body>

</html>