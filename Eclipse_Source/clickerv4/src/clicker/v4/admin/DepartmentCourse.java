/* Author : Gobianth M
 * Use :for adding ,updating and deleting the department and course   
 *  
 */
package clicker.v4.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import clicker.v4.databaseconn.DatabaseConnection;

//import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

//import java.util.Calendar;

/**
 * Servlet implementation class DepartmentCourse
 */
public class DepartmentCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DepartmentCourse() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		// TODO Auto-generated method stub

		// TODO Auto-generated method stub
		String dept_id = request.getParameter("DepartmentID");
		String dept_name = request.getParameter("Department_name");
		String hod = request.getParameter("HOD");
		String courseID = request.getParameter("courseID");
		String coursename = request.getParameter("CourseName");
		String Coursedesc = request.getParameter("CourseDesc");
		String New_courseID = request.getParameter("New_courseID");
		String flag = request.getParameter("Flag");
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection conn = dbconn.createDatabaseConnection();
		
		
		if (flag.equalsIgnoreCase("Department_Add")) {
			String query1 = "insert into department(DeptID,DeptName,HOD,InstiID) values('"
					+ dept_id + "','" + dept_name + "','" + hod + "','I1')";

			int rs1 = 0;
			try {
				Statement st = conn.createStatement();
				rs1 = st.executeUpdate(query1);
				if (rs1 != 0)
					System.out.println("Department record Added");
				else
					System.out.println("unsuccessfull!!");
			} catch (SQLException e) {
				e.printStackTrace();
			}

		} else if (flag.equalsIgnoreCase("Department_Delete")) {

			try {
				String delete_department = "delete FROM instructorcourse where InstrID=(select InstrID from instructor where DeptID='"
						+ dept_id + "')";
System.out.println(delete_department);
				boolean rs1;
				Statement st = conn.createStatement();
				rs1 = st.execute(delete_department);
				{
				  {
					  
					  
					
           		     String delete_instr = "delete from instructor where DeptID='"
								+ dept_id + "'";
                        //System.out.println(delete_instr);

						boolean rs3 = st.execute(delete_instr);
						
						
						
						

						{
							String query3 = "SELECT StudentID from student where DeptID='"
									+ dept_id + "'";
							//System.out.println(query3);
							ResultSet rs = st.executeQuery(query3);
							while (rs.next()) {
								String student_id = rs.getString(1);
								Statement st1 = conn.createStatement();
								String query = "delete from studentcourse where StudentID='"
										+ student_id + "'";
								//System.out.println(query);
								
								boolean rs6 = st1.execute(query);
								
								String query2="DELETE from raisehand where StudentID ='"+student_id+"'";
								boolean rs2=st1.execute(query2);
								//System.out.println(query2);
								
								
								
								String query31="DELETE from attendance where StudentID ='"+student_id+"'";
								boolean rs31=st1.execute(query31);
								//System.out.println(query31);
								
								
								
								String query5="delete from instantquizresponsenew where StudentID='"+student_id+"'";
								boolean rs5=st1.execute(query5);
								//System.out.println(query5);
								
								
								
								String query6 ="delete from poll where StudentID='"+student_id+"'";
								boolean rs61=st1.execute(query6);
								//System.out.println(query6);
								
								
								String query7 ="delete from quizrecordquestion where StudentID='"+student_id+"'";
								boolean rs7=st1.execute(query7);	
								//System.out.println(query7);
								
															
								
								

							}
							String stu_del = "delete from student where DeptID='"
									+ dept_id + "'";
							//System.out.println(stu_del);

							boolean rs4 = st.execute(stu_del);

							String query4 = "DELETE from course where DeptID ='"
									+ dept_id + "'";

							boolean rs5 = st.execute(query4);

							String query5 = "DELETE from department where DeptID ='"
									+ dept_id + "'";

							boolean rs6 = st.execute(query5);

						}
					}

				}

			} catch (SQLException e) {
				e.printStackTrace();
			}

		} else if (flag.equalsIgnoreCase("Department_Update")) {
			try {

				Statement st = conn.createStatement();

				String query3 = "update department set DeptName='" + dept_name
						+ "',HOD='" + hod + "' where DeptID='" + dept_id + "'";
				System.out.println("Delete student Course" + query3);
				int rs3 = st.executeUpdate(query3);
				System.out.println("==>" + rs3);

			} catch (SQLException e) {
				e.printStackTrace();
			}

		}

		else if (flag.equalsIgnoreCase("Course_Add")) {
			String query2 = "insert into course(CourseID,CourseName,CourseDesc,DeptID,Status) values('"
					+ courseID
					+ "','"
					+ coursename
					+ "','"
					+ Coursedesc
					+ "','" + dept_id + "',0)";

			int rs1;
			try {
				Statement st = conn.createStatement();
				rs1 = st.executeUpdate(query2);

			} catch (SQLException e) {
				e.printStackTrace();
			}

		} else if (flag.equalsIgnoreCase("Course_Delete")) {
			try {

				Statement st = conn.createStatement();

				String query3 = "DELETE from studentcourse where CourseID='"
						+ courseID + "'";

				boolean rs3 = st.execute(query3);
				System.out.println("==>" + rs3);
				{

					String query4 = "DELETE from course where CourseID ='"
							+ courseID + "'";
					boolean rs4 = st.execute(query4);

				}

			} catch (SQLException e) {
				e.printStackTrace();
			}

		} else if (flag.equalsIgnoreCase("Course_Update")) {

			try {

				Statement st = conn.createStatement();

				String query3 = "update course set CourseName='" + coursename
						+ "',CourseDesc='" + Coursedesc + "' where CourseID='"
						+ courseID + "'";

				int rs3 = st.executeUpdate(query3);
				

			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		dbconn.closeLocalConnection(conn);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}