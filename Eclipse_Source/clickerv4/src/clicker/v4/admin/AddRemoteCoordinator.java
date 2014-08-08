/* Author : Gobianth M
 * Use :for adding the remote coordinator
 *  
 */
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

/**
 * Servlet implementation class AddRemoteCoordinator
 */
public class AddRemoteCoordinator extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddRemoteCoordinator() {
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
		
		//int coord_id = Integer.parseInt(request.getParameter("coordinatorid"));
		//System.out.println("centerid: " + request.getParameter("centerid"));
		int centerid = Integer.parseInt(request.getParameter("centerid"));
		//System.out.println("centerid: " + centerid);
		int privilege = Integer.parseInt(request.getParameter("privilege"));
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");		
		PreparedStatement ps1 = null;
		int rs = 0;
		PreparedStatement ps = null;
		ResultSet rs1 = null;
		int cid = 0;
		int uid =0;
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection conn = dbcon.createRemoteDatabaseConnection();
		try {
			ps1 = conn.prepareStatement("select count(*) as cid from coordinator");
			rs1 = ps1.executeQuery( );
				while(rs1.next( ))
					cid = rs1.getInt("cid");			
			    cid=cid+1;
			    
		    ps1 = conn.prepareStatement("select count(*) as uid from coordinator where UserName='"+username+"'");
			rs1 = ps1.executeQuery( );
				while(rs1.next( ))
					uid = rs1.getInt("uid");
				
				if (uid == 0)
				{
					System.out.println("User name Does not exit");
				}else
				{
					System.out.println("User name  exit");
				}
						
				//if(uid.equalsIgnoreCase("0"))
				{
			    
			    ps = conn.prepareStatement("insert into coordinator values(?, ?, ?, ?, ?, ?)");
				ps.setInt(1, cid);
				ps.setString(2, username);
				ps.setString(3, password);
				ps.setInt(4, centerid);
				ps.setString(5, email);
				ps.setInt(6, privilege);
				rs = ps.executeUpdate();
				response.sendRedirect("jsp/admin/addremotecoordinator.jsp?status=Coordinator added successfully");
				}//else
				{
				//	response.sendRedirect("jsp/admin/addremotecoordinator.jsp?status=UserName Already  exist");
				}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.sendRedirect("jsp/admin/addremotecoordinator.jsp?status=Duplicate entry for Coordinator ID exist");
		}finally
		{
			try {
				ps.close();
				dbcon.closeRemoteConnection(conn);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
