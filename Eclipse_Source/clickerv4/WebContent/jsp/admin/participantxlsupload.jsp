<%--
      @author Gobinath
DESCREPTION: when the coordinator press the participant upload button it redirect to 
			  this page 
			 
USE        : to upload the student list from the xls file

--%>

<%@page import="clicker.v4.admin.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%> 
<%@page import="java.sql.*"%> 

<%@page import="java.net.*"%>
<%@page import="javax.servlet.http.*"%>

<%
String status="";
   String WS_ID=(String) session.getAttribute("WorkshopID");
if(WS_ID == "No workshop Available")
{
	status="No workshop Available!! you cant Add!!";
	
}
else
{
	
    ParticipantXLSimport xls=new ParticipantXLSimport();
	
	String path1=request.getParameter("xls");
	String workshopid = request.getParameter("workshopid");
	System.out.println("xls: "+path1);
	
	ServletContext context = getServletContext();
	String pathurl = context.getRealPath("/uploads");
	
	System.out.println("url = " + pathurl);
	
	File file = new File(pathurl + "/" + path1);
	System.out.println("Filename: " + file);
	//String instructorid = (String) session.getAttribute("InstructorID");
     status=xls.readQuestionXLSFile(file, workshopid);
}
	System.out.println("status: " + status);
	
	response.sendRedirect("addremoteparticipant.jsp?fileUploadStatus="+status);
%>