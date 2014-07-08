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


</head>

<%@ include file="../../jsp/includes/menuheader.jsp"%>


<script type="text/javascript" src="../../js/dept.js"></script>
<link href="../../jquery/jquery-ui.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../../jquery-ui-1.8.21.custom.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" media="all" type="text/css"	href="../../jsp/newMenu/dropdown.css" />
<!-- <script src="../../jquery/jquery-1.5.min.js"></script>
<script src="../../jquery/jquery-1.8.19-ui.min.js"></script> -->
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript">
		function msg()
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

<body>

	<%
			String titles[];
			titles = new String[3];
			
			titles[0] = "StudentCourse";
			titles[1] = "InstructorCourse";
			titles[2] = "Course";
			int sum[] = {0,0,0};
			//ArrayList<Integer> sum = new ArrayList<Integer>();
			DatabaseConnection dbconn = new DatabaseConnection();
			Connection conn = dbconn.createDatabaseConnection();
		try {
			
			Statement st = conn.createStatement();
			Statement stone = conn.createStatement();
			Statement sttwo = conn.createStatement();
			int i = 0,j = 2,k = 2;
			String num = null;
			String query = "select CourseID from course where DeptID= 'dept001'";
			ResultSet rs = st.executeQuery(query);
			/* String query1 = "select count(CourseID) from studentcourse where CourseID= 'Course-A'";
			ResultSet rs = st.executeQuery(query1);
			String query2 = "select COUNT(*) from instructorcourse where CourseID= 'Course-A'";
			ResultSet rs2 = st.executeQuery(query2); */
	%>
	<br>
	<div style="margin: 0 auto; height: 10px">
		<!-- <div style="margin-top: 5px; margin-left: 600px;">
			<font color="black" size="3"> CREATE BACKUP</font> <img
				src="images.jpg" id="backup" width="42" height="32"
				onclick="location.href='back_up.jsp'" title="DataBase Backup" />
		</div> -->
		<!-- <br>
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
		</form> -->
		
		<form name="my_delete_form" action="dept_conn.jsp" method="post">
			<div id="wrapper" style="width: 700px; overflow:auto; height:290px;color: black; margin: 0 auto;">
				<table id="my_table" border="1" bordercolor="black" cellspacing="1"
					cellpadding="5" width="100%" align="center" >
					<tbody>
						 <tr>
							<th width="14%"></th>
							<th width="30%">Number of Records</th>
							<th width="30%">Delete</th>
							<th width="14%">Show Records</th>
							
						</tr> 
						<%
									while (rs.next()) { // getting course in selected department
											i++;
											//////////////////////////////
											String c_id = rs.getString(1);
											sum[0] = i;
											System.out.println("no of coursess: "+sum[0]);
											int instr_sum = 0;
											int stud_sum = 0;
											String query2 = "select COUNT(*) from instructorcourse where CourseID='"+c_id+"'";
											ResultSet rs2 = stone.executeQuery(query2); 
											while (rs2.next()) { // getting count of instructor of current course.
												int inst_count = rs2.getInt(1);
												
												//sum.add( sum.get(j) + inst_count);
												sum[1] = sum[1] + inst_count;
												System.out.println("no of inst: "+ sum[1]);
												
											}
											
											String query3 = "select COUNT(*) from studentcourse where CourseID='"+c_id+"'";
											ResultSet rs3 = sttwo.executeQuery(query3); 
											while (rs3.next()) { // getting count of student of current course.
												int stud_count = rs3.getInt(1);
												
												sum[2] = sum[2] + stud_count;
												System.out.println("no of stud: "+ sum[2]);
											}
								%>

						 <%-- <tr id="check_<%=i%>">
							<td align="center" id="td1_<%=i%>" width="15%"><%=titles[i-1] %></td>
							<td align="center" id="td2_<%=i%>" width="30%"><%=sum[k]%></td>
							 <td width="5%"><img src="2.png" id="e_<%=i%>" onclick="edit_value_course(<%=i%>)" width="32" height="32" alt="Edit" title="Edit" border="0" /></td>
							<td width="5%"><img src="del.png"	onclick="delete_value_course(<%=i%>)" width="32" height="32"	alt="button" border="0" title="Delete" /></td>
							<td width="5%"><img src="del.png"	onclick="delete_value_course(<%=i%>)" width="32" height="32"	alt="button" border="0" title="Delete" /></td>							
						</tr>  --%>
						<% 
						
						
								}
						System.out.println("Course: "+sum[0]+" instr: "+sum[1]+" stud: "+sum[2]);
						int p = 2;
						for(int q=1;q<=3;q++)
						{
							
						
								%>
							<tr id="check_<%=q%>">
								<td align="center" id="td1_<%=q%>" width="15%"><%=titles[q-1] %></td>
								<td align="center" id="td2_<%=q%>" width="30%"><%=sum[p]%></td>
								<td width="5%"><img src="del.png"	onclick="delete_values(<%=q%>)" width="32" height="32"	alt="button" border="0" title="Delete" /></td>
							</tr>
							<%
							p--;
						}
							%>
							
							<ul id="tree">
			
			<li>
				<label> <input type="checkbox" /> Department </label>
				<ul>
					<li>
						<label>
							<input type="checkbox" />dept001
						</label>
						<ul>
							<li>
								<label>
									<input type="checkbox" checked="checked" />Элемент с чекбоксом
								</label>
							</li>
						</ul>
					</li>
					<li>
						<label>
							<input type="checkbox" />dept002
						</label>
						<ul>
							<li>
								<label>
									<input type="checkbox" checked="checked" />Элемент с чекбоксом
								</label>
							</li>
							<li>
								<label>
									<input type="checkbox" />Элемент с чекбоксом
								</label>
							</li>
							<li>
								<label>
									<input type="checkbox" />Элемент с чекбоксом
								</label>
							</li>
						</ul>
					</li>
					<li>
						<label>
							<input type="checkbox" />Подкатегория с чекбоксом
						</label>
						<ul>
							<li>
								<label>
									<input type="checkbox" />Элемент с чекбоксом
								</label>
							</li>
							<li>
								<label>
									<input type="checkbox" />Элемент с чекбоксом
								</label>
							</li>
							<li>
								<label>
									<input type="checkbox" />Элемент с чекбоксом
								</label>
							</li>
						</ul>
					</li>
				</ul>
			</li>
		</ul>
							
							
							
							
							
							
					</tbody>
				</table>
</div>
				
				
				<input type = "hidden" id = "hiddept" name = "hiddept">  

				<%
				
							} catch (Exception e) {
								out.println(e);
							}
		finally
		{
			dbconn.closeLocalConnection(conn);
		}
						%>

			
		</form>
	</div>


	<!-------------------------------------------------------------------- -->
</body>

<%@ include file="../../jsp/includes/menufooter.jsp"%>
</html>