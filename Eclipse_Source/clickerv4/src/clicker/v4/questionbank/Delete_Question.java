package clicker.v4.questionbank;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import clicker.v4.databaseconn.*;
import java.sql.*;

/**
 * @author Harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: Servlet implementation class Delete_Question. This Class Deletes a question.
 */
//@WebServlet("/deletequestion")
public class Delete_Question extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Delete_Question() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int qid = Integer.parseInt(request.getParameter("qid"));
		//String question_id[ ] = qid.split(delimiter);
		//out.println(question);
		Connection conn=null,conn1 = null;
		DatabaseConnection dbconn = new DatabaseConnection();
		try{
		
		conn = dbconn.createDatabaseConnection();
		Statement st = conn.createStatement();
		//for (int i = 0; i < question_id.length; i++)
			st.executeUpdate("update question set Archived='1' where QuestionID='"+qid+"'");

		}catch(Exception e){
			e.getStackTrace();
		}finally{
			try{
				dbconn.closeLocalConnection(conn);
			}catch(Exception e){
				e.getStackTrace();
			}finally{
				response.sendRedirect("jsp/questionbank/questionbank.jsp");
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}