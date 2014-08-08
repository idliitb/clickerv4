package clicker.v4.managequiz;

/**
 * @author Harshavardhan
 * Clicker Team, IDL, IIT Bombay
 * Description: This servlet populates the options for a particular question
 */
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class OptionPopulator extends HttpServlet{
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,HttpServletResponse response) {
		response.setContentType("text/html");
		try {
			PrintWriter out=response.getWriter();
			RetrieveOptionsModel retrieved=new RetrieveOptionsModel(Integer.parseInt(request.getParameter("questionID")));
			ArrayList<String> options=retrieved.getOptions();

			int ctr=0, i = 0;
			for(String opt:options){
				i = i + 1;
				if(retrieved.getQuestionType()==1||retrieved.getQuestionType()==2)
				{					
					if(i % 2 != 0)
					{	
						if(i > 1)
							out.print("<br>");
						
						out.print("<div style = 'display: inline-block; width: 360px;'> "+Character.toString((char)(65+(ctr++)))+". "+opt+"</div>");
					}	
					else
						out.print("<div style = 'float: right; width: 360px;'>"+Character.toString((char)(65+(ctr++)))+". "+opt+"</div><br>");
				}	                                        
				else if(retrieved.getQuestionType()==4)
				{
					
					if(i % 2 != 0)
						out.print("<div style = 'display: inline-block; width: 360px;' class='options'> "+Character.toString((char)(65+(ctr++)))+". "+opt+"</div>");
					else
						out.print("<div style = 'float: right; width: 360px;' class='options'>"+Character.toString((char)(65+(ctr++)))+". "+opt+"</div><br>");
				}
			}
			
			 if(retrieved.getQuestionType()==3){
				out.print("<p class='options'>Numeric Answer : "+options.get(0)+"</p>");
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}

}