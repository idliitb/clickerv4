package clicker.v4.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import clicker.v4.databaseconn.DatabaseConnection;

/**
 * 
 * @author rajavel, Clicker Team, IDL Lab - IIT Bombay
 * This Class is used for Helper class of Auto test
 * 
 */
public class AutoTestHelper {
	public String getMainCenterURL(String centername){
		String url="";
		DatabaseConnection dbcon = new DatabaseConnection();
		Connection con = dbcon.createRemoteDatabaseConnection();
		try{
			PreparedStatement ps = con.prepareStatement("select URL from maincenter where MainCName = ?");
			ps.setString(1, centername);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				url = rs.getString("URL");
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		finally
		{
			dbcon.closeRemoteConnection(con);
		}
		return url;
	}
}
