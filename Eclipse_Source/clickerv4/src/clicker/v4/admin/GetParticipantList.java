/* Author : Gobianth M
 * Use :for getting the participant list from the database   
 *  
 */
package clicker.v4.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import clicker.v4.databaseconn.DatabaseConnection;

/**
 * Servlet implementation class GetParticipantList
 */
public class GetParticipantList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetParticipantList() {
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
		//System.out.println("In participant servlet");
		PreparedStatement ps = null, ps1 = null;
		ResultSet rs = null;
		int cid = 0, check1 = 0, check2 = 0, selector = 0;
		
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection conn = dbcon.createRemoteDatabaseConnection();
		
		selector = Integer.parseInt(request.getParameter("select"));
		try {						
				if(selector == 1)
				{
					String participantid = request.getParameter("pid");
					String newparticipantid = request.getParameter("newpid");
					String participantname = request.getParameter("newpname");
														
					ps1 = conn.prepareStatement("update participant set ParticipantName = ?, ParticipantID = ? where ParticipantID = ?");
					ps1.setString(1, participantname);
					ps1.setString(2, newparticipantid);
					ps1.setString(3, participantid);					
					check2 = ps1.executeUpdate();
										
					//response.getWriter().print(false);
					//return;
					
				}
				
				else if(selector == 2)
				{
					String participantid = request.getParameter("pid");
					
					ps = conn.prepareStatement("delete from participant where ParticipantID = ?");
					ps.setString(1, participantid);
										
					check1 = ps.executeUpdate();
				}
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally{
			try {
					
					if(selector == 2)
						ps.close();
					else{
							
							ps1.close();
							
					}
					dbcon.closeRemoteConnection(conn);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
		
	public List<String> participantlist(String workshopid)
	{
		int count = 0;
		ResultSet rs = null, resultset = null;
		PreparedStatement ps = null;
		List<String> storeall = new ArrayList<String>( );
		
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection conn = dbcon.createRemoteDatabaseConnection();
		
		try {
				ps = conn.prepareStatement("select count(*) as num from participant where WorkshopID = ?");
				ps.setString(1, workshopid);
				
				resultset = ps.executeQuery();
				resultset.next();
				
				count = resultset.getInt("num");
				//System.out.println("Count: " + count);
				if(count > 0)
				{
					ps = conn.prepareStatement("select ParticipantID, ParticipantName from participant where WorkshopID = ?");
					ps.setString(1, workshopid);
					
					rs = ps.executeQuery();
					while(rs.next())
					{
						
						storeall.add("start"); //this is to mark the start of a row
						storeall.add(rs.getString("ParticipantID"));
						storeall.add(rs.getString("ParticipantName"));
						storeall.add("end"); //this is to mark the end of a row
					}
				}
				//else
					//storeall.add(String.valueOf(count));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			try {
					resultset.close();
				if(count > 0)
					rs.close();
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
