<%-- 
Author : Rajavel 
Jsp page : This jsp file is act as Helper to generate report and AJAX   
--%>
<%@page import="clicker.v4.report.ReportHelper"%>
<%
String infotype = request.getParameter("helpcontent");
ReportHelper reportHelper = new ReportHelper();
if(infotype.equals("studentinfo")){
    String id = request.getParameter("id");
    String studentinfo = reportHelper.getStudentInfo(id);
    out.print(studentinfo);   
}else if(infotype.equals("quizname")){
	String courseID = request.getParameter("courseID");
    String date = request.getParameter("date");
    String instructorID = session.getAttribute("InstructorID").toString();
    String quizinfo = reportHelper.getQuizNames(courseID, date, instructorID);
    out.print(quizinfo);
}else if(infotype.equals("quiztime")){
	String qid = request.getParameter("qid");
    String qdate = request.getParameter("qdate");
    String quiztime = reportHelper.getQuizTime(qid, qdate);
    out.print(quiztime);
}else if(infotype.equals("instantquiztime")){
	String CID = session.getAttribute("courseID").toString();
	String instrID = session.getAttribute("InstructorID").toString();
    String qdate = request.getParameter("qdate");
    String quiztime = reportHelper.getInstantQuizTime(CID, instrID, qdate);
    out.print(quiztime);
}else if(infotype.equals("polltime")){
	String CID = session.getAttribute("courseID").toString();
	 String qdate = request.getParameter("qdate");
   String quiztime = reportHelper.getPollTime(CID,  qdate);
   out.print(quiztime);
}else if(infotype.equals("atteninfo")){
	String cid = request.getParameter("cid");
   String date = request.getParameter("date");
   String atteninfo = reportHelper.getAttendanceInfo(cid, date);
   out.print(atteninfo);
}
%>