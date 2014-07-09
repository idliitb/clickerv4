<!-- 
Author : Dipti, Kirti from Clicker Team, IDL LAB ,IIT Bombay
 -->

<%@page import="clicker.v4.global.Global"%>
<%@page import="clicker.v4.raisehand.*" %>
<%@page import="clicker.v4.remote.*"%>

<%
String InstructorID =(String) session.getAttribute("InstructorID");
String CoordinatorID =(String) session.getAttribute("CoordinatorID");
//This is used to send again unsend response of participant
String MainCenterURL=(String)session.getAttribute("MainCenterURL");
if(MainCenterURL!=null){
	RemoteQuizResponseHelper rqrh= new RemoteQuizResponseHelper();
	rqrh.ResendJsonForLateResponse(MainCenterURL);
	rqrh.createAndReSendIQResponseJsonToMC(MainCenterURL);
}

//this course is for raisehand purpose. For setting raiseHand to pending Status
String CourseID=(String)session.getAttribute("courseID");
if(CourseID!=null){	
	RaiseHandHelper rhp= new RaiseHandHelper();
	rhp.updateRaiseHandAsPending(CourseID);
}

if (InstructorID == null && CoordinatorID==null) {
	request.setAttribute("Error", "Session has ended.  Please login.");
	RequestDispatcher rd = request.getRequestDispatcher("./error.jsp");
	rd.forward(request, response);
	return;
}
session.invalidate();
System.out.println("Instructor/Coordinator Logged out.");
%>

<html>
<head>
<link href="css/style.css" rel="stylesheet" type="text/css" media="screen" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Refresh" content="2;url=./login.jsp">
<title>Instructor-Logout</title>
</head>
<body>
	<div style="text-align:center;">
		<div id="content_in">
			<div style="min-height: 100px">				
				<div id="log_out">
					<br> <br> <br> <br>
					<h2 style="color:">
						You have successfully logged out.<br> Thank you
					</h2><br />
				</div>				
			</div>
		</div>
	</div>
</body>
</html>