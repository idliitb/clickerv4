//Author : Kirti, Clicker Team, IDL LAB ,IIT Bombay 
package clicker.v4.poll;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

import clicker.v4.databaseconn.DatabaseConnection;


public class PollHelper 
{
	Connection con=null;
	static private int pollid;
	PreparedStatement st;
	
	public void setPollid(int i)
		{
		pollid=i;
	}
	public int getPollid()
	{
		return pollid;
	}
	
/*
 * get the student count based on course id 
 * 
 */
	public int studentcount(String courseId)
	{
		int count=0;
		DatabaseConnection dbconn=new DatabaseConnection();
		try
	   	 {
			
			con = dbconn.createDatabaseConnection();
			st = (PreparedStatement) con.prepareStatement("SELECT count(StudentID) FROM studentcourse WHERE courseID =?");
			st.setString(1,courseId);
			ResultSet rs=st.executeQuery();	
			rs.next();
			count=rs.getInt(1);			
	     }
		 
		 catch (SQLException e) 
		 {
				e.printStackTrace();
		 }
		finally{
			try {
				st.close();
				dbconn.closeLocalConnection(con);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		return count;
	
	}
	
//getting count of those students who did not attended the poll 
	//SELECT count(StudentID) FROM studentcourse WHERE courseID ='CSE101' and StudentID not in (select StudentID from poll where PollId=25);
	public int studentnotattended(String courseId,String launchtime)
	{
		int count=0;
		
		DatabaseConnection dbconn=new DatabaseConnection();
		try
	   	 {
			int p=getpollidnew(launchtime,courseId);
			con = dbconn.createDatabaseConnection();
			st = (PreparedStatement) con.prepareStatement("SELECT count(StudentID) FROM studentcourse WHERE courseID =? and StudentID not in (select StudentID from poll where PollId=?);");
			st.setString(1,courseId);
			//int p=getPollid();
			st.setInt(2,p);
			ResultSet rs=st.executeQuery();	
			rs.next();
			count=rs.getInt(1);			
	     }
		 
		 catch (SQLException e) 
		 {
				e.printStackTrace();
		 }
		finally{
			try {
				st.close();
				dbconn.closeLocalConnection(con);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		return count;
	
	}
	
	
	
// saving poll question
	public void savepollquestion(String pollquestion,String courseId,String timestamp) throws SQLException{
		System.out.println("in poll question saving...");
		DatabaseConnection dbcon = new DatabaseConnection();
		try{

			
			con=dbcon.createDatabaseConnection();
			st = con.prepareStatement("INSERT INTO pollquestion (Question,CourseId,TimeStamp) VALUES (?,?,?)",Statement.RETURN_GENERATED_KEYS );
			st.setString(1,pollquestion);
			st.setString(2,courseId);
			st.setString(3,timestamp);
			st.executeUpdate();
			ResultSet rs=st.getGeneratedKeys();
			if (rs.next()) {
				setPollid(rs.getInt(1));
								
			} else {
				throw new RuntimeException("PIB, can't find most recent insert we just entered");
			}
			
		}
		catch (SQLException e2) {
			// Exception when executing java.sql related commands, print error message to the console
			e2.printStackTrace();
		}finally{
			st.close();
			dbcon.closeLocalConnection(con);
		}

	}
	
	public int getpollidnew(String launchtime, String courseid) throws SQLException
	{
		
			int pollidnew = 0;
			Connection conn = null;

			DatabaseConnection dbcon = new DatabaseConnection();
			conn=dbcon.createDatabaseConnection();
			try{
				String selectpollquery="select PollID from pollquestion where CourseID=? and TimeStamp=?";
				st = conn.prepareStatement(selectpollquery);
				st.setString(1,courseid);	
				st.setString(2,launchtime);
				
				ResultSet resultSet = st.executeQuery();

				while (resultSet.next())
				{
					pollidnew = resultSet.getInt("PollID");
					
				}

				resultSet.close();
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
			finally{
				try {
					st.close();
					dbcon.closeLocalConnection(conn);

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return pollidnew;	

		
		
		
	}
//saving responses	
	public void savepollresponse(String studentid, String response , String launchtime, String courseid) throws SQLException{
		System.out.println("in poll response saving...");
		int p=getpollidnew(launchtime,courseid);
		DatabaseConnection dbcon = new DatabaseConnection();
		try{

			
			con=dbcon.createDatabaseConnection();
			/*
			 * querry to insert the raise question into database wrt student id ,courseid
			 */
			java.util.Date date= new java.util.Date();
			new Timestamp(date.getTime());
			int option=Integer.parseInt(response);
			
			st = con.prepareStatement("INSERT INTO poll (StudentID,Response,TimeStamp,PollID) VALUES (?,?,?,?)");
			st.setString(1,studentid);
			st.setInt(2,option);
			st.setString(3,launchtime);
			
			st.setInt(4,p);
			
			st.executeUpdate();		
		}
		catch (SQLException e2) {
			// Exception when executing java.sql related commands, print error message to the console
			e2.printStackTrace();
		}finally{
			st.close();
			dbcon.closeLocalConnection(con);
		}
		
		

	}
	
	
}