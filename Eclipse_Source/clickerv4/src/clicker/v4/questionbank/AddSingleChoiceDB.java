package clicker.v4.questionbank;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import clicker.v4.databaseconn.*;
import java.sql.*;

/**
 * @author Harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: Servlet implementation class addquestionDB. This Class adds the Single Choice Correct Questions in the Database
 */
//@WebServlet("/addsinglechoicedb")
public class AddSingleChoiceDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddSingleChoiceDB() {
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
		
		String question, optionvalue = "";
		Connection conn = null;
		PreparedStatement st =null, st2 = null;
		String instructorid = (String) request.getSession().getAttribute("InstructorID");
		float credits = Float.parseFloat(request.getParameter("credits"));
		float negativemark = Float.parseFloat(request.getParameter("negativemark"));
		String courseid = (String) request.getSession().getAttribute("courseID");			   
		int shuffle = 1, math_select = Integer.parseInt(request.getParameter("math_option"));
		if(request.getParameter("shuffle") != null)
			shuffle = 0;
		//System.out.println("shuffle: " + shuffle);
		DatabaseConnection dbcon = new DatabaseConnection();
		try
		{
				
			conn = dbcon.createDatabaseConnection();
			st = conn.prepareStatement("Insert into question(Question,LevelOfDifficulty,Archived,Credit, MathSelect, QuestionType,InstrID, Shuffle, CourseID, NegativeMark) values(?, ?,?,?,?,?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS );
			st2 = conn.prepareStatement("Insert into options(OptionValue,OptionCorrectness,LevelofDifficulty,Archived,Credit,QuestionID) values(?,?,?,?,?,?)");		 
		}
		catch(Exception ex)
		{
			System.out.println("Exception in AddSingleChoiceDB: " + ex);
		}


		int correctOption=0, ctr=-1, question_type = 1;
			ctr = Integer.parseInt(request.getParameter("count"));
			String[] options= new String[ctr];
			question = request.getParameter("singleaddquest");
			//String whitespace = "\r\n";
			
			if(math_select != 1)
			{
				//question_type = 5;
				shuffle = 0;
			}
			//else
				//question_type = 1;
			for(int i=0;i<ctr;i++)
			{
				
				options[i] = request.getParameter(""+(i+1));
				optionvalue += options[i] + ",";
				/*if(math_select != 1)
					question += whitespace + "Option " + ((char) ch++) + ": " + request.getParameter(""+(i+1));
				else
				{
					options[i] = request.getParameter(""+(i+1));
					optionvalue += options[i] + ",";
				}*/
			}
			correctOption = Integer.parseInt(request.getParameter("option"))-1;
			int qid = -1;
			System.out.println("Question: " + question + "math_select: " + math_select);
			try
			{
			st.setString(1,question);
			st.setInt(2,1);
			st.setInt(3,0);
			st.setFloat(4,credits);
			st.setInt(5,math_select);
			st.setInt(6,question_type);
			st.setString(7,instructorid);
			st.setInt(8, shuffle);
			st.setString(9, courseid);
			st.setFloat(10,negativemark);
			
			st.executeUpdate();
			ResultSet rs=st.getGeneratedKeys();
			if (rs.next()) 
			{
				qid = rs.getInt(1);
			} 
			else 
			{
				throw new RuntimeException("PIB, can't find most recent insert we just entered");
			}
			}
			catch(Exception ex)
			{
				System.out.print("Exception in QuizCreator: ");
				ex.printStackTrace();
				
			}
			
			// Adding entry to history table
			optionvalue = optionvalue.substring(0, optionvalue.length()-1);
			History history = new History (qid, question, instructorid, optionvalue);
			history.addentry ();
			
			try
			{
				//ch = 65;
			for(int i=0;i<ctr;i++)
			{
					/*if(math_select != 1)					
						st2.setString(1, Character.toString((char) ch++));
					else*/
					st2.setString(1,options[i]);
					if(i==correctOption)
						st2.setInt(2,1);
					else
						st2.setInt(2,0);
					st2.setInt(3,1);
					st2.setInt(4,0);
					st2.setFloat(5,credits);
					st2.setInt(6,qid);
				
					st2.executeUpdate();
				}
			}
				catch(Exception ex)
				{
					System.out.print("Exception in AddSingleChoiceDB: ");
					ex.printStackTrace();
				}
			
		try
		{
			st.close();
			st2.close();
			dbcon.closeLocalConnection(conn);
		}
		catch(Exception ex)
		{
			System.out.print("Exception in AddSingleChoiceDB: ");
			ex.printStackTrace();
		}



		response.sendRedirect("jsp/questionbank/questionbank.jsp");
	}

}