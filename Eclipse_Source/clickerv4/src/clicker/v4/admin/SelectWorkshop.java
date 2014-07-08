package clicker.v4.admin;
import java.sql.*;
import java.util.ArrayList;

import clicker.v4.databaseconn.*;

public class SelectWorkshop {
	
	@SuppressWarnings("rawtypes")
	public ArrayList<String> workshopselect(String coordinatorid)
	{
		
		@SuppressWarnings("unchecked")
		ArrayList<String> workshopids = new ArrayList( );;
		
		Connection conn =  null;
		DatabaseConnection db = new DatabaseConnection();
		conn = db.createRemoteDatabaseConnection();
		PreparedStatement ps1 =  null;
		ResultSet rs = null;
		
		try {
			ps1 = conn.prepareStatement("select WorkshopID from workshop where Username = ? and EndDate >= CURDATE()");
			ps1.setString(1, coordinatorid);
			
			rs = ps1.executeQuery();
			while(rs.next( ))
			{
				workshopids.add(rs.getString("WorkshopID")); 
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally
		{
			try
			{
				rs.close( );
				ps1.close();
				db.closeRemoteConnection(conn);
			
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
		return workshopids;
	}

}
