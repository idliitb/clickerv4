<%@page import="clicker.v4.wrappers.Question"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="clicker.v4.quiz.encrypt"%>
<%@page import="clicker.v4.wrappers.Quiz"%>
<%@page import="clicker.v4.global.Global"%>
<%@page import="clicker.v4.student.StudentHelper"%>
<%
String helperText = request.getParameter("helperText");
if(helperText.equals("getStudentList")){
	String sid = request.getParameter("sid").toString();
	StudentHelper studentHelper = new StudentHelper();
	String courseList = studentHelper.getCourseList(sid);
	out.print(courseList);
}else if(helperText.equals("quizCA")){
	String cid = session.getAttribute("StudentCourse").toString();
	Quiz quizCA =  new Quiz(Global.coursejsonobject.get(cid));
	ArrayList<Question> qlist = quizCA.getquestions();	
	for(int i=0;i<qlist.size();i++){
		qlist.get(i).setCorrectAns(new encrypt().decrypt(qlist.get(i).getCorrectAns()));
	}
	Gson gson = new Gson();
	String jsonquiz = gson.toJson(quizCA);	
	out.print(jsonquiz);
}
%>