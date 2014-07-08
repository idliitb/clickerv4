<%--@author rajavel 
This jsp file is used for student report
--%>

<%@page import="clicker.v4.report.RemoteReportHelper"%>
<%
String CoordinatorID = (String) session.getAttribute("CoordinatorID");
if (CoordinatorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
String WorkshopID = session.getAttribute("WorkshopID").toString();
RemoteReportHelper reportHelper = new RemoteReportHelper();
String ParticipantList = reportHelper.getParticipantIDs(WorkshopID);
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Participant Report</title>
		<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
		<link type="text/css" rel="stylesheet" href="../../css/style.css">
		<link type="text/css" rel="stylesheet" href="../../css/jquery-ui.css">
		<script src="../../js/jquery-1.9.1.js"></script>
		<script src="../../js/jquery-ui.js"></script>
		<script src="../../js/remotereport.js"></script>
		<style type="text/css">
			._css3m{
				display:none
			}
			.ui-autocomplete {
				max-height: 100px;
				overflow-y: auto;
				/* prevent horizontal scrollbar */
				overflow-x: hidden;
				/* add padding to account for vertical scrollbar */
				padding-right: 20px;
			}
			/* IE 6 doesn't support max-height
	 			* we use height instead, but this forces the menu to always be this tall
	 			*/
			html .ui-autocomplete {
				height: 100px;
			}						
		</style>
		<script>
			InsideResponseReadForQuizPoll();
			$(function() {			
				var studList = "<%=ParticipantList%>";
				var availableList = studList.split(",");
				$( "#studentid_autocomplete" ).autocomplete({
					source: availableList,
					focus: function( event, ui ) {
						$( "#studentid_autocomplete" ).val( ui.item.label );
						participantInfo(this.value);						
						return false;
					},
					select: function( event, ui ) {
						$( "#studentid_autocomplete" ).val( ui.item.label );
						return false;
					}			
				});	
				
				$("#studreport").click(function(){
					var id = document.getElementById("studentid_autocomplete").value;
					if (id == ""){
						alert("Enter Student ID");
						return false;
					}else if(studList.indexOf(id + ",") == -1){
						alert("Participant ID is not available");
						return false;
					}
					document.getElementById("report").innerHTML= "<img src='../../img/loading.gif' style='margin-top: 40px;'><div>Report is generating...</div>";
					$("#report").load("../../RemoteReport?id="+id + "&report=partcipantreport");
				});				
			});				
		</script>
	</head>
	<body class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
		<%@ include file= "../../jsp/includes/remotemenuheader.jsp" %>
		<table class="table1">
			<tr ><td >
				<div class="ui-header-text" ><h2>Participant Report</h2></div>
				<div style="text-align: center;">
					<label>Workshop ID : <%=WorkshopID %></label>
				</div>
			</td></tr>
		</table>
		<table class="table1" style="margin-top:25px;" >
			<tr><td style="margin:auto;">
				<div style="text-align: center;">
					<label> Participant ID :</label>
					<input type="text"	id="studentid_autocomplete" />
				</div>	
			</td></tr>
		</table>
		<div id=studentinfo class="table1" style="margin-top:15px;">
			<table  border="1" style="margin:auto;border-radius:5px;" >
				<tr ><td>
					<label>Participant Name</label>
					<span style="margin-left:50px;" ></span>
				</td>
				<td>
					<span style="margin-left:150px;" ></span>
				</td></tr>
				<tr ><td>
					<label>Mac Address</label>
					<span style="margin-left:50px;" ></span>
				</td>
				<td>
					<span style="margin-left:150px;" ></span>
				</td></tr>
			</table>
		</div>
		<table class="table1" style="margin-top:5px;">
			<tr ><td >
			<button class="ui-conductquiz-button"  id="studreport" type="submit" style="margin:0px 0 0 460px;">
					<span>Show report</span>
			</button>
			</td></tr>
		</table>
		<table class="table1" style="margin-top:5px;" border="1">
			<tr ><td >
				<div id="report" style="font-size: 18px; margin-left:90px; height:300px;overflow: auto; text-align: center;"></div>
			</td></tr>
		</table>
		<div style="margin-top:-600px;">
			<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		</div>
	</body>
</html>