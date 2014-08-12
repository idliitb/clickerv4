<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../../css/student.css">
<title>Insert title here</title>
</head>
<body>
<table class="ui-table_green" border="0">
	<tr>
		<td class="td-name">Enrollment ID </td>
		
		<td><input id="uid" type="text" name="userid" class="td-textbox" placeholder="Enrollment ID" required  autofocus/></td>
	</tr>
	
	<tr >
		<td class="td-name">Server URL </td>
		<td><input id="sname" type="text" name="servername" class="td-textbox" placeholder="Server URL" required  /></td>
	</tr>
		
	<tr style="padding-left:50px;">
		<td colspan="2" class="td-name" >
		 	<button id="register" type="submit" class="ui-loginbutton" onclick="window.location.href='home.jsp'">
		 	<span >Register</span>
	 		</button>
	 	</td>
	</tr>
		
		
</table>



</body>
</html>