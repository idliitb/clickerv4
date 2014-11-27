<!-- Author : Dipti, Clicker Team, IDL LAB ,IIT Bombay
This page is used to end session and remove ID from global variable.
 -->

<%@page import="clicker.v4.global.Global"%>
<% 
try{
String ParticipantID=session.getAttribute("ParticipantId").toString();
	
	if(ParticipantID==null||ParticipantID.equals(null)){
		if (session.getId().equals(session.getAttribute("UserSessionID"))) {
			session.invalidate();
		}
		response.sendRedirect("login.jsp");
	}else{
		
		System.out.println("Session for participant ended ");
		if(Global.loggedparticipantlist.containsKey(ParticipantID)){
			Global.loggedparticipantlist.remove(ParticipantID);
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