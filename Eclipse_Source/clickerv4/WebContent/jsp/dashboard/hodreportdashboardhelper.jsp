<%--@author rajavel, Clicker Team, IDL Lab - IIT Bombay
	This jsp file is used for helping the quiz dashboard of HOD
--%>
<%@page import="clicker.v4.report.ReportHelper"%>
<%
String helpContent = request.getParameter("helpcontent");
System.out.println("help content " + helpContent);
ReportHelper reportHelper = new ReportHelper();
if(helpContent.equals("coursedata")){
	String instructorID = session.getAttribute("InstructorID").toString();
    String atteninfo = reportHelper.getCorusesDashboardData(instructorID);
    out.print(atteninfo);
}
else if(helpContent.equals("comparecourses")){
	String[] CourseIDs = request.getParameter("courses").split("@");	
	System.out.println(CourseIDs.length);	
	out.print(reportHelper.compareCourses(CourseIDs));
}
%>