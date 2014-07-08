<!--
		Author      : Gobinath M
		Description : it display the no of student are active 
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
    
 <%@page import="clicker.v4.dashboard.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function refresh_page(refreshPeriod)
{
	
	    setTimeout("window.location.reload();",refreshPeriod);	
}

</script>
<style type="text/css">
.square
    {
        background:#9bbb59;
    	background-image:url('img/bkgdimage.gif');
        background-repeat:no-repeat;    	
        float: left;        
        height:60px;
        width:65px;
        font-size: 20px;
        color:#9bbb59;
        font-weight:bold;   
   
    }
    .test_area
    {
       background:#9bbb59;
    	float: left;        
        height:60px;
        width:40px;
         font-size: 20px;
        color:#000000;
        font-weight:bold;  
    
    }
    .container
    {
        text-align:center;
        
    }
    .centerwrapper
    {
       margin: auto;       
    }
</style>
</head>
<body>

<%
String Student_id = (String) request.getParameter("Count");
String course=null;
int no_of_student=0;
if (session.getAttribute("InstructorID") == null) {
	request.setAttribute("Error","Your session has expired.");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;		
}
	course=session.getAttribute("courseID").toString();

{
AttendanceHelper Att_helper = new AttendanceHelper();
no_of_student = Att_helper.getstudentList(course);
}

%>
<div class = "container">
  <div class="centerwrapper">
    <div class = "square"><br><%= no_of_student %></div>  
    <div Class="test_area"><br>OF</div>  
    <div class = "square"><br><%= Student_id %> </div>    
  </div>
</div>
</body>
</html>