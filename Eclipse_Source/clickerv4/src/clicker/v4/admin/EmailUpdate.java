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
 * Servlet implementation class EmailUpdate
 */
public class EmailUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con=null;
	PreparedStatement st;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EmailUpdate() {
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
		//System.out.println("mode : "+mode);
		int rows = 0;
		try{
			
			String newgmailid=request.getParameter("newgmailid");
			
			String newpassword=request.getParameter("newpassword");
			
			
			if(mode.equals("local"))
			{
				DatabaseConnection dbcon = new DatabaseConnection();
				try
				{
					
					con=dbcon.createDatabaseConnection();
					
					String selectquery="SELECT COUNT(*) as cnt FROM emailsetup";
					st = con.prepareStatement(selectquery);
					
					ResultSet resultSet = st.executeQuery();
					
					while (resultSet.next()) {
					  rows = resultSet.getInt("cnt");
					}
					resultSet.close();
				//	System.out.println("Number of rows in local is: "+ rows);
					
					if(rows==1){
						
						String updatequery="update emailsetup set Password=? , EmailAddress=? where id ="+1 ;
						st = con.prepareStatement(updatequery);				
						st.setString(1, newpassword.trim());
						st.setString(2,newgmailid.trim());
						
						//System.out.println(st.executeUpdate()+ " ........");
						
						//System.out.println("rows affected : "+rs);
						
						/*if(rs==0)
						{
							
							response.sendRedirect("jsp/admin/emailupdate.jsp?status=Unsuccessfull");
					
						}
						else
						{	*/
							response.sendRedirect("jsp/home/home.jsp");
						
						
						
					}
					else{
						response.sendRedirect("jsp/admin/emailsetup.jsp");
					}
				}
					catch (Exception e) 
					{
					e.printStackTrace();
					}finally{
						if(con!=null)dbcon.closeLocalConnection(con);
					}
			
			}
			else if(mode.equals("remote"))
			{
				DatabaseConnection dbcon = new DatabaseConnection();
				con=dbcon.createRemoteDatabaseConnection();
			try
			{	
				String selectquery="SELECT COUNT(*) as cnt FROM emailsetup";
				st = con.prepareStatement(selectquery);
				
				ResultSet resultSet = st.executeQuery();
				
				while (resultSet.next()) {
				  rows = resultSet.getInt("cnt");
				}
				resultSet.close();
			//	System.out.println("Number of rows in remote is: "+ rows);
				
				if(rows==1){
					
					String updatequery="update emailsetup set Password=? , EmailAddress=? where id ="+1 ;
					st = con.prepareStatement(updatequery);				
					st.setString(1, newpassword.trim());
					st.setString(2,newgmailid.trim());
					
				//	System.out.println(st.executeUpdate()+ " ........");
					
					//System.out.println("rows affected : "+rs);
					
					/*if(rs==0)
					{
						
						response.sendRedirect("jsp/admin/emailupdate.jsp?status=Unsuccessfull");
				
					}
					else
					{	*/
						response.sendRedirect("jsp/home/remotehome.jsp");
					
					
					
				}
				else{
					response.sendRedirect("jsp/admin/remoteemailsetup.jsp");
				}
			}
			catch (Exception e) 
			{
			e.printStackTrace();
			}finally{
				if(con!=null)dbcon.closeRemoteConnection(con);
			}
				
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

