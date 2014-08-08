/* Author : Gobianth M
 * Use :for adding the remote participant  
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
 * Servlet implementation class AddRemoteParticipant
 */
public class AddRemoteParticipant extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddRemoteParticipant() {
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
		
		String participantid = request.getParameter("participantid");
		String participantname = request.getParameter("participantname");
		String workshopid = request.getParameter("wsselect");
		//System.out.println("Workshop id: " + workshopid);
		int pid = 0, rs = 0;
		
		Connection conn = null;
		ResultSet resultset = null;
		PreparedStatement ps = null, ps1 = null;
		DatabaseConnection db = new DatabaseConnection();
		try {

				
				conn = db.createRemoteDatabaseConnection();
				
				ps1 = conn.prepareStatement("select count(*) as pid from participant where ParticipantID=? and WorkshopID = ?");
				ps1.setString(1, participantid);
				ps1.setString(2, workshopid);
				
				resultset = ps1.executeQuery();
				while(resultset.next())
					pid = resultset.getInt("pid");
				resultset.close();
				if(pid == 0)
				{
					ps = conn.prepareStatement("insert into participant(ParticipantID, ParticipantName, WorkshopID) values(?, ?, ?)");
					ps.setString(1, participantid);
					ps.setString(2, participantname);
					ps.setString(3, workshopid);
				
					rs = ps.executeUpdate();
					
					
					response.sendRedirect("jsp/admin/addremoteparticipant.jsp?status=Participant added successfully");
				}
				else
					response.sendRedirect("jsp/admin/addremoteparticipant.jsp?status=This Participant ID is already registered with the same Workshop ID");
				
			}
		catch(SQLException e)
		{
			//System.out.println("in add remote participant");
			e.printStackTrace( );
			
			
		}
		finally
		{
			db.closeRemoteConnection(conn);
		}
	}

}