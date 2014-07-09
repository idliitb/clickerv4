<!-- Author : Kirti, Clicker Team, IDL LAB ,IIT Bombay
* This page is used for setting course.
 -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>set course</title>

</head>
<body >

<form id="CourseIDform"  action="./Login" method="GET" onsubmit="return validateCourseID()">
						<br>Select Course <select id="StudentCourseSelect" name="courseID">
							<option>Select Course</option>
							<%
							String[] courseList = (String[])session.getAttribute("courseList");
							for (int i=0; i<courseList.length; i++){%>
							<option><%=courseList[i]%></option>
							<%}%>
						</select> <br>
						<br> <input type="submit" value=" Set Course " />
</form>
</body>
</html>