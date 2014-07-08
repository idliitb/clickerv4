<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<style type="text/css">
._css3m {
	display: none
}
</style>

<title>Course</title>
</head>

<%@ include file="../../jsp/includes/menuheader.jsp"%>

<script type="text/javascript" src="../../js/courses.js"></script>

<link href="../../jquery/jquery-ui.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../../jquery-ui-1.8.21.custom.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" media="all" type="text/css"	href="../../jsp/newMenu/dropdown.css" />
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript">
		function check_err()
		{
			<%if (session.getAttribute("error_code") != null) {
				String err = session.getAttribute("error_code").toString();
				if (err.equals("1")) {%>
				alert("COURSE ID ALREADY EXISTS!!!");
				<%session.setAttribute("error_code", "0");
				}
			}%>
		}
</script>

<body onload="check_err()">

	<%
	if(!session.getAttribute("admin").toString().equals("2")){
		request.setAttribute("Error","You are not allow to use this page");
		RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
		rd.forward(request, response);
		return;
	}
	DatabaseConnection dbconn = new DatabaseConnection();
	Connection conn = dbconn.createDatabaseConnection();
		try {
			
			Statement st = conn.createStatement();
			int i = 0;
			String num = null;
			String query1 = "select CourseID,CourseName,CourseDesc,DeptID from course";
			ResultSet rs = st.executeQuery(query1);
	%>
	<br>
	<div style="margin: 0 auto; height: 10px">
		<div style="margin-top: 5px; margin-left: 600px;">
			<font color="black" size="3"> CREATE BACKUP</font> <img
				src="images.jpg" id="backup" width="42" height="32"
				onclick="location.href='back_up.jsp'" title="DataBase Backup" />
		</div>
		<br>
		<form action="" method="post">
			<table style="margin: 0 auto" cellpadding="10">
				<tr>
					<td><font color="black"><b>SEARCH BY NAME :</b></font></td>
					<td><input type="text" name="search_box" id="search_box" /></td>
					<td><img src="searchh.jpg" onclick="search_result_course()"
						width="32" height="32" alt="button" border="0" title="Search" />
					</td>
				</tr>
			</table>
		</form>
		
		<form name="my_form" action="course_conn.jsp" method="post">
			<!--<div style="width: 650px; color: black; margin: 0 auto;"> 
				<table id="mytable" border="0" cellspacing="1" cellpadding="5"
					width="100%">

					  <tr><th width= "14%">COURSE ID</th><th width= "30%">COURSE NAME</th><th width= "30%">DESCRIPTION</th><th width= "14%">DEPT ID</th>
		<th width= "8%"></th><th width= "8%"></th><th width= "6%"></th></tr></table>
					</div> -->
			<br>
			<div id="wrapper" style="width: 700px; overflow:auto; height:290px;color: black; margin: 0 auto;">
				<table id="my_table" border="1" bordercolor="black" cellspacing="1"
					cellpadding="5" width="100%" align="center" >
					<tbody>
						 <tr>
							<th width="14%">COURSE ID</th>
							<th width="30%">COURSE NAME</th>
							<th width="30%">DESCRIPTION</th>
							<th width="14%">DEPT ID</th>
							<th width="8%"></th>
							<th width="8%"></th>
						</tr> 
						<%
									while (rs.next()) {
											i++;
											num = Integer.toString(i);
											String course_id = rs.getString(1);
											String course_name = rs.getString(2);
											String desc = rs.getString(3);
											String dept_id = rs.getString(4);
											//out.println("dept_id"+num);
								%>

						<tr id="check_<%=i%>">
							<td align="center" id="td1_<%=i%>" width="15%"><%=course_id%></td>
							<td align="center" id="td2_<%=i%>" width="30%"><%=course_name%></td>
							<td align="center" id="td3_<%=i%>" width="30%"><%=desc%></td>
							<td align="center" id="td4_<%=i%>" width="15%"><%=dept_id%></td>
							<td width="5%"><img src="2.png" id="e_<%=i%>" onclick="edit_value_course(<%=i%>)" width="32" height="32" alt="Edit" title="Edit" border="0" /></td>
							<td width="5%"><img src="del.png"	onclick="delete_value_course(<%=i%>)" width="32" height="32"	alt="button" border="0" title="Delete" /></td>
						</tr>
						<%
									}
								%>
					</tbody>
				</table>
</div>
				<br></br> <img src="new.png" id="addnew"
					onclick="add_new()" width="32" height="32" alt="button" border="0"
					title="Add New" /> <input type="hidden" name="count" id="count"
					value="<%=i + 1%>" /> <select name="dept" id="dept" size="8"
					multiple="multiple" style="width: 180px; display: none">
					<%
								String d_query = "select DeptID from department";
									ResultSet rs1 = st.executeQuery(d_query);
									while (rs1.next()) {
							%>
					<option value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>
					<%
								}
							%>
				</select> 
				<input type="hidden" id="hid" name="hid">
				<input type="hidden" id="hid1" name="hid1">
				<input type = "hidden" id = "hid7" name = "hid7"> <!--  set alert on delete while editing. -->
				<input type = "hidden" id = "hid8" name = "hid8"> <!--  set alert on edit while editing. -->
				<input type = "hidden" id = "hid11" name = "hid11">
				<input type = "hidden" id = "hid12" name = "hid12">  

				<%
							} catch (Exception e) {
								out.println(e);
							}finally{
								if(conn!=null)dbconn.closeLocalConnection(conn);
							}
						%>

			
		</form>
	</div>


	<!-------------------------------------------------------------------- -->
</body>

<%@ include file="../../jsp/includes/menufooter.jsp"%>
</html>