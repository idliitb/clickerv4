package clicker.v4.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import clicker.v4.databaseconn.DatabaseConnection;

//Author: Kirti, Clicker Team, IDL LAB ,IIT Bombay.
/**
 * Servlet implementation class ForgotPassword
 */
//@WebServlet("/changepassword")
public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con=null;
	PreparedStatement st;
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		String mode = request.getParameter("mode");
		System.out.println("mode : "+mode);
		PrintWriter out = response.getWriter();
		String currentpd1=null;
		String newpswd=request.getParameter("newpassword");
		System.out.println("new : "+newpswd);
		String username=request.getParameter("usernamefp");
		System.out.println("uname: "+username);
		String currentpd=request.getParameter("currentpassword");
		System.out.println("currentpassword: "+currentpd);
		DatabaseConnection dbcon = new DatabaseConnection();
		HttpSession session = request.getSession(true);
		
		if(mode.equals("local"))
		{
		
			try{	
					con=dbcon.createDatabaseConnection();
					
					String selectquery="SELECT Password from instructor where InstrID=?";
					st = con.prepareStatement(selectquery);
					st.setString(1,username);
					System.out.println("In select");
					ResultSet resultSet = st.executeQuery();
					System.out.println("result set");
					while(resultSet.next()){
					currentpd1 = resultSet.getString("Password");
					System.out.println("in while");
					System.out.println("cp in databse is: "+currentpd1);	
					}
					
					if(currentpd1.equals(currentpd))
					{
					
						String updatequery="UPDATE instructor SET Password= ? WHERE InstrID=?";
						st = con.prepareStatement(updatequery);
						st.setString(1,newpswd);
						st.setString(2,username);
					
					
						int rs = st.executeUpdate();
					
						System.out.println("rows affected : "+rs);
					
						if(rs==0)
						{
							//HttpSession session=request.getSession(true);
							System.out.println("in servlet changepswd");			
							//session.setAttribute("status", "unsuccessfull");
							//request.getRequestDispatcher("./forgotpassword.jsp").forward(request, response);
							response.sendRedirect("jsp/admin/changepassword.jsp?status=Unsuccessfull");
					
						}
						else
						{	
							if(session.getAttribute("admin").toString().equalsIgnoreCase("2"))
							{
								response.sendRedirect("jsp/admin/department.jsp");
							}else
							response.sendRedirect("jsp/home/home.jsp");
						}
					}
					else
					{
						System.out.println("can't update because current password is wrong");
						response.sendRedirect("jsp/admin/changepassword.jsp?status=Unsuccessfull");
					}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			finally{
				try {
					st.close();
					dbcon.closeLocalConnection(con);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			
			
		}
		else if(mode.equals("remote"))
		{
			try{
			con=dbcon.createRemoteDatabaseConnection();
			
			String selectquery="SELECT Password from coordinator where UserName=?";
			st = con.prepareStatement(selectquery);
			st.setString(1,username);
			System.out.println("In select");
			ResultSet resultSet = st.executeQuery();
			System.out.println("result set");
			while(resultSet.next()){
			currentpd1 = resultSet.getString("Password");
			System.out.println("in while");
			System.out.println("cp in databse is: "+currentpd1);	
			}
			
			if(currentpd1.equals(currentpd))
			{
			
				String updatequery="UPDATE coordinator SET Password= ? WHERE UserName=?";
				st = con.prepareStatement(updatequery);
				st.setString(1,newpswd);
				st.setString(2,username);
			
			
				int rs = st.executeUpdate();
			
				System.out.println("rows affected : "+rs);
			
				if(rs==0)
				{
					//HttpSession session=request.getSession(true);
					System.out.println("in servlet changepswd");			
					//session.setAttribute("status", "unsuccessfull");
					//request.getRequestDispatcher("./forgotpassword.jsp").forward(request, response);
					response.sendRedirect("jsp/admin/remotechangepassword.jsp?status=Unsuccessfull");
			
				}
				else
				{	
					response.sendRedirect("jsp/home/remotehome.jsp");
				}
			}
			else
			{
				System.out.println("can't update because current password is wrong");
				response.sendRedirect("jsp/admin/remotechangepassword.jsp?status=Unsuccessfull");
			}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			finally{
				try {
					st.close();
					dbcon.closeRemoteConnection(con);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
			
		}
		
		
	}

}