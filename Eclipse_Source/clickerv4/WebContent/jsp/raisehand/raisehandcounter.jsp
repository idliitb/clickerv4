<%@page import="clicker.v4.global.Global"%>
<%@page import="clicker.v4.raisehand.*" %>
<%

//Author :  Dipti.G  from Clicker Team, IDL LAB -IIT Bombay
// This JSP is used to return the counter which is used to show new raise hand indication on menubar on raisehand menu

if(session.getAttribute("courseID")==null){
	out.print(0);
}else{
	if(Global.raisehandcounter.get(session.getAttribute("courseID"))==null){
		out.print(0);
	}else{
	out.print(Global.raisehandcounter.get(session.getAttribute("courseID")).toString());
	}
}
%>
