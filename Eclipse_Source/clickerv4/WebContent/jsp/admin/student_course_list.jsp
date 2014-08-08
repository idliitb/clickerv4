<%--
      @author Gobinath
DESCREPTION: this page is loaded in the student page in local mode
			 
USE        : to assign the course to the student by indvidual or group

--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="../../js/student_info.js"></script>
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>


<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css"/>
<%
DatabaseConnection dbconn = new DatabaseConnection();
Connection conn = dbconn.createDatabaseConnection();
String stud_id = (String) request.getParameter("studentID");
//String stud_id="104";
//String DeptID="dept001";
String DeptID=null ;
//System.out.println("-------------------------------------------------->"+stud_id);
String query1 = "SELECT DeptID FROM student where StudentID='"
						+ stud_id + "'";
				//Original 11.20//String query1 = "select s.StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,s.DeptID,EmailID, CourseID from student s, studentcourse c where c.StudentID = s.StudentID";
				
				Statement stm = conn.createStatement();
				ResultSet rs = stm.executeQuery(query1);
				while (rs.next()) {					
					DeptID = rs.getString(1);
				}





%>
<body>
	
	<div id="course_div" style="width: 300px; height: 100px; border: none;">
								<div id="delete_course" style="float: left;">
									<div id="course_div1" style="border: none; width: 135px; padding: 5px;">
										<select id="ind_stud_course" name="ind_stud_course" style="width: 130px" multiple>

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
									<div class="btn" id=<%=stud_id %>
										
										onclick="ind_delete_course(id)">
										<center>Delete</center>
									</div>
								</div>
								<div id="addcourse_div"
									style="float: right; border: none; width: 140px;margin-right: 15px;">
									<div id="course_div1"
										style="border: none; width: 135px; padding: 5px;">
										<select id="ind_course_select" name="ind_course_select"
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
														
														dbconn.closeLocalConnection(conn);
											%>
										</select>
									</div>
									<div class="btn" id=<%=stud_id %>
										onclick="ind_add_course(id)">
										<center>Add</center>
									</div>
								</div>

								<div id="course_dialog" style="visibility: hidden"
									title="Course"></div>
							</div>
	
	
	
		
</body>
</html>