package clicker.v4.managequiz;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 
 * @author harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: This servlet populates the questions for display.
 */

public class QuestionPopulator extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,HttpServletResponse response){
		RetrieveQuestionsModel rom=new RetrieveQuestionsModel(Integer.parseInt(request.getParameter("qtype")),request.getParameter("InstrID"), request.getParameter("courseid"), Integer.parseInt(request.getParameter("selector")));
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("QP search: " + request.getParameter("question") + " search1: ");
		try {
			if(!(request.getParameter("question")==null||request.getParameter("question").equals(""))){
				System.out.println("Search: " + URLDecoder.decode(request.getParameter("question"), "UTF-8"));
				//rom.setSearchParameter(URLDecoder.decode(request.getParameter("question"), "UTF-8"));
				rom.setSearchParameter(request.getParameter("question"));
			}
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ArrayList<QuestionSave> allQuestions=rom.getQuestions();
		for(QuestionSave q:allQuestions){
			//System.out.println("qid: " + q.QuestionID + " question: " + q.Question);
			out.print("<option value='"+q.QuestionID+"' id='"+q.QuestionID+"'>"+(q.Question).replace("<", "&lt;")+"</option>");
		}
		out.close();
	}
}