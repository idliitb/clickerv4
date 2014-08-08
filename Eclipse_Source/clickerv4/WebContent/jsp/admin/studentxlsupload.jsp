<%--
      @author Gobinath
DESCREPTION: when the instructor press the add student button it redirect to 
			  this page 
			 
USE        : to upload the xls file and it will store in database

--%>
<%@page import="clicker.v4.admin.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%> 
<%@page import="java.sql.*"%> 

<%@page import="java.net.*"%>
<%@page import="javax.servlet.http.*"%>

<%
	StudentXLSimport xls=new StudentXLSimport();
	
	String path1=request.getParameter("xls");
	System.out.println("xls: "+path1);
	
	ServletContext context = getServletContext();
	String pathurl = context.getRealPath("/uploads");
	
	System.out.println("url = " + pathurl);
	
	File file = new File(pathurl + "/" + path1);
	System.out.println("Filename: " + file);
	//String instructorid = (String) session.getAttribute("InstructorID");
	String status=xls.readStudentXLSFile(file);
	System.out.println("status: " + status);
	response.sendRedirect("student.jsp?fileUploadStatus="+status);
%>