<%--
      @author Gobinath
DESCREPTION: it display when student information

			 
USE        : to add student and assign course
--%>
<%@page import="clicker.v4.admin.Admindata"%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%@page import="clicker.v4.admin.Admindata"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String currCourseVal = (String) request.getParameter("courseid");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" ; charset="UTF-8">
<title>Student Details</title>
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>


<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="../../js/student_info.js"></script>
<!-- <script type="text/javascript" src="../../js/student.js"></script> -->




<%
	String InstructorID = (String) session.getAttribute("InstructorID");
	if (InstructorID == null) {
		request.setAttribute("Error",
				"Your session has expired. Login again");
		RequestDispatcher rd = request
				.getRequestDispatcher("../../error.jsp");
		rd.forward(request, response);
		return;
	}
	String courseID = session.getAttribute("courseID").toString();
	Admindata getdata = new Admindata();
	String StudentList = getdata.getStudentIDs();
%>

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

.btn {
	background: #9bbb59;
	font-weight: bold;
	font-size: medium;
	margin-right: 10px;
	border-radius: 4px;
	width: 75px;
	min-width: 0.4in;
	min-height: 0.2in;
	margin-top: 1px;
	cursor: pointer;
	margin-left: 30px;
}

.btn2 {
	background: #9bbb59;
	font-weight: bold;
	font-size: medium;
	margin-right: 10px;
	border-radius: 4px;
	width: 75px;
	min-width: 0.4in;
	min-height: 0.2in;
	margin-top: 1px;
	cursor: pointer;
	margin-left: 120px;
}

#per_div {
	cursor: pointer;
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


<script type="text/javascript">

function Pager(tableName, itemsPerPage) {

this.tableName = tableName;

this.itemsPerPage = itemsPerPage;

this.currentPage = 1;

this.pages = 0;

this.inited = false;

this.showRecords = function(from, to) {

var rows = document.getElementById(tableName).rows;

// i starts from 1 to skip table header row

for (var i = 3; i < rows.length; i++) {

if (i < from || i > to)

rows[i].style.display = 'none';

else

rows[i].style.display = '';

}

}

this.showPage = function(pageNumber) {

if (! this.inited) {

alert("not inited");

return;

}

var oldPageAnchor = document.getElementById('pg'+this.currentPage);

oldPageAnchor.className = 'pg-normal';

this.currentPage = pageNumber;

var newPageAnchor = document.getElementById('pg'+this.currentPage);

newPageAnchor.className = 'pg-selected';

var from = (pageNumber - 1) * itemsPerPage + 1;

var to = from + itemsPerPage - 1;

this.showRecords(from, to);

}

this.prev = function() {

if (this.currentPage > 1)

this.showPage(this.currentPage - 1);

}

this.next = function() {

if (this.currentPage < this.pages) {

this.showPage(this.currentPage + 1);

}

}

this.init = function() {

var rows = document.getElementById(tableName).rows;

var records = (rows.length - 1);

this.pages = Math.ceil(records / itemsPerPage);

this.inited = true;

}

this.showPageNav = function(pagerName, positionId) {

if (! this.inited) {

alert("not inited");

return;

}

var element = document.getElementById(positionId);

var pagerHtml = '<div style="width:400px;"><span onclick="' + pagerName + '.prev();" class="pg-normal"> « Prev </span><br>';




for (var page = 1; page <= this.pages; page++)

pagerHtml += '<span id="pg' + page + '" class="pg-normal" onclick="' + pagerName + '.showPage(' + page + ');">' + page + '</span> ';

pagerHtml += '<br><span onclick="'+pagerName+'.next();" class="pg-normal"> Next »</span></div>';

element.innerHTML = pagerHtml;

}

}

</script>



