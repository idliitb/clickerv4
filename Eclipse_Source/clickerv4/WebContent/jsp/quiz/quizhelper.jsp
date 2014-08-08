<%--@author rajavel, Clicker Team, IDL Lab - IIT Bombay  
This jsp file is act as helper for quiz conduction
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
String helpContent = request.getParameter("helpContent");
if(helpContent.equals("quizList")){
	QuizHelper quizHelper = new QuizHelper();
	String courseID = request.getParameter("courseID");
	String instrID = request.getParameter("instructorID");
	String quizList = quizHelper.getQuizList(courseID, instrID);
	System.out.println(quizList);
	String[] quizListArray = quizList.split("-@-");
	String quizListOptions = "<select id='quizname' name = 'quizname'>";
	System.out.println(quizListArray.length);
	if(quizListArray.length <= 1 && !quizList.contains("-&-")){
		quizListOptions += "<option value='No Quiz Available'>No Quiz Available</option>";
	}else{
		for(int i=0;i<quizListArray.length;i++){		
			quizListOptions += "<option value='" + quizListArray[i].split("-&-")[0].replace("<", "&lt;") + "~"+ quizListArray[i].split("-&-")[1].replace("<", "&lt;") + "'>" +quizListArray[i].split("-&-")[1].replace("<", "&lt;")+"</option>";		
		}
	}
	quizListOptions +="</select>";
	out.print(quizListOptions);
}else if(helpContent.equals("quizPreview")){
	QuizHelper quizHelper = new QuizHelper();
	String courseID = request.getParameter("courseID");
	int quizID = Integer.parseInt(request.getParameter("quizID"));
	String quizDetails = quizHelper.getQuizDetail(quizID, courseID);	
	out.print(quizDetails);
}else if(helpContent.equals("getquiztime")){
	QuizHelper quizHelper = new QuizHelper();
	String courseID = request.getParameter("courseID");
	int quizID = Integer.parseInt(request.getParameter("quizID"));
	int quiztime = quizHelper.getQuizTime(quizID, courseID); 
	out.print(quiztime);
}else if(helpContent.equals("setQuizLaunchTime")){
	QuizHelper quizHelper = new QuizHelper();
	String courseID = request.getParameter("courseID");
	System.out.println(request.getParameter("min"));
	System.out.println(request.getParameter("sec"));
	boolean isShowAns = Boolean.parseBoolean(request.getParameter("isShowAns"));	
	int isnegativemarking = Integer.parseInt(request.getParameter("isnegativemarking"));
	int sec = Integer.parseInt(request.getParameter("min")) * 60 + Integer.parseInt(request.getParameter("sec"));
	String quizStatus = quizHelper.setQuizLaunchTime(courseID, sec, isnegativemarking,isShowAns);
	System.out.println(quizStatus);
	out.print(quizStatus);
}
else if(helpContent.equals("setInstantQuizDetailNew")){
	QuizHelper quizHelper = new QuizHelper();
	String courseID = request.getParameter("courseID");
	String instrID = request.getParameter("instrID");
	String IQuiz = request.getParameter("IQuiz");
	boolean isShowAns = Boolean.parseBoolean(request.getParameter("isShowAns"));	
	int sec = Integer.parseInt(request.getParameter("quiztime"));;
	String quizStatus = quizHelper.setInstantQuizDetailNew(courseID, instrID, IQuiz, sec, isShowAns);
	out.print(quizStatus);
}
else if(helpContent.equals("iscourseactive")){
	String courseID = request.getParameter("courseID");
	if(Global.activecourses.containsKey(courseID)){
		out.print("active");
	}else{
		out.print("inactive");
	}
}
else if(helpContent.equals("getquizresponsestatus")){
	String courseID = session.getAttribute("courseID").toString();
	QuizHelper quizHelper = new QuizHelper();
	int noofstudent = quizHelper.getNoofStudent(courseID);	
	int responsecount = Global.countresponsejson.get(courseID);
	out.print("Responses : " + responsecount + " / " + noofstudent);
}else if(helpContent.equals("endquiz")){
	String courseID = session.getAttribute("courseID").toString();
	int quizRtime = Integer.parseInt(request.getParameter("quizRtime"));
	Quiz quiz= Global.coursejsonobject.get(courseID);
	int quiztime = Integer.parseInt(quiz.getQuizTime());
	quiz.setQuizTime(Integer.toString(quiztime - quizRtime));
	Global.coursejsonobject.put(courseID,quiz);
	out.print("Done");
}else if(helpContent.equals("quizdetail")){
	QuizHelper quizHelper = new QuizHelper();
	String tooltip_msg = request.getParameter("Quiz_msg").toString();	
	String[] quiz_sum=tooltip_msg.split("~");
	int Quiz_count=0;	
	String html_tag= "<div style='height:auto ;width: 250px;border: solid;'>"+
	"<table style='font-size: 12px;height: 100%;width: 100%;border: none;font-weight: bold;'>"+
	"<tr><td >No of Ques :&nbsp;&nbsp;"+quiz_sum[1]+" </td><td>Total Marks :&nbsp;&nbsp;"+quiz_sum[2]+" </td></tr>"+
	"<tr><td colspan='2'> No of Times Conducted:&nbsp;&nbsp;"+ quiz_sum[0] +
	 "</td></tr></table></div>";	
	out.print(html_tag);	
	
}
%>