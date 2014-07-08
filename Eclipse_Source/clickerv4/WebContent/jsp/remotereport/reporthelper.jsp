<%-- 
Author : Rajavel 
Jsp page : This jsp file is act as Helper to generate report and AJAX   
--%>
<%@page import="clicker.v4.report.RemoteReportHelper"%>
<%
String infotype = request.getParameter("helpcontent");
RemoteReportHelper reportHelper = new RemoteReportHelper();
if(infotype.equals("participantinfo")){
    String id = request.getParameter("id");
    String participantinfo = reportHelper.getParticipantInfo(id);
    out.print(participantinfo);   
}else if(infotype.equals("quizname")){
	String courseID = request.getParameter("courseID");
	String date = request.getParameter("date");
    String instructorID = session.getAttribute("CoordinatorID").toString();
    String quizinfo = reportHelper.getQuizNames(courseID, date, instructorID);
    out.print(quizinfo);
}else if(infotype.equals("quiztime")){
	String qid = request.getParameter("qid");
    String qdate = request.getParameter("qdate");
    String WID = session.getAttribute("WorkshopID").toString();
    String quiztime = reportHelper.getQuizTime(WID, qid, qdate);
    out.print(quiztime);
}else if(infotype.equals("instantquiztime")){
	String CID = session.getAttribute("WorkshopID").toString();
	String instrID = session.getAttribute("CoordinatorID").toString();
    String qdate = request.getParameter("qdate");
    String quiztime = reportHelper.getInstantQuizTime(CID, instrID, qdate);
    out.print(quiztime);
}else if(infotype.equals("atteninfo")){
	String cid = request.getParameter("cid");
    String date = request.getParameter("date");
    String atteninfo = reportHelper.getAttendanceInfo(cid, date);
    out.print(atteninfo);
}else if(infotype.equals("polltime")){
	String WID = session.getAttribute("WorkshopID").toString();
	 String qdate = request.getParameter("qdate");
  String quiztime = reportHelper.getPollTime(WID,  qdate);
  out.print(quiztime);
}
%>