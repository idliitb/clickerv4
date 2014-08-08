package clicker.v4.managequiz;

/**
 * @author Harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: This servlet deletes the selected quiz
 */
import clicker.v4.databaseconn.*;
import java.io.IOException;
import java.sql.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Delete_Quiz extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	private Connection conn = null;
	PreparedStatement ps1 = null;
	PreparedStatement ps2 = null;
	private int archive = 1;
	protected void doPost(HttpServletRequest request,HttpServletResponse response)
	{		
		int quizid = Integer.parseInt(request.getParameter("QuizID"));
		System.out.println("Quiz id: " + quizid);
		DatabaseConnection dbconn = new DatabaseConnection ( );
		try
		{
			
			conn = dbconn.createDatabaseConnection();		
			ps1 = conn.prepareStatement("Update quiz set Archived = ? where QuizID = ?");
			ps1.setInt(1, archive);
			ps1.setInt(2, quizid);			
			int rs = ps1.executeUpdate( );			
			response.sendRedirect("jsp/questionbank/questionbank.jsp");
		}catch(SQLException e)
		{
			e.printStackTrace( );
		}catch (IOException e) {
			e.printStackTrace();
		}
		finally{
			try {
				if(ps1!=null){
					ps1.close( );
				}
				if(conn!=null){
					dbconn.closeLocalConnection(conn);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		//return quizname;
		
		
	}
}