//  Author: Kirti, Clicker Team, IDL LAB ,IIT Bombay.
package clicker.v4.login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clicker.v4.databaseconn.DatabaseConnection;

/**
 * Servlet implementation class ForgotPassword
 */
@WebServlet("/ForgotPassword")
public class ForgotPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con=null;
	PreparedStatement st;
	 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForgotPassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		SendMailForForgotPassword send=new SendMailForForgotPassword();
		String emailaddrs=null;
		int rows = 0;

			
			
			
			String username=request.getParameter("usernamefp");
			String emailid=request.getParameter("emailidfp");
			System.out.println("mode is :@@@@@ :"+request.getParameter("mode"));
			DatabaseConnection dbcon = new DatabaseConnection();
			
			//mode is radio button
			if(request.getParameter("mode").equals("Local"))
			{
				try{			
				
							con=dbcon.createDatabaseConnection();
							
							String select="SELECT COUNT(*) FROM instructor where InstrID=?";
							st = con.prepareStatement(select);
							st.setString(1,username);
							ResultSet rs = st.executeQuery();
							
							while (rs.next()) {
							  rows = rs.getInt(1);
							}
							System.out.println("Number of rows is: "+ rows);
							if(rows>0){
							
								String selectquery="SELECT EmailID from instructor where InstrID=?";
								st = con.prepareStatement(selectquery);
								st.setString(1,username);
								System.out.println("In select");
								ResultSet resultSet = st.executeQuery();
								System.out.println("result set ");
								while(resultSet.next())
								{
									emailaddrs=resultSet.getString("EmailID");
									
								}
								
								if(emailaddrs.equals(emailid))
								{
								//HttpSession session=request.getSession(true);
									
								
								send.emailmain(emailaddrs,username);
								
								System.out.println("emailto sent");
								response.sendRedirect("./login.jsp");
								//session.setAttribute("status", "unsuccessfull");
								//request.getRequestDispatcher("./forgotpassword.jsp").forward(request, response);
								
								
								}
								else
								{	
									System.out.println("wrong emailid or username");	
									response.sendRedirect("./forgotpassword.jsp?status=Unsuccessfull");
								}
							}
							else{System.out.println("wrong emailid or username");	
							response.sendRedirect("./forgotpassword.jsp?status=Unsuccessfull");}
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
			else if(request.getParameter("mode").equals("Remote"))
			{
							DatabaseConnection rmdbcon = new DatabaseConnection();
							try{
							con=rmdbcon.createRemoteDatabaseConnection();
							
							
							
							String select1="SELECT COUNT(*) from coordinator where UserName=?";
							st = con.prepareStatement(select1);
							st.setString(1,username);
							ResultSet rst = st.executeQuery();
							while (rst.next()) {
								  rows = rst.getInt(1);
								}
							System.out.println("Number of rows in coordinator is: "+ rows);
							if(rows>0)
							{
							
									String selectquery="SELECT email from coordinator where UserName=?";
									st = con.prepareStatement(selectquery);
									st.setString(1,username);
									System.out.println("In select co");
									ResultSet resultSet = st.executeQuery();
									System.out.println("result set ");
									while(resultSet.next())
									{
										emailaddrs=resultSet.getString("email");
										
									}
									
									if(emailaddrs.equals(emailid))
									{
									//HttpSession session=request.getSession(true);
										
									
									send.remoteemailmain(emailaddrs,username);
									
									System.out.println("emailto sent");
									response.sendRedirect("./login.jsp");
									//session.setAttribute("status", "unsuccessfull");
									//request.getRequestDispatcher("./forgotpassword.jsp").forward(request, response);
									
									
									}
									else
									{	
										System.out.println("wrong emailid or username");	
										response.sendRedirect("./forgotpassword.jsp?status=Unsuccessfull");
									}
							}
							else
							{
								System.out.println("wrong emailid or username");	
								response.sendRedirect("./forgotpassword.jsp?status=Unsuccessfull");
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
