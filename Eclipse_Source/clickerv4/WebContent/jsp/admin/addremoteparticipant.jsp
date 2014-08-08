<%--
      @author Gobinath
DESCREPTION: This JSP Page will display when you Press the add Participant in admin menu 
			  in remote mode
USE        : to add remote participant by xls template ,by individual,delete participant,
			 and remove the mac address for the tablet for particular participant 

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="clicker.v4.admin.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>

<%
//System.out.println("=================================>"+(String) session.getAttribute("WorkshopID"));
	String coordinatorid = (String) session.getAttribute("CoordinatorID");
	String WS_ID=(String) session.getAttribute("WorkshopID");
	String no_WS;
	//String[] Flds = WS_ID.split("[,]");
	//System.out.println("====================================================>"+Flds[1]);
	
	//ArrayList<String> selectworkshop = new SelectWorkshop( ).workshopselect(coordinatorid);
	//int wscount = selectworkshop.size( );
	//System.out.println("workshop count: " + wscount);
	Admindata getdata = new Admindata();
	String ParticipantList = getdata.ParticipantIDs(WS_ID);
%>
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">

<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>
<script type="text/javascript" src="participantxls.js"></script>
<title>Add Participants</title>
<script>
function trimfield(str) 
{ 
	 	return str.replace(/^\s+|\s+$/g,''); 
}
function validate( )
{
	var participantid = document.getElementById("participantid").value;
	var participantname = document.getElementById("participantname").value;
	
	
	if(participantid == null ||trimfield(participantid) == '')
	{
		alert("Please enter Participant ID");
		return false;
	}
	else if(participantname == null || trimfield(participantname) == '')
	{
		alert("Please enter Participant Name");
		return false;
		
	}
	else
		return true;
}

$(document).ready(function(){
	<%if(request.getParameter("fileUploadStatus")!=null){%>
	alert('<%=request.getParameter("fileUploadStatus")%>');
	<%}%>
});
</script>


<script>

function QuizPollListener(){
	$(document).ready(function() {
	    setInterval(function() {
	    	 jQuery.get("../../jsp/remotejsp/remoteListener.jsp", function (response) {
	        	if(response.trim()!=null){

	        		if(response.trim()=="quizlaunch"){
	            		window.location.href="../../jsp/remotejsp/remotequiz.jsp";
	            		
	                	}
	            	if(response.trim()=="polllaunch"){
	            		window.location.href="../../jsp/remotejsp/remotepoll.jsp";	            		
	            	}
	            	if(response.trim()=="launchinstantquiz"){
	            		window.location.href="../../jsp/remotejsp/instantquiz.jsp";
	            		
	                	}
	        	}
	    	});
	    }, 1000);
	});
	}  

			$(function() {			
				var studList = "<%=ParticipantList%>";
				var availableList = studList.split(",");
				$( "#Part_box" ).autocomplete({
					source: availableList,
					focus: function( event, ui ) {
						$( "#Part_box" ).val( ui.item.label );
						studentInfo(this.value);						
						return false;
					},
					select: function( event, ui ) {
						$( "#Part_box" ).val( ui.item.label );
						return false;
					}			
				});			
			});	
		</script>



