package clicker.v4.managequiz;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import clicker.v4.databaseconn.DatabaseConnection;
import java.sql.Connection;

import java.sql.Statement;

/**
 * 
 * @author harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: This class selects the questions from the database
 */

public class RetrieveQuestionsModel {
	private Connection conn=null;
	private Statement statement=null;
	private String searchParameter=null;
	private ArrayList<QuestionSave> list=new ArrayList<QuestionSave>();
	int qtype = 0, selector = 0;;
	private String InstrID=null, courseid = null;
	public RetrieveQuestionsModel(int qtype, String InstrID, String courseid, int selector){
		DatabaseConnection dbcon = new DatabaseConnection();
		try{
			
			conn = dbcon.createDatabaseConnection();
			this.qtype = qtype;
			this.InstrID=InstrID;
			this.courseid = courseid;
			System.out.println("Course id: " + this.courseid);
			this.selector = selector;
		}
		catch(Exception ex){
			System.out.println("Exception At 1");
			ex.printStackTrace();
		}
		finally
		{
			dbcon.closeLocalConnection(conn);
		}
	}
	public void setSearchParameter(String s){
		searchParameter=s;
	}
	public ArrayList<QuestionSave> getQuestions(){
		DatabaseConnection dbcon = new DatabaseConnection();
		conn = dbcon.createDatabaseConnection();
		try {
			statement=(Statement) conn.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Exception At 2");
			e.printStackTrace();
		}
		try {
			if(selector == 00)
			{
				//System.out.println("Course id: " + courseid);
				//System.out.println("Selector 00: " + selector);
				System.out.println("Search parameter: " + searchParameter);
				if(qtype == 0)
					statement.execute("SELECT QuestionID,Question,Archived, QuestionType FROM question WHERE InstrID='"+InstrID+"' and UPPER(CONVERT(Question USING latin1)) LIKE '%"+((searchParameter==null)?("%"):(searchParameter))+"%' and CourseID = '" + courseid + "' order by QuestionID desc");
				else
					statement.execute("SELECT QuestionID,Question,Archived, QuestionType FROM question WHERE InstrID='"+InstrID+"' and UPPER(CONVERT(Question USING latin1)) LIKE '%"+((searchParameter==null)?("%"):(searchParameter))+"%' AND QuestionType=" + qtype + " and CourseID = '" + courseid + "' order by QuestionID desc");
			}
			else
			{
				System.out.println("Selector 01: " + selector);
				if(qtype == 0)
					statement.execute("SELECT QuestionID,Question,Archived FROM question WHERE InstrID != '"+InstrID+"' and UPPER(CONVERT(Question USING latin1)) LIKE '%"+((searchParameter==null)?("%"):(searchParameter))+"%' and CourseID = '" + courseid + "' order by QuestionID desc");
				else
					statement.execute("SELECT QuestionID,Question,Archived, QuestionType FROM question WHERE InstrID != '"+InstrID+"' and UPPER(CONVERT(Question USING latin1)) LIKE '%"+((searchParameter==null)?("%"):(searchParameter))+"%' AND QuestionType=" + qtype + " and CourseID = '" + courseid + "' order by QuestionID desc");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Exception At 4");
			e.printStackTrace();
		}
		ResultSet rs=null;
		try {
			rs=(ResultSet) statement.getResultSet();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Exception At 5");
			e.printStackTrace();
		}
		try {
			while(rs.next()){
				if(rs.getInt("Archived")==0)
				{
					System.out.println("Questions: " + rs.getString("Question"));
					list.add(new QuestionSave(Integer.parseInt(rs.getString("QuestionID")),rs.getString("Question")));
				}
			}
			statement.close();
			dbcon.closeLocalConnection(conn);
		}
		catch(Exception ex){
			ex.printStackTrace();
		}
		return list;
	}
}
