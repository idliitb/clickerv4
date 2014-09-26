<%--@author shachin, rajavel, dipti,kirti 
This file is used as header for clicker application
--%>
<%@page import="clicker.v4.global.Global"%>
<%@page import="clicker.v4.rest.*"%>
<%@page import="java.io.BufferedReader"%> 
<%@page import="java.io.FileReader"%> 
<%@page import="java.io.IOException"%> 
<%@page import="java.io.File"%> 
 <%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%
String headerinstrid = (String) session.getAttribute("InstructorID");

JSONReadandparse version_reader = new JSONReadandparse();
String v_id=version_reader.version_id(getServletContext().getInitParameter("war_version"), getServletContext().getInitParameter("db_version"));
System.out.println("version from main center===>"+v_id);
				
if (headerinstrid == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
String headercid = session.getAttribute("courseID").toString();
String D_ID=session.getAttribute("D_ID").toString();
%>
<%@page import="java.util.*" %>
<%@page import="clicker.v4.admin.Admindata" %>
<%@page import="clicker.v4.raisehand.*" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
		<link rel="stylesheet" href="../../css/menu.css" type="text/css" />
		<style type="text/css">
		
			._css3m{
				display:none
			}
			.menusize{
				width:101px;height:21px;line-height:21px;
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
		</style>
		<script src="../../js/jquery-1.9.1.js"></script>
		<script src="../../js/jquery-ui.js"></script>
		<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
		function raiseHandCounter(){
			$(document).ready(
        		function() {        	
		            setInterval(function() {            	
            			$.get("../../jsp/raisehand/raisehandcounter.jsp", function (response) {
		                	if(response==0){
                				document.getElementById("show").style.backgroundColor='#9bbb59';
                				$('#show').text("");
                    			}else{
		                    		document.getElementById("show").style.backgroundColor='#e46c0a';
                    				$('#show').text(response);
                        			}		
            			}, "json");
            		}, 5000);
        		});
		}        
		
		function redirect()
		{
			window.location.href="../../logout.jsp";
		}
		
		var xmlhttp;
		
		// This method will get the XMLHTTP object for work with ajax
		function getXMLhttp() {
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else if (window.ActiveXObject) { // IE
				try {
					xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
				} catch (e) {
					try {
						xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
					} catch (e) {
					}
				}
			}
		}
		
		function makeActive() {
			getXMLhttp();
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					alert(xmlhttp.responseText);
					document.getElementById("courseactiveness").innerHTML = " <img onclick='makeInactive()' src='../../img/active.png' >";
				}
			};			
			xmlhttp.open("GET",	"../../jsp/course/coursehelper.jsp?helpContent=makeActive", true);	
			xmlhttp.send();	
		}
		
		function makeInactive() {
			getXMLhttp();
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					alert(xmlhttp.responseText);
					document.getElementById("courseactiveness").innerHTML = " <img onclick='makeActive()' src='../../img/in_active.png' >";
				}
			};			
			xmlhttp.open("GET",	"../../jsp/course/coursehelper.jsp?helpContent=makeInactive", true);	
			xmlhttp.send();	
		}
		
		function openWin()
		{
			var myWindow = window.open("../../jsp/admin/version.jsp","","status=no,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no,directories=no,titlebar=no,personalbar=no, width=700,height=400,top=200, left=300");
			myWindow.document.title = 'About Clicker';
			self.close();
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

		setInterval(blinker, 1000);
		</script>
	</head>	
	<body  class="ui-Mainbody" style="width:100%; height:100%; text-align: center;">
	<form id="myform1">
 		<div>
 			<script>raiseHandCounter();</script>
 			<table class="table" style="border: none;" >				
				<tr> <td rowspan="2">
					<a href="http://mhrd.gov.in" target="_blank" style="text-decoration: none;"><div class="ui-square" style="text-align: center;"></div></a>
					<a href="http://mhrd.gov.in" target="_blank" style="text-decoration: none;"><div style="font-size:20px;  margin-left: 13px; color: #e46c0a;font-weight: bold; letter-spacing: 7px;">MHRD</div></a>									
				</td>	
				</tr><tr><td>
				<table id="sample" style="width: 100%;height: 100%; border:none;border-color: green;"  >
					<tr height="75px">	<td >
						<table style="width: 100%;height: 100%; border:1 ;border-color:red;margin: -5px; "  >
							<tr><td>
								<table style="width: 100%;height: 100%;" >
									<tr><td width="160px;" align="left">
										<div style="height:60px; width: 250px;color: #fff;font-size: 12px;font-family: ">
											<%="Instructor ID :  " + headerinstrid %><br><br><%="Department ID : " + D_ID%><br><br><%="Course ID : " + headercid%>
										</div>
										</td>
										<td align="left">			
											<div id="banner_name">
											<%if(session.getAttribute("admin").toString().equals("4")){	 %>
				     							<a style="text-decoration: none;" href="../../jsp/admin/department.jsp">
						   						<div id=Csquare style="text-align: center;float: left;margin-left: 30px;"> </div>
						   						<div style="margin-top:20px;"><div style="font-size:35px; color: white;letter-spacing: 2px;">LICKER</div></div>
						   						</a>
						   					<%if(v_id.equals("update available")){%>
						   						<span class="blink_me" onclick="show_update();" style="margin-right: -40px; margin-top: -30px; float: right;font-size: 20px; font-weight: bolder; color: #ff3333;cursor:pointer;">UPDATE!</span>
						   						<%}
						   					}else {%>
						   					
												<a style="text-decoration: none;" href="../../jsp/home/home.jsp">
												<div id=Csquare style="text-align: center;float: left;margin-left: 30px;"> </div>
						   						<div style="margin-top:20px ;"><div style="width: 240px;font-size:35px; color: white;letter-spacing: 2px;">LICKER</div></div>
						   						</a>
											<%
											if(v_id.equals("update available")){%>
												<span class="blink_me" onclick="show_update();" style="margin-right: -68px; margin-top: -30px; float: right;font-size: 20px; font-weight: bolder; color: #ff3333;cursor:pointer;">UPDATE!</span>
											<%}
											} %>
											</div>
										</td>
										<td width="150px">
											<%if((session.getAttribute("admin").toString().equals("1")) || (session.getAttribute("admin").toString().equals("2"))||session.getAttribute("admin").toString().equals("3")){
											%>
												<div id="courseactiveness" style="width: 120px;height: 50px;border: none;margin-top: -27px;margin-left: 100px;">
												<% if(Global.activecourses.containsKey(headercid)){ %>
													<img onclick="makeInactive()" src="../../img/active.png" >
												<%} else{%>
													<img onclick="makeActive()" src="../../img/in_active.png" >
												<%} %>												
												</div>
											<%} %>
										</td>					
									</tr>
								</table>
							</td></tr>
							<tr><td colspan="3" height="20px" align="center">
								<div style="margin-left: 30px;"><font style="font-size:15px;font-weight: bold;color: #e46c0a;letter-spacing: 1.7px">Student Response System</font>
								
								
								</div>
							</td></tr>
						</table>
					</td></tr>
					<tr><td>
						<%if((session.getAttribute("admin").toString().equals("1")) || (session.getAttribute("admin").toString().equals("2"))||session.getAttribute("admin").toString().equals("3")){
						%>
						<div style="margin-left: 20px;">
							<ul id="css3menu1" class="topmenu" style="margin:3% 0 0 -2%;">
							<li class="topfirst" ><a href="#" style="width:131px;height:21px;line-height:21px;"><span>Quiz</span></a>
							<ul>
								<li><a href="../../jsp/questionbank/questionbank.jsp">Create quiz&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
								<li><a href="../../jsp/quiz/conductquiz.jsp">Conduct quiz</a></li>	    					
	    						<li><a href="../../jsp/quiz/instantquiznew.jsp">Instant quiz</a></li>
							</ul></li>
							<li class="topmenu" ><a href="../../jsp/poll/poll.jsp" style="width:131px;height:21px;line-height:21px;">Poll</a>
							</li>
							<li class="topmenu"><a href="../../jsp/raisehand/raisehand.jsp" style="width:131px;height:21px;line-height:21px;">Raise hand
							<div id="show" style="width:22px ;height:22px  ; left: 120px; top:-30px; text-align:center ; font-size:12px ;font-weight: bold; position:relative;"></div></a></li>
							<li class="topmenu" >
								<%if(session.getAttribute("admin").toString().equals("2")){%>
									<a href="../../jsp/dashboard/hodreport.jsp" style="width:131px;height:21px;line-height:21px;">Report</a>
								<%}else if(session.getAttribute("admin").toString().equals("3")){ %>
									<a href="../../jsp/dashboard/principalreport.jsp" style="width:131px;height:21px;line-height:21px;">Report</a>
								<%}else{%>
									<a href="../../jsp/dashboard/report.jsp" style="width:131px;height:21px;line-height:21px;">Report</a>
								<% }%></li>
							<li class="toplast"><a href="#" style="width:131px;height:21px;line-height:21px;"><span>Admin</span></a>
								<ul>					
									<li><a href="../../jsp/admin/student.jsp">Student</a></li>
									<li><a href="../../jsp/admin/changepassword.jsp">Change Password</a></li>
						    		<li onclick="openWin()"><a>About Clicker</a></li>
								</ul></li>
							</ul>
						</div>
						<%}
						else if(session.getAttribute("admin").toString().equals("4"))
						{%>
						<div style="margin-left: 20px;">
							<ul id="css3menu1" class="topmenu" style="margin:3% 0 0 -2%;">
							<li class="topfirst" ><a href="../../jsp/admin/department.jsp" style="width:131px;height:21px;line-height:21px;">Department</a>
							</li>
							<li class="topmenu"><a href="../../jsp/admin/instructor_info.jsp" style="width:131px;height:21px;line-height:21px;">Instructor
							</a></li>
							<li class="topmenu"><a href="../../jsp/admin/changepassword.jsp" style="width:131px;height:21px;line-height:21px;">Change Password
							</a></li>
					    	<li class="toplast" onclick="openWin()"><a href="" style="width:131px;height:21px;line-height:21px;">About Clicker
							</a></li>						
							</ul>
						</div>
						<%}%>
					</td></tr>					
				</table>
				</td><td>
			    <table style="width: 100%;height: 100%;margin-top: -5px;" border="0">
			 		<tr><td style="vertical-align:top;">
						<div id="loginout" style="float:right;cursor: pointer; margin-top: -5px;"><img src='../../img/Logout Logo.png' onclick="redirect();"></div>						
					</td></tr>
					<tr align="center">	<td>
						<a href="http://www.iitb.ac.in" target="_blank" style="text-decoration: none;">
							<div id="iit_logo" style="height: 80px;width: 80%;border: none;background-color:#9bbb59;background:url('../../img/iitb01 copy.png') no-repeat center">						
							</div>
							<font style="color:#e46c0a;font-weight: bold; ">IIT BOMBAY</font>
						</a>
					</td></tr>
				</table>
				</tr>
			</table>
		</div>
	</form>
	<div id="login_div"></div>
	</body>
</html>