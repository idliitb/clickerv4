 /*
  * Author: Kirti, Dipti  from Clicker Team, IDL LAB -IIT Bombay
  */
package clicker.v4.login;

import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import clicker.v4.databaseconn.DatabaseConnection;


public class loginHelper {
	Connection con=null;
	PreparedStatement st;
	
	
	
	public String[] getInstructorIDCourseID(Connection conn, String InstrID) {
		String Query = "SELECT ic.CourseID from instructorcourse ic where ic.InstrID=?";		
		ResultSet resultSet =null;
		try {
			if (conn != null) {
				PreparedStatement st1 = conn.prepareStatement(Query);
				st1.setString(1,InstrID);
				resultSet = st1.executeQuery();				
			}
		} catch (Exception ex) {
			System.out.println(ex);
		}
		String[] result = runStringArrayQuery(conn, resultSet);
		return result;
	}
	
	public String[] runStringArrayQuery(Connection conn, ResultSet result) {
		String[] ResultArray;
		try {
			result.last();
			int n = result.getRow();
			result.beforeFirst();
			ResultArray = new String[n];
			if (n != 0) {
				int i = 0;
				while (result.next()) {
					ResultArray[i] = result.getString(1);
					i++;
				}
			}
		} catch (Exception ex) {
			ResultArray = null;
		}
		return ResultArray;
	}	
	
public String[] getInstructorIDWorkshopID(Connection conn, String coordinatorID) {
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String todaysDate = dateFormat.format(cal.getTime());
		System.out.println("tadays date is : "+todaysDate);
		
		
		
		
		String Query = "SELECT WorkshopID from workshop  where Username=? and  EndDate >= ?";		
		ResultSet resultSet =null;
		try {
			if (conn != null) {
				PreparedStatement st1 = conn.prepareStatement(Query);
				st1.setString(1,coordinatorID);
				st1.setString(2,todaysDate);
				resultSet = st1.executeQuery();				
			}
		} catch (Exception ex) {
			System.out.println(ex);
		}
		String[] result = runStringArrayQuery(conn, resultSet);
		return result;
	}

	public String[] getMainCenterName(Connection conn) {
	
		String Query = "SELECT MainCName from maincenter";		
		ResultSet resultSet =null;
		try {
			if (conn != null) {
				PreparedStatement st1 = conn.prepareStatement(Query);
				resultSet = st1.executeQuery();				
			}
		} catch (Exception ex) {
			System.out.println(ex);
		}
		String[] result = runStringArrayQuery(conn, resultSet);
		return result;
}
	public String getMainCenterURL(String MainCenterName) {
		DatabaseConnection dbcon = new DatabaseConnection();
		con=dbcon.createRemoteDatabaseConnection();
		
		ResultSet resultSet =null;
		String MainCenterURL = null;
		String Query = "SELECT URL FROM maincenter where MainCName=?";	
		try {
			if (con != null) {
				st = con.prepareStatement(Query);
				st.setString(1,MainCenterName);
				resultSet = st.executeQuery();			
				
				while(resultSet.next())
				{
					MainCenterURL = resultSet.getString(1);
				}
				
				
			}
		} catch(Exception e)
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
		
		
		return MainCenterURL;
		
		
	}	
	
	
	
	public String getEmail() {
		DatabaseConnection dbcon = new DatabaseConnection();
		con=dbcon.createDatabaseConnection();
		
		ResultSet resultSet =null;
		String emailid = null;
		String Query = "SELECT EmailAddress from emailsetup";	
		try {
			if (con != null) {
				st = con.prepareStatement(Query);
				resultSet = st.executeQuery();			
				
				while(resultSet.next())
				{
					emailid = resultSet.getString(1);
				}
				
				
			}
		} catch(Exception e)
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
		
		
		return emailid;
		
		
	}	
	
	public String getPassword() {
		DatabaseConnection dbcon = new DatabaseConnection();
		con=dbcon.createDatabaseConnection();
		
		ResultSet resultSet =null;
		String password = null;
		String Query = "SELECT Password from emailsetup";	
		try {
			if (con != null) {
				st = con.prepareStatement(Query);
				resultSet = st.executeQuery();			
				
				while(resultSet.next())
				{
					password = resultSet.getString(1);
				}
				
				
			}
		} catch(Exception e)
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
		
		
		return password;
		
		
	}	
	
	public String updatePassword(String username , String password) {
		DatabaseConnection dbcon = new DatabaseConnection();
		con=dbcon.createDatabaseConnection();
				
		String Query = "update instructor set Password=? where InstrID=? ";	
		try {
			if (con != null) {
				st = con.prepareStatement(Query);
				st.setString(1,password);
				st.setString(2,username);
					
				st.executeUpdate();
				
				System.out.println("password updated to@@@@@@@@@ : "+password);
				
			}
		} catch(Exception e)
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
		
		
		return password;
		
		
	}	
	
	
//remote code
	
	
	public String remotegetEmail() {
		DatabaseConnection rmdbcon = new DatabaseConnection();
		con=rmdbcon.createRemoteDatabaseConnection();
		
		ResultSet resultSet =null;
		String emailid = null;
		String Query = "SELECT EmailAddress from emailsetup";	
		try {
			if (con != null) {
				st = con.prepareStatement(Query);
				resultSet = st.executeQuery();			
				
				while(resultSet.next())
				{
					emailid = resultSet.getString(1);
				}
				
				
			}
		} catch(Exception e)
		{
			e.printStackTrace();
		}
		finally{
			try {
				st.close();
				rmdbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		
		return emailid;
		
		
	}	
	
	public String remotegetPassword() {
		DatabaseConnection rmdbcon = new DatabaseConnection();
		con=rmdbcon.createRemoteDatabaseConnection();
		
		ResultSet resultSet =null;
		String password = null;
		String Query = "SELECT Password from emailsetup";	
		try {
			if (con != null) {
				st = con.prepareStatement(Query);
				resultSet = st.executeQuery();			
				
				while(resultSet.next())
				{
					password = resultSet.getString(1);
				}
				
				
			}
		} catch(Exception e)
		{
			e.printStackTrace();
		}
		finally{
			try {
				st.close();
				rmdbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		
		return password;
		
		
	}	
	
	public String remoteupdatePassword(String username , String password) {
		DatabaseConnection rmdbcon = new DatabaseConnection();
		con=rmdbcon.createRemoteDatabaseConnection();
				
		String Query = "update coordinator set Password=? where UserName=? ";	
		try {
			if (con != null) {
				st = con.prepareStatement(Query);
				st.setString(1,password);
				st.setString(2,username);
					
				st.executeUpdate();
				
				System.out.println("password updated to@@@@@@@@@ : "+password);
				
			}
		} catch(Exception e)
		{
			e.printStackTrace();
		}
		finally{
			try {
				st.close();
				rmdbcon.closeRemoteConnection(con);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		
		return password;
		
		
	}
	
	
	
	
	
}