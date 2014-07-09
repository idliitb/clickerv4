<%-- Author : kirti, Dipti.G, Clicker Team, IDL LAB ,IIT Bombay--%>
<%@ page language="java" isErrorPage="true"	%>
<% 
String message = (request.getAttribute("Error")).toString();
System.out.println(message);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Session End</title>
</head>
<body>
		
			<div style="min-height: 300px; text-align:center;margin-top:20%;">
				<font color="#404040" size="7px"><%=message %></font> <br>	
				<a href="../../login.jsp" style="font-size: 150%;">For login click here</a>				
			</div>
		
</body>
</html>