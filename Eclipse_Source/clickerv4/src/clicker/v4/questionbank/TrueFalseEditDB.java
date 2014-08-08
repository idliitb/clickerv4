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
 * Description: This servlet inserts the edited True or False type questions in the database.
 * Servlet implementation class TrueFalseEditDB
 */
//@WebServlet("/truefalseeditdb")
public class TrueFalseEditDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TrueFalseEditDB() {
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
		
		String instructorid = (String) request.getSession().getAttribute("InstructorID");
		DatabaseConnection dbconn = new DatabaseConnection();
		Connection conn = dbconn.createDatabaseConnection();
		PrintWriter out = response.getWriter();
		String option=request.getParameter("option");
		System.out.println("OValue: " + option);
		try
		{		
		String query1="update question set Question= ?, Credit = ?, Shuffle = ?, NegativeMark = ? where QuestionID= ?" ;
		System.out.println("Query: " + query1);
		PreparedStatement st =conn.prepareStatement(query1);
		System.out.println("after prepared statement");
		int qid = Integer.parseInt(request.getParameter("qid"));
		System.out.println("QuestionID: " + qid);
		String question=request.getParameter("edittfquest");
		System.out.println("Question: " + question);
		String image = request.getParameter("browse");
		float credits = Float.parseFloat(request.getParameter("credits"));
		float negativemarks = Float.parseFloat(request.getParameter("negativemarks"));
		System.out.println("Negative Marks........... T/F: " + negativemarks);
		int shuffle = 1;
		if(request.getParameter("shuffle") != null)
			shuffle = 0;
		System.out.println("shuffle: " + shuffle);
		
		st.setString(1, question);
		st.setFloat(2, credits);
		st.setInt(3, shuffle);
		st.setFloat(4, negativemarks);
		st.setInt(5, qid);	
		
		/*// Adding entry into the history table
		History history = new History (qid, question, instructorid, option);
		history.addentry ();*/	
		
		int rs=st.executeUpdate();
		String query3 = "", query4 = "";
		
		out.println(option);
		if(option.equals("true")){
			
			query3="update options set OptionCorrectness='1', Credit ='" + credits +  "'where QuestionID='"+qid+"' and OptionValue='true'" ;
			query4="update options set OptionCorrectness='0', Credit ='" + credits +  "'where QuestionID='"+qid+"' and OptionValue='false'" ;
		}
		else{
			query3="update options set OptionCorrectness='0', Credit ='" + credits +  "'where QuestionID='"+qid+"' and OptionValue='true'" ;
			query4="update options set OptionCorrectness='1', Credit ='" + credits +  "'where QuestionID='"+qid+"' and OptionValue='false'" ;
		}	
		int rs2=st.executeUpdate(query3);
		int rs3=st.executeUpdate(query4);
		
		if((rs!=0)||(rs2!=0))
		{
			out.println("Successful");
			response.sendRedirect("jsp/questionbank/questionbank.jsp");
			
		}
		else
			out.println(" Not Successful");
		//conn.close();
	}
	catch(Exception e)
	{
		out.println("Exception is: " + e);
	}
		finally
		{
			dbconn.closeLocalConnection(conn);
		}
  }
	

}
