<%--
      @author Gobinath
DESCREPTION:This JSP Page will display when you Press the Add Department Button
USE        : to add New Department

--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="../../js/department_course.js"></script>
<title>Insert title here</title>
</head>
<body>
	<div id="main">
		<table class="ss" border="1" cellpadding="5" width="450">
			<tr>
				<td>Department ID</td>
				<td><input type="text" name="Department_id" id="Department_id" onkeyup="nospaces(this);"></td>
			</tr>
			<tr>
				<td>Department Name</td>
				<td><textarea name="Department_name" id="Department_name"
						style="resize: none;" cols="25" rows="1"></textarea></td>
			</tr>
			<tr>
				<td>HOD</td>
				<td><input type="text" name="hod" id="hod"></td>
			</tr>	
		</table>
		<br>
		<div id="btn_div" style="border: none;">
			<table cellpadding="5" width="450">
				<tr>
					<td align="center">
						<button class="btn" onClick="add_depart();">Add</button>
					</td>
					<td align="center">
						<button class="btn" onClick="close_dept_div();">Close</button>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>