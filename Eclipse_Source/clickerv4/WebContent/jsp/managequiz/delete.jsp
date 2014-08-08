<%-- @Author Harshavardhan
	Clicker Team, IDL, IIT Bombay
	Description: This file selects the active quizzes from the database for deletion --%>

<%@page import="clicker.v4.managequiz.*"%>
<%@ page import = "clicker.v4.databaseconn.*" %>
<%@ page import = "java.sql.*" %>
<%@page import="clicker.v4.quiz.QuizHelper"%>

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
String courseID = (String) session.getAttribute("courseID");
QuizNameSelect qns = new QuizNameSelect( );
QuizHelper quizHelper = new QuizHelper();
String quiz_names = quizHelper.getQuizList(courseID, instructorID);


//String quiztimestamp[ ] = qrq.getQuizTimestamp(QuizID);


%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Delete Quiz</title>
<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<link type="text/css" rel="stylesheet" href="../../css/conductquiz.css">
<script type="text/javascript" src="../../js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="../../js/jquery-ui.js"></script>
<link href="../../js/jquery-ui.css" rel="stylesheet" type="text/css"/>
<style type="text/css">
._css3m{
display:block
}
</style>
<script>
/*$(document).ready(function( ){
	quiz_id = document.getElementById("firstquiz").value;
	//alert("quiz name: " + quiz_id);
	//quiz_id = parseInt(qname.replace(/[^0-9\.]/g, ''), 10);
	document.getElementById(quiz_id).style.background = 'rgb(255, 99, 8)';
	$('#quizdetails').load("../../jsp/managequiz/deletequizdisplay.jsp?quizid=" + escape(quiz_id));
});*/


</script>

</head>

<body style="width:100%; height:100%; text-align: center;">
			

<div style="border: 3px solid #e46c0a;border-radius: 10px; float: left; min-height:120px; width: 1050px;text-align:left;margin-left:33px;overflow: auto;">
 			<%
			String Q_Id,Q_name;
			String[] quizListArray = quiz_names.split("-@-");
			try{
				Statement st = conn.createStatement();
				String Quiz_count=null;
				String[] tool_tip_content=null;
			
			
			
			if(quizListArray.length <= 1 && !quiz_names.contains("-&-")){
				 %>
				<div align="center"><br></br><font style="font-size:25px;font-weight: bold;color: #B20000;letter-spacing: 1.7px"> No Quiz Available</font> </div>
				<%
			}else{ %>
 			<div style="margin-left: 10px; margin-top: 20px; height: 60px;width:180px; float:left;">					    
			   	<div style="height: 20px;width: 60px;background-color:#e46c0a;float:left;"></div><div style="float:left;height: 20px;width: 110px;">&nbsp;&nbsp;Conducted</div><br><br>
			   	<div style="height: 20px;width: 60px;background-color:#CCCCB2;float:left;"></div><div style="float:left;height: 20px;width: 110px;">&nbsp;&nbsp;Not Conducted</div>
			</div> 
			
			<div id = "quiz_conduction_record" style = "margin-top: 0px;margin-left: 10px; height: 87px; width: 250px; float: right;"></div>
			<%
				for(int i=0;i<quizListArray.length;i++){
					Q_Id=quizListArray[i].split("-&-")[0].replace("<", "&lt;");
					
					Q_name=quizListArray[i].split("-&-")[1].replace("<", "&lt;");
					String query1 = "SELECT count(QuizID) FROM quizrecord where QuizID='"+Q_Id+"'" ;
					ResultSet rs = st.executeQuery(query1);
					while (rs.next())
					{
						Quiz_count = rs.getString(1);
					}
					
					if(Quiz_count.equalsIgnoreCase("0"))
					{
						String quiz_summ=quizHelper.get_quizsumm(Q_Id);
						tool_tip_content=quiz_summ.split("~");
						//System.out.println("Quiz ID :"+ tool_tip_content[0] + " " + tool_tip_content[1]);
					%>
					
					<div id="<%=Q_Id %>" class = "Q_div" onmousemove="showtip(event, '<%=tool_tip_content[0]%>','<%=tool_tip_content[1]%>','<%=tool_tip_content[2]%>');" onmouseout="hidetip();" onclick="quizname('<%=Q_name %>', '<%=Q_Id %>')" > 
						<table class="quiz_select" border="0">
							<tr> <td> <%=Q_name %></td></tr>
							<tr > <td style="vertical-align:bottom;">
	     							 <div class="meter">
										<span style="width: 0%"></span>
									 </div>
								   </td>
							</tr>
					 	</table> 
					 	
					 </div>				 
					    
					<%		
					}else
					{  
						
						String quiz_summ=quizHelper.get_quizsumm(Q_Id);						
					    tool_tip_content=quiz_summ.split("~");
					    System.out.println("Quiz ID : "+ tool_tip_content[0] + " " + tool_tip_content[1]);
						String str=quizHelper.get_quiz_per(Q_Id);
						String Per=str+"%";%>
						<div id="<%=Q_Id %>" class = "Q_div1" onmousemove="showtip(event, '<%=tool_tip_content[0]%>','<%=tool_tip_content[1]%>','<%=tool_tip_content[2]%>');" onmouseout="hidetip();" onclick="quizname('<%=Q_name %>', '<%=Q_Id %>')" >
						<table class="quiz_select">
							<tr> <td> <%=Q_name %></td></tr>
							<tr > <td style="vertical-align:bottom;">
	     							 <div class="meter">
										<span style="width: <%= Per%>"></span>
									 </div>
								   </td>
							</tr>
					 	</table> 						
						</div>
					<%}
						
				}
			}
			}catch(Exception ex)
			{
				System.out.println("In delete.jsp------Error: ");
				ex.printStackTrace();
			}finally
			{
				dbconn.closeLocalConnection(conn);	
			}
			
			%>					
					
			
</div><br>


<%--int QuizID = qns.getQuizID(conn, qname);
  System.out.println("ID: " + QuizID);
  dbconn.closeLocalConnection(conn);--%>
<br><br>
<div id = "quizdetails" style="font-size: 18px; overflow: auto; text-align: justify;clear: both;"></div>
<div id="tooltip" ></div>

<div id = "delete_quiz_button" style = "display: none">
	<table class="table1" style="margin-top:2px;">
		<tr>
			<td >
				<div style="margin-left:480px;">
					<Form id = "DeleteQuiz" action = "../../deleteQuiz" method = "post" name = "DeleteQuiz" >
						<input type = hidden name = "QuizID" id = "QuizID"/>	
						<button class="ui-createquiz-button" id="createqbtn1" type="submit" onclick="return confirm('Are you sure you want to Delete this Quiz?')">
						<span>Delete Quiz</span>
						</button>
					</Form>
				</div>
		</td>
	</tr>
	</table>
</div>
</body>
</html>