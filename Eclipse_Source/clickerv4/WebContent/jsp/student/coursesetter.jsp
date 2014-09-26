<!-- Author : Dipti, Clicker Team, IDL LAB ,IIT Bombay
* This page is used for setting course.
 -->
 <%@page import="clicker.v4.wrappers.*"%>
 <%@page import= "com.google.gson.Gson"%>
 <%@page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>set course</title>
<script type="text/javascript">

function setcourse()
{
	var course_ID=document.getElementById("StudentCourse").options[document.getElementById("StudentCourse").selectedIndex].innerHTML
	window.parent.parent.window.location="home.jsp?StudentCourse="+course_ID;
	}

</script>
</head>
<% 
int truecount=0;
String courseName="";
String CourseList=request.getParameter("CourseList");
String StudentID=request.getParameter("StudentID");
String autoSubmitAlert=request.getParameter("autoSubmitAlert");
System.out.println("=====>"+CourseList);
session.setAttribute("Mode","local");
session.setAttribute("UserSessionID",session.getId());
session.setAttribute("autoSubmitAlert", autoSubmitAlert);
session.setAttribute("StudentID", StudentID );
Gson gson = new Gson();
CourseList list=gson.fromJson(CourseList, CourseList.class);
System.out.println(CourseList+"::::::::::::::::::::::::::"+list.getCourseIDs());
ArrayList<String> courselist=list.getCourseIDs();
ArrayList<Boolean> activelist=list.getIsActive();

	for(int i=0;i<courselist.size();i++){
		if(activelist.get(i)){
			truecount++;
			courseName=courselist.get(i);
			}
		}
	if(truecount<1||truecount==0){
		session.setAttribute("StudentCourse", "No Active Course");
	}
	if(truecount==1){
		session.setAttribute("StudentCourse",courseName);
	}

%>
<body>
<form id="CourseIDform" method="POST" action="home.jsp">
<div style="text-align: center;">
			<br>Select Course <select id="StudentCourse" name="StudentCourse">
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
						
	<br> <input type="submit" value=" Set Course " onclick="setcourse()"/>
	</div>
</form>
</body>
</html>