<%-- @Author Harshavardhan, Clicker Team, IDL, IIT Bombay--%>

<%
String instructorID = (String) session.getAttribute("InstructorID");
if (instructorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>XLS Upload file </title>
</head>
<body>
<form action="xlsupload.jsp" method="get">
<input type="file" name="xls"></input>
<input type="submit" value="send" /></form>
</body>
</html>