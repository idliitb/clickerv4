package clicker.v4.questionbank;

import java.sql.*;

import clicker.v4.databaseconn.*;

/**  
 * @author Harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: This Class selects the questions from the database based on the question type, archived or not.
 */
public class GetAllQuestions {
	Connection con;
	String quest, credits = "", shuffle = "", question_repeated = "";
	private int archive = 0;

	public void setAllQuestions(int archive) {
		this.archive = archive;
	}

	public GetAllQuestions() {
		// TODO Auto-generated constructor stub
		con = null;
		quest = "";
	}

	public String getAllQuestions(int qtype,String InstrID, String courseid, int selector, int math_select) {
		DatabaseConnection db = new DatabaseConnection();
		con = db.createDatabaseConnection();
		String query = null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		//List<String> question = new ArrayList<String>( );
		
		try {
				if(selector == 00)
				{
					if (qtype != 0)
					{
						query = "select Question, QuestionID, Archived, Shuffle, Credit, QuestionType from question where QuestionType=? and InstrID=? and CourseID=? and MathSelect = ? order by QuestionID desc ";
						pstmt = con.prepareStatement(query);
						pstmt.setInt(1, qtype);
						pstmt.setString(2,InstrID);
						pstmt.setString(3, courseid);
						pstmt.setInt(4, math_select);
					}
					else 
					{
						query="select Question,QuestionID,Archived, Shuffle, Credit, QuestionType from question where InstrID=? and CourseID=? order by QuestionID desc ";
						pstmt=con.prepareStatement(query);
						pstmt.setString(1,InstrID);
						pstmt.setString(2, courseid);
					}
					
					
					rs = pstmt.executeQuery( );
				if(rs!=null){
				while(rs.next()) {
					
					if(rs.getInt("Archived") == 0 && archive == 0)
					{
							quest+=rs.getString("Question");
							quest+="@~";
							quest+=rs.getString("QuestionID");
							quest+="@@";
							credits += rs.getFloat("Credit") + "#";
							shuffle += rs.getInt("Shuffle") + "!";
							question_repeated += getQuizQuestionCount(con, rs.getString("QuestionID")) + "$";
					}
					
					else if(rs.getInt("Archived") == 1 && archive == 1)
					{
							quest+=rs.getString("Question");
							quest+="@~";
							quest+=rs.getString("QuestionID");
							quest+="@@";
							credits += rs.getFloat("Credit") + "#";
							shuffle += rs.getInt("Shuffle") + "!";
							question_repeated += getQuizQuestionCount(con, rs.getString("QuestionID")) + "$";
					}
					
				}
				}
			}
			else if(selector == 01)
			{
				if (qtype != 0)
				{
					query = "select Question, QuestionID, Archived, Shuffle, Credit, QuestionType from question where QuestionType=? and CourseID=? and InstrID != ? and MathSelect = ? order by QuestionID desc ";
					pstmt = con.prepareStatement(query);
					pstmt.setInt(1, qtype);
					pstmt.setString(2, courseid);
					pstmt.setString(3, InstrID);
					pstmt.setInt(4, math_select);
				}
				else 
				{
					query="select Question,QuestionID,Archived, Shuffle, Credit, QuestionType from question where CourseID=? and InstrID != ? order by QuestionID desc ";
					pstmt=con.prepareStatement(query);
					pstmt.setString(1, courseid);
					pstmt.setString(2, InstrID);
				}
				
				
				rs = pstmt.executeQuery( );
				if(rs!=null){
				while(rs.next()) {
					
					if(rs.getInt("Archived") == 0 && archive == 0)
					{
						
							quest+=rs.getString("Question");
							quest+="@~";
							quest+=rs.getString("QuestionID");
							quest+="@@";
							credits += rs.getFloat("Credit") + "#";
							shuffle += rs.getInt("Shuffle") + "!";	
							question_repeated += getQuizQuestionCount(con, rs.getString("QuestionID")) + "$";
					}
					
					else if(rs.getInt("Archived") == 1 && archive == 1)
					{
						
							quest+=rs.getString("Question");
							quest+="@~";
							quest+=rs.getString("QuestionID");
							quest+="@@";
							credits += rs.getFloat("Credit") + "#";
							shuffle += rs.getInt("Shuffle") + "!";
							question_repeated += getQuizQuestionCount(con, rs.getString("QuestionID")) + "$";
					}
					
					}
				}
			}
			else{
				System.out.println("Result set is empty");
			}
			rs.close();
			pstmt.close();
			db.closeLocalConnection(con); 
			if(!quest.equals(""))
			{
				/*System.out.println("--->" + quest.substring(0, quest.length() - 1));
				System.out.println("--->" + credits.substring(0, credits.length() - 1));
				System.out.println("--->" + shuffle.substring(0, shuffle.length() - 1));
				System.out.println("--->" + question_repeated.substring(0, question_repeated.length() - 1));*/
				
				quest = quest.substring(0, quest.length() - 2) + "#@" + credits.substring(0, credits.length() - 1) + "!@" 
						+ shuffle.substring(0, shuffle.length() - 1) + "$@" + question_repeated.substring(0, question_repeated.length() - 1);
			}
		} catch (Exception e) {
			System.out.print("Exception in getallquestions in get all questions file: ");
			e.printStackTrace();
		}
		return quest.substring(0, quest.length());
	}
	
	public String getQuizQuestionCount(Connection con, String questionid)
	{
		PreparedStatement ps = null;
		String question_count = "";
		ResultSet rs = null;
		
		try {
				ps = con.prepareStatement("Select count(QuestionID) as quest_count from quizquestion where QuestionID = ?");
				ps.setInt(1, Integer.parseInt(questionid));
				
				rs = ps.executeQuery();
				
				while(rs.next())
					question_count = Integer.toString(rs.getInt("quest_count"));
				
				//System.out.println("Question Count: " + question_count);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.print("Exception in getquizquestioncout in get all questions file: ");
			e.printStackTrace();
		}
		finally
		{
			try {
				rs.close( );
				ps.close();				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.print("Exception in getquizquestioncout in get all questions file: " + e);
				e.printStackTrace();
			}
		}
		return question_count;
		
	}
}