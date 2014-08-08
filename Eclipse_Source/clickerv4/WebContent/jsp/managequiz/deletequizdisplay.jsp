<%-- @Author Harshavardhan
	Clicker Team, IDL, IIT Bombay
	Description: This file selects the active quizzes from the database for deletion --%>

<%@	page import="clicker.v4.managequiz.*"%>
<%@ page import = "clicker.v4.databaseconn.*" %>
<%@ page import = "java.sql.*" %>
<%@	page import="java.util.*"%>

<%
String instructorID = (String) session.getAttribute("InstructorID");
if (instructorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}

	Question question;
	String questionStr="";
	DatabaseConnection dbconn = new DatabaseConnection();
	Connection conn = dbconn.createDatabaseConnection();
	QuizNameSelect qns = new QuizNameSelect( );
	int QuestionIndex=0;
	Vector<String> CorrectAnswer = new Vector<String>();
	
	//String qname = request.getParameter("quizname");
	//System.out.println("qname: " + qname);
	int QuizID = Integer.parseInt(request.getParameter("quizid"));//qns.getQuizID(conn, qname);
	String Quiz_ID = String.valueOf(QuizID);
	String quiztimestamp[ ] = qns.getQuizTimestamp(QuizID);
	Vector<Question> Questiondetails = new Vector<Question>();
	Questiondetails = qns.getallQuestionDetails(conn, String.valueOf(QuizID));
	StringBuilder timestamp = new StringBuilder( );
	StringBuilder quiz_info = new StringBuilder( );

		StringBuilder quests = new StringBuilder( );
		//String quests = "";
		for(int j = 0; j < Questiondetails.size( ); j++)// ((QuestionIndex + 1) <= Questiondetails.size())
		{
			
			question = Questiondetails.elementAt(j);	
			int QuestionType = question.getQuestionType();
			String QuestionAnswer="";
			questionStr = question.getQuestionText().replace("\r\n","<br/>").replace("\n","<br/>");	
			//System.out.println("Questions+++++++++++++++++++++++++" + questionStr);		
			
			//questionStr--
			
			
			Vector<Option> Options = question.getOptions();
			Option option[] = new Option[Options.size()];
			String OptionResponse="";
			StringBuilder opts = new StringBuilder( );
			for (int i=0; i<Options.size(); i++)
			{
				OptionResponse =  Character.toString((char)(i+65));		
				option[i]=Options.elementAt(i);
				if(QuestionType!=3){
					if(!((i + 1) == Options.size()))
						opts.append(option[i].getOptionValue().toString() + "!!");
					else
						opts.append(option[i].getOptionValue().toString());
				
				
				
				
				
				}
			}
			
			if(!((j + 1) == Questiondetails.size( )) && QuestionType != 3)
				quests.append(questionStr + "!@" + opts + "@@");
			else if(QuestionType == 3)
			{
				if((j + 1) == Questiondetails.size( ))
					quests.append(questionStr);
				else
					quests.append(questionStr + "@@");
			}					
			else
				quests.append(questionStr + "!@" + opts);
			//System.out.println("Questions--------------" + quests);
			}
			
			
			
			/*	
			if (QuestionType==1)
			{
				for(int i=0;i<Options.size();i++){
					if (Options.elementAt(i).getCorrect()==true)
					{
						QuestionAnswer = QuestionAnswer+Character.toString((char)(i+65));
						CorrectAnswer.add(QuestionAnswer);
					}
				}				
			}
			else if (QuestionType==2)
			{
				for(int i=0;i<Options.size();i++){
					if (Options.elementAt(i).getCorrect()==true)
					{
						QuestionAnswer = QuestionAnswer+Character.toString((char)(i+65));				
					}
				}				
				CorrectAnswer.add(QuestionAnswer);
			}
			else if (QuestionType==3)
			{		
				CorrectAnswer.add(option[0].getOptionValue(java.lang.OutOfMemoryError: Java heap space).toString());
			}
			else if (QuestionType==4)
			{
				for(int i=0;i<Options.size();i++){
					Option opt = Options.elementAt(i);
					if (opt.getCorrect()==true)
					{
						QuestionAnswer +=(opt.getOptionValue().equalsIgnoreCase("true")?"A":"B");				
					}
				}				
				CorrectAnswer.add(QuestionAnswer);
			}
			QuestionIndex++;*/
			//quests.append(questionStr);
			//quests.append("@@");
			//questionStr += "@@";
		//}
		dbconn.closeLocalConnection(conn);
		
		
			if(quiztimestamp.length > 0){
				
					 
						for (int i = 0; i < (quiztimestamp.length); i++)
						{ 
							if(!((i + 1) == quiztimestamp.length))
								timestamp.append(quiztimestamp[i] + "#");
							else
								timestamp.append(quiztimestamp[i]);
					   }	
					
				
				}
			else
			{ timestamp.append("1");
				
			} 
		
out.print(quests.append("$$" + timestamp)); %>


