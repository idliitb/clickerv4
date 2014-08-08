<%--
      @author Gobinath
DESCREPTION: it display when admin double click the instructor or click the edit button

			 
USE        : to update,delete the instructor

--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>


<script type="text/javascript" src="instructor.js"></script>
<title>Insert title here</title>
</head>

<style type="text/css">

table.ss {
font-family:Liberation Serif;
width:400px;
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

table.ss td {
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
<form name="my_form" method="post">
<%
			String InstructorID = (String) request.getParameter("instructor_id");
           //  System.out.println("enter into instructor_details");
			//String InstructorID="dbp";
			DatabaseConnection dbconn = new DatabaseConnection();
			Connection conn = dbconn.createDatabaseConnection();
			Statement st = conn.createStatement();
			String query1 = "SELECT InstrID,InstrName,DOJ,DeptID,Designation,EmailID,MobileNo,AdminPriviledges FROM instructor where InstrID='"+InstructorID+"'";
			System.out.println(query1);
			ResultSet rs = st.executeQuery(query1);	
			while (rs.next()) {
				String ss;
				String InstrID = rs.getString(1);
				String InstrName = rs.getString(2);
				String DOJ = rs.getString(3);
				String DeptID = rs.getString(4);
				String Designation = rs.getString(5);
				String EmailID = rs.getString(6);
				String MobileNo = rs.getString(7);
				String AdminPriviledges = rs.getString(8);
				
				System.out.println(InstrID+" "+InstrName+" "+DOJ+" "+DeptID+" "+Designation+" "+EmailID+" "+MobileNo+" "+AdminPriviledges);
			
			
			%>
			
			<div id="main_cont" style="top:0px;" >
			<div id="details" style="text-align: left;">
				<table id="tablepaging" class="ss" align="center" cellpadding="2">
					<tr>
						<td>Instructor ID</td>
						<td><input type="text" name="I_id" id="I_id" value=<%=InstrID%> readonly></td>
					</tr>
					<tr>
						<td>Instructor Name</td>
						<td><textarea name="I_name" id="I_name" style="resize: none;" cols="25" rows="1"><%=InstrName%></textarea></td>
					</tr>
					
					<tr>
						<td>Year Of Joining</td>
						<td><input type="text" name="I_year_of_join" id="I_year_of_join" value=<%=DOJ%>></td>
					</tr>
					
					<tr>
						<td>Department ID</td>
						<td><input type="text" name="I_depatment_id" id="I_depatment_id" value=<%=DeptID%> readonly></td>
					</tr>
					<tr>
						<td>Designation</td>
						<td><input type="text" name="I_Desg" id="I_Desg" value=<%=Designation%> ></td>
					</tr>
					
					<tr>
						<td>Course</td>
						<td>
							<div id="course_div" style="width: 300px; height: 100px; border: none;">
								<div id="delete_course" style="float: left;">
									<div id="course_div1" style="border: none; width: 135px; padding: 5px;">
										<select id="I_course" name="I_course" style="width: 130px" multiple>

											<%
												String qq = "SELECT CourseID FROM instructorcourse where InstrID='"+ InstructorID + "'";
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
										
										onclick="delete_course()">
										<center>Delete</center>
									</div>
								</div>
								<div id="addcourse_div"
									style="float: right; border: none; width: 140px;">
									<div id="course_div1"
										style="border: none; width: 135px; padding: 5px;">
										<select id="I_course_select" name="I_course_select"
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
										onclick="add_course()">
										<center>Add</center>
									</div>
								</div>

								<div id="course_dialog" style="visibility: hidden"
									title="Course"></div>
							</div>
						</td>
					</tr>
					
					<tr>
						<td>Email ID</td>
						<td><input type="text" name="I_email_id" id="I_email_id" value=<%=EmailID%>></td>
					</tr>
					<tr>
						<td>Mobile No</td>
						<td><input type="text" name="I_Mobile_no" id="I_Mobile_no" value=<%=MobileNo%> ></td>
					</tr>
				</table>
				<br>
				<table align="center">
					<tr>
						<td><div class="btn1" onClick="update_instr_details();" align="center">Update</div></td>
						<td><div class="btn1" onclick="delete_values_inst();" align="center">Delete</div></td>
						<td><div class="btn1" onclick="close_add_div();" align="center">Close</div></td>
					</tr>
				</table>

				<!-- <center><button>Close</button></center>  -->
			</div>
			

		</div>
<%
}
			dbconn.closeLocalConnection(conn);
%>
			
			
			

</form>

</body>
</html>