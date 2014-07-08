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
	
	String qname = request.getParameter("quizname");
	System.out.println("qname: " + qname);
	int QuizID = qns.getQuizID(conn, qname);
	String Quiz_ID = String.valueOf(QuizID);
	String quiztimestamp[ ] = qns.getQuizTimestamp(QuizID);
	Vector<Question> Questiondetails = new Vector<Question>();
	Questiondetails = qns.getallQuestionDetails(conn, String.valueOf(QuizID));
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">

<title>Insert title here</title>
</head>
<body>

<table class="table1" style="margin-top:0px;" border="1">
<tr>
<td>
<div id = "details" style="font-size: 18px; height:400px;overflow: auto; text-align: justify;">
<%	
while ((QuestionIndex + 1) <= Questiondetails.size())
{
	question = Questiondetails.elementAt(QuestionIndex);	
	int QuestionType = question.getQuestionType();
	String QuestionAnswer="";
	questionStr = question.getQuestionText().replace("\r\n","<br/>").replace("\n","<br/>");	
%>						
	<font style = "font-weight: bold">Question <%= QuestionIndex + 1%></font> :
	<%=questionStr%>
	<br>
	<%
	Vector<Option> Options = question.getOptions();
	Option option[] = new Option[Options.size()];
	String OptionResponse="";
	
	for (int i=0; i<Options.size(); i++)
	{
		OptionResponse =  Character.toString((char)(i+65));		
		option[i]=Options.elementAt(i);
		if(QuestionType!=3){
	%>
		<font style = "font-weight: bold">Option
		<%=OptionResponse%></font>
		:
		<%=option[i].getOptionValue().toString()%>
		<br>
	<%}}%>
	<br>
	
	<%	
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
		CorrectAnswer.add(option[0].getOptionValue().toString());
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
	QuestionIndex++;	
}
dbconn.closeLocalConnection(conn);
%>
</div>
</td>
</tr>
</table>

<br>
<div class="table1" style="width: 300px; margin-top:0px;overflow: auto; height: 150px; text-align: justify; border: 3px solid #e46c0a;"> 
	<div style="font-size:18px; text-align: center;">Quiz Conduction Record</div>
	<%if(quiztimestamp.length > 0){ %>
		<table  border="1" style="margin-left: 50px; border-radius:5px;" >
			<tr style  = "font-size : 14px;">
				<th>Sr.No.</th>
				<th>Quiz Conducted On</th>
			</tr>
			<% 
				for (int i = 0; i < (quiztimestamp.length); i++)
				{ %>
						<tr style = "font-size : 13px">		 
								<td style = "text-align: center;"> <%=i+1 %> </td>
								<td style = "text-align: center;"> <%=quiztimestamp[i] %> </td> 
									 
						</tr>
			   <%}%>	
			
		</table>
		<%}
	else
	{%>
		<p style = "color:red; font-size: 20px; text-align: center;"> This Quiz has not been conducted till date </p>
	<%} %>
</div>

<table class="table1" style="margin-top:2px;">
<tr>
<td >
<div style="margin-left:480px;">
<Form id = "DeleteQuiz" action = "../../deleteQuiz" method = "post" name = "DeleteQuiz" >
	<input type = hidden name = "QuizID" id = "QuizID" value = "<%=QuizID %>" />	
	<button class="ui-createquiz-button" id="createqbtn1" type="submit" onclick="return confirm('Are you sure you want to Delete this Quiz?')">
		<span>Delete quiz</span>
	</button>
</Form>
</div>
</td>
</tr>
</table>

</body>
</html>