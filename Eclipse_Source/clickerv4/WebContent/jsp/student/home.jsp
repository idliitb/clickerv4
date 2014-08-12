<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>

</script>
<link type="text/css" rel="stylesheet" href="../../css/student.css">
<title>Insert title here</title>
</head>
<body>
<table id="homemaintable" style="width:1900px; height:980px; text-align:center; margin:auto; margin-left:-300px; "   border="0">
	<tr>
		<td ><font size=5px; color="#9bbb59">Course ID<br>No active courses</font></td>
		<td colspan="2" ><font size=35px; color="#E46C0A">ClickerV4</font></td>
		<td ><font size=5px; color="#9bbb59">Student ID<br>101</font></td>
	</tr>
	
	<tr style="height:400px;">
		<td ><button class="homemenu" onclick="window.location.href='quiz.jsp'"><span>QUIZ</span></button></td>
		<td ><button class="homemenu" onclick="window.location.href='poll.jsp'"><span>POLL</span></button></td>
		<td ><button class="homemenu" onclick="window.location.href='report.jsp'"><span>REPORT</span></button></td>
		<td ><button class="homemenu" onclick="window.location.href='raisehand.jsp'"><span>RAISE</span></button></td>
	</tr>
	
	<tr>
		<td  colspan="4"><button id="exit" type="submit" class="ui-loginbutton" onclick="window.location.href='login.jsp'">
		 	<span >EXIT</span>
	 		</button>
	 	</td>
		
	</tr>
	
	<tr>
		<td ></td>
		<td  colspan="2"><font color="#ffffff">Designed and Developed by IIT Bombay.</font></td>
		<td ><div ><input type="image" src="../../img/refresh_course.png" alt="Submit" width="100px" height="100px" onclick="window.location.href='login.jsp'">
			&emsp;&emsp;&emsp;
			<input type="image" src="../../img/QuestionIcon.png" alt="Submit" width="100px" height="100px" onclick="window.location.href='login.jsp'">
			</div></td>
	</tr>


</table>



</body>
</html>