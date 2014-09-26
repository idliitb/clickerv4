<%--@author dipti, rajavel
This file is used as header for remote clicker application
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "clicker.v4.admin.*"%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%@page import="clicker.v4.rest.*"%>
<%
String headerinstrid = (String) session.getAttribute("CoordinatorID");
String Maincenter_name=(String) session.getAttribute("maincentername");

JSONReadandparse version_reader = new JSONReadandparse();
String v_id=version_reader.version_id(getServletContext().getInitParameter("war_version"), getServletContext().getInitParameter("db_version"));
System.out.println("version from main center===>"+v_id);
System.out.println("WorkshopID>>>>>>>>>"+session.getAttribute("WorkshopID"));

if (headerinstrid == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
String headercid=session.getAttribute("WorkshopID").toString();

String centerID=null;
DatabaseConnection dbconn = new DatabaseConnection();
Connection conn = dbconn.createRemoteDatabaseConnection();
Statement st = conn.createStatement();
String query1 = "select CenterID from remotecenter";
//Original 11.20//String query1 = "select s.StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,s.DeptID,EmailID, CourseID from student s, studentcourse c where c.StudentID = s.StudentID";
System.out.println(query1);
ResultSet rs = st.executeQuery(query1);
while (rs.next()) {
	centerID = rs.getString(1);
}

dbconn.closeRemoteConnection(conn);
st.close();

//System.out.println("Privilege value: " + session.getAttribute("admin").toString( ));
/*String privilege = (String) session.getAttribute("admin");
System.out.println("Privilege value: " + privilege);
int privi = Integer.parseInt(privilege);
System.out.println("Privilege value: " + privilege);*/
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
		<link rel="stylesheet" href="../../css/menu.css" type="text/css" />
		<style type="text/css">
		
			._css3m{
				display:none
			}
			#banner_name{
		
			height:55px;
			width: 95%;
			border: solid;
			border-color: #404040;
			
			}
			#Csquare
			{
			margin-top:4px;			
			height: 100%;
			width: 50px;			
			background:url('../../img/Clicker50x50.png') no-repeat center;		
			}
			
			.remote_header{	
				width:1040px;				
				background-color: #404040;
				/*margin: -5% 0 0 -5%;*/
				margin:auto;
				border-radius:10px;	
			}
			
			.blink_me {
    -webkit-animation-name: blinker;
    -webkit-animation-duration: 1s;
    -webkit-animation-timing-function: linear;
    -webkit-animation-iteration-count: infinite;
    
    -moz-animation-name: blinker;
    -moz-animation-duration: 1s;
    -moz-animation-timing-function: linear;
    -moz-animation-iteration-count: infinite;
    
    animation-name: blinker;
    animation-duration: 1s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
}

@-moz-keyframes blinker {  
    0% { opacity: 1.0; }
    50% { opacity: 0.0; }
    100% { opacity: 1.0; }
}

@-webkit-keyframes blinker {  
    0% { opacity: 1.0; }
    50% { opacity: 0.0; }
    100% { opacity: 1.0; }
}

