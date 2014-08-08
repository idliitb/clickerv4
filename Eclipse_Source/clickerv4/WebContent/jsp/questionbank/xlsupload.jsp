<%-- @Author Harshavardhan, Clicker Team, IDL, IIT Bombay--%>

<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%> 
<%@page import="java.sql.*"%> 
<%@page import="clicker.v4.questionbank.*"%>
<%@page import="java.net.*"%>
<%@page import="javax.servlet.http.*"%>

<% 

	XLSimport xls=new XLSimport();
	
	String path1=request.getParameter("xls");
	System.out.println("xls: "+path1);
	
	ServletContext context = getServletContext();
	String pathurl = context.getRealPath("/uploads");
	
	System.out.println("url = " + pathurl);
	
	File file = new File(pathurl + "/" + path1);
	System.out.println("Filename: " + new File(path1).getAbsolutePath());
	String instructorid = (String) session.getAttribute("InstructorID");
	String courseid = (String) session.getAttribute("courseID");
	String status=xls.readQuestionXLSFile(instructorid, file, courseid);
	
	response.sendRedirect("../../jsp/questionbank/questionbank.jsp?fileUploadStatus="+status);
%>