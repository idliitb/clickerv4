<!-- Author : Dipti, Clicker Team, IDL LAB ,IIT Bombay
* This page is used for setting workshop.
 -->
 <%@page import="clicker.v4.wrappers.*"%>
 <%@page import= "com.google.gson.Gson"%>
 <%@page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>set workshop</title>
<script type="text/javascript">
function submitForm(){
	var workshop_ID=document.getElementById("ParticipantWorkshop").options[document.getElementById("ParticipantWorkshop").selectedIndex].innerHTML
	window.parent.parent.window.location="remotehome.jsp?ParticipantWorkshop="+workshop_ID;
}
</script>
</head>
<% 
int truecount=0;
String courseName="";
String CourseList=request.getParameter("WorkshopListForLogin");
String StudentID=request.getParameter("ParticipantId");
String autoSubmitAlert=request.getParameter("autoSubmitAlert");
session.setAttribute("Mode","remote");
session.setAttribute("autoSubmitAlert", autoSubmitAlert);
session.setAttribute("ParticipantId", StudentID );
session.setAttribute("UserSessionID",session.getId());
Gson gson = new Gson();
CourseList list=gson.fromJson(CourseList, CourseList.class);
ArrayList<String> courselist=list.getCourseIDs();
ArrayList<Boolean> activelist=list.getIsActive();
if(courselist.size()==1){
	if(activelist.get(0)){
		session.setAttribute("ParticipantWorkshop", courselist.get(0));
	}else{
		session.setAttribute("ParticipantWorkshop", "No Active Course(s)");
	}
}else{
	for(int i=0;i<courselist.size();i++){
		if(activelist.get(i)){
			truecount++;
			courseName=courselist.get(i);
			}
		}
	if(truecount<1||truecount==0){
		session.setAttribute("ParticipantWorkshop", "No Active Course(s)");
	}
	if(truecount==1){
		session.setAttribute("ParticipantWorkshop",courseName);
	}
}
%>
<body>
<form id="CourseIDform" method="POST" action="remotehome.jsp">
			<br>Select Workshop <select id="ParticipantWorkshop" name="ParticipantWorkshop">
							<%
							boolean flag=false;
							for (int i=0; i<courselist.size(); i++){
								if(activelist.get(i)){
									flag=true;
							%>
									<option><%=courselist.get(i)%></option>
							
							<%	}
							}
							
							%>
								
							
						</select> <br>
						
	<br> <input type="submit" value=" Set Workshop " onclick="submitForm()" />
</form>
</body>
</html>