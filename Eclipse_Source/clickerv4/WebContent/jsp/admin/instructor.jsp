<%-- <%@page import="com.clicker.databaseconn.DatabaseConnection"%> --%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection" %>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Instructor</title>

<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<link rel="stylesheet" media="all" type="text/css" href="../../jsp/newMenu/dropdown.css" />
<script type="text/javascript" src="../../js/instructor.js"></script>
 
 <script>
		function check_err()
		{
			<%
			if(session.getAttribute("error_code")!=null)
			{
			String err=session.getAttribute("error_code").toString();
			if(err.equals("1"))
			{
				
				%>
				alert("INSTRUCTOR ID ALREADY REGISTERED WITH THIS COURSE!!!");
				<%
				session.setAttribute("error_code","0");
			}
			}
			%>
		}
        </script>
</head>

<body onload="check_err()">
	<input type="hidden" id="currCourseinst" name="currCourseinst">

<div  > 	

<%@ include file= "../../jsp/includes/menuheader.jsp" %>


<%
if(!session.getAttribute("admin").toString().equals("2")){
	request.setAttribute("Error","You are not allow to use this page");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
DatabaseConnection dbconn = new DatabaseConnection();
Connection conn = dbconn.createDatabaseConnection();
try{	
		Statement st =conn.createStatement();
		
		int i=0;
		String num=null;
		//String query1="select * from instructor" ;
		String query1 = "select i.InstrID,i.InstrName,i.DOJ,cs.DeptID,i.Designation,i.EmailID,i.MobileNo,i.AdminPriviledges, c.CourseID from instructor i, course cs, instructorcourse c where c.InstrID = i.InstrID  and c.CourseID = cs.CourseID ";// set Year instead of DOJ
		ResultSet rs=st.executeQuery(query1);
		%>
		
		<div style= "margin-top:5px;margin-left: 650px; "><font color="white" size="3" > CREATE BACKUP</font><img src="images.jpg" id="backup" width="42" height="32" onclick="location.href='back_up.jsp'" title = "DataBase Backup"/></div>
		
		<form action="" method="post">
		<table cellpadding = "10"  style="margin: 0 auto">
		<tr><td><font color = "white"><b>SEARCH BY NAME :</b></font></td><td><input type="text" name="search_box" id="search_box"/></td>
		<td><img src="searchh.jpg" onclick = "search_result_inst()" width="32" height="32" alt="button" border="0" title = "Search"/></td> </tr>
		</table>
		</form>
		<br><br>
		<form name="my_form" action = "instr_conn.jsp" method = "post">


<!-- <div style= "width:900px;color:white; margin: 0 auto;" >
		<table id="mytable" border="0" cellspacing="1" cellpadding="5" width= "100%">
		
		<tr><th width= "4%">InstrID</th><th width= "13%">Instructor Name</th><th width= "9%">Date Of Joining</th><th width= "8%">Dept ID</th>
		<th width= "8%">Designation</th><th width= "10%">Email-Id</th><th width= "7%">Mobile No.</th><th width = "5%">Admin Privileges</th><th width = "5%">Course</th>
		<th width = "4%"></th><th width = "4%"></th>
		</tr></table>
		</div> --> 
		<div id ="wrapper" style="margin: 0 auto ; overflow:auto; width:1050px; height: 290px; ">
        <table id= "my_table" border="1" style="overflow: auto;">
		<tbody>
		<tr><th width= "4%">InstrID</th><th width= "13%">Instructor Name</th><th width= "9%">Date Of Joining</th><th width= "8%">Dept ID</th>
		<th width= "8%">Designation</th><th width= "10%">Email-Id</th><th width= "7%">Mobile No.</th><th width = "5%">Admin Privileges</th><th width = "5%">Course</th>
		<th width = "4%"></th>
		</tr>
		<% 
		while(rs.next())
		{
			i++;
			num=Integer.toString(i);
			String instr_id = rs.getString(1);
			String instr_name = rs.getString(2);
			String doj = rs.getString(3);
			String dept_id = rs.getString(4);
			String desg = rs.getString(5);
			String email_id = rs.getString(6);
			String mobile = rs.getString(7);
			String admin_pri = rs.getString(8);	
			
			// commented by ajay
			/* Statement st2 =conn.createStatement();
			String query2="SELECT CourseID FROM instructorcourse where InstrID='"+ instr_id +"'";
			System.out.println(query2);
			ResultSet rs2=st2.executeQuery(query2);
			rs2.next(); */
			String course=rs.getString(9);
			
			%>
				
		<tr id="check_<%=i%>">	
			<td align="center" id = "td1_<%=i%>" width= "6%"><%=instr_id %></td>
			<td align="center" id = "td2_<%=i%>" width= "15%"><%=instr_name%></td>
			<td align="center" id = "td3_<%=i%>" width= "10%"><%=doj%></td>
			<td align="center" id = "td4_<%=i%>" width= "8%"><%=dept_id %></td>
			<td align="center" id = "td5_<%=i%>" width= "10%"><%=desg %></td>	
			<td align="center" id = "td6_<%=i%>" width= "12%"><%=email_id %></td>
			<td align="center" id = "td7_<%=i%>" width= "8%"><%=mobile %></td>
			<td align="center" id = "td8_<%=i%>" width= "15%"><%=admin_pri %></td>
			<td align="center" id = "td9_<%=i%>" width= "5%"><%=course %></td>	
			<td width= "2%"><img src="2.png" id = "e_<%=i%>" onclick = "edit_value(<%=i%>)" width="32" height="32" alt="button" border="0" title="Edit"/>
			</td>
			<td width= "2%">
			<img src="del.png" onclick = "delete_values_inst(<%=i%>)" width="32" height="32" alt="button" border="0" title="Delete"/></td>	
		</tr>
		<%
		}%>
		</tbody>
		</table>
	
	</div>
	<br></br>
		<img src="new.png" id="addnew" onclick = "add_new()" width="32" height="32" alt="button" border="0" title="Add New"/>
		<input type="hidden" name="count" id="count" value="<%=i+1%>" />
		<input type = "hidden" name = "hid" id ="hid">
		<input type = "hidden" id = "hid1" name = "hid1">
		
		<input type = "hidden" id = "btn_edit_inst" name = "btn_edit_inst">	
		<input type = "hidden" id = "btn_del_inst" name = "btn_del_inst">
		
		<input type = "hidden" id = "btn_editc" name = "btn_editc">	
	    <input type = "hidden" id = "btn_delc" name = "btn_delc">	
		<input type="hidden" id="oldinstCourseId" name="oldinstCourseId"/>
		
		
			
		<select name="dept" id="dept" size="8" multiple = "multiple" style = "width:180px;display:none" >
		<%
		String d_query="select DeptID from department";
		ResultSet rs1=st.executeQuery(d_query);
		while(rs1.next())
		{
			%>
			  <option value="<%=rs1.getString(1)%>" ><%=rs1.getString(1) %></option>
			<%			
		}
		%>
		</select>

		
				
</form>


<%
		
}
		catch(Exception e)
		{
			out.println(e);
		}finally{
			if(conn!=null)dbconn.closeLocalConnection(conn);}

		%>

		<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		
		</div>
</body>

</html>