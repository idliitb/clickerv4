<%--
      @author Gobinath
DESCREPTION:This JSP Page will display when you Press the Add Course Button
USE        : to add New Course

--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../../css/table_design.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../js/department_course.js"></script>
<title>Insert title here</title>
</head>

<body>
<%
			String Dept_ID = (String) request.getParameter("Dept_ID");
            //System.out.println("=================>"+Dept_ID);
			//Dept_ID="dept001";
			String dpt_id=null;
			
%>

	<div id="main">

		<table class="course_add_table" border="1" cellpadding="5" width="450">
			<tr>
				<td>Course ID</td>
				<td><input type="text" name="course_id" id="course_id" onkeyup="nospaces(this);"></td>
			</tr>
			<tr>
				<td>Course Name</td>
				<td><input type="text" name="course_name" id="course_name"></td>
			</tr>
			<tr>
				<td>Description</td>
				<td><textarea name="course_desc" id="course_desc"
						style="resize: none;" cols="25" rows="1"></textarea></td>
			</tr>
			<tr>
				<td>Department ID</td>
				<td>						<%
							DatabaseConnection dbconn = new DatabaseConnection();
							Connection conn = dbconn.createDatabaseConnection();
							Statement st = conn.createStatement();
							String query1 = "SELECT DeptName,DeptID FROM department where DeptID='"+Dept_ID+"'";
							ResultSet rs = st.executeQuery(query1);
							while (rs.next()) {
								String DepartmentName = rs.getString(1);
								String DepartmentID = rs.getString(2);
								dpt_id=DepartmentID;
						%>
						<input type="text" name="dep_nam" id=<%=DepartmentID %> value=<%=DepartmentName%> readonly>
						
						
						<%
							}
							 dbconn.closeLocalConnection(conn);
						%>
						
						</td>
				
			</tr>
		</table>
		<br>
		<div id="btn_div" style="border: none;">
			<table cellpadding="5" width="450">
				<tr>
					<td align="center">
						<button class="btn" onClick="add_course();">Add</button>
					</td>
					<td align="center">
						<button class="btn" onClick="close_add_course_div();">Close</button>
					</td>
				</tr>
			</table>
			<input type="text" name="dep_id" id=dep_id value=<%=dpt_id%> style="visibility: hidden;">
		</div>
	</div>
</body>
</html>