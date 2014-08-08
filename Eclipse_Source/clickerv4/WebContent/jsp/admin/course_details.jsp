<%--
      @author Gobinath
DESCREPTION: This JSP Page will display course details when you double click the course 
			 in the department page this page will open
			 
USE        : to update and delete the course

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
            <%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="../../js/department_course.js"></script>
<link href="../../css/table_design.css" rel="stylesheet" type="text/css" />
<title>Insert title here</title>
</head>
<%
			String Course_ID = (String) request.getParameter("course_ID");
            //System.out.println("=================>"+Dept_ID);
			//Course_ID="Course-A";
			//String dpt_id=null;
			
%>

<style type="text/css">
table.sss {
font-family:Liberation Serif;

width:450px;
border: solid 3px #7f7f7f;
font-size:medium;
 -moz-user-select: -moz-none;
   -khtml-user-select: none;
   -webkit-user-select: none;

   /*
     Introduced in IE 10.
     See http://ie.microsoft.com/testdrive/HTML5/msUserSelect/
   */
   -ms-user-select: none;
   user-select: none;
}

table.sss td {
padding: 2px;
border-right: solid 1px #7f7f7f;
border-bottom: solid 1px #7f7f7f;

}

.btn{
    background:#9bbb59;	
	font-weight:bold;
	font-size:medium;
	margin-right:10px;
	border-radius:4px;
	width:75px;
	min-width:0.4in; 
	min-height:0.2in;
	margin-top:1px;
	cursor: pointer;
	margin-left: 30px;
	}
	
	.btn1{
    background:#9bbb59;	
	font-weight:bold;
	font-size:medium;
	margin-right:10px;
	border-radius:4px;
	width:90px;
	height:25px;
	min-width:0.4in; 
	min-height:0.2in;
	margin-top:1px;
	cursor: pointer;
	margin-left: 30px;
	padding-top: 8px;
	}

</style>	


<body>

<%
			
			DatabaseConnection dbconn = new DatabaseConnection();
			Connection conn = dbconn.createDatabaseConnection();
			Statement st = conn.createStatement();
			try {
				int i = 0;
				String query1 = "SELECT CourseID,CourseName,CourseDesc,DeptID FROM course where CourseID='"+Course_ID+"'";
				//Original 11.20//String query1 = "select s.StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,s.DeptID,EmailID, CourseID from student s, studentcourse c where c.StudentID = s.StudentID";
				System.out.println(query1);
				ResultSet rs = st.executeQuery(query1);
				while (rs.next()) {
					
					String CourseID = rs.getString(1);
					String CourseName = rs.getString(2);
					String CourseDesc = rs.getString(3);
					String DeptID = rs.getString(4);
					

					//out.println(stud_id +"-"+ roll_no + "- " +stud_name +"-"+ Yearofjoining + "- " +DeptID +"-" +EmailID);
					//System.out.println(stud_id +"-"+ roll_no + "- " +stud_name +"-"+ Yearofjoining + "- " +DeptID +"-" +EmailID);
		%>
		
		
<table id="tablepaging" class="sss" align="center" cellpadding="2">


					<tr>
						<td>Course ID</td>
						<td><input type="text" name="course_id" id="course_id" value=<%=CourseID%>></td>
					</tr>
					<tr>
						<td>Course Name</td>
						<td><input type="text" name="course_name" id="course_name" value=<%=CourseName%>></td>
					</tr>
					<tr>
						<td>Course Description</td>
						<td><textarea name="course_desc" id="course_desc" style="resize: none;" cols="25" rows="1"><%=CourseDesc%></textarea></td>
					</tr>
					<tr>
						<td>Department ID</td>
						<td><input type="text" name="deptid" id="deptid" value=<%=DeptID%> readonly></td>
					</tr>
</table>
<br>
<table align="center">
					<tr>
						<td><div class="btn1" onClick="update_DC();" align="center">Update</div></td>
						<td><div class="btn1" onclick="delete_course_btn();" align="center">Delete</div></td>
						<td><div class="btn1" onclick="close_course_div();" align="center">Close</div></td>
					</tr>
				</table>
<%
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			finally
			{
				dbconn.closeLocalConnection(conn);
			}
%>
</body>
</html>