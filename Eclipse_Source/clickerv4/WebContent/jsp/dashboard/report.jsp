<%--@author rajavel 
This jsp file is used for quiz dashboard
--%>
<%--
@Credit - Highcharts
	http://api.highcharts.com/highcharts
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

String dates="";
int courseatt_sdd = 0, courseatt_smm=0, courseatt_syyyy=0;
int courseatt_edd = 0, courseatt_emm=0, courseatt_eyyyy=0;
int raiseHand_sdd = 0, raiseHand_smm=0, raiseHand_syyyy=0;
int raiseHand_edd = 0, raiseHand_emm=0, raiseHand_eyyyy=0;
String courseatt_dates="";
String studentIDs ="";
String raiseHand_dates="";
String courseID = session.getAttribute("courseID").toString();
ReportHelper reportHelper = new ReportHelper();
String calendarDate=  reportHelper.getCalendarDate(courseID, "attendanceTakenDate", InstructorID);
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

calendarDate=  reportHelper.getCalendarDate(courseID, "raiseHandDate", InstructorID);
raiseHand_dates = calendarDate.split("@")[0];
System.out.println("Raise Hand : " + raiseHand_dates);			
date = calendarDate.split("@")[1];
raiseHand_syyyy = Integer.parseInt(date.split("-")[0]);
raiseHand_smm = Integer.parseInt(date.split("-")[1]);
raiseHand_sdd = Integer.parseInt(date.split("-")[2]);						
date = calendarDate.split("@")[2];
raiseHand_eyyyy = Integer.parseInt(date.split("-")[0]);
raiseHand_emm = Integer.parseInt(date.split("-")[1]);
raiseHand_edd = Integer.parseInt(date.split("-")[2]);

%>
<!DOCTYPE>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Dashboard</title>
		<link type="text/css" rel="stylesheet" href="../../css/style.css">
		<link type="text/css" rel="stylesheet" href="../../css/reportdashboard.css">
		<link type="text/css" rel="stylesheet" href="../../css/jquery-ui.css">
		<script src="../../js/jquery-1.9.1.js"></script>
		<script src="../../js/jquery-ui.js"></script>
		<script src="../../js/reportdashboard.js"></script>
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
	  	var raiseHand_start= new Date(<%=raiseHand_syyyy%> , <%=raiseHand_smm-1%>, <%=raiseHand_sdd%>);
	  	var raiseHand_end = new Date(<%=raiseHand_eyyyy%> , <%=raiseHand_emm-1%>, <%=raiseHand_edd%>);
	  	var raiseHand_dateString = "<%=raiseHand_dates%>";
	  	//document.getElementById("hide_querydates").innerHTML = raiseHand_dateString;
	  	var raiseHand_dates= raiseHand_dateString.split(",");
	  	$(function() {
			$( "#studentQuery_datepicker" ).datepicker({
				minDate: raiseHand_start, maxDate: raiseHand_end,
				changeMonth: true,
				changeYear: true, 
				beforeShowDay: highlightDays
			});	

			function highlightDays(date) {
				//alert(date);
				for (var i = 0; i < raiseHand_dates.length; i++) {
					if (raiseHand_dates[i] == date.formatYYYYMMDD()) {
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
	<body onload="quizData('<%=InstructorID%>')" class="ui-Mainbody" style="width:100%; height:100%; text-align: center; background-color: #fff;">
		<%@ include file= "../../jsp/includes/menuheader.jsp" %>
		<script src="../../js/highcharts.js"></script>
		<table class="table1">
			<tr ><td >
				<div id="qtype" style="display: inline; margin-left: 20px;">
					<input type="radio" checked="checked" name="reporttype" value="QuizResponse" />Quiz Report
					<input type="radio" name="reporttype" value="QuizResult" />Quiz Result
				</div>
				<div class="ui-header-text"  style="display: inline;margin-left: 240px;"><h2 style="display: inline;">Dashboard</h2></div>
			</td></tr>
		</table>
		<table class="table1" style="margin-top: 10px;">
		<tr>
		<td>		
		<div class="notebox" onclick="changeActive('nq')">
			<div id="nq_head" class="boxhead" style="background-color: #9bbb59">Normal quiz</div>
			<div id="nq" class="boxnote" style="background-color: #9bbb59">00</div>
		</div>
		<div class="notebox" onclick="changeActive('iq')">
			<div id="iq_head" class="boxhead">Instant quiz</div>
			<div id="iq" class="boxnote">00</div>
		</div>		
		<div class="notebox" onclick="changeActive('p')">
			<div id="p_head" class="boxhead">Poll</div>
			<div id="p" class="boxnote">00</div>
		</div>
		<div class="notebox" onclick="changeActive('ts')">
			<div id="ts_head" class="boxhead">Total Student</div>
			<div id="ts" class="boxnote">00</div>
		</div>
		</td>
		<td rowspan="2" align="center" style="width: 490px;">
		<div id="qpChart" style="margin: auto; width:450px;height: 170px;"><img src="../../img/loading.gif"/></div>		
		<div id="qpChart1" ></div>
		</td>
		</tr>
		<tr>
			<td>				
				<div class="downarrow_div">
					<img id="nq_arrow" style="visibility: visible;" class="downarrow" src="../../img/downarrow.png"></img>			
				</div>
				<div class="downarrow_div">
					<img id="iq_arrow" class="downarrow" src="../../img/downarrow.png"></img>			
				</div>
				<div class="downarrow_div">
					<img id="p_arrow" class="downarrow" src="../../img/downarrow.png"></img>			
				</div>
				<div class="downarrow_div">
					<img id="ts_arrow" class="downarrow" src="../../img/downarrow.png"></img>			
				</div>
				
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div id="nqcontent_div" class="boxcontainer" style="display: block"><img src="../../img/loading.gif"/></div>
				<div id="iqcontent_div" class="boxcontainer"></div>
				<div id="pcontent_div" class="boxcontainer"></div>
				<div id="tscontent_div" class="boxcontainer"></div>
			</td>
		</tr>
		</table>
		<div id="quizreport"> 
		<div id="dlg_header"></div>
		<div id="dlg_body"></div>
		</div>
		<div id="quizreport1" style="display: none;">
		<div id="dlg_header_att"> 
			Select Date : <input type="text" id="courseAtt_datepicker" style="width: 85px;" onchange="fillAttenDetail('<%=courseID%>', '<%=courseatt_dates %>', this.value)"/>
			<div id="att_ts" style="display: none;">
				<select name="attendancetimestamp"	id="attendancetimestamp">
					<option value="">Time Stamp</option>
				</select>
			</div> 
		</div>
		<div id="dlg_header_query"> 
			Select Date : <input type="text" id="studentQuery_datepicker" style="width: 85px;" onchange="studentQuery(this.value)"/>  
			<div id="hide_querydates" style="display: none;"><%=raiseHand_dates%></div>
		</div>
		<div id="dlg_body1"></div>
		</div>
		<div id="tempdiv" style="display: none;">
		</div>
		<div style="margin-top: -600px;">
			<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		</div>
	</body>
</html>