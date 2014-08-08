/* Author : Gobianth M
 * Use :for adding ,updating and deleting the instructor details   
 *  
 */
package clicker.v4.admin;

import java.io.IOException;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clicker.v4.databaseconn.DatabaseConnection;

/**
 * Servlet implementation class Instructor
 */
public class Instructor extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Instructor() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String Instructor_id=request.getParameter("InstructorID");
		System.out.println("====>"+Instructor_id );
		
		String instr_name=request.getParameter("Instructor_name");
		//System.out.println("====>"+instr_name );
		
		String doj=request.getParameter("DOJ");		
		//System.out.println("====>"+doj );
		
		String mail_id=request.getParameter("email_id");
		//System.out.println("====>"+mail_id );
		
		String desg=request.getParameter("Desgination");
		//System.out.println("====>"+desg );
		
		String mobile_no=request.getParameter("mobile_no");
		//System.out.println("====>"+mobile_no );
		
		
		String course=request.getParameter("Course");
		//System.out.println("====>"+course );
		
		String admin=request.getParameter("Admin_pre");
		//System.out.println("====>"+admin );
		
		
		String dept_id=request.getParameter("dept_id");		
		//System.out.println("====>"+dept_id );			
 		
		String flag=request.getParameter("Flag");
		// String course_id=request.getParameter("CourseID");
		
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection conn = dbconn.createDatabaseConnection();
		Calendar cal=Calendar.getInstance();
		  int curect_year=cal.get(Calendar.YEAR);
		  
		  
		
		if(flag.equalsIgnoreCase("Add"))
		{
			
			  System.out.println("================================>Add =======");
			  int pr;
			  
			  if(admin.equalsIgnoreCase("Instructor"))
				  pr=1;
			  else if(admin.equalsIgnoreCase("HOD")) 
				  pr=2;
			  else if(admin.equalsIgnoreCase("Principal")) 
				  pr=3;
			  else
				  pr=4;
				  
			String query2="insert into instructor(InstrID,InstrName,DOJ,DeptID,Password,Designation,EmailID,MobileNo,AdminPriviledges) values('"+Instructor_id+"','"+ instr_name +"','"+doj +"','"+dept_id +"','"+ Instructor_id+"','"+ desg+"','"+mail_id +"','"+ mobile_no+"','"+pr+"')";
			int rs1;
			try {
				Statement st = conn.createStatement();
				rs1 = st.executeUpdate(query2);
				if(rs1!=0)
				{
					int rs2;
					System.out.println("Instructor record Added");
					String query3="insert into instructorcourse(Year,Semester,CourseID,InstrID) values('"+curect_year+"','"+ 1 +"','"+course +"','"+Instructor_id +"')";
					rs2 = st.executeUpdate(query3);
					if(rs2!=0)
						System.out.println("instructor course record Added");
					
					else
						System.out.println("instructor course record not Added");
						
				}
					else
						System.out.println("unsuccessfull!!");
			} catch (SQLException e) {
					e.printStackTrace();
			}
			
		
		
		
		
		//System.out.println("=======>"+query3);
		}else if(flag.equalsIgnoreCase("Delete"))
		{
			
			//System.out.println(query4);
			Statement st;
			try {
				String query4 = "DELETE from instructorcourse where InstrID = '"+Instructor_id+"'";
				System.out.println("delete query==="+query4);
				st = conn.createStatement();
				int rs3 = st.executeUpdate(query4);
				System.out.println("record Delete from Student course");
				st = conn.createStatement();
				String query1 = "DELETE from instructor where InstrID ='"+Instructor_id+"'";
				System.out.println("==>"+query1);
				int rs4=st.executeUpdate(query1);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}else if(flag.equalsIgnoreCase("update"))
		{
			
			System.out.println("instructor ID in Serverlet =========================>"+Instructor_id +"  Flag ==========>"+flag);
			
			try {

				Statement st = conn.createStatement();

				String query3 = "update instructor set InstrName='"+instr_name+"',DOJ='"+doj+"',Designation='"+desg+"',EmailID='"+mail_id+"',MobileNo='"+mobile_no+"' where InstrID='"+Instructor_id+"'";
				int rs3 = st.executeUpdate(query3);
				System.out.println("==>" + rs3);

			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			
			
		}else if(flag.equalsIgnoreCase("Remove_Course"))
		{
			
			Statement st;
			try {
				String query4 = "DELETE from instructorcourse where InstrID = '"+Instructor_id+"' and CourseID='"+course+"'" ;
				st = conn.createStatement();
				int rs = st.executeUpdate(query4);
				System.out.println("record Delete from Student course");				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}else if(flag.equalsIgnoreCase("Add_Course"))
		{
			String query3="insert into instructorcourse(Year,Semester,CourseID,InstrID) values('"+curect_year+"','"+ 1 +"','"+course +"','"+Instructor_id +"')";

			System.out.println(query3);
			
			int rs1;
			try {
				Statement st = conn.createStatement();
				rs1 = st.executeUpdate(query3);
				if(rs1!=0)
				{
					
					System.out.println("Instructor record Added");					
						
				}
					else
						System.out.println("unsuccessfull!!");
			} catch (SQLException e) {
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