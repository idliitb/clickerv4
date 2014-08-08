package clicker.v4.questionbank;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import clicker.v4.databaseconn.*;
import java.io.*;
/**
 * @author Harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: Servlet implementation class TrueFalseDB. This Class adds True or False type questions in the Database.
 */
//@WebServlet("/addtruefalsedb")
public class AddTrueFalseDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTrueFalseDB() {
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
		String instructorid = (String) request.getSession( ).getAttribute("InstructorID");
		PrintWriter out = response.getWriter();
		DatabaseConnection dbconn = new DatabaseConnection();
		try{
			int question_id=0;String query4,query3;
			String question=request.getParameter("tfaddquest");
			String credit=request.getParameter("credit");
			String option=request.getParameter("option");
			String image = request.getParameter("browse");
			float credits = Float.parseFloat(request.getParameter("credits"));
			float negativemark = Float.parseFloat(request.getParameter("negativemark"));
			String courseid = (String) request.getSession().getAttribute("courseID");
			int shuffle = 1;
			if(request.getParameter("shuffle") != null)
				shuffle = 0;
			System.out.println("shuffle: " + shuffle);
			
			
			conn = dbconn.createDatabaseConnection();
			String query1="insert into question(Question,Archived,Credit,ImageName,QuestionType,InstrID, Shuffle, CourseID, NegativeMark) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement st =conn.prepareStatement(query1 , Statement.RETURN_GENERATED_KEYS);
			st.setString(1, question);
			st.setInt(2, 0);
			st.setFloat(3, credits);
			st.setString(4,	image);
			st.setInt(5, 4);
			st.setString(6,instructorid);
			st.setInt(7, shuffle);
			st.setString(8, courseid);
			st.setFloat(9, negativemark);
			int rs=st.executeUpdate();
			ResultSet res = st.getGeneratedKeys();
			if(res.next()){
				question_id  = res.getInt(1);
			}
			
			/*// Adding entry in the Questions history table
			History history = new History (question_id, question, instructorid, option);
			history.addentry ();*/
			
			if(option.equals("true")){
			query3="insert into options(OptionValue,OptionCorrectness,QuestionID, Credit) values('true',1,'"+question_id+"'," + credits + ")";
			    query4="insert into options(OptionValue,OptionCorrectness,QuestionID, Credit) values('false',0,'"+question_id+ "'," + credits + ")";
			}
			else{
				query3="insert into options(OptionValue,OptionCorrectness,QuestionID, Credit) values('true',0,'"+question_id+ "'," + credits + ")";
				query4="insert into options(OptionValue,OptionCorrectness,QuestionID, Credit) values('false',1,'"+question_id+"'," + credits + ")";
			}
			int rs2=st.executeUpdate(query3);
			int rs3=st.executeUpdate(query4);
			if((rs!=0)||(rs2!=0)||(rs3!=0))
			{
				out.println("Successful");
				response.sendRedirect("jsp/questionbank/questionbank.jsp");
				
			}
			else
				out.println(" Not Successful");
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