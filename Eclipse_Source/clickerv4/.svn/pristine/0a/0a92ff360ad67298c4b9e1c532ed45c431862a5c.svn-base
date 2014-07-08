<%@page import="clicker.v4.report.ReportHelper"%>
<%
String helpContent = request.getParameter("helpcontent");
System.out.println("help content " + helpContent);
ReportHelper reportHelper = new ReportHelper();
if(helpContent.equals("quizdata")){
	String CourseID = session.getAttribute("courseID").toString();
	System.out.println(CourseID);	
	out.print(reportHelper.getReportDashboardData(CourseID));
}else if(helpContent.equals("atteninfo")){
	String cid = request.getParameter("cid");
	String date = request.getParameter("date");
    String atteninfo = reportHelper.getAttendanceInfo(cid, date);
    out.print(atteninfo);
}
%>