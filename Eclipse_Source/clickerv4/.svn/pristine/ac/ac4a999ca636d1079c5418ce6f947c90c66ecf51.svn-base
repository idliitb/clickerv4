<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%-- <%@page import="com.clicker.databaseconn.DatabaseConnection"%> --%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table id= "my_table" border="1" bordercolor="black" cellspacing="1" cellpadding="5" width= "50%" align="center">
		<tbody>
		
<%
String search=request.getParameter("search");
String type=request.getParameter("type");
Connection conn = null;
DatabaseConnection dbconn = new DatabaseConnection();
conn = dbconn.createDatabaseConnection();
Statement st = conn.createStatement();
System.out.println("--------------"+type);
if(type.equals("dept"))
{	
		try {
				int i=0;
				String dept_id=null;
			 	String query="select DeptID,DeptName,HOD, InstiID from department where DeptName LIKE '%"+search+"%'"; 
				ResultSet rs = st.executeQuery(query);
				while(rs.next())
				{
					i++;
					
					dept_id = rs.getString(1);
					String dept_name = rs.getString(2);
					String hod = rs.getString(3);
					String insti_id = rs.getString(4);
					
					%>
				<tr><th width= "22%">DEPARTMENT ID</th><th width= "23%">  DEPARTMENT NAME</th><th width= "22%">HOD</th><th width= "19%">INSTITUTE ID</th><th width= "8%"></th><th width= "8%"></th></tr>		
				<tr id="check_<%=i%>">	
					<td align="center" id = "td1_<%=i%>" width= "21%"><%=dept_id %></td>
					<td  align="center" id = "td2_<%=i%>" width= "21%"><%=dept_name%></td>
					<td align="center" id = "td3_<%=i%>" width= "20%"><%=hod%></td>
					<td align="center" id = "td4_<%=i%>" width= "20%"><%=insti_id %></td>		
					<td width= "5%"><img src="2.png" id = "e_<%=i%>" onclick = "edit_value_dept(<%=i%>)" width="32" height="32" alt="button" border="0" /></td>
					<td width= "5%"><img src="del.png" onclick = "delete_values(<%=i%>)" width="32" height="32" alt="button" border="0" /></td>	
				</tr>
				<%}//end of while...%>
		<input type="hidden" name="count" id="count" value="<%=i+1%>" />
		<%
		
			}
		catch (Exception e) 
		{
		e.printStackTrace();
		}finally{
			if(conn!=null)dbconn.closeLocalConnection(conn);
		}
}//end of dept
else if(type.equals("course"))
{
	try {
		int i=0;
		String query="select CourseID,CourseName,CourseDesc,DeptID from course where CourseName LIKE '%"+search+"%'"; 
		ResultSet rs = st.executeQuery(query);
		while(rs.next())
		{
			i++;
			String course_id = rs.getString(1);
			String course_name = rs.getString(2);
			String desc = rs.getString(3);
			String dept_id = rs.getString(4);
			%>
			<tr>
							<th width="14%">COURSE ID</th>
							<th width="30%">COURSE NAME</th>
							<th width="30%">DESCRIPTION</th>
							<th width="14%">DEPT ID</th>
							<th width="8%"></th>
							<th width="8%"></th>
						</tr> 
			<tr id="check_<%=i%>">	
			<td align="center" id = "td1_<%=i%>" width= "21%"><%=course_id %></td>
			<td  align="center" id = "td2_<%=i%>" width= "21%"><%=course_name%></td>
			<td align="center" id = "td3_<%=i%>" width= "20%"><%=desc%></td>
			<td align="center" id = "td4_<%=i%>" width= "20%"><%=dept_id %></td>		
			<td width= "5%"><img src="2.png" id = "e_<%=i%>" onclick = "edit_value(<%=i%>)" width="32" height="32" alt="button" border="0" /></td>
			<td width= "5%"><img src="del.png" onclick = "delete_values(<%=i%>)" width="32" height="32" alt="button" border="0" /></td>	
			</tr>
		<%}//end of while...%>
		<input type="hidden" name="count" id="count" value="<%=i+1%>" />
		<%}
		catch (Exception e) 
		{
		e.printStackTrace();
		}finally{
			if(conn!=null)dbconn.closeLocalConnection(conn);
		}
	
}//end of course
else if(type.equals("inst"))
{
	%>
	<tr><th width= "4%">InstrID</th><th width= "13%">Instructor Name</th><th width= "9%">Date Of Joining</th><th width= "8%">Dept ID</th>
		<th width= "8%">Designation</th><th width= "10%">Email-Id</th><th width= "7%">Mobile No.</th><th width = "5%">Admin Privileges</th><th width = "5%">Course</th>
		<th width = "4%"></th>
		</tr>
	<%
	
	
	//out.println("instructor");
	try {
		int i=0;
		String query="select i.InstrID,i.InstrName,i.DOJ,cs.DeptID,i.Designation,i.EmailID,i.MobileNo,i.AdminPriviledges, c.CourseID from instructor i, course cs, instructorcourse c where c.InstrID = i.InstrID  and c.CourseID = cs.CourseID and i.InstrName LIKE '%"+search+"%'"; 
		ResultSet rs = st.executeQuery(query);
		while(rs.next())
		{
			i++;
			String instr_id = rs.getString(1);
			String instr_name = rs.getString(2);
			String doj = rs.getString(3);
			String dept_id = rs.getString(4);
			String desg = rs.getString(5);
			String email_id = rs.getString(6);
			String mobile = rs.getString(7);
			String admin_pri = rs.getString(8);
			String course = rs.getString(9);
			%>
				
			<tr id="check_<%=i%>">	
			<td align="center" id = "td1_<%=i%>" width= "6%"><%=instr_id %></td>
			<td align="center" id = "td2_<%=i%>" width= "15%"><%=instr_name%></td>
			<td align="center" id = "td3_<%=i%>" width= "10%"><%=doj%></td>
			<td align="center" id = "td4_<%=i%>" width= "11%"><%=dept_id %></td>
			<td align="center" id = "td5_<%=i%>" width= "10%"><%=desg %></td>	
			<td align="center" id = "td6_<%=i%>" width= "12%"><%=email_id %></td>
			<td align="center" id = "td7_<%=i%>" width= "10%"><%=mobile %></td>
			<td align="center" id = "td8_<%=i%>" width= "5%"><%=admin_pri %></td>	
			<td align="center" id = "td9_<%=i%>" width= "5%"><%=course %></td>	
			<td width= "5%"><img src="2.png" id = "e_<%=i%>" onclick = "edit_value(<%=i%>)" width="32" height="32" alt="button" border="0" /></td>
			<td width= "5%"><img src="del.png" onclick = "delete_values_inst(<%=i%>)" width="32" height="32" alt="button" border="0" /></td>
			</tr>
		<%}//end of while...%>
		<input type="hidden" name="count" id="count" value="<%=i+1%>" />
		<%}
		catch (Exception e) 
		{
		e.printStackTrace();
		}finally{
			if(conn!=null)dbconn.closeLocalConnection(conn);
		}
}//end of inst
else if(type.equals("student"))
{
	
	%>
	<tr><th width= "10%">STUDENT ID</th><th width= "8%">ROLL NO</th><th width= "16%">NAME</th><th width= "14%">JOINING</th><th width= "10%">PRIVILEDGES</th><th width= "8%">DEPT ID</th>
		<th width = "12%">EmailID</th><th width = "10%">Course</th><th width= "8%"></th><th width= "8%"></th></tr>
	<%
	
	
	try {
		int i=0;
		//String query="select StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,DeptID,EmailID from student where StudentName LIKE '%"+search+"%'";
		//11.20//String query = "select c.StudentID,s.StudentRollNo,s.StudentName,s.YearofJoining,s.Privileges,s.DeptID,s.EmailID, c.CourseID from student s, studentcourse c  where s.StudentID = c.StudentID and s.StudentName LIKE '%"+search+"%'";
		String query="select s.StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,cs.DeptID,EmailID, c.CourseID from student s, course cs, studentcourse c where c.StudentID = s.StudentID  and c.CourseID = cs.CourseID and s.StudentName LIKE'%"+search+"%' ";
		ResultSet rs = st.executeQuery(query);
		while(rs.next())
		{
			i++;
			String stud_id=rs.getString(1);
			String roll_no = rs.getString(2);
			String stud_name = rs.getString(3);
			String year= rs.getString(4);
			String privileges = rs.getString(5);
			String dept_id=rs.getString(6); 
			String email_id=rs.getString(7);
			String course=rs.getString(8);
			
			
			Statement st2 =conn.createStatement();
			
			%>
				
		<tr id="check_<%=i%>">	
			<td align="center" id = "td1_<%=i%>" width= "12%"><%=stud_id %></td>
			<td  align="center" id = "td2_<%=i%>" width= "12%"><%=roll_no%></td>
			<td align="center" id = "td3_<%=i%>" width= "15%"><%=stud_name%></td>
			<td align="center" id = "td4_<%=i%>" width= "12%"><%=year%></td>	
			<td align="center" id = "td5_<%=i%>" width= "12%"><%=privileges%></td>	
			<td align="center" id = "td6_<%=i%>" width= "12%"><%=dept_id%></td>		
			<td align="center" id = "td7_<%=i%>" width= "12%"><%=email_id%></td>	
			<td align="center" id = "td8_<%=i%>" width= "12%"><%=course%></td>
			<td width= "5%"><img src="2.png" id = "e_<%=i%>" onclick = "edit_value(<%=i%>)" width="32" height="32" alt="button" border="0" /></td>
			<td width= "5%"><img src="del.png" onclick = "delete_values_stu(<%=i%>)" width="32" height="32" alt="button" border="0" /></td>	
		</tr>
		<%}//end of while...%>
		<input type="hidden" name="count" id="count" value="<%=i+1%>" />
		
				
		<%
		
		
		
	
	
	}
		catch (Exception e) 
		{
		e.printStackTrace();
		}finally{
			if(conn!=null)dbconn.closeLocalConnection(conn);
		}
	
}
else
{
	out.println("some error!!");
}


%>
</tbody>
</table>

</body>
</html>