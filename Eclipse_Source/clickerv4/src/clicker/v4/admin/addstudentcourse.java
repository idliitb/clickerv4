/* Author : Gobianth M
 * Use :for adding the student details
 *  
 */
package clicker.v4.admin;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import clicker.v4.databaseconn.*;

import java.sql.*;

/**
 * Servlet implementation class addstudentcourse
 */
public class addstudentcourse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addstudentcourse() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		
		String student_id=request.getParameter("StudentID");
		String course_id=request.getParameter("CourseID");
		String year_of_join=request.getParameter("year_of_join");
		String flag=request.getParameter("Flag");
		String email_id=request.getParameter("email_id");		
		String student_name=request.getParameter("Student_name");
		String roll_no=request.getParameter("roll_no");
		String dept_id=request.getParameter("dept_id");		
		String TA=request.getParameter("TA");
		String M_no=request.getParameter("m_no");
		
		//System.out.println("Course ID=========================================================>"+course_id);	
		
		System.out.println("student_id"+student_id);	
		//System.out.println("roll_no"+roll_no);	
		//System.out.println("student_name"+student_name);	
		//System.out.println("year_of_join"+year_of_join);	
		//System.out.println("T_A"+TA);	
		//System.out.println("dept_id"+dept_id);	
		System.out.println("Course ID"+course_id);	
		//System.out.println("Email ID"+email_id);
	
		
		
		
		int T_A=0;
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection conn = dbconn.createDatabaseConnection();
		if(flag.equalsIgnoreCase("1"))
		{
		try {
			System.out.println("==================Delete==================");
			Statement st = conn.createStatement();
			String query3 = "DELETE from studentcourse where StudentID ='"+student_id+"' and CourseID='"+course_id+"'";
			System.out.println(query3);
			int rs3 = st.executeUpdate(query3);
			if(rs3!=0)
			{
				System.out.println("Successfull deleted");		
				
			}else
			{			   
				System.out.println("Delete UnSuccessful");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}else if(flag.equalsIgnoreCase("3"))
		{
			
			String query1 = "Update student set MacAddress='' where StudentID ='"+student_id+"'";
			
			int rs1;
			try {
				Statement st = conn.createStatement();
				rs1 = st.executeUpdate(query1);
				if((rs1!=0))
				{
					System.out.println("Successful successfully mac ID Removed ====>"+student_id);
					
				}
				else{
					System.out.println(" Not Successful");
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}else  if(flag.equalsIgnoreCase("4"))
		{
			
		
			if(TA.equalsIgnoreCase("Yes"))
			{
				T_A=1;
			}else				
				T_A=0;
			Statement st;
			try {
				st = conn.createStatement();
				String query1 = "Update student set StudentRollNo='"+roll_no+"', StudentName='"+student_name+"', YearofJoining= '"+year_of_join+"', Privileges = '"+T_A+"',EmailID = '"+email_id+"' where StudentID ='"+student_id+"'";
				//System.out.println(query1);
				int rs1=st.executeUpdate(query1);
				if((rs1!=0))
				{
					System.out.println("Successful updated into student");
					
				}
				else{
					System.out.println(" Not Successful");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}else if(flag.equalsIgnoreCase("5"))
		{
			
				
			String query2="insert into student(StudentID,StudentRollNo,StudentName,YearofJoining,Privileges,DeptID,Password,Status,EmailID,MacAddress) values('"+student_id+"','"+roll_no+"','"+student_name+"','"+year_of_join+"','"+T_A+"','"+dept_id+"','"+M_no+"',0,'"+email_id+"','') " ;
	      // System.out.println(strquerysc);
			System.out.println(query2);
			try {
				Statement st = conn.createStatement();
				int rs4 = st.executeUpdate(query2);
				if(rs4!=0)
				System.out.println("Student record Added");
				else
					System.out.println("unsuccessfull!!");
				String strquerysc ="insert into studentcourse(Year,Semester,CourseID,StudentID) values('"+year_of_join+"','Spring','"+course_id+"','"+student_id+"') " ;
				//System.out.println(strquerysc);
				st = conn.createStatement();
				int rs1=st.executeUpdate(strquerysc);
				if(rs1!=0)
					System.out.println("Student course record Added");
					else
						System.out.println("unsuccessfull");
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
			
			
		}else if(flag.equalsIgnoreCase("6"))
		{
			
			String query4 = "DELETE from studentcourse where StudentID = '"+student_id+"'";
			//System.out.println(query4);
			Statement st;
			try {
				st = conn.createStatement();
				int rs4 = st.executeUpdate(query4);
				
				
				String query2="DELETE from raisehand where StudentID ='"+student_id+"'";
				int rs2=st.executeUpdate(query2);
				
				
				
				String query3="DELETE from attendance where StudentID ='"+student_id+"'";
				int rs3=st.executeUpdate(query3);
				
				
				
				String query5="delete from instantquizresponsenew where StudentID='"+student_id+"'";
				int rs5=st.executeUpdate(query5);
				
				
				
				String query6 ="delete from poll where StudentID='"+student_id+"'";
				int rs6=st.executeUpdate(query6);
				
				
				String query7 ="delete from quizrecordquestion where StudentID='"+student_id+"'";
				int rs7=st.executeUpdate(query7);
				
				
				st = conn.createStatement();
				String query1 = "DELETE from student where StudentID ='"+student_id+"'";
				
				int rs1=st.executeUpdate(query1);
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}else
		{
			
			String strquerysc ="insert into studentcourse(Year,Semester,CourseID,StudentID) values('"+year_of_join+"','Spring','"+course_id+"','"+student_id+"') " ;
			System.out.println(strquerysc);	
			
			try {
				Statement st = conn.createStatement();
				int resultset1 = st.executeUpdate(strquerysc);
				if(resultset1!=0)
				{
					
					//System.out.println("Successful inserted into Student Course Only!!");
					System.out.println("Insert Successful");
					
					
				}
				else
				{
					System.out.println(" insert Not Successful!!");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
			
		}
		
		
		dbconn.closeLocalConnection(conn);
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}