<%-- Author : Dipti.G  from Clicker Team, IDL LAB -IIT Bombay --%>

<%@page import="clicker.v4.global.Global"%>
<%@page import="clicker.v4.util.*"%>
<%@page import="clicker.v4.rest.*"%>
<%@page import="clicker.v4.remote.*"%>
<%@page import="java.net.URL"%>
<%@page import="java.sql.*"%> 
<%@page import="java.util.*"%>
<%
	String s=null;
	String message="";
	String WorkshopID=(String) session.getAttribute("WorkshopID");
	String Coordinator=(String) session.getAttribute("CoordinatorID");
	String MainCenterURL=(String)session.getAttribute("MainCenterURL");
	if(MainCenterURL.equals("No URL")||(MainCenterURL=="No URL")){
		s="15";
		System.out.println("inside remote Listener... No maincenter Added");
	}
	else if(MainCenterURL.equals("Wrong URL")||(MainCenterURL=="Wrong URL")){
		s="13";
		System.out.println("inside remote Listener... Wrong URL");
	}
	
	else if(WorkshopID.equals("No workshop Available")){
		s="14";
		System.out.println("inside remote Listener...No workshop Available ");
	}
 	else{
 		s=null;
		JSONReadandparse jread= new JSONReadandparse();
		
		s = jread.readStatusJsonFromUrl(MainCenterURL,WorkshopID);
	}
	
	int serverversion=0;
	serverversion = Integer.parseInt(s);
	if (serverversion != 0) {
		if(serverversion==1){
			message=null;
			message="quizlaunch";
			out.print(message.toString());									
		}
		else if(serverversion==2){
			message=null;
			 message="polllaunch";
			out.print(message.toString());
		}
		else if(serverversion==3){
			message=null;
			message="launchinstantquiz";
			out.print(message.toString());
		}
		else if(serverversion==11){	
			message=null;
			message="noliveworkshop";
			out.print(message.toString());								
		}
		else if(serverversion==12){	
			message=null;
			message="notreachable";
			out.print(message.toString());								
		}
		else if(serverversion==13){	
			message=null;
			message="noproperserverip";
			out.print(message.toString());								
		}
		
	}
	else
	{
		message=null;
		message="nopollnoquiz";
		out.print(message.toString());
	}
%>		