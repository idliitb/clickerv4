package clicker.v4.questionbank;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;
import clicker.v4.databaseconn.*;

/**
 * @author Harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: This servlet inserts the edited Single Choice Correct questions in the database.
 * Servlet implementation class SingleChoice_editDB
 */
//@WebServlet("/singlechoice_editdb")
public class SingleChoice_editDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SingleChoice_editDB() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		Connection conn = null;
		PreparedStatement st =null, st1 = null, st2 = null, st3 = null, st4=null, st5=null;
		String instructorid = (String) request.getSession().getAttribute("InstructorID");
		int option_count=-1, old_option_count=-1;
		String question = null, optionvalue = "";
		PrintWriter out = response.getWriter();
		try
		{
			DatabaseConnection dbcon = new DatabaseConnection();	
			conn = dbcon.createDatabaseConnection();	
			option_count = Integer.parseInt(request.getParameter("count"));
			old_option_count = Integer.parseInt(request.getParameter("old_count"));
			String[] options= new String[option_count];
			System.out.println("option IDs: " + request.getParameter("optionIDs"));
			String[] optionIDs = request.getParameter("optionIDs").split(";");
			int correctOption = Integer.parseInt(request.getParameter("option"))-1;
			int correctness =0;
			float credits = Float.parseFloat(request.getParameter("credits"));
			float negativemarks = Float.parseFloat(request.getParameter("negativemarks"));
			System.out.println("Credits: " + credits);
			int shuffle = 1;
			if(request.getParameter("shuffle") != null)
				shuffle = 0;
			System.out.println("shuffle: " + shuffle);
			question = request.getParameter("singlechoicequest");	
			int qid = -1;
			qid = Integer.parseInt(request.getParameter("qid"));
			st = conn.prepareStatement("update question set Question= ?, Credit = ?, Shuffle = ?, NegativeMark = ? where QuestionID= ?");
			st.setString(1,question);
			st.setFloat(2, credits);
			st.setInt(3, shuffle);
			st.setFloat(4, negativemarks);
			st.setInt(5,qid);
			st.executeUpdate();
			st.close();
			st1 = conn.prepareStatement("update options set OptionValue = ?, OptionCorrectness = ?, Credit = ? where OptionID= ?");
			
			if(old_option_count<=option_count){
				for(int i=0;i<old_option_count;i++)
				{
					st1.setString(1,request.getParameter(""+(i+1)));
					optionvalue += request.getParameter(""+(i + 1)).toString() + ",";
					st1.setInt(2,correctOption==i?1:0);
					st1.setFloat(3, credits);
					st1.setInt(4,Integer.parseInt(optionIDs[i]));
					
					st1.executeUpdate();
				}	
				st1.close();
				st2 = conn.prepareStatement("Insert into options(OptionValue,OptionCorrectness,LevelofDifficulty,Archived,Credit,QuestionID) values(?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
				st3 = conn.prepareStatement("Insert into quizquestionoption(QuizID, QuestionID, OptionID) values (?, ?, ?)");
				for(int i=old_option_count;i<option_count;i++)
				{
						st2.setString(1,request.getParameter(""+(i+1)));
						optionvalue += request.getParameter(""+(i + 1)).toString() + ",";
						st2.setInt(2,correctOption==i?1:0);		
						st2.setInt(3,1);
						st2.setInt(4,0);
						st2.setFloat(5,credits);
						st2.setInt(6,qid);
						st2.executeUpdate();	
						ResultSet res = st2.getGeneratedKeys();
						int optionid =0;
						if (res.next())
						{
							optionid = res.getInt(1);
						}				
						PreparedStatement preparedStatement = conn.prepareStatement("SELECT distinct QuizID from quizquestionoption where QuestionID = ?");
						preparedStatement.setInt(1, qid);
						ResultSet rs = preparedStatement.executeQuery();
						while (rs.next()) {
							int quizid = rs.getInt("QuizID");	
							st3.setInt(1,quizid);		
							st3.setInt(2,qid);
							st3.setInt(3,optionid);
							st3.executeUpdate();
						}				
				}	
				st3.close();
				st2.close();
			}		
			else if(old_option_count>option_count){
				for(int i=0;i<option_count;i++)
				{
					st1.setString(1,request.getParameter(""+(i+1)));
					optionvalue += request.getParameter(""+(i + 1)).toString() + ",";
					st1.setInt(2,correctOption==i?1:0);
					st1.setFloat(3, credits);
					st1.setInt(4,Integer.parseInt(optionIDs[i]));	
					st1.executeUpdate();
				}	
				st1.close();
				st4 = conn.prepareStatement("Delete from quizquestionoption where OptionID = ?");
				st5 = conn.prepareStatement("Delete from options where OptionID = ?");
				for(int i=option_count;i<old_option_count;i++)
				{
						st4.setInt(1, Integer.parseInt(optionIDs[i]));				
						st4.executeUpdate();	
						st5.setInt(1, Integer.parseInt(optionIDs[i]));				
						st5.executeUpdate();
				}
				st4.close();
				st5.close();
			}	
			dbcon.closeLocalConnection(conn);
			
			/*//Adding entry in the history table
			optionvalue = optionvalue.substring(0, optionvalue.length()-1);
			History history = new History (qid, question, instructorid, optionvalue);
			history.addentry ();*/
			
			response.sendRedirect("jsp/questionbank/questionbank.jsp");
		}	
		catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}

}