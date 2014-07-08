<%@page import="clicker.v4.managequiz.*"%>
<%@ page import = "clicker.v4.databaseconn.*" %>
<%@ page import = "java.sql.*" %>

<%! String qname; %>
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

int qz = 1; //Integer.parseInt(request.getParameter("quiztype"));
String CourseID = (String) session.getAttribute("courseID");
QuizNameSelect qns = new QuizNameSelect( );
String quiz_names[ ] = qns.quiz_Name(qz, CourseID);


//String quiztimestamp[ ] = qrq.getQuizTimestamp(QuizID);


%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Delete Quiz</title>
<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
._css3m{
display:block
}
</style>
<script>
$(document).ready(function( ){
	qname = (document.getElementById("quiznameselect").options[document.getElementById("quiznameselect").selectedIndex].value);
	$('#quizdetails').load("../../jsp/managequiz/deletequizdisplay.jsp?quizname=" + escape(qname));
});
function quizname( )
{
	qname = (document.getElementById("quiznameselect").options[document.getElementById("quiznameselect").selectedIndex].value);
	//alert("quiz name: " + qname);
	$('#quizdetails').load("../../jsp/managequiz/deletequizdisplay.jsp?quizname=" + escape(qname));
	
}
</script>

</head>

<body style="width:100%; height:100%; text-align: center;" onload = "quizname( );">


<table class="table1">

<tr>
<td style="margin:auto;padding-left:180px;">

 	<div>	

			<section style="margin:10px 0 0 180px;margin-bottom:10px;">
			<%if(quiz_names.length > 0)
			{%>
				<div>Select Quiz &nbsp;
					<select id="quiznameselect" name="quiznameselect" class="cd-select" onchange = "quizname( );">
						<%
							for (int i=0; i < quiz_names.length; i++)
							{
							//System.out.println("quiz name......"+quiz_names[i]);
							%>
							<option><%=quiz_names[i]%></option>
						<%}%>
					</select>
				</div>
			<%}
			else
			{%>
				<span style = "color:red; font-size: 20px; text-align: center;"> Cannot delete any Quiz as no Quiz is created</span>
			<%} %>	
			</section>
	</div>
</td>
</tr>
</table>
<%int QuizID = qns.getQuizID(conn, qname);
  System.out.println("ID: " + QuizID);
  dbconn.closeLocalConnection(conn);  %>

<div id = "quizdetails" style="font-size: 18px; overflow: auto; text-align: justify;"></div>

</body>
</html>