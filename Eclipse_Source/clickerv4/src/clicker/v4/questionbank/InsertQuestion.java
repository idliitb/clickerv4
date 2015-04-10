package clicker.v4.questionbank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * 
 * @author Harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: This class inserts the questions in database
 */
public class InsertQuestion {
	/*
	 * It inserts the question and it's associated details into the database.
	 * Finally returns it the questionID so that the options can be inserted as
	 * well.
	 */
	public int insertQuestion(Connection conn, String Question, int LevelOfDifficulty, int Archived, float Credit,
			int math_select, String ImageName, int QuestionType, String InstrID, int shuffle, String courseid, float negativemark) {
		
		int QuestionID = -1;
		try {
			PreparedStatement st = conn.prepareStatement("Insert into question(Question,LevelOfDifficulty,Archived,Credit," +
														 "MathSelect, ImageName,QuestionType,InstrID, Shuffle, CourseID, NegativeMark) " +
														 "values(?, ?,?,?,?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
			st.setString(1, Question);
			st.setInt(2, LevelOfDifficulty);
			st.setInt(3, Archived);
			st.setFloat(4, Credit);
			st.setInt(5, math_select);
			st.setString(6, ImageName);
			st.setInt(7, QuestionType);
			st.setString(8,InstrID);
			st.setInt(9, shuffle);
			st.setString(10, courseid);
			st.setFloat(11, negativemark);
			st.executeUpdate();
			ResultSet rs = st.getGeneratedKeys();
			if (rs.next()) {
				QuestionID = rs.getInt(1);
			} else {
				throw new RuntimeException("PIB, can't find most recent insert we just entered");
			}
			
		} catch (Exception e) {
			System.out.print("Exception in InsertQuestion: ");
			e.printStackTrace();
		} 
		return QuestionID;	
	}
}