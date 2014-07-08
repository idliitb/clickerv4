<%-- <%@page import="com.clicker.databaseconn.DatabaseConnection"%> --%>
<%@page import="clicker.v4.databaseconn.DatabaseConnection" %>
<%@page import="java.sql.*"%>
<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server
	response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance
	response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility

	String InstructorID = (String) session.getAttribute("InstructorID");
    session.setAttribute("insid",InstructorID);
	System.out.println("Instructor ID is : " + InstructorID);

	/* if (InstructorID == null) {
		request.setAttribute("Error","Your session has expired.");
		RequestDispatcher rd = request.getRequestDispatcher("../../jsp/errorpages/Error.jsp");
		rd.forward(request, response);
	} */
	System.out.println("Course ID :"+(String)session.getAttribute("courseID"));
	System.out.println((String)session.getAttribute("Usertype"));
%> --%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
DatabaseConnection dbconn = new DatabaseConnection();
Connection conn = dbconn.createDatabaseConnection();
try
{
	
	Statement st =conn.createStatement();
	String type = request.getParameter("hid");
	
	if(type.equals("1")) // update
	{
			String stud_id = request.getParameter("edit_txt1");
			
			String rollno = request.getParameter("edit_txt2");
			String stud_name = request.getParameter("edit_txt3");
			String year = request.getParameter("edit_txt4");
			int priviledges = Integer.parseInt(request.getParameter("edit_txt5"));
			
			String dept_id = request.getParameter("edit_txt6");
			String email = request.getParameter("edit_txt7");
			String course = request.getParameter("edit_txt8");
			System.out.println("My Dept "+dept_id);
			
			String courseold=request.getParameter("oldCourseId");
			String queryupdate=" select * from student where StudentID='"+stud_id+"'";
			ResultSet rs=st.executeQuery(queryupdate);
			int k=0;
			while(rs.next())
			{
				k++;	
			}
			if(k==1) // duplicate student id
			{	
				System.out.println(" update Student id is already exist!!"); 
				String strquery="select * from student s, studentcourse c where c.StudentID = s.StudentID and s.StudentID= '"+stud_id+"' and c.CourseID = '"+course+"'";
				ResultSet rscheck =st.executeQuery(strquery);
				int q=0;
				
				while(rscheck.next())
				{
					q++;					
				}
				
				if(q != 0)
				{
					String query1 = "Update student set StudentRollNo='"+rollno+"', StudentName='"+stud_name+"', YearofJoining= '"+year+"', Privileges = '"+priviledges+"',DeptID='"+ dept_id +"',EmailID = '"+email+"' where StudentID ='"+stud_id+"'";
					int rs1=st.executeUpdate(query1);
					if((rs1!=0))
					{
						System.out.println("Successful updated into student");
						
					}
					else{
						out.println(" Not Successful");
					}
					
					System.out.println("Redirecting to student page!!");
					session.setAttribute("error_code","1");
					response.sendRedirect("student.jsp");
					
				}
				else					
				{ 
					String query1 = "Update student set StudentRollNo='"+rollno+"', StudentName='"+stud_name+"', YearofJoining= '"+year+"', Privileges = '"+priviledges+"',DeptID='"+ dept_id +"' ,EmailID = '"+email+"' where StudentID ='"+stud_id+"'";
					int rs1=st.executeUpdate(query1);
					if((rs1!=0))
					{
						System.out.println("Successful updated into student");
						
					}
					else{
						out.println(" Not Successful");
					}
					System.out.println("Next query will fire with ABC: "+courseold);
					String query2="update studentcourse set CourseID='"+course +"' where StudentID='"+stud_id +"' and CourseID='"+courseold +"'";
					int rs2=st.executeUpdate(query2);
					if((rs2!=0))
					{
						System.out.println("Successful updated into studentcourse ");
						
					}
					else
						out.println(" Not Successful");
					
					response.sendRedirect("student.jsp");	
					 
				}
			}
			
	}
	else
	if(type.equals("2")) //insert
	{
		String stud_id = request.getParameter("new_value_1");
		String rollno = request.getParameter("new_value_2");
		String stud_name = request.getParameter("new_value_3");
		String year = request.getParameter("new_value_4");
		String priviledges = request.getParameter("new_value_5");
		String dept_id = request.getParameter("new_value_6");
		String email = request.getParameter("new_value_7");
		String course=request.getParameter("text61");
		String pass="abc"+stud_id;
		
		
		String query3=" select * from student where StudentID='"+stud_id+"'";
		
		
		ResultSet rs=st.executeQuery(query3);
		int i=0;
		while(rs.next())
		{
			i++;
			
		}
		
		if(i==1) // duplicate student id
		{	out.println("Student id is already exist!!");
			session.setAttribute("error_code","1");
			
%>
<%
		
			String strquery=" select s.StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,s.DeptID,EmailID, CourseID from student s, studentcourse c where c.StudentID = s.StudentID and s.StudentID= '"+stud_id+"' and c.CourseID = '"+course+"'";
			ResultSet rscheck =st.executeQuery(strquery);
			int r=0;
			while(rscheck.next())
			{
				r++;
				
			}
			if(r != 0)
			{
				
				System.out.println("Redirecting to student page!!");
				session.setAttribute("error_code","1");
				response.sendRedirect("student.jsp");
				
			}
			else
				
			{
				String strquerysc ="insert into studentcourse(Year,Semester,CourseID,StudentID) values('"+year+"','Spring','"+course+"','"+stud_id+"') " ;
				int resultset1 =st.executeUpdate(strquerysc);
				
				if(resultset1!=0)
				{
					System.out.println("Successful inserted into Student Course Only!!");
					
				}
				else
				{
					System.out.println(" Not Successful!!");
				}
				response.sendRedirect("student.jsp");	
				
				
			}
		}
		else
		{
			String query2="insert into student(StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,DeptID,Password,Status,EmailID,MacAddress) values('"+stud_id+"','"+rollno+"','"+stud_name+"','"+year+"','"+priviledges+"','"+dept_id+"','"+pass+"',0,'"+email+"','') " ;
			int rs2=st.executeUpdate(query2);
			if(rs2!=0)
			{
				System.out.println("Successful!! inserted into Student table");
			}
			else
			{
				System.out.println(" Not Successful!!");
			}
			String query4="insert into studentcourse(Year,Semester,CourseID,StudentID) values('"+year+"','Spring','"+course+"','"+stud_id+"') " ;
			int rs4=st.executeUpdate(query4);
			if(rs4!=0)
			{
				System.out.println("Successful!! inserted into studentcourse");
			}
			else
			{
				System.out.println(" Not Successful!!");
			}
			
			
			
			response.sendRedirect("student.jsp");
		}
	}//end of type 2
	else
		if (type.equals("3")) //delete
		{
				String stud_id=request.getParameter("hid1");
				
				String courseolddel=request.getParameter("oldCourseId"); 
				System.out.println("Old course in conn" + courseolddel);
				
				
				String query=" select * from studentcourse where StudentID='"+stud_id+"'";

				ResultSet rs=st.executeQuery(query);
				int i=0;
				while(rs.next())
				{
					i++;
					
				}
				
				if(i==1) // duplicate student id
				{	
					
					System.out.println("Student id is already exist!!");
				
					String query4 = "DELETE from studentcourse where StudentID = '"+stud_id+"'";
					System.out.println(query4);
					int rs4 = st.executeUpdate(query4);
				
					String query3 = "DELETE from student where StudentID = '"+stud_id+"'";
					System.out.println(query3);
					int rs3 = st.executeUpdate(query3);
					if(rs3!=0)
					{
						out.println("Successful");					
					}
					else
					{
						out.println(" Not Successful");
					}
					
										
				}
				else{
					
					
					String query4 = "DELETE from studentcourse where StudentID = '"+stud_id+"' and CourseID ='"+courseolddel+"'";
					System.out.println(query4);
					int rs4 = st.executeUpdate(query4);
				}
				response.sendRedirect("student.jsp");	
		}
		
}
catch(Exception e)
{
	out.println(e);
	e.printStackTrace();
}
finally
{
	dbconn.closeLocalConnection(conn);
}
%>
</body>
</html>