@keyframes blinker {  
    0% { opacity: 1.0; }
    50% { opacity: 0.0; }
    100% { opacity: 1.0; }
}
			
			
			
			
		</style>
	</head>
	<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript">
		function redirect()
		{
			window.location.href="../../logout.jsp";
		}
		
		function checkquizlaunch( )
		{
			//alert("in check quiz");
			$(document).ready(function() {
				jQuery.get("../../jsp/remotejsp/remoteListener.jsp", function (response) {
					if(response.trim()=="quizlaunch"){
						/*var child1 = document.getElementById("autotest");
						var parent=document.getElementById("list");
						try
						{
							parent.removeChild(child1);
						}
						catch(error)
						{
							alert("error message: " + error.message);
						}*/
						//alert("in check quiz");
						document.getElementById("autotest").style.display = "none";
					}
					//document.getElementById("autotest").style.visibility = "hidden";
				});
			});
		}

		function show_update()
		{
			var myWindow = window.open("../../jsp/admin/update.jsp","","status=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,directories=no,titlebar=no,personalbar=no, width=600,height=300,top=200, left=300");
			myWindow.document.title = 'Update';
			self.close();
			
		}
		function blinker() {
		    $('.blink_me').fadeOut(500);
		    $('.blink_me').fadeIn(500);
		}
	</script>
	<body  class="ui-Mainbody" style="width:100%; height:100%; text-align: center;" onload = "checkquizlaunch( );">
	<script>checkquizlaunch( );</script>
		<form >
 			<div>
				<table class="remote_header" id="remote_header" border=0 >
				<tr> 
				
				<td rowspan="2" width="120px" >
				
    				<div class=" ui-square " style="text-align: center;"><a style="text-decoration: none;" href="../../jsp/home/remotehome.jsp">
						<span class="ui-shape-text"></span></a></div>
						<div style="font-size:20px;  margin-left: 15px; color: #e46c0a;font-weight: bold; letter-spacing: 7px;">MHRD</div>
				</td>
					<td height="50px" >
          			
						 <table class="banner_inner_table" id="banner_inner_table" border=0>
						 <tr>
						 <td width="220px" height="70px">
						 <div id="inst_detail" style="height:60px; width: 220px;color: #fff;font-size: 13px;margin-top: -10px; ">
						 <%="  Coordinator ID : "+ headerinstrid  %> <br><br><%="Workshop ID : "+headercid%><br><br>
						 <%="Center ID : "+centerID%>
						</div>	
						 </td>
						 <td width="400px" height="70px">
						 <a style="text-decoration: none;" href="../../jsp/home/remotehome.jsp">
						 <div id="banner_name">
						   <div id=Csquare style="float: left;margin-left: 45px;"> </div>
						   <div style="margin-top:20px ;"><div style="width: 255; font-size:35px; color: white;letter-spacing: 2px;">LICKER</div></div>
							<%
								if(v_id.equals("update available")){%>
									<span class="blink_me" onclick="show_update();" style="margin-right: -46px; margin-top: -30px; float: right;font-size: 20px; font-weight: bolder; color: #ff3333;cursor:pointer;">UPDATE!</span>
								<%}%>
						   <div style="margin-left: 30px;"><font style="font-size:15px;font-weight: bold;color: #e46c0a;letter-spacing: 1.7px">Student Response System</font></div>
						</div>
						</a>
						 </td>
						 <td width="400px">
					<!-- 	 <div style="vertical-align: top;"><font style="font-size:13px;font-weight: bold;color: #E60000;letter-spacing: 1.7px">Main Center:&nbsp;&nbsp;<span class="blink_me"><%=Maincenter_name %></span></font>
						 </div>  -->
						 </td>
						 
						 </tr>
						 
						 </table>
						
					</td>
					
					
					<td rowspan="2" width="120px" >
				
    				<table class="banner_inner_table1" id="banner_inner_table2" style="width: 100%;height: 100%;margin-top: -5px;" border="0">
			 			  <tr>
							<td style="vertical-align:top;">
								<div id="loginout" style="float:right;cursor: pointer; margin-top: -5px;"><img src='../../img/Logout Logo.png' onclick="redirect();"></div>						
							</td>
							</tr>
							<tr align="center">
							<td>
								<div id="iit_logo" style="height: 80px;width: 80%;border: none;background-color:#9bbb59;background:url('../../img/iitb01 copy.png') no-repeat center">						
								
								</div>
								<font style="color:#e46c0a;font-weight: bold; ">IIT BOMBAY</font>
														
							</td>
						</tr>
				</table>
				</td>
				
				
				
				
				</tr>
				<tr>
				<td height="30px">
					<ul id="css3menu1" class="topmenu" style="margin:0% 0 0 0%;">
						
						<li class="topfirst"><a href="../../jsp/dashboard/rcreport.jsp" style="width:131px;height:21px;line-height:21px;"><span>Report</span></a>
						<%-- <ul>
							<li><a href="../../jsp/remotereport/workshopreport.jsp">
							Workshop&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
							<li><a href="../../jsp/remotereport/quizreport.jsp">Quiz</a></li>
							<li><a href="../../jsp/remotereport/instantquizreport.jsp">Instant Quiz</a></li>
							<li><a href="../../jsp/remotereport/pollreport.jsp">Poll</a></li>
							<li><a href="../../jsp/remotereport/participantreport.jsp">Participant</a></li>
						</ul> --%>
						</li>
						<li class="toplast"><a href="#" style="width:131px;height:21px;line-height:21px;"><span>Admin</span></a>
						<ul>
						<%if(session.getAttribute("admin").toString().equals("2"))
						{%>
							<li><a href="../../jsp/admin/addremotecenter.jsp">Enter RemoteCenter</a></li>
							<li><a href="../admin/addremotecoordinator.jsp">Create Coordinator</a></li>
							<li><a href="../../jsp/admin/remoteemailsetup.jsp">Set up Mail System</a></li>
							<li><a href="../../jsp/admin/remotechangepassword.jsp">Change Password</a></li>
						<%}
						else if (session.getAttribute("admin").toString().equals("1"))
						{%>
							<li><a href="../../jsp/admin/addmainCenter.jsp">Add MainCenter</a></li>
							<li><a href="../admin/addremoteparticipant.jsp">Add Participant</a></li>
							<li><a href="../../jsp/admin/remotechangepassword.jsp">Change Password</a></li>	
							<% if(!session.getAttribute("WorkshopID").equals("No workshop Available")){ %>
							<li id = "autotest"><a href="../../jsp/remotejsp/autotest.jsp">Auto Test</a></li>			
								<%} %>		
						<%} %>
						
						</ul></li>
					</ul>
				</td>
				
								
				
				</tr>
				
				
				
				</table>
			</div>
		</form>
	</body>
</html>