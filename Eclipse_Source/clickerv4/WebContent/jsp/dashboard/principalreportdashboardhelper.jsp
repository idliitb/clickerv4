<%--@author rajavel, Clicker Team, IDL Lab - IIT Bombay
	This jsp file is used for helping the quiz dashboard of Principal
--%>
<%@page import="clicker.v4.report.ReportHelper"%>
<%
String helpContent = request.getParameter("helpcontent");
System.out.println("help content " + helpContent);
ReportHelper reportHelper = new ReportHelper();
if(helpContent.equals("coursedata")){
	String instructorID = session.getAttribute("InstructorID").toString();
    String courseinfo = reportHelper.getAllCorusesDashboardData(instructorID);
    out.print(courseinfo);
}
if(helpContent.equals("alldeptchartedata")){
	String deptinfo = reportHelper.getAllDeptChartData();
	out.print(deptinfo);
}
%>