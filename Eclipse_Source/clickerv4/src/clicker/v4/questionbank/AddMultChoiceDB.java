package clicker.v4.questionbank;
/** 
 * @Author: Harshavardhan, Clicker Team, IDL, IIT Bombay
 * Description: This class adds the Multiple Choice correct questions to the Database
 */
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
 * Servlet implementation class AddMultChoiceDB. 
 */
//@WebServlet("/addmultchoicedb")
public class AddMultChoiceDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddMultChoiceDB() {
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
			System.out.println("Conn here:"+conn);
			int count=Integer.parseInt((String)request.getParameter("count"));
			String courseid = (String) request.getSession().getAttribute("courseID");
			System.out.println("Count: " + count);
			int questionID;
			//out.println(request.getParameter("Count"));
			String Question=(String)request.getParameter("addquest");
			int LevelOfDifficulty=1;
			String imageName=(String)request.getParameter("image"), optionvalue = "";
			int questionType = 2;
			String options[]={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
			int archived=0;
			float credits = Float.parseFloat(request.getParameter("credits"));
			float negativemark = Float.parseFloat(request.getParameter("negativemark"));
			int shuffle = 1;
			if(request.getParameter("shuffle") != null)
				shuffle = 0;
			System.out.println("shuffle: " + shuffle);
			
			InsertQuestion i_q=new InsertQuestion();
			questionID=i_q.insertQuestion(conn, Question, LevelOfDifficulty, archived, credits, imageName, questionType, instructorid, shuffle, courseid, negativemark);
			System.out.println(questionID);
			InsertOptions i_o=new InsertOptions();
					
			
			for(int i=0;i<count;i++)
			{
				if(request.getParameter(options[i])!=null)
				{
					System.out.println("if: " + (i + 1));
					i_o.insertOption(request.getParameter(""+ (i + 1)).toString(), "nothing", 1, 1, 0, credits, questionID);
					optionvalue += request.getParameter(""+(i + 1)).toString() + ",";
					System.out.println("if1: " + request.getParameter(""+(i + 1)).toString());
				}
				else
				{
					System.out.println("else: " + (i + 1));
					i_o.insertOption(request.getParameter(""+ (i + 1)).toString(), "nothing", 0, 1, 0, credits, questionID);
					optionvalue += request.getParameter(""+(i + 1)).toString() + ",";
					System.out.println("else1: " + request.getParameter(""+(i +1)).toString());
				}
				
			}
			
			/*// Adding entry in the Questions history table
			optionvalue = optionvalue.substring(0, optionvalue.length()-1);
			History history = new History (questionID, Question, instructorid, optionvalue);
			history.addentry ();*/
			
			response.sendRedirect("jsp/questionbank/questionbank.jsp");	
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}finally{
			try{
				dbconn.closeLocalConnection(conn);}
			catch(Exception ex){
				System.out.println("Exception in AddMultChoiceDB: " + ex);
			}
		}
	}

}