<script>

			$(function() {			
				var studList = "<%=StudentList%>";
				var availableList = studList.split(",");
				$( "#search_box" ).autocomplete({
					source: availableList,
					focus: function( event, ui ) {
						$( "#search_box" ).val( ui.item.label );
						studentInfo(this.value);						
						return false;
					},
					select: function( event, ui ) {
						$( "#search_box" ).val( ui.item.label );
						return false;
					}			
				});
				$( "#search_box2" ).autocomplete({
					source: availableList,
					focus: function( event, ui ) {
						$( "#search_box2" ).val( ui.item.label );
						studentInfo(this.value);						
						return false;
					},
					select: function( event, ui ) {
						$( "#search_box2" ).val( ui.item.label );
						return false;
					}			
				});	
				
								
			});
						
			
			jQuery('html')
            .bind(
             'click',
             function(e){
          if(
           jQuery('#student_dialog').dialog('isOpen')
           && !jQuery(e.target).is('.ui-dialog, a')
           && !jQuery(e.target).closest('.ui-dialog').length
          ){
           jQuery('#student_dialog').dialog('close');
          }
             }
            );
			
			
		</script>


</head>
<body class="ui-Mainbody" style="width: 100%; height: 100%; text-align: center;">
	<%@ include file="../../jsp/includes/menuheader.jsp"%>


	<input type="hidden" id="currCourse" name="currCourse">
	<%%>
	<br>
	<br>
	<br>
	<div style="height: 600px;">
	<table align=center width="75%">
	
	<tr>
<td width="60%" style="margin-top: 0px;vertical-align:top;" >

<table id="tablepaging" class="yui" align="center">
				<thead>
					<tr>
						<th colspan="3" align="left">
							<div>
								<label><b>Upload </b></label> <input id="file" type="file"
									name="xls" />
								<button id="pre" type="button" style="margin-left: 5px;"
									onclick="uploadXLS();">
									<span>Preview</span>
								</button>
								<br> <a href="../../xlstemplates/StudentInfo_Template.xls">Student
									Information Template</a>
							</div>
						</th>
					</tr>
					<tr>
						<th colspan="3" align="left">
							<div>
								<div style="float: left;">
									<img src="plus.png" onclick="add_new_student()"
										style="cursor: pointer;" width="15px" height="15px"
										alt="button" border="0" title="Add" />&nbsp&nbsp&nbsp <img
										src="mm.png" onclick="delete_student_details()"
										style="cursor: pointer;" width="15px" height="15px"
										alt="button" border="0" title="Delete" />&nbsp&nbsp&nbsp <img
										src="Files-Edit.png" onclick="edit_student()"
										style="cursor: pointer;" width="15px" height="15px"
										alt="button" border="0" title="Edit" />
								</div>
								<div style="float: right;">
									Search By ID &nbsp&nbsp&nbsp <input type="text"
										name="search_box" id="search_box" />&nbsp&nbsp&nbsp <img
										src="Search-icon-24x24.png" onclick="search_edit_student()"
										style="cursor: pointer;" 16px" height="16px" alt="button"
										border="0" title="Search" />
								</div>
							</div>
						</th>
					<tr>

						<th>Student ID</th>
						<th>Student Name</th>
						<th>Department</th>

					</tr>
				</thead>
				<tbody>



					<%
						DatabaseConnection dbconn = new DatabaseConnection();
						Connection conn = dbconn.createDatabaseConnection();
						try {

							Statement st = conn.createStatement();
							int i = 0;
							String query1 = "SELECT sc.StudentID,s.StudentName,d.DeptName FROM student s,studentcourse sc,department d where (s.StudentID = sc.StudentID) and  (d.DeptID=s.DeptID) and (sc.CourseID='"+courseID+"')" ;
							//System.out.println("==>"+query1);
							//Original 11.20//String query1 = "select s.StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,s.DeptID,EmailID, CourseID from student s, studentcourse c where c.StudentID = s.StudentID";
							ResultSet rs = st.executeQuery(query1);
							while (rs.next()) {

								String instr_id = rs.getString(1);
								String instr_name = rs.getString(2);
								String dept = rs.getString(3);
					%>

					<tr id=<%=instr_id%> onclick="rowSelected(id)" 
						ondblclick="edit_student()">
						<td width="100"><%=instr_id%></td>
						<td align="left" width="250"><%=instr_name%></td>
						<td width="100"><%=dept%></td>
					</tr>
					<%
						i++;
							}
						} catch (Exception e) {
							e.printStackTrace();
						} finally {
							if (conn != null)
								dbconn.closeLocalConnection(conn);
						}
					%>
				</tbody>
			</table>
			
			<div id="pageNavPosition"
				style="padding-top: 20px; margin-left: 75px;text-align: center;"></div>
			

