<%--@author rajavel 
This jsp file is used for instant quiz report
--%>
<%@page import="clicker.v4.report.ReportHelper"%>
<%
String InstructorID = (String) session.getAttribute("InstructorID");
if (InstructorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
String courseID = session.getAttribute("courseID").toString();
ReportHelper reportHelper = new ReportHelper();
String calendarDate = reportHelper.getCalendarDate(courseID, "pollCondectedDate", InstructorID.toString());			
String dates = calendarDate.split("@")[0];
String date = calendarDate.split("@")[1];
System.out.println(dates);
int syyyy = Integer.parseInt(date.split("-")[0]);
int smm = Integer.parseInt(date.split("-")[1]);
int sdd = Integer.parseInt(date.split("-")[2]);
date = calendarDate.split("@")[2];
int eyyyy = Integer.parseInt(date.split("-")[0]);
int emm = Integer.parseInt(date.split("-")[1]);
int edd = Integer.parseInt(date.split("-")[2]);
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Poll Report</title>
		<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
		<link type="text/css" rel="stylesheet" href="../../css/style.css">
		<link type="text/css" rel="stylesheet" href="../../css/jquery-ui.css">
		<script src="../../js/jquery-1.9.1.js"></script>
		<script src="../../js/jquery-ui.js"></script>
		<script src="../../js/report.js"></script>
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
		<script>
 			var start= new Date(<%=syyyy%> , <%=smm-1%>, <%=sdd%>);
  			var end = new Date(<%=eyyyy%> , <%=emm-1%>, <%=edd%>);
  			var dateString = "<%=dates%>";
  			var dates= dateString.split(",");
  			$(function() {
				$( "#poll_datepicker" ).datepicker({
					minDate: start, maxDate: end,
					changeMonth: true,
					changeYear: true, 
					beforeShowDay: highlightDays
				});	
		
				function highlightDays(date) {
					for (var i = 0; i < dates.length; i++) {						
						if (dates[i] == date.formatYYYYMMDD()) {
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
		<%@ include file= "../../jsp/includes/menuheader.jsp" %>
		<table class="table1">
			<tr ><td >
				<div class="ui-header-text" ><h2>Poll Report</h2></div>
			</td></tr>
		</table>
		<table class="table1" style="margin-top:8px;" border="1" >
			<tr ><td width="22%">
				<label style="margin-left:35px;">Date :</label>&nbsp;
				<input type="text" id="poll_datepicker"	style="width: 85px;" onchange="fillPollTime()" ><br><br>
				<div id="polltime" style="display: none;">
					<select name="polltimeselect" id="polltimeselect" onchange="setPollTime()">
						<option value="Time Stamp">Time Stamp</option>
					</select>					
				</div> <br/>
				<input type="hidden" style="display: none;" id="hide_pid" name="hide_pid" />
				<input type="hidden" style="display: none;" id="hide_pts" name="hide_pts" />
				<span style=""></span><input type="radio" checked="checked" value="PollResponse" name="pollrpt"/>
				<label>Poll Response</label><br><br>				
				<button class="ui-conductquiz-button" id="quizreport_btn" type="button" style="margin-left: 50px;" onclick="pollReport('<%=dates%>')">
					<span>Show report</span>
				</button>	
			</td>
			<td width="78%">
				<div id="pollreport" style="font-size: 18px; height:450px; width:100%; overflow: auto; text-align: center;"></div>
			</td></tr>
		</table>
		<div style="margin-top:-600px;">
			<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		</div>
	</body>
</html>