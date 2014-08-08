package clicker.v4.managequiz;

import clicker.v4.databaseconn.*;

import java.sql.*;
import java.util.*;

/**
 * 
 * @author harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: This class selects and displays all the active quizzes from the database for deletion
 */

public class QuizNameSelect 
{
	public int quiztype = 0;
	String quizname [ ];
	public String [ ] quiz_Name(int qt, String courseID)
	{
		quiztype = qt;
		Connection conn = null;
		DatabaseConnection dbconn = new DatabaseConnection ( );
		try
		{
			
			conn = dbconn.createDatabaseConnection();			
			PreparedStatement ps = null;
			ps = conn.prepareStatement("Select QuizName from quiz where QuizType = ? and CourseID = ? and Archived = 0");
			ps.setInt(1, quiztype);
			ps.setString(2, courseID);			
			ResultSet rs = ps.executeQuery( );
			rs.last();
			int n = rs.getRow( );
			rs.beforeFirst();
			quizname = new String[n];
			int i = 0;
			while (rs.next())
			{			
				quizname[i] = rs.getString("QuizName");
				i++;
			}		
			rs.close( );
			ps.close( );					
		}catch(SQLException e)
		{
			e.printStackTrace( );
		}finally{
			dbconn.closeLocalConnection(conn);
		}
		
		return quizname;
		
	}
	
	public int getQuizID(Connection conn, String QuizName) {
		int QuizID = 0;
		String Query = "SELECT QuizID FROM quiz WHERE QuizName='" + QuizName
				+ "'";
		ResultSet result = null;

		Statement st;
		try {
			st = conn.createStatement();
			result = st.executeQuery(Query);

			while (result.next()) {
				QuizID = result.getInt("QuizID");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return QuizID;
	}
	
	public Vector<Question> getallQuestionDetails(Connection conn, String QuizID) {
		Vector<Question> QuestionList = new Vector<Question>();

		String QuestionIDs[] = getQuestionIDsinQuiz(conn, QuizID);
		String QuestionText_Type="";
		String QuestionText="";
		for (int i = 0; i < QuestionIDs.length; i++) {
			QuestionText_Type = displayQuestionText(conn, QuestionIDs[i]);
			QuestionText = QuestionText_Type.split("@@")[0];
			//QuestionText = QuestionText.replace("\r\n", " ").replace("\n", " ").replace("\"", "\\\"").replace("\'", "\\\'");
			int questionType = Integer.parseInt(QuestionText_Type.split("@@")[1]);
			String QuestionOptionsIDs[] = getQuestionOptionIDs(conn,QuestionIDs[i], QuizID);
			Question quest = new Question();						
			quest.setQuestionID(QuestionIDs[i]);
			quest.setQuestionText(QuestionText);
			quest.setQuestionType(questionType);
			for (int j = 0; j < QuestionOptionsIDs.length; j++) {
				try {
					Option opt = getOptionDetails(conn, QuestionOptionsIDs[j], QuestionIDs[i]);
					quest.addOption(opt);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			QuestionList.addElement(quest);
		}
		return QuestionList;
	}
	
	public String[] getQuestionOptionIDs(Connection conn, String QuestionID,
			String QuizID) {
		// This needs to be updated in the future to reflect LOD
		String Query = "select OptionID " + "from options "
				+ "where OptionID in "
				+ "(select OptionID from quizquestionoption "
				+ "where QuestionID='" + QuestionID + "' " + "AND QuizID='"
				+ QuizID + "')";

		String[] optionName;
		ResultSet result;
		result = runResultSetQuery(conn, Query);

		try {
			System.out.println("Debugging rows at start" + result.getRow());
			result.last();
			System.out.println("Debugging rows at last" + result.getRow());
			int n = result.getRow();
			result.beforeFirst();
			System.out.println("Debugging rows at beforeFirst"
					+ result.getRow());
			optionName = new String[n];

			int i = 0;
			while (result.next()) {
				optionName[i] = result.getString(1);
				i++;
			}
		} catch (Exception ex) {
			optionName = null;
		}
		return optionName;
	}
	
	public ResultSet runResultSetQuery(Connection conn, String Query) {
		ResultSet result = null;
		try {
			if (conn != null) {
				Statement st = conn.createStatement();
				result = st.executeQuery(Query);
			}

		} catch (Exception ex) {
			System.out.println(ex);
		}
		return result;
	}
	
	public String displayQuestionText(Connection conn, String QuestionID) {

		String Query = "SELECT Question, QuestionType FROM question WHERE QuestionID= '"
				+ QuestionID + "'";
		ResultSet result = null;
		String ResultArray = null;
		int questionType = 0;
		try {
			if (conn != null) {
				Statement st = conn.createStatement();
				result = st.executeQuery(Query);
				if (result.next()) {
					Blob b = result.getBlob(1);
					byte[] bdata = b.getBytes(1, (int) b.length());
					ResultArray = new String(bdata);
					questionType = result.getInt("QuestionType");
				}
			}
		} catch (Exception ex) {
			System.out.println(ex);
		}
		return ResultArray + "@@" + questionType;
	}
	
	public String[] getQuestionIDsinQuiz(Connection conn, String QuizID) {
		String Query = "SELECT QuestionID FROM quizquestion  WHERE QuizID = '"
				+ QuizID + "'";
		ResultSet result = null;
		String[] ResultArray = null;

		try {
			Statement st = conn.createStatement();
			result = st.executeQuery(Query);
			int i = 0;
			int count = 0;
			while (result.next()) {
				count++;
			}
			ResultArray = new String[count];
			result = st.executeQuery(Query);
			while (result.next()) {

				ResultArray[i] = result.getString(1);
				i++;
			}
		} catch (Exception ex) {
			ResultArray = new String[1];
			System.out.println(ex);
		}
		return ResultArray;
	}
	
	public Option getOptionDetails(Connection conn, String optionid,
			String questionid) throws SQLException {
		// String[] details = new String[6];
		Option op = new Option();
		String Query = "select * from options where OptionID = '" + optionid
				+ "'";

		ResultSet result = runResultSetQuery(conn, Query);
		result.next();
		op.setOptionID(result.getString("OptionID"));
		op.setOptionValue(result.getString("OptionValue"));
		op.setExp(result.getString("OptionDesc"));
		op.setCorrect(result.getBoolean("OptionCorrectness"));
		op.setLOD(result.getInt("LevelofDifficulty"));
		op.setCredit(result.getFloat("Credit"));
		op.setQuestionId(questionid);

		return op;
	}
	
	public String[ ] getQuizTimestamp(int QuizID) throws SQLException
	{
		System.out.println("In QNS quiz id: " + QuizID);
		DatabaseConnection dbconn = new DatabaseConnection ( );
		Connection conn = dbconn.createDatabaseConnection();
		PreparedStatement ps1 = conn.prepareStatement("Select TimeStamp from quizrecord where QuizID = ? ORDER BY Timestamp desc");
		ps1.setInt(1, QuizID);
		ResultSet rs = ps1.executeQuery();
		int i = 0;
		rs.last();
		int n = rs.getRow( );
		rs.beforeFirst();
		String timestamp[ ] = new String[n];
		while(rs.next())
		{
			timestamp[i] = rs.getString("TimeStamp");
			i++;
		}
		ps1.close( );
		dbconn.closeLocalConnection(conn);
		
		
		
		
		return timestamp;
	}
}