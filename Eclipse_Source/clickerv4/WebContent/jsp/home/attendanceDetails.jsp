<%--
      @author Gobinath
DESCREPTION: it will display will appear when the user press the attendance div in the have page

			 
USE        : to display present and absent list

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%@page import="clicker.v4.dashboard.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<%
	int no_of_student = 0;
	String Student_id = null;
	String name = null;
	int no_of_absent=0;
	
	if (session.getAttribute("InstructorID") == null) {
		request.setAttribute("Error", "Your session has expired.");
		RequestDispatcher rd = request
				.getRequestDispatcher("../../error.jsp");
		rd.forward(request, response);
		return;
	}

	AttendanceHelper Att_helper = new AttendanceHelper();
	String course = session.getAttribute("courseID").toString();
	//String course = "CSE101";
	no_of_student = Att_helper.getstudentList(course);
	HashSet<String> Student_List = new HashSet<String>();
	int tt=Att_helper.get_total_Studentlist(course); 
	
	if(no_of_student !=0)
	{
	Student_List = Att_helper.studentlist(course);
	Iterator it = Student_List.iterator();
	String[] Present_Sid = new String[Student_List.size()];
	try {
		DatabaseConnection dbconn1 = new DatabaseConnection();
		Connection conn1 = dbconn1.createDatabaseConnection();
		Statement st1 = conn1.createStatement();
		String query1 = "SELECT count(StudentID) from studentcourse where CourseID='"
				+ course + "'";
		ResultSet rs = st1.executeQuery(query1);
	

		while (rs.next()) {
			Student_id = rs.getString(1);
		}
		no_of_absent=Integer.parseInt(Student_id)-no_of_student;
				
		dbconn1.closeLocalConnection(conn1);
		st1.close();
		rs.close();

	} catch (Exception e) {
		out.println(e);
	}%>
<style type="text/css">
.main-container {
	width: 700px;
	height: 500px;
	border: 2px solid;
}

.left-container {
	margin: 10px;
	float: left;
	width: 45%;
	height: 90%;
	border: 2px solid; padding 15px;
	overflow: auto;
	overflow-x: hidden
}

.right-container {
	margin: 10px;
	float: right;
	width: 45%;
	height: 90%;
	border: 2px solid; padding 15px;
	overflow: auto;
	overflow-x: hidden
}
</style>

<body>



	<div class="main-container">
		<div class="left-container">

			<h3>Present :<%= no_of_student %></h3>
			<table border="1" style="width: 100%">

				<tr>
					<th>Student ID</th>
					<th>Student Name</th>
				</tr>
				<%
				int j=0;
					while (it.hasNext()) {

						String value = (String) it.next();						
						Present_Sid[j]=value;
						j++;
						DatabaseConnection dbconn1 = new DatabaseConnection();
						Connection conn1 = dbconn1.createDatabaseConnection();
						Statement st1 = conn1.createStatement();
						String query1 = "SELECT StudentName from student where StudentID='"
								+ value + "'";
						ResultSet rs = st1.executeQuery(query1);
						if (rs.next()) {							
							name = rs.getString(1);
						}
				%>
				<tr>
					<td><%=value%></td>
					<td><%=name%></td>
				</tr>
				<%
				dbconn1.closeLocalConnection(conn1);
						st1.close();
						rs.close();
						//System.out.println("Present Student id :" + value);
					}
				%>
			</table>



		</div>
		<div class="right-container">
			<h3>Absent : <%=no_of_absent%></h3>
			<table border="1" style="border: solid 3px #7f7f7f;border-collapse:collapse;font-size:small;padding: 2px;border: solid 1px #7f7f7f;width: 100%;">
				<tr>
					<th>Student ID</th>
					<th>Student Name</th>
				</tr>
				<%
					String studentid=null;
					String value = null;
					DatabaseConnection dbconn1 = new DatabaseConnection();
					Connection conn1 = dbconn1.createDatabaseConnection();
					Statement st1 = conn1.createStatement();
					String query1 = "SELECT StudentID from studentcourse where CourseID='"
							+ course + "'";
					
					ResultSet rs = st1.executeQuery(query1);
					int pre = 0;
					int size = Integer.parseInt(Student_id);
					String[] Sid = new String[size];
					while (rs.next()) {
					  studentid = rs.getString(1);						
					  Sid[pre]=studentid;					 
					  pre=pre+1;			 

					}					
					dbconn1.closeLocalConnection(conn1);
					st1.close();
					rs.close();
					int m=0;
					boolean s=false;					
					String ss=null;
					String[] Absent_student = new String[size];
					for(int i=0;i <Sid.length;i++)
					{
						for(int k=0;k <Present_Sid.length;k++)
						{
							if(Sid[i].equalsIgnoreCase(Present_Sid[k]))
									{
								      s=true;
								      break;
								      
									}else 
									{
									   s=false;
									}
							
						}						
						if(!s)
						{
							Absent_student[m]=Sid[i];
							m=m+1;						   
						}			    
						
					}
					m=m-1;
					
					
					DatabaseConnection dbconn4 = new DatabaseConnection();
					Connection conn4 = dbconn4.createDatabaseConnection();
					Statement st4 = conn4.createStatement();
					ResultSet rs4;
					
				for(int l=0;l<m;l++)
					{
					String query4 = "SELECT StudentName from student where StudentID='"+Absent_student[l]+"'";
					 rs4 = st4.executeQuery(query4);
					if (rs4.next()) {							
						name = rs4.getString(1);
						
					}
					%>	
				<tr>
					<td><%= Absent_student[l]%></td>
					<td><%=name %></td>
				</tr>
				<%
					}
				dbconn4.closeLocalConnection(conn4);
				%>
				</table>
		</div>
	</div>
				
				<%
	} else
	{
		
	
		String studentid=null;
		String value = null;
		DatabaseConnection dbconn1 = new DatabaseConnection();
		Connection conn1 = dbconn1.createDatabaseConnection();
		Statement st1 = conn1.createStatement();
		String query1 = "SELECT StudentID from studentcourse where CourseID='"
				+ course + "'";
		
		ResultSet rs = st1.executeQuery(query1);
		int pre = 0;
		
		String[] Sid = new String[tt];
		
		%>
		
		<div class="right-container">
			<h3>Absent : <%=tt%></h3>
			<table border="1" style="border: solid 3px #7f7f7f;border-collapse:collapse;font-size:small;padding: 2px;border: solid 1px #7f7f7f;width: 100%;">
				<tr>
					<th>Student ID</th>
					<th>Student Name</th>
				</tr>
				
		<%
		while (rs.next()) {
		  studentid = rs.getString(1);	
		  Sid[pre]=studentid;					 
		  pre=pre+1;			 

		}					
		dbconn1.closeLocalConnection(conn1);
		st1.close();
		rs.close();
		
		pre=pre-1;	
		DatabaseConnection dbconn4 = new DatabaseConnection();
		Connection conn4 = dbconn4.createDatabaseConnection();
		Statement st4 = conn4.createStatement();
		ResultSet rs4;
		
	for(int l=0;l<pre;l++)
		{
		
		String query4 = "SELECT StudentName from student where StudentID='"+Sid[l]+"'";
		rs4 = st4.executeQuery(query4);
		if (rs4.next()) {							
			name = rs4.getString(1);		
			
		}
		
		%>
		
		<tr>
					<td><%=Sid[l] %></td>
					<td><%=name %></td>
				</tr>
		
		<%
			
		
	}
	
	dbconn4.closeLocalConnection(conn4);
	st1.close();
	rs.close();
	}
				%>
				
				</table>
				</div>				
				
				
				
			

</body>
</html>