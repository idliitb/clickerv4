<%--@author rajavel 
This jsp file is used for student report
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
String StudentList = reportHelper.getStudentIDs(courseID);
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Student Report</title>
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
			$(function() {	
				var iid = "<%=InstructorID%>";
				var studList = "<%=StudentList%>";
				var availableList = studList.split(",");
				$( "#studentid_autocomplete" ).autocomplete({
					source: availableList,
					focus: function( event, ui ) {
						$( "#studentid_autocomplete" ).val( ui.item.label );
						studentInfo(this.value);						
						return false;
					},
					select: function( event, ui ) {
						$( "#studentid_autocomplete" ).val( ui.item.label );
						return false;
					}			
				});	
				
				$("#studreport").click(function(){
					var sid = document.getElementById("studentid_autocomplete").value;
					if (sid == ""){
						alert("Enter Student ID");
						return false;
					}else if(studList.indexOf(sid + ",") == -1){
						alert("Student ID is not available");
						return false;
					}
					document.getElementById("report").innerHTML= "<img src='../../img/loading.gif' style='margin-top: 40px;'><div>Report is generating...</div>";
					$("#report1").load("../../studentPerformanceChart?sid="+sid, function(){
						$("#report").load("../../Report?sid="+sid + "&report=studreport", function(){
							document.getElementById("schart").innerHTML = "<img src='../../"+iid+"/studResult.png?"+new Date()+"' />";
	  					});	
  					});
					
				});				
			});				
		</script>
	</head>
	<body class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
		<%@ include file= "../../jsp/includes/menuheader.jsp" %>
		<table class="table1">
			<tr ><td >
				<div class="ui-header-text" ><h2>Student Report</h2></div>				
			</td></tr>
		</table>
		<div class="table1">
		<div style="width:350px; margin-left:100px; float: left;">
		<table style="margin-top:15px;margin-left: 40px;" >
			<tr><td style="margin:auto;">
				<div style="text-align: center;">
					<label>Course : <%=courseID %></label>
				</div><br/>
				<div style="text-align: center;">
					<label> Student ID :</label>
					<input type="text"	id="studentid_autocomplete" />
				</div>	
			</td></tr>
		</table>
		<div id=studentinfo style="margin-top:15px;">
		<table  border="1" style="border-radius:5px;" >
			<tr ><td>
				<label>Student Name</label>
				<span style="margin-left:50px;" ></span>
			</td>
			<td>
				<span style="margin-left:150px;" ></span>
			</td></tr>
			<tr ><td>
				<label>Year of Joining</label>
				<span style="margin-left:50px;" ></span>
			</td>
			<td>
				<span style="margin-left:150px;" ></span>
			</td></tr>
			<tr ><td>
				<label>Teaching Assistant</label>
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
		<table style="margin-top:5px;">
			<tr ><td >
			<button class="ui-conductquiz-button"  id="studreport" type="submit" style="margin-left: 120px;">
					<span>Show report</span>
			</button>
			</td></tr>
		</table>
		</div>
		<div  id="schart" style="width: 500px; float: left; font-size: 20px;">
		<br><br><br>
			Student Performance Chart <img src="../../img/loading.gif"/>
		</div>
		</div>
		<table class="table1" border="1">
			<tr ><td >
				<div id="report" style="font-size: 18px; margin:auto; height:300px;overflow: auto; text-align: center;"></div>
				<div id="report1" style="display: none" ></div>
			</td></tr>
		</table>
		<div style="margin-top:-600px;">
			<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		</div>
	</body>
</html>