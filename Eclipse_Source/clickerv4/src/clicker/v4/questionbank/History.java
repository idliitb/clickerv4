package clicker.v4.questionbank;
/**
 * @author Harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: This Class displays the history of edited questions.
 */
import clicker.v4.databaseconn.*;
import java.sql.*;

public class History 
{
	
	private String instructor;
	private int qid;
	private String instructorid, question, optionvalue;
		 
	public History (int questionid, String quest, String instrid, String optionvalue)
	{
		qid = questionid;
		question = quest;
		instructorid = instrid;
		this.optionvalue = optionvalue;
	}
	
	public History(int questionid)
	{
		qid = questionid;
	}
	
	public void addentry( )
	{
		DatabaseConnection dbconn = new DatabaseConnection ( );
		Connection conn = dbconn.createDatabaseConnection();
		
		try
		{
			java.util.Date currentDatetime = new java.util.Date(System.currentTimeMillis());
			java.sql.Timestamp timestamp = new java.sql.Timestamp(currentDatetime.getTime());
			
			
			PreparedStatement st = null, st1 = null;
			
			st = conn.prepareStatement("select InstrName from instructor where InstrID = ?");
			st.setString(1, instructorid);
			ResultSet rs = st.executeQuery();
			while(rs.next()){
				
				instructor=rs.getString(1);
				
			}
			
			st1  = conn.prepareStatement("insert into questionshistory (QuestionID, Question, Instructor, Date, OptionValue) values (?, ?, ?, ?, ?)");
			st1.setInt(1, qid);
			st1.setString(2, question);
			st1.setString(3, instructor);
			st1.setTimestamp(4, timestamp);
			st1.setString(5, optionvalue);
			st1.executeUpdate();
			
			
			System.out.println ("Entry added to History");
			st.close ( );
			st1.close();
		}
		catch (Exception ex)
		{
			System.out.println ("The error is: " + ex);
		}
		finally
		{
			dbconn.closeLocalConnection(conn);
		}
	}
	
	/*public String[ ] viewhistory(int questionid)
	{
		String [ ] temp1, temp2, temp3, temp4;
		
		Connection conn = null;
		DatabaseConnection db = new DatabaseConnection ( );
		conn = db.createDatabaseConnection ( );
		PreparedStatement st = null;
			
		int qtype = -1;
		
		
		String question = "", instructor = "", date = "";
		String delimiter = ";";
		
		try
		{
			st = conn.prepareStatement("select Question, Instructor, Date from questionshistory where QuestionID = ? ORDER BY Date asc");
			st.setInt(1, qid);
		
		
			
			ResultSet rs = st.executeQuery( );
				
			while (rs.next())
			{
				
				instructor += (rs.getString("Instructor")) + ";";
				question += (rs.getString ("Question")) + ";";
				date += (rs.getTimestamp("Date")) + ";";
			}
			
			temp1 = instructor.split(delimiter);
			temp2 = question.split (delimiter);
			temp3 = date.split(delimiter);
			
			
		}
		catch (Exception e)
		{
			System.out.println ("Fatal Error! Exiting due to " + e);
		}
	}*/

}