<%--@author rajavel 
This jsp file is act as helper for quiz response
--%>

<%@page import="clicker.v4.quiz.QuizResponseHelper"%>
<%@page import="clicker.v4.wrappers.Quiz"%>
<%@page import="clicker.v4.global.Global"%>
<%
String instructorID = (String) session.getAttribute("InstructorID");
if (instructorID == null) {
	request.setAttribute("Error","Your session has expired. Login again");
	RequestDispatcher rd = request.getRequestDispatcher("../../error.jsp");
	rd.forward(request, response);
	return;
}
String helpContent = request.getParameter("helpContent");
if(helpContent.equals("responseDialog")){
	String quiztype = request.getParameter("quiztype");
	if(quiztype.equals("normalquiz")){
		String questionid = request.getParameter("questionid");
		QuizResponseHelper quizResponseHelper = new QuizResponseHelper();
		String courseID = session.getAttribute("courseID").toString();
		out.print(quizResponseHelper.getResponseTable(questionid, courseID));
	}else if(quiztype.equals("instantquizmq")){
		String questionid = request.getParameter("questionid");
		QuizResponseHelper quizResponseHelper = new QuizResponseHelper();
		String courseID = session.getAttribute("courseID").toString();
		out.print(quizResponseHelper.getInstantResponseTable(questionid, courseID));
	}else if (quiztype.equals("instantquiz")){
		QuizResponseHelper quizResponseHelper = new QuizResponseHelper();
		String courseID = session.getAttribute("courseID").toString();
		out.print(quizResponseHelper.getResponseTable(courseID));
	}
}else if (helpContent.equals("responseCount")) {
	String quiztype = request.getParameter("quiztype");
	if (quiztype.equals("normalquiz")) {
		String courseID = session.getAttribute("courseID").toString();
		int quizrecordid = Global.quizrecordids.get(courseID);
		QuizResponseHelper quizResponseHelper = new QuizResponseHelper();
		String chartString=quizResponseHelper.getNormalQuizResponseCount(quizrecordid);
		out.print(chartString);
	} else if (quiztype.equals("instantquizmq")) {
		String courseID = session.getAttribute("courseID").toString();
		int quizrecordid = Global.quizrecordids.get(courseID);
		QuizResponseHelper quizResponseHelper = new QuizResponseHelper();
		String chartString=quizResponseHelper.getInstantQuestionResponseCount(quizrecordid);
		out.print(chartString);
	}

}
%>