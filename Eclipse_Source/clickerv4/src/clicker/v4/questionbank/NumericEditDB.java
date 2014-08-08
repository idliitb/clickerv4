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
 * Description: This servlet inserts the edited Numeric type questions in the database.
 * Servlet implementation class NumericEditDB
 */
//@WebServlet("/numericeditdb")
public class NumericEditDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NumericEditDB() {
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
		
		Connection conn=null;
		String instructorid = (String) request.getSession().getAttribute("InstructorID");
		PrintWriter out = response.getWriter();
		DatabaseConnection dbconn = new DatabaseConnection();
		try{
			
			conn = dbconn.createDatabaseConnection();
			
			String query1 = "update question set Question= ?, Credit = ?, NegativeMark = ? where QuestionID= ? ";
			String query2 = "update options set OptionValue =?, Credit = ? where QuestionID=?";
			
				PreparedStatement st = conn.prepareStatement(query1,Statement.RETURN_GENERATED_KEYS);
				String question=request.getParameter("editnumericquest");
				float credits = Float.parseFloat(request.getParameter("credits"));
				float negativemarks = Float.parseFloat(request.getParameter("negativemarks"));
				String option=request.getParameter("numericanswer");
				String image = request.getParameter("browse");
				int qid = -1;
				qid = Integer.parseInt(request.getParameter("qid"));
				st.setString(1,question);
				st.setFloat(2, credits);
				st.setFloat(3, negativemarks);
				st.setInt(4,qid);
				
				int rs=st.executeUpdate();
				ResultSet res = st.getGeneratedKeys();
				
				PreparedStatement st1 = conn.prepareStatement(query2,Statement.RETURN_GENERATED_KEYS);
				st1.setString(1,option);
				st1.setFloat(2, credits);
				st1.setInt(3,qid);
				
				int rs2=st1.executeUpdate();
				
				/*// Adding entry in the Questions history table
				History history = new History (qid, question, instructorid, option);
				history.addentry ();*/
				
				if((rs!=0)||(rs2!=0))
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