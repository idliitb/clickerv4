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
	String cid = request.getParameter("cid");
	String date = request.getParameter("date");
    String atteninfo = reportHelper.getAttendanceInfo(cid, date);
    out.print(atteninfo);
}
%>