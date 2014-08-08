<%--
      @author Gobinath
DESCREPTION: when the instructor press the assign course button it redirect to 
			  this page 
			 
USE        : to upload the xls file and it will store in database

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="clicker.v4.admin.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%> 
<%@page import="java.sql.*"%> 

<%@page import="java.net.*"%>
<%@page import="javax.servlet.http.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

StudentcourseXLSimport xls=new StudentcourseXLSimport();
String path1=request.getParameter("xls1");
System.out.println("xls: "+path1);
ServletContext context = getServletContext();
String pathurl = context.getRealPath("/uploads");

System.out.println("url = " + pathurl);

File file = new File(pathurl + "/" + path1);
System.out.println("Filename: " + file);
String status=xls.readstudentCourseXLSfile(file);
System.out.println("status: " + status);
response.sendRedirect("student.jsp?fileUploadStatus="+status);

%>
</body>
</html>