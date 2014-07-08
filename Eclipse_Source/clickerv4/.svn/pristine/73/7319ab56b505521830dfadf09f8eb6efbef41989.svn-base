package clicker.v4.admin;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clicker.v4.databaseconn.DatabaseConnection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Servlet implementation class DeleteDepartment
 */
public class DeleteDepartment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteDepartment() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String dept_id=request.getParameter("DepartmentID");
		DatabaseConnection dbconn = new DatabaseConnection();
		   Connection conn = dbconn.createDatabaseConnection();
		try {
			String delete_department= "delete FROM instructorcourse where InstrID=(select InstrID from instructor where DeptID='"+dept_id+"')";
		//System.out.println("delete_department==="+delete_department);
		boolean rs1;
		
			Statement st = conn.createStatement();
			rs1 = st.execute(delete_department);
			//System.out.println("instructorcourse==="+delete_department);
			//System.out.println(rs1);
			
			{
				//System.out.println("Department record Deleted");
				String delete_course="delete from course where DeptID='"+dept_id+"'";
				//System.out.println(delete_course);
				boolean rs2 = st.execute(delete_course);
				//System.out.println("delete_course==="+delete_course);
				//System.out.println(rs2);
				
				{
					//System.out.println("successfull!! Deleted the course");
					String delete_instr="delete from instructor where DeptID='"+dept_id+"'";
					//System.out.println(delete_instr);
					boolean rs3 = st.execute(delete_instr);
					//System.out.println(rs3);
					
					{
						String query3 = "SELECT StudentID from student where DeptID='"+dept_id+"'";
						ResultSet rs = st.executeQuery(query3);
						while (rs.next()) {		
							String student_id = rs.getString(1);
							Statement st1 = conn.createStatement();
							String query="delete from studentcourse where StudentID='"+student_id+"'";
							//System.out.println("Delete student Course"+query);
							boolean rs6 = st1.execute(query);
							//System.out.println("==>"+rs6);
							
						}
						String stu_del="delete from student where DeptID='"+dept_id+"'";
					//	System.out.println("Delete student Course"+stu_del);
						boolean rs4 = st.execute(stu_del);
					//	System.out.println("==>"+rs4 );
						
						
						String query4 = "DELETE from course where DeptID ='"+dept_id+"'";
						
						boolean rs5 = st.execute(query4);
						//System.out.println("Delete  Course"+query4);
						//System.out.println("==>"+rs5 );
						
						String query5 = "DELETE from department where DeptID ='"+dept_id+"'";
						
						boolean rs6 = st.execute(query5);
					//	System.out.println("Delete  Course"+query5);
					//	System.out.println("==>"+rs6 );
						
					}
				}
					
			}  
				
		} catch (SQLException e) {
				e.printStackTrace();
		}
		finally
		{
			dbconn.closeLocalConnection(conn);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
