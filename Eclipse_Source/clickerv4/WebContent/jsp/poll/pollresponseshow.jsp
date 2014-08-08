<!-- Author: Kirti, Harshavardhan, Clicker Team, IDL lab, IIT Bombay 
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
/*pollresponsecount linear-array of size 3--->a[0] stores  total count for Yes options selected by student and a[1]
stores count for No options selected by student and a[2] states the blank responses*/


int[] pollresponsecount={0,0,0};
// studentcount[0] stores total no. of student participated in polling
int[] studentcount= {0};
try {	
	   	
    	  System.out.println("collected polljson from hash..");
          Getresponsefromhash  st=new Getresponsefromhash ();
      	  st.getpollcount(courseId,pollresponsecount,studentcount);
     
  } 
catch (Exception e) {
     System.out.println("Stored Thread stopped");}

PrintWriter outnew = response.getWriter();
outnew.print(studentcount[0]+"@"+pollresponsecount[0]+"@"+pollresponsecount[1]+"@"+pollresponsecount[2]);
outnew.close();
%>

</body>
</html>