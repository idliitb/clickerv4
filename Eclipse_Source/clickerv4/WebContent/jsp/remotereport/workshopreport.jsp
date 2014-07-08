<%--@author rajavel 
This jsp file is used for course report
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

String dates="";
int courseatt_sdd = 0, courseatt_smm=0, courseatt_syyyy=0;
int courseatt_edd = 0, courseatt_emm=0, courseatt_eyyyy=0;
int raiseHand_sdd = 0, raiseHand_smm=0, raiseHand_syyyy=0;
int raiseHand_edd = 0, raiseHand_emm=0, raiseHand_eyyyy=0;
String courseatt_dates="";
String studentIDs ="";
String raiseHand_dates="";
String WorkshopID = session.getAttribute("WorkshopID").toString();
RemoteReportHelper reportHelper = new RemoteReportHelper();
String calendarDate=  reportHelper.getCalendarDate(WorkshopID, "attendanceTakenDate", CoordinatorID);
courseatt_dates = calendarDate.split("@")[0];
System.out.println(courseatt_dates);			
String date = calendarDate.split("@")[1];
courseatt_syyyy = Integer.parseInt(date.split("-")[0]);
courseatt_smm = Integer.parseInt(date.split("-")[1]);
courseatt_sdd = Integer.parseInt(date.split("-")[2]);						
date = calendarDate.split("@")[2];
courseatt_eyyyy = Integer.parseInt(date.split("-")[0]);
courseatt_emm = Integer.parseInt(date.split("-")[1]);
courseatt_edd = Integer.parseInt(date.split("-")[2]);
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Workshop Report</title>
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
			#highlight,.highlight {
				background-color: #00FF00;
				color : #00FF00;
				font-weight: bold;
			}
		</style>
		<script type="text/javascript">
		var courseatt_start= new Date(<%=courseatt_syyyy%> , <%=courseatt_smm-1%>, <%=courseatt_sdd%>);
	  	var courseatt_end = new Date(<%=courseatt_eyyyy%> , <%=courseatt_emm-1%>, <%=courseatt_edd%>);
	  	var courseatt_dateString = "<%=courseatt_dates%>";
	  	var courseatt_dates= courseatt_dateString.split(",");
	  	InsideResponseReadForQuizPoll();
	  	$(function() {
			$( "#courseAtt_datepicker" ).datepicker({
				minDate: courseatt_start, maxDate: courseatt_end,
				changeMonth: true,
				changeYear: true, 
				beforeShowDay: highlightDays
			});	

			function highlightDays(date) {
				//alert(date);
				for (var i = 0; i < courseatt_dates.length; i++) {
					if (courseatt_dates[i] == date.formatYYYYMMDD()) {
						return [true, 'highlight'];
			        }
			    }
			    return [true, ''];
			} 
			Date.prototype.formatYYYYMMDD=function(){
			    var dd = this.getDate(), mm = this.getMonth()+1, yyyy = this.getFullYear();
			    if(dd<10){
			      dd = '0' + dd;
			    }
			    if(mm<10){
			      mm = '0'+ mm;
			    }
			  return String(yyyy + "-" + mm + "-" + dd);
			  };
		});	    	
		</script>
	</head>
	<body class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
		<%@ include file= "../../jsp/includes/remotemenuheader.jsp" %>
		<table class="table1">
			<tr ><td >
				<div class="ui-header-text" ><h2>Workshop Report</h2></div>
			</td></tr>
		</table>
		<table class="table1" style="margin-top:8px;" border="1" >
			<tr ><td width="20%">
				<span style="margin-left:10px;"></span><input type="radio" value="ParticipantList" name="courserpt"  onchange="courseDetail()"/>
				<label>Participant list</label><br><br>
				<span style="margin-left:10px;"></span><input type="radio" value="Attendance" name="courserpt" onchange="courseDetail()"/>
				<label>Attendance</label><br><br>				
				<div id="courseAttDate" style="display: none;">
					<label style="margin-left:35px;">Date :</label>&nbsp;
					<input type="text" id="courseAtt_datepicker" style="width: 85px;" onchange="fillAttenDetail('<%=WorkshopID%>', this.value)"/><br><br>
				</div>
				<div id="att_ts" style="display: none;">
					<select name="attendancetimestamp"	id="attendancetimestamp" onclick="setAttendanceTS()">
						<option value="">Time Stamp</option>
					</select>
				</div>
				<span style="margin-left:10px;"></span><input type="radio" value="RemoteQuizSummary" name="courserpt" onchange="courseDetail()"/>
				<label>Quiz summary</label><br><br>
				<button class="ui-conductquiz-button" id="coursereport_btn" type="button" style="margin-left: 50px;" onclick="coruseRport('<%=WorkshopID%>')">
					<span>Show report</span>
				</button>
			</td>
			<td width="80%">
				<div id="coursereport"  style="font-size: 18px; height:450px; width:100%; overflow: auto; text-align: center;"></div>
			</td></tr>
		</table>
		<div style="margin-top:-600px;">
			<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		</div>
	</body>
</html>