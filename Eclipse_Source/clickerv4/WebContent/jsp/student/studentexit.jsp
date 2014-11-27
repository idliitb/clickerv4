<!-- Author : Dipti, Clicker Team, IDL LAB ,IIT Bombay
This page is used to end session and remove ID from global variable.
 -->
<%@page import="clicker.v4.global.Global"%>
<% 
try{
String StudentID=session.getAttribute("StudentID").toString();

	if(StudentID==null||StudentID.equals(null)){
		if (session.getId().equals(session.getAttribute("UserSessionID"))) {
			session.invalidate();
		}
		response.sendRedirect("login.jsp");
	}else{	
		System.out.println("Session for student ended ");
			if(Global.loggedstudentlist.containsKey(StudentID)){
			Global.loggedstudentlist.remove(StudentID);
			}
		if (session.getId().equals(session.getAttribute("UserSessionID"))) {
			session.invalidate();
		}
		response.sendRedirect("login.jsp");	
	}
}catch(Exception e){
	if (session.getId().equals(session.getAttribute("UserSessionID"))) {
		session.invalidate();
	}
	response.sendRedirect("login.jsp");
}
%>