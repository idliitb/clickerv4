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
	String cid = session.getAttribute("courseID").toString();
	String instrType = request.getParameter("instrType");
	String courseinfo = "";
	if(instrType.equals("hod")){
		courseinfo = reportHelper.getCorusesDashboardData(instructorID);
	}else if(instrType.equals("principal")){
		courseinfo = reportHelper.getAllCorusesDashboardData(instructorID);
	}else{
		courseinfo = reportHelper.getCorusesforInstrDashboardData(instructorID, cid);
	}
    out.print(courseinfo);
}
else if(helpContent.equals("comparecourses")){
	String[] CourseIDs = request.getParameter("courses").split("@");	
	System.out.println(CourseIDs.length);	
	out.print(reportHelper.compareCourses(CourseIDs));
}else if(helpContent.equals("getCalendarDate")){
	String cid = request.getParameter("cid");
	String InstructorID = session.getAttribute("InstructorID").toString();
	String dateType = request.getParameter("dateType");
	String calendarDate=  reportHelper.getCalendarDate(cid, dateType, InstructorID);
	out.print(calendarDate);
}else if(helpContent.equals("atteninfo")){
	String cid = request.getParameter("cid");
	String date = request.getParameter("date");
    String atteninfo = reportHelper.getAttendanceInfo(cid, date);
    out.print(atteninfo);
}else if(helpContent.equals("alldeptchartedata")){
	String deptinfo = reportHelper.getAllDeptChartData();
	out.print(deptinfo);
}
%>