</td>

<td style="margin-top: 0px;vertical-align:top;">
<table id="tablepaging1" class="yui1">
				<thead>
					<tr>
						<th align="left">Assign Course</th>
					</tr>
				</thead>
				<tr>
					<td>
						<div>
							<input type="radio" name="IND" value="IND" onchange="ind_radio()"
								checked>Individual<br> <input type="text"
								name="search_box2" id="search_box2" />
							<button id="course_btn" type="button" onclick="do_it()">Submit</button>
							<div id="Course_div"
								style="visibility: hidden; height: 0px; width: 0px; border-collapse: collapse; border: solid 3px #7f7f7f;">
								<div id="cou_div" style="visibility: visible;"></div>
								<div class="btn2" id="close_div" onclick="stu_close()">
									<center>Close</center>
								</div>
							</div>

						</div>

					</td>
				</tr>
				<tr>
					<td>
						<div>
							<input type="radio" name="IND" value="IND" onchange="grp_radio()">Group
							(by XLS) <br><input id="course_file" type="file" name="xls" disabled /><br>
							<a href="../../xlstemplates/Student_course_Template.xls">Student
								Course Template</a>
							&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							<button id="pre_btn" type="button" style="margin-left: 5px;"
								onclick="upload_courseXLS()" disabled>Preview</button>
						</div>
					</td>
				</tr>

			</table>

</td>

</tr>

	
	</table>
	
	
	
	
	
	<div>


		<!-- <img src="new.png" id="addnew" onclick="add_new_student()" style="cursor: pointer;"
				width="32" height="32" alt="button" border="0" title="Add New" /> 
				<br>   	<br><br> -->


		<div>


			
		</div>

		<div>

			
			
			<script type="text/javascript">
			var pager = new Pager('tablepaging', 15);
pager.init();
pager.showPageNav('pager', 'pageNavPosition');
pager.showPage(1);
</script>
			<div id="student_dialog"
				style="visibility: hidden; height: 0px; width: 0px;"
				title="Response"></div>

			<div id="dialog" title="File Preview"
				style="visibility: hidden; height: 0px; width: 0px;" align="center">
				<form action="studentxlsupload.jsp" method="get" id="uploadForm">
					<iframe id="frame"> </iframe>
					<br /> <br />
					<center><input type="hidden" name=xls id="xls"> <input
							type="submit" value=" Add Student Information " />&nbsp;&nbsp;&nbsp;&nbsp;<input
							type="button" value=' Cancel ' onclick="closeDialog();" />
					</center>
				</form>
			</div>
			<div id="student_course_div" title="Student Course"
				style="visibility: hidden; height: 0px; width: 0px;" align="center">
				<form action="studentcourseupload.jsp" method="get" id="uploadForm">
					<iframe id="frame2"> </iframe>
					<br /> <br />
					<center>
						<input type="hidden" name=xls1 id="xls1"> <input
							type="submit" value=" Add Student Information " />&nbsp;&nbsp;&nbsp;&nbsp;<input
							type="button" value=' Cancel ' onclick="closeDialog();" />
					</center>
				</form>
			</div>
		</div>
	</div>
</div>
	<div style="margin-top: -600px;">
		<center><%@ include file="../../jsp/includes/menufooter.jsp"%></center>
	</div>
</body>
</html>