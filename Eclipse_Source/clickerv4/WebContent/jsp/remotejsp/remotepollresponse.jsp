<!-- Author: Kirti-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="clicker.v4.global.Global" %>
 <%@page import="clicker.v4.rest.*"%>
 <%@ page import="clicker.v4.poll.*" %>
 <%@page import="clicker.v4.remote.RemoteDBHelper"  %>
  <%@ page import="java.io.PrintWriter" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Poll Response</title>
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>
<script src="../../js/remotequiz.js"></script>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />

</head>



<body>

<%
String Coordinator = (String) session.getAttribute("CoordinatorID");
String WorkshopID=(String) session.getAttribute("WorkshopID");
String pollquestion= request.getParameter("pollquestion");
RemoteDBHelper rdh= new RemoteDBHelper();
int participantcount=rdh.getNoofParticipant(WorkshopID);
/*pollresponsecount linear-array of size 2--->a[0] stores  total count for Yes options selected by student and a[1]
stores count for No options selected by student*/
double yes_percent=0;
double no_percent=0;
double noresponse_percent=0;

int[] pollresponsecount={0,0,0};
// studentcount[0] stores total no. of student participated in polling
int[] studentcount= {0};
try {	

          Getresponsefromhash  st=new Getresponsefromhash ();
      	  st.remotegetpollcount(WorkshopID,pollresponsecount,studentcount);
		 double temp1=pollresponsecount[0];
    	 double temp2=pollresponsecount[1];
    	 double temp3=pollresponsecount[2]; 
    	 yes_percent= ((temp1 / studentcount[0])*100);
      	 no_percent= ((temp2 / studentcount[0])*100);
      	 noresponse_percent= ((temp3 / studentcount[0])*100);
      	 System.out.println("**==>student count remote: "+studentcount[0]+"...yes percent: "+ yes_percent+"..no percent:"+ no_percent+"..no response percent :"+ noresponse_percent);
         if(Double.isNaN(yes_percent) || Double.isNaN(no_percent) || Double.isNaN(noresponse_percent))
         {
	        yes_percent = no_percent = noresponse_percent= 0;
	     }
      	        
       //Thread.sleep(1000);	 
      //create new json for main center

  } 
catch (Exception e) {
     System.out.println("Stored Thread stopped");}

PrintWriter outnew = response.getWriter();
outnew.print(participantcount+"@"+studentcount[0]+"@"+pollresponsecount[0]+"@"+pollresponsecount[1]+"@"+pollresponsecount[2]);
outnew.close();

%>

<div id="result">


</div>
</body>
</html>