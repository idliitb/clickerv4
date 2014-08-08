<%--
      @author Gobinath
DESCREPTION:This JSP Page will display when you Press the Add Instructor Button
USE        : to add New Instructor

--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>

<script type="text/javascript" src="instructor.js"> </script>


<title>Insert title here</title>
</head>
<style type="text/css">
select {
	font-size: 12pt;
}
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


select {
    font-size: 12pt;
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
</style>

<body>


	<div id="details" style="text-align: left;">
		<div id="main">
			<table class="ss"  border="1" align="center" cellpadding="5" width="450">
				<tr>
					<td>Instructor ID</td>
					<td><input type="text" name="instr_id" id="instr_id"></td>
				</tr>
				<tr>
					<td>Instructor Name</td>
					<td><textarea name="instr_name" id="instr_name"
							style="resize: none;" cols="25" rows="1"></textarea></td>
				</tr>
				<tr>
					<td>Date Of Joining<br>(YYYY-MM-DD)</td>
					<td><input type="text" name="instr_doj" id="instr_doj"></td>
				</tr>
				<tr>
					<td>Department ID</td>
					<td><select id="instr_Dept_id" name="instr_Dept_id"
						onchange="getinstrCourseValue(this)">
						<option>SELECT</option>
							<%
								DatabaseConnection dbconn = new DatabaseConnection();
								Connection conn = dbconn.createDatabaseConnection();
								Statement st = conn.createStatement();
								String query1 = "SELECT DeptName,DeptID FROM department";
								ResultSet rs = st.executeQuery(query1);
								while (rs.next()) {

									String DepartmentName = rs.getString(1);
									String DepartmentID = rs.getString(2);
							%>
							<option id=<%=DepartmentID%>><%=DepartmentName%></option>
							<%
								}
								 dbconn.closeLocalConnection(conn);
							%>

					</select></td>
				</tr>				
				<tr>
					<td>Course</td>
					<td><select name="instr_course_list" id="instr_course_list"><option
								value="-1">Select</option></select></td>
				</tr>
				<tr>
					<td>Designation</td>
					<td> <input type="text" name="instr_Designation" id="instr_Designation"> 
					<!--<select id="instr_Desg" name="instr_Desg"  >
						<option Selected>Select</option>
					    <option>HOD</option>
				 		<option>Professor</option>
				 		<option>Asst professor</option>
				 		<option>Lecturer</option>
				        </select>
					-->
					
					</td>
				</tr>
				<tr>
					<td>Email ID</td>
					<td><input type="text" name="instr_email_id" id="instr_email_id"></td>
				</tr>
				<tr>
					<td>Mobile No</td>
					<td><input type="text" name="instr_mobile_no" id="instr_mobile_no"></td>
				</tr>
				<tr> <td>Privilege  </td><td>			
				 <select id="instr_Admin" name="instr_Admin"  >
				 <option>Admin</option>
				 <option selected>Instructor</option>
				 <option>HOD</option>
				 <option>Principal</option>
				 </select>
			    
			</td></tr>

			</table>
			<br>
			<div id="btn_div" style="border: none;">
			<table  cellpadding="5" width="450">
			<tr>
			<td align="center"> <button class="btn" onClick="add_instr_details()"> Add </button></td>
			<td align="center">		
			
			
			<button class="btn" onClick="close_add_div()"> Close </button>		</td>
			</tr>
			</table>			
			</div>

		</div>
	</div>




	<div id="msg_div" style="visibility: hidden;">

		<table cellpadding="5" width="450">
			<tr>Record Added....
			</tr>
			<tr>
				<td align="center">
					<button onClick="add_inst()">Add</button>
				</td>
				<td align="center"><div id="close_btn"
						style="width: 100px; border: solid;" onClick="close_add_div()">Close</div>
				</td>
			</tr>
		</table>

	</div>






</body>
</html>