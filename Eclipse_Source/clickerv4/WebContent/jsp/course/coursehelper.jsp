<%--@author rajavel, Clicker Team, IDL Lab - IIT Bombay  
This is helper file for course related information
--%>

<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashSet"%>
<%@page import="clicker.v4.global.Global"%>
<%
String instructorID = (String) session.getAttribute("InstructorID");
if (instructorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
String helpContent = request.getParameter("helpContent");
if(helpContent.equals("makeActive")){
	if(session.getAttribute("courseID")!=null){
		String courseID = session.getAttribute("courseID").toString();
		java.util.Date date = new Date();
		String activeTime = (new Timestamp(date.getTime())).toString();
		Global.activecourses.put(courseID, activeTime);
		HashSet<String> activestudent = new HashSet<String>();
		Global.activestudentlist.put(courseID, activestudent);
		Global.raisehandcounter.put(courseID, 0);		
	}
	System.out.println("Active Course List : " +  Global.activecourses);
	out.print("Course is Active");
}
else if(helpContent.equals("makeInactive")){
	if(session.getAttribute("courseID")!=null){
		String courseID = session.getAttribute("courseID").toString();
		Global.activecourses.remove(courseID);
		Global.activestudentlist.remove(courseID);
		Global.raisehandcounter.remove(courseID);
	}
	System.out.println("Active Course List : " +  Global.activecourses);
	out.print("Course is Inactive");
}
%>