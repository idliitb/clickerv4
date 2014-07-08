<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*,javax.swing.*"%>

<%
DatabaseConnection dbconn = new DatabaseConnection();
Connection conn = dbconn.createDatabaseConnection();
try
{
	
		Statement st =conn.createStatement();
	String type = request.getParameter("hid");
	if(type.equals("1"))
	{
			String course_id = request.getParameter("edit_txt1");
			//out.println(dept_id);
			String course_name = request.getParameter("edit_txt2");
			String course_desc = request.getParameter("edit_txt3");
			String dept_id = request.getParameter("edit_txt4");
				System.out.println("Im in update");
				String query1 = "Update course set CourseName='"+course_name+"', CourseDesc= '"+course_desc+"', DeptID = '"+dept_id+"' where CourseID ='"+course_id+"'";
				int rs1=st.executeUpdate(query1);
				if((rs1!=0))
				{
					out.println("Successful");
					
				}
				else
					out.println(" Not Successful");
				response.sendRedirect("courses.jsp");
	}
	else
	if(type.equals("2"))
	{
		String course_id=request.getParameter("new_value_1");
		String course_name=request.getParameter("new_value_2");
		String course_desc=request.getParameter("new_value_3");
		String dept_id=request.getParameter("new_value_4");
		String query3=" select * from course where CourseID='"+course_id+"'";
		ResultSet rs=st.executeQuery(query3);
		int i=0;
		while(rs.next())
		{
			i++;
		}
		
		if(i==1)
		{	//out.println("hello");
			session.setAttribute("error_code","1");
			response.sendRedirect("courses.jsp");
		}
		else
		{
		
		String query2="insert into course(CourseID,CourseName,CourseDesc,DeptID) values('"+course_id+"','"+course_name+"','"+course_desc+"','"+dept_id+"') " ;
		int rs2=st.executeUpdate(query2);
		if(rs2!=0)
		{
			System.out.println("Successful!!");
		}
		else
		{
			System.out.println(" Not Successful!!");
		}
		
		response.sendRedirect("courses.jsp");
		}
		
	}//end of type 2
	else
		if (type.equals("3"))
		{
			//////////////////////////////////////////////////////////////////////
		
			Statement stone = conn.createStatement();
			Statement sttwo = conn.createStatement();
			
			 String course_id=request.getParameter("hid1");
			
			int sum[] = {0,0};

			//Statements for deleting
			Statement stmtdel = conn.createStatement();
			Statement stdelone = conn.createStatement();
			Statement stdeltwo = conn.createStatement();
			Statement stdelc = conn.createStatement();
			
			
				//System.out.println("no of coursess: "+sum[0]);
				int instr_sum = 0;
				int stud_sum = 0;
				String query1 = "select COUNT(*) from instructorcourse where CourseID='"+course_id+"'";
				ResultSet rsdel1 = stone.executeQuery(query1); 
				while (rsdel1.next()) { // getting count of instructor of current course.
					int inst_count = rsdel1.getInt(1);
					sum[0] = inst_count;
					//System.out.println("no of inst: "+ sum[0]);
					
				}
				
				String query2 = "select COUNT(*) from studentcourse where CourseID='"+course_id+"'";
				ResultSet rsdel2 = sttwo.executeQuery(query2); 
				while (rsdel2.next()) { // getting count of student of current course.
					int stud_count = rsdel2.getInt(1);
					sum[1] = stud_count;
					//System.out.println("no of stud: "+ sum[2]);
				}
			
			System.out.println("Course: "+course_id+" instr: "+sum[0]+" stud: "+sum[1]);
			//JOptionPane.showMessageDialog(null,"Please delete following number of entries in respective tables.\n\nCourse:"+course_id+"\nNo. of instructors:"+sum[0]+"\nNo. of students:"+sum[1]);
			//response.sendRedirect("courses.jsp");
			out.print("Please delete following number of entries in respective tables.\n\nCourse:"+course_id+"\nNo. of instructors:"+sum[0]+"\nNo. of students:"+sum[1]);
				/////////////////AJAY/////////////
				
				/* String course_id=request.getParameter("hid1");
				String queryone = "Delete from instructorcourse where CourseID='"+course_id+"'";
				int rs_del1 = stmtcdel.executeUpdate(queryone); 
				
				String querytwo = "Delete from studentcourse where CourseID='"+course_id+"'";
				int rs_del2 = stdelctwo.executeUpdate(querytwo); 
				
				
				String queryc = "Delete from course where CourseID='"+course_id+"'";
				int rs_delc = stmtcdel.executeUpdate(queryc);  */
			/////////////////AJAY////////////////////////////////////////////////
				/*String course_id=request.getParameter("hid1");
				String query3 = "DELETE from course where CourseID = '"+course_id+"'";
				int rs3 = st.executeUpdate(query3);
				if(rs3!=0)
				{
					out.println("Successful");
					
				}
				else
				{
					out.println(" Not Successful");
				} */
			
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
