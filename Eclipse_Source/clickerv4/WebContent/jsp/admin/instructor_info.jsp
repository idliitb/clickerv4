<%--
      @author Gobinath
DESCREPTION: it display will display when admin press the instrutor menu
			 
USE        : to display the list of instructor add in the data base and admin
			  can add ,delete and update the instructor

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
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>


<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="instructor.js"></script>
<!-- <script type="text/javascript" src="../../js/student.js"></script> -->





<%
		int count=0;	
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

<style type="text/css">
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

	for (var i = 1; i < rows.length; i++) {

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

	var pagerHtml = '<span onclick="' + pagerName + '.prev();" class="pg-normal"> « Prev </span> ';

	for (var page = 1; page <= this.pages; page++)

	pagerHtml += '<span id="pg' + page + '" class="pg-normal" onclick="' + pagerName + '.showPage(' + page + ');">' + page + '</span> ';

	pagerHtml += '<span onclick="'+pagerName+'.next();" class="pg-normal"> Next »</span>';

	element.innerHTML = pagerHtml;

	}

	}


</script>

<%
	String courseID = session.getAttribute("courseID").toString();
	Admindata getdata = new Admindata();
	String Instr_list = getdata.getInstrutorIDs();
%>

<script>



function check_int()
{
	var inst_count=document.getElementById("instcount").value;	
	if(inst_count=="1")
		window.location.assign("../../jsp/admin/institute.jsp");
	}

jQuery('html').bind('click',function(e){
	if(jQuery('#instr_dialog').dialog('isOpen')&& !jQuery(e.target).is('.ui-dialog, a')&& !jQuery(e.target).closest('.ui-dialog').length)
	{
	jQuery('#instr_dialog').dialog('close');
	}
	 }
	);

				$(function() {			
					var studList = "<%=Instr_list%>";
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
				});		
			
		</script>


</head>
<body class="ui-Mainbody" style="width: 100%; height: 100%; text-align: center;" onload="check_int();">
	<%@ include file="../../jsp/includes/menuheader.jsp"%>
	<input id="instcount"  style="visibility:hidden; width:220px;  font-size:15px; color:black" type="text" name="centerid" value = '<%=count%>' /> 
<br><br>
<div style="margin: auto; width: 70%;height:70%; border: none;">

	
		<!-- 	<div id="heade_menu">
				<table cellpadding="10" style="margin: 0 auto">
					<tr>
						<td><img src="new.png" id="addnew" onclick="add_instr()"
							style="cursor: pointer;" width="32" height="32" alt="button"
							border="0" title="Add New" /></td>
						<td><img src="del.png" onclick="delete_values_stu()"
							width="32" height="32" alt="button" border="0" title="Delete" /></td>
						<td><img src="2.png" id="e" onclick="editValue()" width="32"
							height="32" alt="button" border="0" title="Edit" /></td>
						<td><font color="white"><b>SEARCH BY ID :</b></font></td>
						<td><input type="text" name="search_box1" id="search_box1" /></td>
						<td><img src="searchh.jpg" onclick="search_inst()" width="32"
							height="32" alt="button" border="0" title="Search" /></td>
					</tr>
				</table>
			</div> -->

			<div id="inst_details">
				<div id="navBar1">
					<table id="instructor_table" class="yui" align="center">
						<thead>
							<tr>
							<th colspan="3" align="left">
								<div>
								<div style="float: left;">
									<img src="plus.png" onclick="add_instr()"
										style="cursor: pointer;" width="15px" height="15px"
										alt="button" border="0" title="Add" />&nbsp&nbsp&nbsp <img
										src="mm.png" onclick="delete_de()()"
										style="cursor: pointer;" width="15px" height="15px"
										alt="button" border="0" title="Delete" />&nbsp&nbsp&nbsp <img
										src="Files-Edit.png" onclick="editValue()"
										style="cursor: pointer;" width="15px" height="15px"
										alt="button" border="0" title="Edit" />
								</div>
								<div style="float: right;">
									Search By ID &nbsp&nbsp&nbsp <input type="text"
										name="search_box" id="search_box" />&nbsp&nbsp&nbsp <img
										src="Search-icon-24x24.png" onclick="search_inst()"
										style="cursor: pointer;" 16px" height="16px" alt="button"
										border="0" title="Search" />
								</div>
							</div>
							</th>

							</tr>
							<tr>
								<th>Instructor ID</th>
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
									String query1 = "SELECT s.InstrID,s.InstrName,d.DeptName FROM instructor s ,department d where s.DeptID=d.DeptID";
									//Original 11.20//String query1 = "select s.StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,s.DeptID,EmailID, CourseID from student s, studentcourse c where c.StudentID = s.StudentID";
									ResultSet rs = st.executeQuery(query1);
									while (rs.next()) {

										String instr_id = rs.getString(1);
										String instr_name = rs.getString(2);
										String dept = rs.getString(3);
							%>

							<tr id=<%=instr_id%> onclick="rowSelected(id)"
								ondblclick="editValue(id);">

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
					<div id="pageNavPosition" style="padding-top: 20px" align="center">
					</div>
					<script type="text/javascript">var pager = new Pager('instructor_table', 10);
pager.init();
pager.showPageNav('pager', 'pageNavPosition');
pager.showPage(1);
</script>


					<!-- <div id="instr_dialog" style="visibility: hidden" title="Response"></div> -->
				</div>
				<br>
			</div>

	
		
		
		<div id="instr_dialog" style="visibility: hidden;height: 0px;width:0px;" title="Response"></div>
	
</div>
	<div style="margin-top: -600px;">
		<center><%@ include file="../../jsp/includes/menufooter.jsp"%></center>
	</div>
</body>
</html>