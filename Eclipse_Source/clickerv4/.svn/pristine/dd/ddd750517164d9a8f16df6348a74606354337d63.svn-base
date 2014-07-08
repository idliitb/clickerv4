package clicker.v4.managequiz;

import clicker.v4.databaseconn.*;

import java.sql.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Quiz_Function extends HttpServlet
{
	//private static final long serialVersionUID = 1L;
		private Connection conn = null;
		PreparedStatement ps1 = null;
		PreparedStatement ps2 = null;
		private int archive = 1;
		
		protected void doPost(HttpServletRequest request,HttpServletResponse response)
		{
			
			int quizid = Integer.parseInt(request.getParameter("QuizID"));
			int retrievequiz = Integer.parseInt(request.getParameter("QuizFunctionSelect"));
			DatabaseConnection dbconn = new DatabaseConnection ( );
			try
			{
				
				conn = dbconn.createDatabaseConnection();
				
				if(retrievequiz == 0)
					ps1 = conn.prepareStatement("Update quiz set Archived = ? where QuizID = ?");
				
				else
				{
					System.out.println("Success1");
					archive = 0;
					ps1 = conn.prepareStatement("Update quiz set Archived = ? where QuizID = ?");
				}
				ps1.setInt(1, archive);
				ps1.setInt(2, quizid);
				
				int rs = ps1.executeUpdate( );
				if(rs != 0)
					System.out.println("Success:");
				else 
					System.out.println("No Success:");
						ps1.close( );
						
				response.sendRedirect("jsp/managequiz/createquiz.jsp");			
			}
			
			catch(Exception e)
			{
				e.printStackTrace( );
			}
			finally
			{
				dbconn.closeLocalConnection(conn);
			}
			//return quizname;
			
			
		}

}