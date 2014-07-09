package clicker.v4.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clicker.v4.databaseconn.DatabaseConnection;
//Author: Kirti, Clicker Team, IDL LAB ,IIT Bombay.
/**
 * Servlet implementation class EmailSetUp
 */
public class EmailSetUp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con=null;
	PreparedStatement st;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmailSetUp() {
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
		String mode = request.getParameter("mode");
	//	System.out.println("mode : "+mode);
		
		int rows = 0;
		try{
			
			String gmailid=request.getParameter("gmailid");
			String password=request.getParameter("password");
			//local mode
			if(mode.equals("local"))
			{
					DatabaseConnection dbcon = new DatabaseConnection();
					con=dbcon.createDatabaseConnection();
					
					String selectquery="SELECT COUNT(*) FROM emailsetup";
					st = con.prepareStatement(selectquery);
					
					ResultSet resultSet = st.executeQuery();
					
					while (resultSet.next()) {
					  rows = resultSet.getInt(1);
					}
				//	System.out.println("Number of rows is: "+ rows);
					
						if(rows==0){
							
							//insert query
							String insertquery="insert into emailsetup (EmailAddress , Password , id) values(?, ? , ?)";
							st = con.prepareStatement(insertquery);
							st.setString(1,gmailid);
							st.setString(2,password);
							st.setInt(3,1);

							
							int rs = st.executeUpdate();				
						//	System.out.println("rows affected : "+rs);
							
							if(rs==0)
							{
								
								response.sendRedirect("jsp/admin/emailsetup.jsp?status=Unsuccessfull");
						
							}
							else
							{	
								response.sendRedirect("jsp/home/home.jsp");
							}
							
							
						}
						else{
							//System.out.println("insert query error");	
							response.sendRedirect("jsp/admin/emailsetup.jsp?status1=Unsuccessfull");
						}
						dbcon.closeLocalConnection(con);
						
					
				}
			else if(mode.equals("remote"))
			{
					//System.out.println("in remote mode emailsetup");
					DatabaseConnection dbcon = new DatabaseConnection();
					con=dbcon.createRemoteDatabaseConnection();
					
					String selectquery="SELECT COUNT(*) FROM emailsetup";
					st = con.prepareStatement(selectquery);
					
					ResultSet resultSet = st.executeQuery();
					
					while (resultSet.next()) {
					  rows = resultSet.getInt(1);
					}
				//	System.out.println("Number of rows is: "+ rows);
					
						if(rows==0){
							
							//insert query
							String insertquery="insert into emailsetup (EmailAddress , Password , id) values(?, ?, ?)";
							st = con.prepareStatement(insertquery);
							st.setString(1,gmailid);
							st.setString(2,password);
							st.setInt(3,1);
							
							int rs = st.executeUpdate();				
							//System.out.println("rows affected : "+rs);
							
							if(rs==0)
							{
								
								response.sendRedirect("jsp/admin/remoteemailsetup.jsp?status=Unsuccessfull");
						
							}
							else
							{	
								response.sendRedirect("jsp/home/remotehome.jsp");
							}
							
							
						}
						else{
							//System.out.println("insert query error");	
							response.sendRedirect("jsp/admin/remoteemailsetup.jsp?status1=Unsuccessfull");
						}
						
						dbcon.closeRemoteConnection(con);
						
					
				}
				
				
			
			}
		catch(Exception e)
			{
				e.printStackTrace();
			}
		finally{
			try {
				st.close();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	
		}
	}

}
