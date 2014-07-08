
<!--  

    Author       : Gobinath.M
    Description  : Display the widgets

 -->

<%@page import="clicker.v4.databaseconn.DatabaseConnection"%>
<%@page import="java.sql.*"%>
<%@page import="clicker.v4.managequiz.*"%>
 <%@page import="clicker.v4.dashboard.*"%>
 <%@page import="clicker.v4.quiz.QuizHelper"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="../../css/createquiz.css">
<link type="text/css" rel="stylesheet" href="../../css/menuheader.css">
<link type="text/css" rel="stylesheet" href="../../css/menu.css">
<link type="text/css" rel="stylesheet" href="../../css/style.css">
<link href="inettuts.css" rel="stylesheet" type="text/css" />




<link rel="stylesheet" href="../../css/jquery-ui.css" />

<script src="../../js/dashboard.js"></script>

<script src="../../js/jquery-1.9.1.js"></script>

<script src="../../js/jquery-ui.js"></script>



<script type="text/javascript" src="excanvas.min.js"></script>
<script type="text/javascript" src="jquery.flot.js"></script>



<script type="text/javascript">

	var $j = jQuery.noConflict();	
		
	
</script>

<style type="text/css">
._css3m {
	display: none
}

.Present_Select {
	
}

.sample {
    cursor:pointer;
	background-color: #9bbb59;
	border: 2px solid;
	border-radius: 10px;
	width: 230px;
	height: 25px;
	padding: 5px;
	margin-top: 3px;
	font-weight: bold;
}

.sample1 {
    cursor:pointer;
	background-color: #EFA76C;
	border: 2px solid #e46c0a;
	border-radius: 10px;
	width: 230px;
	height: 25px;
	padding: 5px;
	margin-top: 3px;
	font-weight: bold;
	color: black;
}

.sample2 {
    cursor:pointer;
	background-color: #CCCCB2;
	border: 2px solid #7A7A6B;
	border-radius: 10px;
	width: 230px;
	height: 25px;
	padding: 5px;
	margin-top: 3px;
	font-weight: bold;
	color: black;
}

</style>




</head>
<%
    String Student_count=null;
	if (session.getAttribute("InstructorID") == null) {
		request.setAttribute("Error", "Your session has expired.");
		RequestDispatcher rd = request
				.getRequestDispatcher("../../error.jsp");
		rd.forward(request, response);
		return;
	}
	String InstructorID = (String) session.getAttribute("InstructorID");
	String CourseID = (String) session.getAttribute("courseID");
	session.setAttribute("insid", InstructorID);
	//System.out.println("Instructor ID is : " + InstructorID);
%>

