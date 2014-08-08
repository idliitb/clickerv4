/* Author : Gobianth M
 * Use :for adding the remote center
 *  
 */
package clicker.v4.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clicker.v4.databaseconn.DatabaseConnection;

/**
 * Servlet implementation class AddRemoteCenter
 */
public class AddRemoteCenter extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddRemoteCenter() {
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
						
		PreparedStatement ps = null, ps1 = null;
		ResultSet rs = null;
		int cid = 0, check = 0;
		
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection conn = dbcon.createRemoteDatabaseConnection();
		
		try {						
				ps = conn.prepareStatement("select count(*) as cid from remotecenter");
				rs = ps.executeQuery( );
				while(rs.next( ))
					cid = rs.getInt("cid");
				
				//System.out.println("check1: " + request.getParameter("check") + " check2: " + request.getParameter("check"));
				if(Integer.parseInt(request.getParameter("check")) == 1)
				{
					if(cid == 0)
					{
						int centerid = Integer.parseInt(request.getParameter("centerid"));
						String centername = request.getParameter("centername");
						String state = request.getParameter("state");
						String city = request.getParameter("city");
						
						ps1 = conn.prepareStatement("insert into remotecenter values(?, ?, ?, ?)");
						ps1.setInt(1, centerid);
						ps1.setString(2, centername);
						ps1.setString(3, state);
						ps1.setString(4, city);
						check = ps1.executeUpdate();
						
						response.sendRedirect("jsp/home/remotehome.jsp");
					}
					
				}
				else
				{
					int storedcenterid = Integer.parseInt(request.getParameter("storedcenterid"));
					String storedcentername = request.getParameter("storedcentername");
					String storedstate = request.getParameter("storedstate");
					String storedcity = request.getParameter("storedcity");
					
					ps1 = conn.prepareStatement("update remotecenter set CenterID = ?, CenterName = ?, State = ?, City = ?");
					ps1.setInt(1, storedcenterid);
					ps1.setString(2, storedcentername);
					ps1.setString(3, storedstate);
					ps1.setString(4, storedcity);
					check = ps1.executeUpdate();
					response.sendRedirect("jsp/home/remotehome.jsp");
				}
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally
		{
			
			try {
				rs.close();
				ps.close();
				//ps1.close();
				dbcon.closeRemoteConnection(conn);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}
	
	public ArrayList<String> getAll()
	{
		int count =0;
		ArrayList<String> storeall = new ArrayList<String>( );
		PreparedStatement ps = null;
		ResultSet resultset = null;
				
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection conn = dbcon.createRemoteDatabaseConnection();
		
		try {
				ps = conn.prepareStatement("select *, count(*) as num from remotecenter");
				resultset = ps.executeQuery();
								
				resultset.next();
				count = resultset.getInt("num");
				if(count > 0)
				{
					
					storeall.add(String.valueOf(resultset.getInt("CenterID")));
					storeall.add(resultset.getString("CenterName"));
					storeall.add(resultset.getString("State"));
					storeall.add(resultset.getString("City"));
				}
				else
					storeall.add(String.valueOf(resultset.getInt("num")));
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally
		{
			try {
				resultset.close();
				ps.close();
				dbcon.closeRemoteConnection(conn);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return storeall;
	}

}
