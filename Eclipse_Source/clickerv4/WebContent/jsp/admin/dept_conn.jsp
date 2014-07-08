<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*,javax.swing.*"%>

<%
int sum[] = {0,0,0};
int sumdel[] = {0,0,0};
DatabaseConnection dbconn = new DatabaseConnection();
Connection conn = dbconn.createDatabaseConnection();
try
{
	
		Statement st =conn.createStatement();
	String type = request.getParameter("hid");
	
	if(type.equals("1"))
	{
			String dept_id = request.getParameter("edit_txt1");
			//out.println(dept_id);
			String dept_name = request.getParameter("edit_txt2");
			String hod = request.getParameter("edit_txt3");
			String insti_id = request.getParameter("edit_txt4");
			
				String query1 = "Update department set DeptName='"+dept_name+"', HOD= '"+hod+"',InstiID='"+insti_id+"' where DeptID ='"+dept_id+"'";
				int rs1=st.executeUpdate(query1);
				if((rs1!=0))
				{
					out.println("Successful");
					
				}
				else
					out.println(" Not Successful");
				response.sendRedirect("department.jsp");
	}
	else
	if(type.equals("2"))
	{
		String dept_id=request.getParameter("new_value_1");
		String dept_name=request.getParameter("new_value_2");
		String hod=request.getParameter("new_value_3");
		String inst_id=request.getParameter("new_value_4");
		String query3=" select * from department where DeptId='"+dept_id+"'";
		ResultSet rs=st.executeQuery(query3);
		int i=0;
		while(rs.next())
		{
			i++;
		}
		
		if(i==1)
		{	//out.println("hello");
			session.setAttribute("error_code","1");
			response.sendRedirect("department.jsp");
		}
		else
		{
		
		String query2="insert into department(DeptID,DeptName,HOD,InstiID) values('"+dept_id+"','"+dept_name+"','"+hod+"','"+inst_id+"') " ;
		int rs2=st.executeUpdate(query2);
		if(rs2!=0)
		{
			out.println("Successful!!");
		}
		else
		{
			out.println(" Not Successful!!");
		}
		
		response.sendRedirect("department.jsp");
	}}//end of type 2
	else
		if (type.equals("3"))
		{
			///////////////////////////////////////////////////////
			String deptid=request.getParameter("hid1");
			String titles[];
			titles = new String[3];
			
			titles[0] = "StudentCourse";
			titles[1] = "InstructorCourse";
			titles[2] = "Course";
			//int sum[] = {0,0,0};
			
			Statement stmt = conn.createStatement();
			Statement stone = conn.createStatement();
			Statement sttwo = conn.createStatement();
			
			//Statements for deleting
			Statement stmtdel = conn.createStatement();
			Statement stdelone = conn.createStatement();
			Statement stdeltwo = conn.createStatement();
			Statement stdelc = conn.createStatement();
			
			int i = 0,j = 2,k = 2;
			
			String query = "select CourseID from course where DeptID='"+deptid+"'";
			ResultSet rsdel = stmt.executeQuery(query);
			
			while (rsdel.next()) { // getting course in selected department
				i++;
				//////////////////////////////
				String c_id = rsdel.getString(1);
				sum[0] = i;
				//System.out.println("no of coursess: "+sum[0]);
				int instr_sum = 0;
				int stud_sum = 0;
				String query2 = "select COUNT(*) from instructorcourse where CourseID='"+c_id+"'";
				ResultSet rsdel2 = stone.executeQuery(query2); 
				while (rsdel2.next()) { // getting count of instructor of current course.
					int inst_count = rsdel2.getInt(1);
					
					//sum.add( sum.get(j) + inst_count);
					sum[1] = sum[1] + inst_count;
					//System.out.println("no of inst: "+ sum[1]);
					
				}
				
				String query3 = "select COUNT(*) from studentcourse where CourseID='"+c_id+"'";
				ResultSet rsdel3 = sttwo.executeQuery(query3); 
				while (rsdel3.next()) { // getting count of student of current course.
					int stud_count = rsdel3.getInt(1);
					sum[2] = sum[2] + stud_count;
					//System.out.println("no of stud: "+ sum[2]);
				}
			}
			System.out.println("Course: "+sum[0]+" instr: "+sum[1]+" stud: "+sum[2]);
			//JOptionPane.showMessageDialog(null,"Please delete following number of entries in respective tables.\n\nDepartment:"+deptid+"\nNo. of Courses:"+sum[0]+"\nNo. of Instructors:"+sum[1]+"\nNo. of Students:"+sum[2]);
			out.print("Please delete following number of entries in respective tables.\n\nDepartment:"+deptid+"\nNo. of Courses:"+sum[0]+"\nNo. of Instructors:"+sum[1]+"\nNo. of Students:"+sum[2]);
			//response.sendRedirect("department.jsp");
			
			/* int b=JOptionPane.showConfirmDialog(null, "Really want to delete?\n Department:"+deptid+"\nNo. of Courses:"+sum[0]+"\nNo. of Instructors:"+sum[1]+"\nNo. of Students:"+sum[2],"Delete",JOptionPane.YES_NO_OPTION);
			  // TODO add your handling code here:
			if(b==JOptionPane.YES_OPTION)
			{
			    //CODE WHICH WILL BE CALLED ONCE YES IS PRESSED
				String queryone = "select CourseID from course where DeptID='"+deptid+"'";
				ResultSet rs_del = stmtdel.executeQuery(queryone);
				
				while (rs_del.next()) { // getting course in selected department
					i++;
					//////////////////////////////
					String c_id = rs_del.getString(1);
					sumdel[0] = i;
					//System.out.println("no of coursess: "+sum[0]);
					int instr_sum = 0;
					int stud_sum = 0;
					String querytwo = "Delete from instructorcourse where CourseID='"+c_id+"'";
					int rs_del2 = stdelone.executeUpdate(querytwo); 
					
					String querythree = "Delete from studentcourse where CourseID='"+c_id+"'";
					int rs_del3 = stdeltwo.executeUpdate(querythree); 
					
					
					String queryc = "Delete from course where CourseID='"+c_id+"'";
					int rs_delc = stdelc.executeUpdate(queryc); 
				}
				String queryfour = "Delete from department where DeptID='"+deptid+"'";
				int rs_del3 = stdeltwo.executeUpdate(queryfour);  
				response.sendRedirect("department.jsp");
				 
			}
			else
			{
			    //CODE WHICH WILL BE CALLED ONCE NO IS PRESSED
				response.sendRedirect("department.jsp");
				 
			}
			
			
			 */
			
			
			//session.setAttribute("error_code","2");
			
			
			
			
			////////////////AJAY//////////////////////////////////////
			//Commented , not confirmed !!!
			
			/* String queryone = "select CourseID from course where DeptID='"+deptid+"'";
			ResultSet rs_del = stmtdel.executeQuery(queryone);
			
			while (rs_del.next()) { // getting course in selected department
				i++;
				//////////////////////////////
				String c_id = rs_del.getString(1);
				sumdel[0] = i;
				//System.out.println("no of coursess: "+sum[0]);
				int instr_sum = 0;
				int stud_sum = 0;
				String querytwo = "Delete from instructorcourse where CourseID='"+c_id+"'";
				int rs_del2 = stdelone.executeUpdate(querytwo); 
				
				String querythree = "Delete from studentcourse where CourseID='"+c_id+"'";
				int rs_del3 = stdeltwo.executeUpdate(querythree); 
				
				
				String queryc = "Delete from course where CourseID='"+c_id+"'";
				int rs_delc = stdelc.executeUpdate(queryc); 
			}
			String queryfour = "Delete from department where DeptID='"+deptid+"'";
			int rs_del3 = stdeltwo.executeUpdate(queryfour);  */
			////////////AJAY///////////////////////////////////////////
			
			
			
			   /*  String deptid=request.getParameter("hid1");
				String query3 = "DELETE from department where DeptID = '"+deptid+"'";
				System.out.println("gobianth----------------"+query3);
				int rs3 = st.executeUpdate(query3);
				if(rs3!=0)
				{
					out.println("Successful");
					
				}
				else
				{
					out.println(" Not Successful");
				}
				response.sendRedirect("department.jsp");
				
				 */
				
			
				
		}
		
}
catch(Exception e)
{
	out.println(e);
}
finally
{
	dbconn.closeLocalConnection(conn);	
}
%>