<body onload="Get_Attendance()">
	<%@ include file="../../jsp/includes/menuheader.jsp"%>
	<table style="margin: auto; margin-top: 2px;">
		<tr>
			<td>
				<div class="ui-createquiz-text">
					<h2>
						<label>Welcome</label>
					</h2>
				</div>
			</td>
		</tr>
	</table>
	<table class="table" style="margin-top: 30px; overflow: auto;"
		border="1">
		<tr>
			<td>
				<!-- This is used for dashboard -->
				<div id="columns">
				
				
					<ul id="column1" class="column">
						<li class="widget color-red">
							<%
								try {
									DatabaseConnection dbconn1 = new DatabaseConnection();
									Connection conn1 = dbconn1.createDatabaseConnection();
									Statement st1 = conn1.createStatement();
									String query2 = "SELECT DISTINCT StudentID FROM raisehand where CourseID='"+CourseID+"'";
									// System.out.println("Raise Hand =====>"+query2);
									ResultSet rs2 = st1.executeQuery(query2);
							%>
							<div class="widget-head">
								<h3>Pending raise hand</h3>
							</div>
							<div class="widget-content">
								<div style="height: 150px; overflow-y: scroll;">
									<%
										while (rs2.next()) {

												String Student_id = rs2.getString(1);
									%>
									<div id="<%=Student_id%>" class="sample"
										onclick="GetSelectedID(id)">
										<%=Student_id%>
									</div>
									<%
										}
									String query1="SELECT count(StudentID) from studentcourse where CourseID='"+ CourseID+"'";
									 //System.out.println("-------------->"+ query1);
									 ResultSet rs=st1.executeQuery(query1);
									
											 while(rs.next()){
												 Student_count = rs.getString(1);
											 }
											 System.out.println("Student Count===>"+Student_count);
											 dbconn1.closeLocalConnection(conn1);
										
						
											
										} catch (Exception e) {
											out.println(e);
										}
									%>
								</div>
								<div id="raisehand_dialog" style="visibility: hidden"
									title="Response"></div>
							</div>
						</li>
					</ul>



					
					<ul id="column2" class="column">
						<li class="widget color-yellow">
							<div class="widget-head">
								<h3>Attendance</h3>
							</div>
							<div class="widget-content">
								<div style="margin: 0px 0 0 -4px;">
									<div id="<%= CourseID %>"
										style="width: 278px; height: 150px; background: #9bbb59; align: center; padding-left: 65px;cursor:pointer" onclick="show_attendance(id)">
										<br></br>
										<div id="attendance_div" align="left" ></div>
									</div>
								</div>
								<div id="attendance_dialog" style="visibility: hidden" title="status"></div>
							</div>
						</li>						
				<%				
				String Data_load="[";
				graphhelper GH = new graphhelper();				
				//GH.getstudentPersentage(CourseID,1);
				HashSet<Integer> QuizID= new HashSet<Integer>();
				QuizID = GH.getQuizid(CourseID);
				int sam=QuizID.size();
				//System.out.println("size of QuizID set=>"+sam);
				float tt[] = new float[sam];
				Iterator it = QuizID.iterator();
				int k=0;
				while (it.hasNext()){
					String nam=it.next().toString();
					int foo = Integer.parseInt(nam);
					//System.out.println("===>"+foo);
					tt[k]=GH.getstudentPersentage(CourseID, foo);
					k++;
				}
				int l=0;
				Iterator it1 = QuizID.iterator();
				while (it1.hasNext()){
					 String nam=it1.next().toString();
					 int ii=Integer.parseInt(nam);
					 String qname=GH.getQuizname(ii);					 
					// System.out.println("Quiz ID:"+qname +"Percentage :"+tt[l]);
					 Data_load =Data_load+"{ label: '"+qname+"',y: "+tt[l]+"},";
					 l++;
				}
				Data_load=Data_load+"]";
			//	System.out.println(Data_load);
				
				/*HashSet<String> Quizname= new HashSet<String>();
				Quizname=GH.getQuizname(CourseID);
				
				Integer [] array = QuizID.toArray(new Integer[0]);
				String [] nam=Quizname.toArray(new String[0]);
				for(int i =0;i<siz;i++)
				{
				int CR=GH.getcredit(array[i]);
				Data_load =Data_load+"{ label: '"+nam[i]+"',y: "+CR+"},";
				}
				Data_load=Data_load+"]";*/
				%>				
			
	<script type="text/javascript">
 		 window.onload = function () {
	 		 var DD=<%=Data_load %>;
    			var chart = new CanvasJS.Chart("graph_div",
    			{
     				 theme: "theme2",
      				title:{
        					text: "Student Performance",
      						},
      				 axisX: {
    					label: "Quiz",
        				interval:1,
       					intervalType: "",
        
      						},
     				 axisY:{
        				includeZero: false
          					},
      				 data: [
      						{        
        				type: "line",
        				//lineThickness: 3,        
        				dataPoints: DD
      						},     
      
      						]
    			});
			chart.render();
		}
   </script>
	<script type="text/javascript" src="canvasjs.min.js"></script>
				
				
				<li class="widget color-orange">
							<div class="widget-head">
								<h3>Performance</h3>
							</div>
							<div class="widget-content">
							
								<div id="graph_div"	style="margin: -10px 0 0 -15px;background-color:#FFFFFF;height: 160px;cursor:pointer" onclick="test_sam()" >
									
								</div>
							
							</div>
							
							<div id="report_dialog"	style="visibility: false" >							
							</div>
								</li>

					</ul>
					
					<ul id="column3" class="column">
						<%
						String Q_Id,Q_name;
						QuizHelper quizHelper = new QuizHelper();
						String quizList = quizHelper.getQuizList(CourseID, InstructorID);
						System.out.println(quizList);
						String[] quizListArray = quizList.split("-@-");
						DatabaseConnection dbconn = new DatabaseConnection();
						Connection con = dbconn.createDatabaseConnection();
						Statement st = con.createStatement();
						String Quiz_count=null;
						String[] tool_tip_content=null;
		
						%>
						<li class="widget color-orange">
							<div class="widget-head">
								<h3>Quizes</h3>
							</div>
							<div class="widget-content">
								<div 
									style="margin: 0px 0 0 -4px; height: 150px; overflow-y: scroll;">
								    <%
								    if(quizListArray.length <= 1 && !quizList.contains("-&-")){
										 %>
										<div> No Quiz Available </div>";
										
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
												//String quiz_conducted_count=quizHelper.getquiz_detail(Q_Id);
												String quiz_summ=quizHelper.get_quizsumm(Q_Id);
												tool_tip_content=quiz_summ.split("~");
												
											%>									
										
									<div id="<%=Q_Id%>" class="sample"
										onclick="quiz_detail('<%=Q_Id%>','<%=Q_name%>')">
										<%=Q_name%>
									</div>
										<%		
					}else
					{  
						//String quiz_conducted_count=quizHelper.getquiz_detail(Q_Id);
						String quiz_summ=quizHelper.get_quizsumm(Q_Id);	
						
						String str=quizHelper.get_quiz_per(Q_Id);
						
						System.out.println("Q_Id=====================>"+str);
						
					    tool_tip_content=quiz_summ.split("~");
						%>
						
						
				          <div id="<%=Q_Id%>" class="sample1" onclick="quiz_detail('<%=Q_Id%>','<%=Q_name%>');">
										<%=Q_name%>
						  </div>
									
						
						<%}
						
				}
			}			
			dbconn.closeLocalConnection(con);
			%>				
								</div>
								<div id="Quiz_dialog" style="visibility: hidden"
									title="Quiz Details"></div>
							</div>
						</li>
						
						
					</ul>
					
					
					
					
					
					
					
					
					
					
					
				</div> <script type="text/javascript" src="jquery-1.2.6.min.js"></script>
				<script type="text/javascript"
					src="jquery-ui-personalized-1.6rc2.min.js"></script> <script
					type="text/javascript" src="inettuts.js"></script> <!-- This is used for dashboard -->

			</td>
		</tr>
		<tr>
			<td align="center">
				<!-- 
<div id="chart_div" style="width: 900px; height: 200px;">
</div>
 -->

			</td>
		</tr>
	</table>
<input type="text" name="student_count" id="student_count" value=<%= Student_count%> style="visibility: hidden;background-color:#9bbb59;width: 0px;height: 0px;" >
	<div style="margin-top: -600px; text-align: center;">
		<%@ include file="../../jsp/includes/menufooter.jsp"%>
	</div>
</body>
</html>