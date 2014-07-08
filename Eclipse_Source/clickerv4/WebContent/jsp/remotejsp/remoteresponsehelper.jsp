<%--@author dipti,rajavel 
This jsp file is act as helper for quiz response
--%>

<%@page import="clicker.v4.admin.AutoTestHelper"%>
<%@page import="clicker.v4.remote.RemoteDBHelper"%>
<%@page import="clicker.v4.rest.JSONReadandparse"%>
<%@page import="clicker.v4.global.Global"%>
<%@page import="clicker.v4.remote.RemoteQuizResponseHelper"%>
<%@page import="clicker.v4.wrappers.Quiz"%>
<%
String instructorID = (String) session.getAttribute("CoordinatorID");
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
		RemoteQuizResponseHelper quizResponseHelper = new RemoteQuizResponseHelper();
		String courseID = session.getAttribute("WorkshopID").toString();
		out.print(quizResponseHelper.getResponseTable(questionid, courseID));
	}else if (quiztype.equals("instantquiz")){
		RemoteQuizResponseHelper remoteQuizResponseHelper = new RemoteQuizResponseHelper();
		String courseID = session.getAttribute("WorkshopID").toString();
		out.print(remoteQuizResponseHelper.getResponseTable(courseID));
	}else if(quiztype.equals("instantquizmq")){
		String questionid = request.getParameter("questionid");
		RemoteQuizResponseHelper remoteQuizResponseHelper = new RemoteQuizResponseHelper();
		String courseID = session.getAttribute("WorkshopID").toString();
		System.out.println(questionid + courseID);
		out.print(remoteQuizResponseHelper.getInstantResponseTable(questionid, courseID));
	}
}else if(helpContent.equals("responseDialogAutoTest")){
	String questionid = request.getParameter("questionid");
	RemoteQuizResponseHelper remoteQuizResponseHelper = new RemoteQuizResponseHelper();
	out.print(remoteQuizResponseHelper.getAutoTestResponseTable(questionid));
}
else if(helpContent.equals("getinstantquizresponsecount")){		
	String courseID = session.getAttribute("WorkshopID").toString();
	out.print(Global.remotecountresponsejson.get(courseID));
}else if(helpContent.equals("sendinstantquizresponse")){
	String WorkshopID = session.getAttribute("WorkshopID").toString();
	String CoordinatorID = session.getAttribute("CoordinatorID").toString();
	int quizrecordid = Global.remotemcquizrecordids.get(WorkshopID);
	JSONReadandparse sendJSON = new JSONReadandparse();
	RemoteDBHelper rdh= new RemoteDBHelper();
	String MainCenterURL=(String)session.getAttribute("MainCenterURL");
	Global.isInstantResponseSent.put(WorkshopID,"yes");
	out.println(sendJSON.sendInstantQuizResponceJSON(quizrecordid, MainCenterURL,WorkshopID,CoordinatorID));
}else if(helpContent.equals("autotestresponsecount")){				
	out.print(Global.remotecountresponsejson.get("autotest"));
}else if(helpContent.equals("sendautotestresponse")){
	String CoordinatorID = session.getAttribute("CoordinatorID").toString();
	int quizrecordid = Global.remotequizrecordids.get("autotest");
	JSONReadandparse sendJSON = new JSONReadandparse();
	String MaincenterName = session.getAttribute("maincentername").toString();
	String MainCenterURL = new AutoTestHelper().getMainCenterURL(MaincenterName);
	out.println(sendJSON.sendAutoTestResponceJSON(quizrecordid, MainCenterURL,"autotest",CoordinatorID));
}else if(helpContent.equals("getnormalquizresponsecount"))
{
	String WorkshopID = (String)session.getAttribute("WorkshopID");	
	out.println(Global.remotecountresponsejson.get(WorkshopID));
}
else if	(helpContent.equals("sendnormalquizresponse"))
{
	String WorkshopID = (String)session.getAttribute("WorkshopID");
	String MainCenterURL=(String)session.getAttribute("MainCenterURL");
	int quizrecordid = Global.remotequizrecordids.get(WorkshopID);
	new RemoteQuizResponseHelper( ).createMCResponseJson(quizrecordid,MainCenterURL);
	Global.isnormalresponsesent.put(WorkshopID,"yes");
}else if(helpContent.equals("getquizresponsestatus")){
	String WorkshopID = (String)session.getAttribute("WorkshopID");
	RemoteDBHelper quizHelper = new RemoteDBHelper();
	int noofparticipant =0;
	if(session.getAttribute("noofparticipant")!=null){
		noofparticipant = Integer.parseInt(session.getAttribute("noofparticipant").toString());
	}else{
		session.setAttribute("noofparticipant", quizHelper.getNoofParticipant(WorkshopID));
	}
	int responsecount = Global.remotecountresponsejson.get(WorkshopID);
	out.print("Responses : " + responsecount + " / " + noofparticipant);
}else if(helpContent.equals("endquiz")){
	String WorkshopID = session.getAttribute("WorkshopID").toString();
	int quizRtime = Integer.parseInt(request.getParameter("quizRtime"));
	Quiz quiz= Global.workshopjsonobject.get(WorkshopID);
	int quiztime = Integer.parseInt(quiz.getQuizTime());
	quiz.setQuizTime(Integer.toString(quiztime - quizRtime));
	Global.workshopjsonobject.put(WorkshopID,quiz);
	out.print("Done");
}else if (helpContent.equals("responseCount")) {
	String quiztype = request.getParameter("quiztype");
	if (quiztype.equals("normalquiz")) {
		String WorkshopID = (String)session.getAttribute("WorkshopID");
		int quizrecordid = Global.remotequizrecordids.get(WorkshopID);
		RemoteQuizResponseHelper quizResponseHelper = new RemoteQuizResponseHelper();
		String chartString=quizResponseHelper.getNormalQuizResponseCount(quizrecordid,WorkshopID);
		out.print(chartString);
	} else if (quiztype.equals("instantquizmq")) {
		String WorkshopID = (String)session.getAttribute("WorkshopID");
		int quizrecordid = Global.remotequizrecordids.get(WorkshopID);
		RemoteQuizResponseHelper quizResponseHelper = new RemoteQuizResponseHelper();
		String chartString=quizResponseHelper.getInstantQuestionResponseCount(quizrecordid);
		out.print(chartString);
	}

}


%>