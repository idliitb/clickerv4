<%--@author rajavel 
This jsp file is used for conducting quiz
--%>
<%@page import="clicker.v4.global.Global"%>
<%@page import="clicker.v4.quiz.QuizHelper"%>
<%@page import="clicker.v4.wrappers.Quiz"%>


<%
String instructorID = (String) session.getAttribute("InstructorID");
if (instructorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
String courseID = session.getAttribute("courseID").toString();
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Select Quiz</title>
		<link type="text/css" rel="stylesheet" href="../../css/style.css">
		<link type="text/css" rel="stylesheet" href="../../css/conductquiz.css">
		<script src="../../js/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="../../js/quiz.js"></script>
		<style type="text/css">
			._css3m{
				display:none
			}
		</style>
	</head>
	<style type="text/css">


</style>

	<body onload="getQuizList('<%=courseID%>', '<%=instructorID%>');" class="ui-Mainbody" style="text-align: center;">
		<%@ include file= "../../jsp/includes/menuheader.jsp" %>
		<form action="quiz.jsp" method="get" onsubmit="return isValidCourse()">
 			<table class="table1">
				<tr>
					<td>
						<div class="ui-header-text" >
							<h2>Select quiz</h2>
						</div>
					</td>
				</tr>
			</table>
			<!-- <table class="table1" style="margin-top:25px;" >
				<tr><td style="margin:auto;">
					<div id = "quizList" style="margin-left: 450px;"></div>			
				</td></tr>
			</table> -->
			<table align="center" >
			<tr>
			<td>
			 <div style="height: 30px;width: ;margin-left: 150px;" align="center">
			
			   <!-- <div style="height: 27px;width: 35px;;border:2px solid;border-color:#7A7A6B;background-color:#CCCCB2;float: left;">
			      
			    </div>
			    <div style="height: 27px;width: 35px;;border:2px solid;border-color:#7A7A6B;background-color:#85FF85;border-color:#009933;float:left;">
			     
			    </div>-->
			    
			    <div style="height: 20px;width: 500px;float: center;">
			    <div style="float:left;">
			    <div style="height: 20px;width: 50px;background-color:#e46c0a;float:left;"> 
			    
			    </div>&nbsp;&nbsp;&nbsp;&nbsp;Conducted</div>
			    <div style="float:left;">
			    &nbsp;&nbsp;&nbsp;&nbsp;<div style="height: 20px;width: 60px;background-color:#CCCCB2;float:left;margin-left: 20px;">
			    
			    
			    </div>&nbsp;&nbsp;&nbsp;&nbsp;Not Conducted
			    </div>
			    
			    </div>
			   
			    
			</div> 
			
			</td>
			</tr>
			<tr><td>
			<div style="width: 1000px;text-align:left;border:2px none;border-color: black;margin-left: 10px;overflow: auto;">
			<%
			String Q_Id,Q_name;
			QuizHelper quizHelper = new QuizHelper();
			String quizList = quizHelper.getQuizList(courseID, instructorID);
			System.out.println(quizList);
			String[] quizListArray = quizList.split("-@-");
			DatabaseConnection dbconn = new DatabaseConnection();
			Connection con = dbconn.createDatabaseConnection();
			try{
				
			
			Statement st = con.createStatement();
			String Quiz_count=null;
			String[] tool_tip_content=null;
			
			
			
			if(quizListArray.length <= 1 && !quizList.contains("-&-")){
				 %>
				<div align="center"><br></br><br></br><font style="font-size:25px;font-weight: bold;color: #B20000;letter-spacing: 1.7px"> No Quiz Available</font> </div>
				<%
			}else{
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
						
					%>
					
					<div id="Q_div" onmousemove="showtip(event, '<%=tool_tip_content[0]%>','<%=tool_tip_content[1]%>','<%=tool_tip_content[2]%>');" onmouseout="hidetip();" onclick="conduct_quiz('<%=Q_Id%>','<%=Q_name %>')" > 
						<table class="quiz_select">
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
					    //System.out.println("Quiz ID :"+Q_Id);
						String str=quizHelper.get_quiz_per(Q_Id);
						String Per=str+"%";%>
						<div id="Q_div1" onmousemove="showtip(event, '<%=tool_tip_content[0]%>','<%=tool_tip_content[1]%>','<%=tool_tip_content[2]%>');" onmouseout="hidetip();" onclick="conduct_quiz('<%=Q_Id%>','<%=Q_name %>')" >
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
				
			}finally
			{
				dbconn.closeLocalConnection(con);	
			}
			
			%>					
					
			
			</div>
			</td>
		</tr>
			</table>
		<!-- 	<table class="table1" style="margin-top:5px;" >
				<tr><td style="margin:auto;">
					<div style="margin-top:20px;margin-bottom:20px;margin-left:465px;">	
						<button class="ui-conductquiz-button" id="conductqbtn1" type="submit"  >
							<span>Conduct quiz</span>
						</button>
					</div>
				</td></tr>
			</table> -->
		</form>
		<div id="tooltip" ></div>
				
		<div style="margin-top:-600px;">
			<%@ include file= "../../jsp/includes/menufooter.jsp" %>
		</div>	
	</body>
</html>