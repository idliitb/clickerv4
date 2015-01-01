/* Author : Gobianth M
 * Use :for adding ,updating and deleting the participant   
 *  
 */
package clicker.v4.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import clicker.v4.databaseconn.DatabaseConnection;

/**
 * Servlet implementation class ParticipantDetails
 */
public class ParticipantDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ParticipantDetails() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String participantid = request.getParameter("participantid");
		String participantname = request.getParameter("participantname");
		String workshopid = request.getParameter("wsselect");
		
		String flag = request.getParameter("Flag");
		
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection conn = dbconn.createRemoteDatabaseConnection();
		
		//System.out.println("======"+participantid+"====="+participantname+"===="+workshopid);
		
		if(flag.equalsIgnoreCase("ADD"))
		{
				String query3="insert into participant(ParticipantID,MacAddress,ParticipantName,WorkshopID,Password) values('"+participantid+"',' ','"+participantname +"','"+workshopid +"','"+participantid +"')";
				int rs2;
				try {
					Statement st = conn.createStatement();
					rs2 = st.executeUpdate(query3);
					if(rs2!=0)
						System.out.println(" Participant record added");
									
					else
						System.out.println("Participant  record not added");
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				finally {
					dbconn.closeRemoteConnection(conn);
				} 
		} else if(flag.equalsIgnoreCase("DELETE"))
		{
			String query4="delete from attendance where ParticipantID='"+participantid+"' and WorkshopID='"+workshopid+"'";
			
			String query3="delete from participant where ParticipantID='"+participantid+"' and WorkshopID='"+workshopid+"'";
			int rs2,rs12;
			try {
				Statement st = conn.createStatement();
				rs12=st.executeUpdate(query4);
				String QINST="delete from instantquizresponsenew where ParticipantID='"+participantid+"'";	
				rs12=st.executeUpdate(QINST);				
				String QRQ="delete from quizrecordquestion where ParticipantID='"+participantid+"'";	
				rs12=st.executeUpdate(QRQ);	
				rs2 = st.executeUpdate(query3);
				if(rs2!=0)
					System.out.println("Delete Participant record deleted");
				else
					System.out.println(" Participant record not deleted");
					
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			finally
			{
				dbconn.closeRemoteConnection(conn);
			}
		}else if(flag.equalsIgnoreCase("DELETE_ALL"))
		{
			String delete_ATT="delete FROM attendance where WorkshopID='"+workshopid+"'";
			String query3="delete from participant where WorkshopID='"+workshopid+"'";
			String QINST="delete from instantquizresponsenew";
			String IQR="delete from quizrecordquestion";
			int rs2,rs12;
			try {
				Statement st = conn.createStatement();
				rs12=st.executeUpdate(delete_ATT);
				rs12=st.executeUpdate(QINST);
				rs12=st.executeUpdate(IQR);
				rs2 = st.executeUpdate(query3);
				if(rs2!=0)
					System.out.println("Delete Participant record deleted");
								
				else
					System.out.println(" Participant record not deleted");
					
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			finally
			{
				dbconn.closeRemoteConnection(conn);
			}
		}else if(flag.equalsIgnoreCase("REMOVE_MAC"))
		{
			String query3="update participant set MacAddress='' where ParticipantID='"+participantid +"' and WorkshopID='"+workshopid+"'";
			int rs2;
			try {
				Statement st = conn.createStatement();
				rs2 = st.executeUpdate(query3);
				if(rs2!=0)
					System.out.println("mac Updated");
								
				else
					System.out.println(" mac not Updated");
						
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}		
			finally
			{
				dbconn.closeRemoteConnection(conn);
			}
			
		}
				
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}