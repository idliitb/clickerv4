package clicker.v4.questionbank;

import java.sql.Connection;
import java.sql.PreparedStatement;

import clicker.v4.databaseconn.DatabaseConnection;
/**
 * 
 * @author Harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: This Class inserts the options in the database.
 */
public class InsertOptions {
	public void insertOption(String optionValue,
			String optionDesc, int optionCorrectness, int LevelOfDifficulty,
			int archived, float credit, int questionID) {
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection conn = dbconn.createDatabaseConnection();
		try {
			PreparedStatement statement = conn
					.prepareStatement("Insert into options(OptionValue,OptionDesc,OptionCorrectness,LevelofDifficulty,Archived,Credit,QuestionID) values(?,?,?,?,?,?,?)");
			// out.println(request.getParameter(options[i]));
			statement.setString(1, optionValue);
			statement.setString(2, "Nothing");
			statement.setInt(3, optionCorrectness);
			statement.setInt(4, LevelOfDifficulty);
			statement.setInt(5, archived);
			statement.setFloat(6, credit);
			statement.setInt(7, questionID);
			statement.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("Fatal Error!!! Exiting due to-> " + e);
		}
		finally
		{
			dbconn.closeLocalConnection(conn);
		}

	}
}