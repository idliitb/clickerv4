<%--
      @author Gobinath
DESCREPTION: This JSP Page will display when you Press add student button in student page
			 in local mode
			 
USE        : to add student

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="../../js/student_info.js"></script>
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui.js"></script>
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
<br><br>
<div id="details" style="text-align: left;">
<center>
<div id="main">

			<table class="ss"  border="1" cellpadding="5" width="450">			
			<tr><td>Student ID</td><td><input type="text" name="student_id" id="student_id" ></td></tr>
			<tr><td>Student Name </td><td> <textarea name="student_name" id="student_name" style="resize: none;" cols="25" rows="1"></textarea></td></tr>
			<tr><td>Roll No </td><td><input type="text" name="roll_no" id="roll_no" ></td></tr>
			<tr><td>Year Of Joining</td><td> <input type="text" name="year_of_join" id="year_of_join" ></td></tr>
			<tr> <td>T A   </td><td>
			
				 <select id="TA_select" name="TA_select"  >
				 <option>Yes</option>
				 <option>No</option>
				 </select>
			    
			</td></tr>
			
			<tr> <td>Email ID </td><td> <input type="text" name="email_id" id="email_id"></td></tr>
			<tr> <td>Mobile No </td><td> <input type="text" name="m_n" id="m_n"></td></tr>
			<tr> <td>Department ID </td><td> 
    <select id="Dept_id" name="Dept_id" onchange="getCourse(this)" >
<option id="select">SELECT</option>
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
				<option id=<%= DepartmentID%>><%=DepartmentName %></option>
				<%				
			}dbconn.closeLocalConnection(conn);
		%>			
          
			 </select>


</td></tr>
			<tr> <td>Course </td>
			<td>
            <select name="course_list" id="course_list" ><option value ="-1">Select</option></select>

			
			</td></tr>
			<tr> <td>Mac Address </td><td><div> <div style=""><input id="mac_txt" type="text" name="MacAddress"></div></div>  </td></tr>
		
			</table>
			<br>
			<div id="btn_div" style="border: none;">
			<table  cellpadding="5" width="450">
			<tr>
			<td align="center"> <button class="btn" onClick="add_student()"> Add </button></td>
			<td align="center">	
			<button class="btn" onClick="close_div()"> Close </button></td>
			</tr>
			</table>
			
			</div>
						
			</div>	
			</center>
			</div>		
			
			
								
			
			

</body>
</html>