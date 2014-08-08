<%--
      @author Gobinath
DESCREPTION: it display when student information double click the student or click the edit button

			 
USE        : to update,delete the student

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="../../js/student_info.js"></script>
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>
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
<%
	String currCourseVal = (String) request.getParameter("courseid");
%>

<body>
			<!-- <div id="hid" style="visibility: hidden;">Record Deleted Successfully<br><div class="btn1" onclick="close_div()" align="center">Close</div></td>				
			</div> -->
	<form name="my_form" method="post">
		<%
			String StudentID = (String) request.getParameter("studentID");
			//String Flag = (String) request.getParameter("flag");
			//String StudentID="120010037";
			DatabaseConnection dbconn = new DatabaseConnection();
			Connection conn = dbconn.createDatabaseConnection();
			Statement st = conn.createStatement();
			try {
				int i = 0;
				String query1 = "SELECT StudentID,StudentRollNo,StudentName,Yearofjoining,Privileges,DeptID,EmailID,MacAddress FROM student where StudentID='"
						+ StudentID + "'";
				//Original 11.20//String query1 = "select s.StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,s.DeptID,EmailID, CourseID from student s, studentcourse c where c.StudentID = s.StudentID";
				System.out.println(query1);
				ResultSet rs = st.executeQuery(query1);
				while (rs.next()) {
					String ss;
					String stud_id = rs.getString(1);
					String roll_no = rs.getString(2);
					String stud_name = rs.getString(3);
					String Yearofjoining = rs.getString(4);
					String Priv = rs.getString(5);
					String DeptID = rs.getString(6);
					String EmailID = rs.getString(7);
					String mac = rs.getString(8);
					//out.println(stud_id +"-"+ roll_no + "- " +stud_name +"-"+ Yearofjoining + "- " +DeptID +"-" +EmailID);
					//System.out.println(stud_id +"-"+ roll_no + "- " +stud_name +"-"+ Yearofjoining + "- " +DeptID +"-" +EmailID);
		%>
		
		
		
		<div id="main_cont" style="top:0px;" >
			<div id="details" style="text-align: left;">
				<table id="tablepaging" class="sss" align="center" cellpadding="2">
					<tr>
						<td>Student ID</td>
						<td><input type="text" name="student_id" id="student_id" value=<%=stud_id%>></td>
					</tr>
					<tr>
						<td>Student Name</td>
						<td><textarea name="student_name" id="student_name" style="resize: none;" cols="25" rows="1"><%=stud_name%></textarea></td>
					</tr>
					<tr>
						<td>Roll No</td>
						<td><input type="text" name="roll_no" id="roll_no" value=<%=roll_no%>></td>
					</tr>
					<tr>
						<td>Year Of Joining</td>
						<td><input type="text" name="year_of_join" id="year_of_join" value=<%=Yearofjoining%>></td>
					</tr>
					<tr>
						<td>T A</td>
						<td>
							<%
								if (Priv == "1") {
											ss = "Yes";
							%> 
								<select id="TA_select" name="TA_select">
									<option selected>Yes</option>
									<option>No</option>
								</select>
							<%
								} else
 									ss = "No";
							%>
								 <select id="TA_select" name="TA_select">
										<option>Yes</option>
										<option selected>No</option>
								  </select> 
						</td>
					</tr>
					<tr>
						<td>Department ID</td>
						<td><input type="text" name="depatment_id" id="depatment_id" value=<%=DeptID%> readonly></td>
					</tr>
					<tr>
						<td>Email ID</td>
						<td><input type="text" name="email_id" id="email_id" value=<%=EmailID%>></td>
					</tr>
					<tr>
						<td>Course</td>
						<td>
							<div id="course_div" style="width: 300px; height: 100px; border: none;">
								<div id="delete_course" style="float: left;">
									<div id="course_div1" style="border: none; width: 135px; padding: 5px;">
										<select id="stud_course" name="stud_course" style="width: 130px" multiple>

											<%
												String qq = "SELECT CourseID FROM studentcourse where StudentID='"+ stud_id + "'";
														Statement st1 = conn.createStatement();
														ResultSet rs1 = st1.executeQuery(qq);
														String courses = "@";
														String CourseID = null;
														while (rs1.next()) {
															CourseID = rs1.getString(1);
															courses = courses + CourseID + "@";
															//System.out.println("==>"+courses);
											%>
											<option id=<%=CourseID%> value=<%=CourseID%>><%=CourseID%></option>
											<%
												}

														rs1.close();
											%>
										</select>
									</div>
									<div class="btn"
										
										onclick="Delete_course()">
										<center>Delete</center>
									</div>
								</div>
								<div id="addcourse_div"
									style="float: right; border: none; width: 140px;">
									<div id="course_div1"
										style="border: none; width: 135px; padding: 5px;">
										<select id="course_select" name="course_select"
											style="width: 130px">
											<%
												String[] Courseid = courses.split("@");

														String query = "SELECT CourseID FROM course where DeptID='"
																+ DeptID + "'";

														Statement st2 = conn.createStatement();
														ResultSet rs2 = st2.executeQuery(query);
														int l = 0;
														while (rs2.next()) {
															String rr = rs2.getString(1);
															l = 0;
															for (int j = 0; j < Courseid.length; j++) {

																if (rr.equalsIgnoreCase(Courseid[j])) {
																	l = l + 1;
																}

															}

															if (l == 0) {
											%>
											<option value=<%=rr%>><%=rr%></option>
											<%
												}
														}
											%>
										</select>
									</div>
									<div class="btn"
										onclick="Add_course()">
										<center>Add</center>
									</div>
								</div>

								<div id="course_dialog" style="visibility: hidden"
									title="Course"></div>
							</div>
						</td>
					</tr>
					<tr>
						<td>Mac Address</td>
						<td><div>
								<div style="float: left;">
									<input id="mac_txt" type="text" name="firstname"
										value=<%=mac%>>
								</div>
								<div style="float: right;"> <div class="btn"  onclick="remove_mac()">Remove</div></div>
								
							</div>
						</td>
					</tr>
				</table>
				<br>
				<table align="center">
					<tr>
						<td><div class="btn1" onClick="update_student()" align="center">Update</div></td>
						<td><div class="btn1" onclick="delete_student()" align="center">Delete</div></td>
						<td><div class="btn1" onclick="close_div();" align="center">Close</div></td>
					</tr>
				</table>

				<!-- <center><button>Close</button></center>  -->
			</div>
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

		</div>
	</form>
</body>
</html>