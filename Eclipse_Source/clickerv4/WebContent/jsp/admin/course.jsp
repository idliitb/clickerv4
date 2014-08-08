<%--
      @author Gobinath
DESCREPTION: This JSP Page will display inside the department.jsp page load in course div
			 in local mode
			 
USE        : it display the course when we select department in department page

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
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>

<title>Insert title here</title>
<style type="text/css">
}
#navBar {
	border-width: 1px;
	border: none;
	border-radius: 10px;
	border-color: #008040;
	overflow: auto;
	overflow-x: hidden;
	float: left;
}

.pg-normal {
	color: #000000;
	font-size: 15px;
	cursor: pointer;
	background: #9BBB59;
	padding: 2px 4px 2px 4px;
}

.pg-selected {
	color: #fff;
	font-size: 15px;
	background: #000000;
	padding: 2px 4px 2px 4px;
}

table.course {
	font-family: arial;
	border-collapse: collapse;
	border: solid 3px #7f7f7f;
	font-size: small;
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

table.course td{
	padding: 5px;
	border-right: solid 1px #7f7f7f;
	cursor: pointer;
}

table.course .even {
	background-color: #EEE8AC;
}

table.course .odd {
	background-color: #F9FAD0;
}

table.course th {
	border: 1px solid #7f7f7f;
	padding: 5px;
	height: auto;
	background: #9BBB59;
}

table.course th a {
	text-decoration: none;
	text-align: center;
	padding-right: 20px;
	font-weight: bold;
	white-space: nowrap;
}

table.course tfoot td {
	border-top: 1px solid #7f7f7f;
	background-color: #E1ECF9;
}

table.course thead td {
	vertical-align: middle;
	background-color: #E1ECF9;
	border: none;
}

table.course thead .tableHeader {
	font-size: larger;
	font-weight: bold;
}

table.course thead .filter {
	text-align: right;
}

table.course tfoot {
	background-color: #E1ECF9;
	text-align: center;
}

table.course .tablesorterPager {
	padding: 10px 0 10px 0;
}

table.course .tablesorterPager span {
	padding: 0 5px 0 5px;
}

table.course .tablesorterPager input.prev {
	width: auto;
	margin-right: 10px;
}

table.course .tablesorterPager input.next {
	width: auto;
	margin-left: 10px;
}

table.course .pagedisplay {
	font-size: 10pt;
	width: 30px;
	border: 0px;
	background-color: #E1ECF9;
	vertical-align: top;
}

._css3m {
	display: none
}
</style>

</head>


<script>

jQuery('html').bind('click', function(e){
if(jQuery('#course_div_dialog').dialog('isOpen') && !jQuery(e.target).is('.ui-dialog, a') && !jQuery(e.target).closest('.ui-dialog').length)
{
jQuery('#course_div_dialog').dialog('close');
}
 }
);


</script>


<body>

<%
			String Dept_ID = (String) request.getParameter("Dept_ID");
            //System.out.println("=================>"+Dept_ID);
			//Dept_ID="dept001";
			
%>
<div>
  			<table id="Course_table" class="course" align="center" style="margin-top: 0px;">
				<thead>
				<tr>
				<th colspan="3" align="center">
		      <font size="5px">Course</font>
				</th>
				
				</tr>
				 <tr>
					  	<th colspan="3" align="left">
							<div style="width: 275px">
								<div style="float: right;">
									<img src="plus.png" onclick="add_new_course()"
										style="cursor: pointer;" width="15px" height="15px"
										alt="button" border="0" title="Add" />&nbsp&nbsp&nbsp <img
										src="mm.png" onclick="delete_course()"
										style="cursor: pointer;" width="15px" height="15px"
										alt="button" border="0" title="Delete" />&nbsp&nbsp&nbsp <img
										src="Files-Edit.png" onclick="edit_course_DC()"
										style="cursor: pointer;" width="15px" height="15px"
										alt="button" border="0" title="Edit" />
								</div>
								<!-- <div style="float: right;">
									Search By ID &nbsp&nbsp&nbsp <input type="text"
										name="search_box" id="search_box" />&nbsp&nbsp&nbsp <img
										src="Search-icon-24x24.png" onclick="search_edit_student()"
										style="cursor: pointer;" 16px" height="16px" alt="button"
										border="0" title="Search" />
								</div> -->
							</div>
						</th>
						</tr> 
					<tr>

						<th>Course ID</th>
						<th>Course Name</th>                                        

					</tr>
				</thead>
				
				
				<%								
				
						DatabaseConnection dbconn = new DatabaseConnection();
						Connection conn = dbconn.createDatabaseConnection();
						try {
							Statement st = conn.createStatement();
							int i = 0;
							String query1 = "SELECT CourseID,CourseName,CourseDesc FROM course where DeptID='"+Dept_ID+"'";
							//System.out.println("=====>"+query1);
							//Original 11.20//String query1 = "select s.StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,s.DeptID,EmailID, CourseID from student s, studentcourse c where c.StudentID = s.StudentID";
							ResultSet rs = st.executeQuery(query1);
							while (rs.next()) {

								String C_id = rs.getString(1);
								String C_name = rs.getString(2);
								String Dec = rs.getString(3);
								
				%>
								
								
				<tbody>
					<tr id=<%=C_id%>  onclick="CourserowSelected(id)" ondblclick="edit_course_DC(id)"> 
						<td width="100"><%=C_id %></td>
						<td align="left" width="250"><%=C_name %></td>
						
					</tr>
			
				</tbody>
								<%
							}
						}	
						catch(Exception e)
						{
							out.println(e);
						}
						finally
						{
							dbconn.closeLocalConnection(conn);}
					%>
				
				
				
			</table>
			<div id="course_div_dialog" style="visibility: hidden; height: 0px; width: 0px;" title="Course"></div>

</div>



</body>
</html>