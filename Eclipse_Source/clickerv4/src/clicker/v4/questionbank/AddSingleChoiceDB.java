package clicker.v4.questionbank;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.*;
import clicker.v4.databaseconn.*;
import java.io.FileInputStream.*;
import java.sql.*;
import java.util.*;
import java.io.*;

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
		int shuffle = 1;
		if(request.getParameter("shuffle") != null)
			shuffle = 0;
		System.out.println("shuffle: " + shuffle);
		DatabaseConnection dbcon = new DatabaseConnection();
		try
		{
				
			conn = dbcon.createDatabaseConnection();
			st = conn.prepareStatement("Insert into question(Question,LevelOfDifficulty,Archived,Credit,QuestionType,InstrID, Shuffle, CourseID, NegativeMark) values(?,?,?,?,?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS );
			st2 = conn.prepareStatement("Insert into options(OptionValue,OptionCorrectness,LevelofDifficulty,Archived,Credit,QuestionID) values(?,?,?,?,?,?)");		 
		}
		catch(Exception ex)
		{
			System.out.println(ex);
			System.out.println("Here:");
		}


		int correctOption=0, ctr=-1;
			ctr = Integer.parseInt(request.getParameter("count"));
			String[] options= new String[ctr];
			question = request.getParameter("singleaddquest");
			
			for(int i=0;i<ctr;i++)
			{
				options[i] = request.getParameter(""+(i+1));
				optionvalue += options[i] + ",";
			}
			correctOption = Integer.parseInt(request.getParameter("option"))-1;
			int qid = -1;
			
			try
			{
			st.setString(1,question);
			st.setInt(2,1);
			st.setInt(3,0);
			st.setFloat(4,credits);
			st.setInt(5,1);
			st.setString(6,instructorid);
			st.setInt(7, shuffle);
			st.setString(8, courseid);
			st.setFloat(9,negativemark);
			
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
				ex.printStackTrace();
			}
			
			/*// Adding entry to history table
			optionvalue = optionvalue.substring(0, optionvalue.length()-1);
			History history = new History (qid, question, instructorid, optionvalue);
			history.addentry ();*/
			
			try
			{		
			for(int i=0;i<ctr;i++)
			{
			
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
					//ex.printStackTrace();
				}
			
		try
		{
			st.close();
			st2.close();
			dbcon.closeLocalConnection(conn);
		}
		catch(Exception ex)
		{
			//ex.printStackTrace();
		}



		response.sendRedirect("jsp/questionbank/questionbank.jsp");
	}

}