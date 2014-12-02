<%--@author rajavel, Clicker Team, IDL Lab - IIT Bombay
	This jsp file is used for helping the quiz dashboard in remote mode
--%>
<%@page import="clicker.v4.report.RemoteReportHelper"%>
<%
String helpContent = request.getParameter("helpcontent");
System.out.println("help content " + helpContent);
RemoteReportHelper reportHelper = new RemoteReportHelper();
if(helpContent.equals("quizdata")){
	String WorkshopID = session.getAttribute("WorkshopID").toString();
	System.out.println(WorkshopID);	
	out.print(reportHelper.getReportDashboardData(WorkshopID));
}else if(helpContent.equals("atteninfo")){
	String cid = request.getParameter("wid");
	String date = request.getParameter("date");
    String atteninfo = reportHelper.getAttendanceInfo(cid, date);
    out.print(atteninfo);
}else if(helpContent.equals("workshopsdata")){
	out.print(reportHelper.getWorkshopsDashboardData());
}else if(helpContent.equals("getCalendarDate")){
	String wid = request.getParameter("wid");
	String coordinatorID = session.getAttribute("CoordinatorID").toString();
	String dateType = request.getParameter("dateType");
	String calendarDate=  reportHelper.getCalendarDate(wid, dateType, coordinatorID);
	out.print(calendarDate);
}
%>