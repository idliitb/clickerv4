package clicker.v4.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;

import clicker.v4.databaseconn.DatabaseConnection;
import clicker.v4.login.loginHelper;
import clicker.v4.rest.JSONReadandparse;



/**
 * Author : Dipti , Rajavel  from Clicker Team, IDL LAB ,IIT Bombay
 * 
 * Servlet implementation class Login
 */
public class Login extends HttpServlet {
	
	public boolean checkInstructorLogin(Connection conn, String InstructorID, String Password, HttpServletRequest request) 
	{
		String mode = request.getParameter("mode");
		if(mode!=null)
		{
			try {
				Statement stmt;
				stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery("Select * from coordinator where UserName = '"+ InstructorID + "'");
				String DBInstructorName, DBPassword;
				if (rs.next()) {
					DBInstructorName = rs.getString("UserName");
					DBPassword = rs.getString("Password");
					if (InstructorID.equals(DBInstructorName) && Password.equals(DBPassword) && !Password.equals("")) {
						HttpSession session = request.getSession(true);
						String privilege = String.valueOf(rs.getInt("AdminPriviledges"));
						session.setAttribute("admin", privilege);
						return true;
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}		
		}else{
			Statement stmt=null, stmt1=null;
			ResultSet rs=null, rs1=null;			
			try {
				stmt = conn.createStatement();
				rs = stmt.executeQuery("Select * from instructor where InstrID = '"+ InstructorID + "'");
				String DBInstructorName, DBPassword;
				if (rs.next()) {
					DBInstructorName = rs.getString("InstrID");
					DBPassword = rs.getString("Password");
					if (InstructorID.equals(DBInstructorName) && Password.equals(DBPassword) && !Password.equals("")) {
						HttpSession session = request.getSession(true);
						session.setAttribute("admin", rs.getInt("AdminPriviledges"));
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery("SELECT DeptID from instructor where InstrID='"+ InstructorID + "'");
						if(rs1.next()){
							session.setAttribute("D_ID", rs1.getString("DeptID"));
						}
						return true;
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}finally{
				if(rs1!=null)try {rs1.close();} catch (SQLException e) {e.printStackTrace();}
				if(rs!=null)try {rs.close();} catch (SQLException e) {e.printStackTrace();}
				if(stmt1!=null)try {stmt1.close();} catch (SQLException e) {e.printStackTrace();}
				if(stmt!=null)try {stmt.close();} catch (SQLException e) {e.printStackTrace();}
			}
		}
		return false;
	}
	
	
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */

	public Login() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		if(request.getParameter("courseID")!=null){
			session.setAttribute("courseID", request.getParameter("courseID"));
			try {
				System.out.println("courseId is : "+request.getParameter("courseID"));
				response.sendRedirect("./jsp/home/home.jsp");
			} catch (IOException e) {
					e.printStackTrace();
			}
		}
		else{
			if(request.getParameter("maincentername").equals("MainCenter not added")){
				session.setAttribute("maincentername", "MainCenter not added");
				try {
						session.setAttribute("WorkshopID","No Workshop, As No MainCenter");
						session.setAttribute("MainCenterURL","No URL");
						System.out.println("No Main Center Present..: "+(String) session.getAttribute("maincentername"));
						response.sendRedirect("./jsp/home/remotehome.jsp");
				} catch (IOException e) {
						e.printStackTrace();
				}	
			}
			else{
				String StatusOfCenter=null;
				session.setAttribute("maincentername", request.getParameter("maincentername"));
				try {
					System.out.println("maincenterName is : "+request.getParameter("maincentername"));
					String maincentername = session.getAttribute("maincentername").toString();
					int workshopcount = 0;
					loginHelper helper=new loginHelper();
					String URL=helper.getMainCenterURL(maincentername);
					JSONReadandparse jparse= new JSONReadandparse();
					try {
						StatusOfCenter=jparse.connectToMainCenterFromUrl(URL);
					} catch (ParseException e1) {
						System.out.println("Error in login.java, While getting connecting to server - "+e1);
					}
					if(StatusOfCenter=="reachable"||(StatusOfCenter.equals("reachable"))){
						try {
							String[] workshops=jparse.getWorkshopListFromUrl(URL);
							session.setAttribute("workshopList", workshops);
							workshopcount = workshops.length;
							System.out.println("Workshop count is :"+workshopcount);
							session.setAttribute("WorkshopID","No Workshop Set");
							session.setAttribute("MainCenterURL",URL);
						}catch(Exception e){
							System.out.println("in login.java ,while getting lsit of workshop");
						}
						response.sendRedirect("./workshopsetter.jsp");
					}else{
						session.setAttribute("WorkshopID","No Workshop, Wrong URL");
						session.setAttribute("MainCenterURL","Wrong URL");
						System.out.println("Wrong URL of maincenter.. : "+(String) session.getAttribute("maincentername"));
						response.sendRedirect("./jsp/home/remotehome.jsp");
					}
				} catch (IOException e) {
					e.printStackTrace();
				}	
			}
		}		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		Connection conn = null;
		String LoginName = request.getParameter("LoginName");
		System.out.println("login name :"+LoginName);
		String Password = request.getParameter("Password");
		System.out.println("Password is :"+Password);
		String mode=request.getParameter("mode");
		if(mode!=null){
			PrintWriter out = response.getWriter();
			DatabaseConnection dbconn = new DatabaseConnection();
			conn = dbconn.createRemoteDatabaseConnection();	
			try {
				loginHelper loginhelp = new loginHelper();
				boolean flag = false;
				flag = checkInstructorLogin(conn, LoginName, Password, request);	
				if(flag == false){
					System.out.println("wrong username and password");
					out.print("0");
					out.close();
				}
				else 
				{
					HttpSession session = request.getSession(true);
					session.setAttribute("CoordinatorID", LoginName);
					String[] maincenterlist=loginhelp.getMainCenterName(conn);
					session.setAttribute("maincenterList", maincenterlist);
					session.setMaxInactiveInterval(8 * 60 * 60);
				}				
				
			} catch (Exception ex) {
				ex.printStackTrace();
			}finally{
				if(conn!=null)dbconn.closeRemoteConnection(conn);
			}			
		}else{
			PrintWriter out1 = response.getWriter();
			int courselistcount = 0;
			DatabaseConnection dbconn = new DatabaseConnection();
			try {
				loginHelper loginhelp = new loginHelper();
				conn = dbconn.createDatabaseConnection();				
				boolean flag = false;
				flag = checkInstructorLogin(conn, LoginName, Password, request);	
				if(flag == false){
					System.out.println("wrong username and password");
				}
				else {
					HttpSession session = request.getSession(true);
					session.setAttribute("InstructorID", LoginName);
					String[] Courses =loginhelp.getInstructorIDCourseID(conn,LoginName);
					session.setAttribute("courseList", Courses);
					courselistcount = Courses.length;
					if(session.getAttribute("admin").toString().equalsIgnoreCase("4")){
						courselistcount=-4;
					}
					else if(session.getAttribute("admin").toString().equalsIgnoreCase("2")){
						courselistcount=-2;
					}
					session.setMaxInactiveInterval(8 * 60 * 60);
					if(courselistcount==1 || courselistcount == -4 || courselistcount == -2)
						session.setAttribute("courseID", Courses[0]);
				}
				out1.print(courselistcount);
				out1.close();				
				
			} catch (Exception ex) {
				ex.printStackTrace();
			}finally{
				dbconn.closeLocalConnection(conn);
			}
		}				
	}
}