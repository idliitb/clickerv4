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
 * Description: Servlet implementation class AddNumericDB. This class Adds Numeric type Questions in the Database.
 */
//@WebServlet("/addnumericdb")
public class AddNumericDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddNumericDB() {
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
		String instructorid = (String) request.getSession().getAttribute("InstructorID");
		PrintWriter out = response.getWriter();
		DatabaseConnection dbconn = new DatabaseConnection();
		try{
			
			conn = dbconn.createDatabaseConnection();
			String query1="insert into question(Question,LevelOfDifficulty,Archived,Credit,QuestionType,InstrID, Shuffle, CourseID, NegativeMark) values(?,?,?,?,?,?,?,?, ?)";
			
				PreparedStatement st =conn.prepareStatement(query1, Statement.RETURN_GENERATED_KEYS);
				int question_id=0;
				String question=request.getParameter("numericaddquest");
				String option=request.getParameter("numericanswer");
				String image = request.getParameter("browse");
				float credits = Float.parseFloat(request.getParameter("credits"));
				float negativemark = Float.parseFloat(request.getParameter("negativemark"));
				String courseid = (String) request.getSession().getAttribute("courseID");
				int shuffle = 0;
				st.setString(1, question);
				st.setInt(2, 1);
				st.setInt(3, 0);
				st.setFloat(4, credits);
				st.setInt(5, 3);
				st.setString(6,instructorid);
				st.setInt(7, shuffle);
				st.setString(8, courseid);
				st.setFloat(9, negativemark);
				int rs=st.executeUpdate();
				ResultSet res = st.getGeneratedKeys();
				if(res.next()){
					question_id  = res.getInt(1);
				}
				String query2="insert into options(OptionValue,LevelOfDifficulty,OptionCorrectness,Archived,Credit,QuestionID) values('"+option+"',1,1,0," + credits + ",'" +question_id+"')";
				int rs2=st.executeUpdate(query2);
				if((rs!=0)||(rs2!=0))
				{
					out.println("Successful");
					response.sendRedirect("jsp/questionbank/questionbank.jsp");
				}
				else
					out.println(" Not Successful");
				
				/*// Adding entry in the Questions history table
				History history = new History (question_id, question, instructorid, option);
				history.addentry ();*/
		}
		catch(Exception e)
		{
			out.println(e);
		}finally{
			try{
				dbconn.closeLocalConnection(conn);
			}catch(Exception e){
				e.getStackTrace();
			}
		}
	}

}