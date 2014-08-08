<%--
      @author Gobinath
DESCREPTION: This JSP Page will display when you Press Department menu in admin
			 in local mode
			 
USE        : to add department,course

--%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%@page import="clicker.v4.admin.Admindata"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<html>


<head>

<title>Department</title>
<script type="text/javascript" src="../../js/department_course.js"></script>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>
<link rel="stylesheet" media="all" type="text/css" href="../../jsp/newMenu/dropdown.css" />

<style type="text/css">

#navBar {
	border-width: 1px;
	border: none;
	border-radius: 10px;
	border-color: #008040;
	overflow: auto;
	overflow-x: hidden;
	float: left;
	width: 500px;
	height: 300px;
}
#leftBar{

   border-width: 1px;
	border: none;
	border-radius: 10px;
	border-color: #008040;
	overflow: auto;
	overflow-x: hidden;
	float: right;
	width: 300px;
	height: 300px;
    margin-right: 100px;

}

table.yui,table.yui1 {
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

table.yui td,table.yui1 td {
	padding: 5px;
	border-right: solid 1px #7f7f7f;
	cursor: pointer;
}

table.yui .even {
	background-color: #EEE8AC;
}

table.yui .odd {
	background-color: #F9FAD0;
}

table.yui th,table.yui1 th {
	border: 1px solid #7f7f7f;
	padding: 5px;
	height: auto;
	background: #9BBB59;
}

table.yui th a {
	text-decoration: none;
	text-align: center;
	padding-right: 20px;
	font-weight: bold;
	white-space: nowrap;
}

table.yui tfoot td {
	border-top: 1px solid #7f7f7f;
	background-color: #E1ECF9;
}

table.yui thead td {
	vertical-align: middle;
	background-color: #E1ECF9;
	border: none;
}

table.yui thead .tableHeader {
	font-size: larger;
	font-weight: bold;
}

table.yui thead .filter {
	text-align: right;
}

table.yui tfoot {
	background-color: #E1ECF9;
	text-align: center;
}

table.yui .tablesorterPager {
	padding: 10px 0 10px 0;
}

table.yui .tablesorterPager span {
	padding: 0 5px 0 5px;
}

table.yui .tablesorterPager input.prev {
	width: auto;
	margin-right: 10px;
}

table.yui .tablesorterPager input.next {
	width: auto;
	margin-left: 10px;
}

table.yui .pagedisplay {
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

<%
int count=0;
Admindata getdata = new Admindata();
String dept_IDS = getdata.departmentIDs();
%>

<%
			
			DatabaseConnection dbconn1 = new DatabaseConnection();
			Connection conn1 = dbconn1.createDatabaseConnection();
			Statement st1 = conn1.createStatement();
			String inst_name=null;
			try {
				int i = 0;
				String query1 = "SELECT instiID FROM institution;";
				//Original 11.20//String query1 = "select s.StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,s.DeptID,EmailID, CourseID from student s, studentcourse c where c.StudentID = s.StudentID";
				System.out.println(query1);
				ResultSet rs = st1.executeQuery(query1);
				while (rs.next()) {
					i++;					
				}
				count=i;
				String query2 = "SELECT InstiName FROM institution where InstiID='I1'";
				ResultSet rs1 = st1.executeQuery(query2);
				while (rs1.next()) {
					inst_name=rs1.getString(1);					
				}
				if(i==1)
				{
					System.out.println("------------>"+i);
					 // window.location.assign("../../jsp/admin/institute.jsp");
				}

					//out.println(stud_id +"-"+ roll_no + "- " +stud_name +"-"+ Yearofjoining + "- " +DeptID +"-" +EmailID);
					//System.out.println(stud_id +"-"+ roll_no + "- " +stud_name +"-"+ Yearofjoining + "- " +DeptID +"-" +EmailID);
		
		
			} catch (Exception e) {
				e.printStackTrace();
			}
			finally
			{
				dbconn1.closeLocalConnection(conn1);
			}

		%>



       <script>
       
       
   	$(function() {			
		var studList = "<%=dept_IDS%>";
		var availableList = studList.split(",");
		$( "#D_search_box" ).autocomplete({
			source: availableList,
			focus: function( event, ui ) {
				$( "#D_search_box" ).val( ui.item.label );
				studentInfo(this.value);						
				return false;
			},
			select: function( event, ui ) {
				$( "#D_search_box" ).val( ui.item.label );
				return false;
			}			
		});
						
	});
       
       
       

jQuery('html').bind('click', function(e){
if(jQuery('#department_dialog').dialog('isOpen') && !jQuery(e.target).is('.ui-dialog, a') && !jQuery(e.target).closest('.ui-dialog').length)
{
jQuery('#department_dialog').dialog('close');
}
 }
);


jQuery('html').bind('click', function(e){
	if(jQuery('#course_div_dialog').dialog('isOpen') && !jQuery(e.target).is('.ui-dialog, a') && !jQuery(e.target).closest('.ui-dialog').length)
	{
	jQuery('#course_div_dialog').dialog('close');
	}
	 }
	);



</script>
</head>

<body onload="open_course()">

<%@ include file="../../jsp/includes/menuheader.jsp"%>

<input id="instcount"  style="visibility:hidden; width:220px;  font-size:15px; color:black" type="text" name="centerid" value = '<%=count%>' /> 
<br><br>


<div><font style="font-size: large;font-weight: bold;color:black;"><%=inst_name %></font></div>
<br>
<div style="height: 600px;width: 1000px;margin: auto;">

<table align="center" width="75%">

<tr>
<td width="60%" style="margin-top: 0px;vertical-align:top;" >
 			<table id="department_table" class="yui" align="center">
				<thead>
				<tr>
				<th colspan="3" align="center">
		      <font size="5px">Department</font>
				</th>
				</tr>
				<tr>
						<th colspan="3" align="left">
							<div>
								<div style="float: left;">
									<img src="plus.png" onclick="add_new_Department()"
										style="cursor: pointer;" width="15px" height="15px"
										alt="button" border="0" title="Add" />&nbsp&nbsp&nbsp <img
										src="mm.png" onclick="delete_Department()"
										style="cursor: pointer;" width="15px" height="15px"
										alt="button" border="0" title="Delete" />&nbsp&nbsp&nbsp <img
										src="Files-Edit.png" onclick="edit_Department()"
										style="cursor: pointer;" width="15px" height="15px"
										alt="button" border="0" title="Edit" />
								</div>
								<div style="float: right;">
									Search By ID &nbsp&nbsp&nbsp <input type="text"
										name="D_search_box" id="D_search_box" />&nbsp&nbsp&nbsp <img
										src="Search-icon-24x24.png" onclick="edit_dept()"
										style="cursor: pointer;" 16px" height="16px" alt="button"
										border="0" title="Search" />
								</div>
							</div>
						</th>
						</tr>
					<tr>
						<th>Department ID</th>
						<th>Department Name</th>
						<th>HOD</th>				
					</tr>
				</thead>	
				
				<%
						DatabaseConnection dbconn = new DatabaseConnection();
						Connection conn = dbconn.createDatabaseConnection();
						 {
							Statement st = conn.createStatement();
							int i = 0;
							String query1 = "SELECT DeptID,DeptName,HOD FROM department";
							//Original 11.20//String query1 = "select s.StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,s.DeptID,EmailID, CourseID from student s, studentcourse c where c.StudentID = s.StudentID";
							ResultSet rs = st.executeQuery(query1);
							while (rs.next()) {		
								String D_id = rs.getString(1);
								String D_name = rs.getString(2);
								String hod = rs.getString(3);
				%>
				<tbody>
					<tr id=<%=D_id%> onclick="rowSelected(id)" ondblclick="edit_Department()" > 
						<td width="100"><%=D_id %></td>
						<td align="left" width="250"><%=D_name %></td>
						<td width="100"><%=hod %></td>
					</tr>			
				</tbody>		
					<%
							}
						}		
						 dbconn.closeLocalConnection(conn);
					%>
			</table>

</td>

<td style="margin-top: 0px;vertical-align:top;">

<div id="course_div">
</div>

</td>
</tr>
</table>

<div id="department_dialog" style="visibility: hidden; height: 0px; width: 0px;" title="Deparment"></div>

		
</div>
</body>
<div style="margin-top: -600px;">
		<center><%@ include file="../../jsp/includes/menufooter.jsp"%></center>
	</div>
</html>