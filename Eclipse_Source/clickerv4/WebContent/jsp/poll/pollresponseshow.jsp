<!-- Author: Kirti, Harshavardhan 
This page is used for collecting responses of poll from hash.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="clicker.v4.global.Global" %>
 <%@ page import="clicker.v4.poll.*" %>
 <%@ page import="java.io.PrintWriter" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Poll Response</title>
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
</head>
<body>

<%
String courseId=(String)session.getAttribute("courseID");
String pollquestion= request.getParameter("pollquestion");
String launchtime1=Global.polljsonobject.get(courseId).getlaunchtime();
// removing pollobject (poll question) from database, so no student can access poll question after time for polling is over
//Global.polljsonobject.remove(courseId); 
/*pollresponsecount linear-array of size 2--->a[0] stores  total count for Yes options selected by student and a[1]
stores count for No options selected by student*/
double yes_percent=0;
double no_percent=0;
double noresponse_percent=0;


int[] pollresponsecount={0,0,0};
// studentcount[0] stores total no. of student participated in polling
int[] studentcount= {0};
try {	
	  int count=Global.responsepollobject.size(), newcount =0, idle=0;

while (true) {	        	
        newcount =Global.responseobject.size();//0        
        if(count != newcount){
        	count = newcount;
        	idle=0;	            	      	
           }
        idle++;	            
        if(idle>=3){
        	
          System.out.println("collected polljson from hash..");
          Getresponsefromhash  st=new Getresponsefromhash ();
      	  st.getpollcount(courseId,pollresponsecount,studentcount);
		 double temp1=pollresponsecount[0];
    	 double temp2=pollresponsecount[1];
    	 double temp3=pollresponsecount[2];
      	      	 
         break;
    	}
        Thread.sleep(1000);	 
     }
  } 
	
	catch (Exception e) {
     System.out.println("Stored Thread stopped");}

PrintWriter outnew = response.getWriter();
outnew.print(studentcount[0]+"@"+pollresponsecount[0]+"@"+pollresponsecount[1]+"@"+pollresponsecount[2]);
outnew.close();
%>

</body>
</html>