</head>
<body onload = "getlist( )">
<%@ include file= "../includes/remotemenuheader.jsp" %>
<script>QuizPollListener();</script>
<% 
if(WS_ID.equalsIgnoreCase(" Wrong URL") || WS_ID.equalsIgnoreCase("No Workshop, As No MainCenter"))
{
	%>
	<div style="margin-top:40px;height: 60%;">
	<font size="10">No Workshop Active</font>
	</div>
	
	<%
	
}else
{
	//System.out.println("====>"+Flds[1]);
	%>

<div style="margin-top:40px;">
<textarea name="WS_id" id="WS_id" rows="1" cols="50" style="height:0px;width:0px;visibility: hidden;"><%=WS_ID%></textarea>
<!-- <input type="text" name="WS_id" id="WS_id" value=<%=WS_ID%> style="visibility: hidden;"> -->
	
	<div style="margin-top:30px;">
	
	<center>
	<table border="1" id="RC_d" style="border: solid 3px #7f7f7f;border-collapse:collapse;font-size:15px;padding: 2px;border: solid 1px #7f7f7f;width: 700px;" >

<tr style="background-color:#9BBB59">

				<th colspan="2">
				<label class="ui-text" style="margin:auto;color:#ffffff; font-size: 25px;">Add Participant</label>		
	
				</th>
				
						
</tr>
<tr>
	<th align="left" width="350px;" ><label class="ui-text" style="margin:auto; font-size: 15px;">Add Participant BY Xls</label>	</th>
	<th align="left" ><label class="ui-text" style="margin:auto; font-size: 15px;">individual</label>	</th>
</tr>


<tr  height="150px;">
		<td>
				<div align="center">
				<input id="file" type="file" name="xls" />
				<br><br>
				 <a href="../../xlstemplates/RemoteParticipantInfo_Template.xls" style = "margin-left: -15px;">Add Participant Template</a>
				<button id="preview" type="button" style="" onclick = "uploadXLS();">
				<span>Preview</span>
				</button>
			</div>
		</td>
		<td>
			
			<div>
					<table id="tablepaging" class="sss" align="center" cellpadding="3">

					<tr>
						<td>Participant ID</td>
						<td><input type="text" name="Part_id" id="Part_id" onkeyup="nospaces(this);" ></td>
					</tr>
					<tr>
						<td>Participant Name</td>
						<td><input type="text" name="Part_name" id="Part_name" ></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
						
						<button style="background:#9bbb59; font-size:16px; color:#ffffff;	margin-right:10px; border-radius:12px; min-width:0.4in; min-height:0.3in; width:100px; margin-top:15px;"   onclick="add_part();" >
						<span>ADD</span>
						</button>
					
						</td>
						
					</tr>
				
					</table>

			</div>
		</td>
</tr>


<tr height="75px;">

<td colspan="2">

<div>
								
								<div style="float: left; ">
									Delete Participant &nbsp&nbsp&nbsp <input type="text"
										name="Part_box" id="Part_box" onkeyup="nospaces(this);" />&nbsp&nbsp&nbsp 
										<button style="background:#9bbb59; font-size:16px; color:#ffffff;	margin-right:10px; border-radius:12px; min-width:0.4in; min-height:0.3in; width:100px; margin-top:15px;"   onclick="delete_part();" >
						<span>Delete</span>
						</button>
						<button style="background:#9bbb59; font-size:15px; color:#ffffff;	margin-right:10px; border-radius:12px; min-width:0.4in; min-height:0.3in; width:100px; margin-top:15px;"   onclick="remove_mac();" >
						<span>Remove Mac</span>
						</button>
						
								</div>
							</div>

</td>
</tr>

<tr height="50px;">

<td colspan="2">
<div style="float: left; ">
									Delete All Participant &nbsp&nbsp&nbsp  
										<button style="background:#9bbb59; font-size:16px; color:#ffffff;	margin-right:10px; border-radius:12px; min-width:0.4in; min-height:0.3in; width:100px; margin-top:15px;"   onclick="delete_all();" >
						<span>Delete All</span>
						</button>
								</div>

							

</td>
</tr>



</table>
<center>
<input type="text" name="WS_id" id="WS_id" value=<%=WS_ID%> style="visibility: hidden;" >	
	
	</div>
	
	<div align="center">
	<table id="Part_table" border="1" style="align:center; border: solid 3px #7f7f7f;border-collapse:collapse;font-size:15px;padding: 2px;border: solid 1px #7f7f7f;width: 400px;" >
	<thead style="background-color:#9BBB59;font-size: 16;font-weight: bold;">
	<tr> 
	<td colspan="2">
	<label style="font-size:18px" id="Work_shop"> Workshop ID: <%=WS_ID%></label>
	</td>
	</tr>
	<tr>
	<td>Participant ID</td>
	<td>Participant Name</td>
	</tr>
	</thead>
	<tbody>
	<%
	
	DatabaseConnection dbconn1 = new DatabaseConnection();
	Connection conn1 = dbconn1.createRemoteDatabaseConnection();
	Statement st1 = conn1.createStatement();
	String query2 = "SELECT ParticipantID,ParticipantName FROM participant where WorkShopID='"+WS_ID+"'";
	ResultSet rs1 = st1.executeQuery(query2);
	
	while (rs1.next()) {

		String P_Id = rs1.getString(1);
		String P_name = rs1.getString(2);
		%>
		<tr id=<%=P_Id %>>
	<td><%=P_Id %></td>
	<td><%=P_name %></td>
	</tr>	
		<%
	}
	dbconn1.closeRemoteConnection(conn1);
	%>
	</tbody>
	</table>
	
	</div>
	
	<div id="dialog" title="File Preview" style = "visibility: hidden;">
	<form action="participantxlsupload.jsp" method="get" id="uploadForm">
	<iframe id="frame" style = "height: 0px;width: 0px; overflow: auto;">
	</iframe ><br/><br/>
	
		<input type = "hidden" name = "workshopid" id = "workshopid">
		<input type="hidden" name=xls id="xls">
		<input type="submit" value=" Add Participants "/>&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value=' Cancel ' onclick="closeDialog();"/>
	
</form>
</div>
</div>

<!-- <input type = hidden id = "plist" value = ""/> -->
<div id = "participantlist"></div>
<%
}
%>

<div style="margin-top: -600px; text-align: center;">
		<%@ include file="../../jsp/includes/menufooter.jsp"%>
	</div>
</body>
</html>