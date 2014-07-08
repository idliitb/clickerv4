<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@	page import="clicker.v4.managequiz.*"%>
<%@ page import = "clicker.v4.databaseconn.*" %>
<%@ page import = "java.sql.*" %>
<%@	page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<script type="text/javascript">


</script>

<%
if (session.getAttribute("InstructorID") == null) {
	request.setAttribute("Error","Your session has expired.");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;		
}
Question question;
String questionStr="";
String QuizName =null;
DatabaseConnection dbconn = new DatabaseConnection();
Connection conn = dbconn.createDatabaseConnection();
QuizNameSelect qns = new QuizNameSelect( );
int QuestionIndex=0;
Vector<String> CorrectAnswer = new Vector<String>();
String qname = (String)request.getParameter("quizID");
//String qname="test";
//System.out.println("qname: " + qname);

int QuizID = Integer.parseInt(qname);
String Quiz_ID = String.valueOf(QuizID);

String Query = "select QuizName from quiz where QuizID='"+ QuizID +"'";
//System.out.println("----->"+Query);
Statement st1 = conn.createStatement();
ResultSet rs1 = st1.executeQuery(Query);
if(rs1.next())
{
	QuizName=rs1.getString("QuizName");
}




String quiztimestamp[ ] = qns.getQuizTimestamp(QuizID);
Vector<Question> Questiondetails = new Vector<Question>();
Questiondetails = qns.getallQuestionDetails(conn, String.valueOf(QuizID));
dbconn.closeLocalConnection(conn);
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
 <div style="margin-left:20px;height:40px;width:300px;font-weight: bold;color:0fff;padding-left: 50px;padding-top: 10px;border:2px solid;
    border-radius: 10px; " >  <%=QuizName %> Quiz Conduction Record </div> 
<div class="main_continer" style="margin-top:10px;overflow:auto; height: 150px; width:420px;align:center;border: 2px"> 

   
    <table  border=".5" width="400">
		<tr style  = "font-size : 14px;">
			<th>Sr.No.</th>
			<th>Quiz Conducted On</th>
		</tr>
		<% 
			for (int i = 0; i < (quiztimestamp.length); i++)
			{ %>
					<tr style = "font-size : 13px">		 
							<td style = "text-align: center;"> <%=i+1 %> </td>
							<td id="<%=quiztimestamp[i] %>" style = "text-align: center;" onclick="timestamp(id)"> <%=quiztimestamp[i] %> </td> 
								 
					</tr>
		   <%}%>	
		
	</table>


</div>



</body>
</html>