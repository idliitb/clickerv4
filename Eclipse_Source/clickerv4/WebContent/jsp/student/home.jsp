<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <script src="../../js/div.js" type="text/javascript"></script>
<%
	if (session.getAttribute("StudentID") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	String sid = session.getAttribute("StudentID").toString();
	String autoSubmitAlert=session.getAttribute("autoSubmitAlert").toString();
	System.out.println("Value of auto alert from submit::::"+autoSubmitAlert);
	session.setAttribute("UserSessionID",session.getId());
	String studcourse = "";
	if (request.getParameter("StudentCourse") != null) {
		studcourse = request.getParameter("StudentCourse");
		session.setAttribute("StudentCourse", studcourse);
	} else {
		studcourse = session.getAttribute("StudentCourse").toString();
	}
%>
<title>Home</title>
<script type="text/javascript">
	var xmlhttp;
	//This method will get the XMLHTTP object for work with ajax
	function getXMLhttp() {
		if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else if (window.ActiveXObject) { // IE
			try {
				xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
				}
			}
		}
	}

	function getCourseList(sid){
		getXMLhttp();
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var courselist = xmlhttp.responseText.split("@");
				var CoruseButtons = "<div style='height: 250px;overflow-y: scroll;overflow-x: hidden;overflow-y:auto;'>";
				for(var i=0;i<courselist.length-1;i++){
					CoruseButtons += "<input class='courseBtn' type='button' onclick='showReport(\""+courselist[i].trim()+"\", \""+sid+"\")' value='"+courselist[i].trim()+"'>";
				}
				CoruseButtons+="</div>";
				document.getElementById("rep_courselist").innerHTML = CoruseButtons;
				document.getElementById("rep_courselist").style.display = 'block';				
			    document.getElementById("homemaintable").style.pointerEvents = "none";			
				document.getElementById("homemaintable").style.opacity = 3/10;
				var divToOpen = "rep_courselist";
				var popupSetting = { width: '310', height: '330', title: 'Coruse List',isFixed:true };
				
				ShowPopup(divToOpen, popupSetting,"0");
				
			}
		};	
		xmlhttp.open("GET", "studenthelper.jsp?helperText=getStudentList&sid="+sid, false);
		xmlhttp.send();	
	}

	function getActiveCourseList(sid)	    	
	{
		
		getXMLhttp();
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var truecount=0;
				var courseName="";
				var courselist = xmlhttp.responseText;
				var courselistjson = JSON.parse(courselist);
				for(var i=0;i<courselistjson.courseIDs.length;i++){
					if(courselistjson.isActive[i]){
						truecount++;
						courseName=courselistjson.courseIDs[i];
						}
					}
				if (truecount==1) {
					var xmlhttp2;
					xmlhttp2 = new XMLHttpRequest();
					xmlhttp2.onreadystatechange = function() {

						if (xmlhttp2.readyState == 4
								&& xmlhttp2.status == 200) {
							window.location.href = "home.jsp";
						}
					};

					xmlhttp2.open("POST", "coursesetter.jsp", false);
					xmlhttp2.setRequestHeader("Content-type",
							"application/x-www-form-urlencoded");
					xmlhttp2.send("CourseList=" + xmlhttp.responseText
							+ "&StudentID=" + sid
							+ "&autoSubmitAlert=true");
					return true;
					
				}
				else if(truecount<1||truecount==0){
					
					var xmlhttp2;
					xmlhttp2 = new XMLHttpRequest();
					xmlhttp2.onreadystatechange = function() {

						if (xmlhttp2.readyState == 4
								&& xmlhttp2.status == 200) {
							window.location.href = "home.jsp";
						}
					};

					xmlhttp2.open("POST", "coursesetter.jsp", false);
					xmlhttp2.setRequestHeader("Content-type",
							"application/x-www-form-urlencoded");
					xmlhttp2.send("CourseList=" + xmlhttp.responseText
							+ "&StudentID=" + sid
							+ "&autoSubmitAlert=true");
					return true;
					
					
				}else{

				document.getElementById("homemaintable").style.pointerEvents = "none";			
				document.getElementById("homemaintable").style.opacity = 3/10;
				var url= "coursesetter.jsp?CourseList="+courselist+"&StudentID="+sid+ "&autoSubmitAlert=true";
				var divToOpen = "activeCourseListDiv";
				var popupSetting = { width: '300', height: '250', title: 'Course List',isFixed:true };
				document.getElementById("test").innerHTML='<object type="text/html" data='+url+'></object>';
				ShowPopup(divToOpen, popupSetting,"0");
				}
			}
		};	
		xmlhttp.open("GET","../../rest/quiz/courselist/"+sid,false);
		xmlhttp.send(); 
	}

	function showReport(cid, sid) {
		getXMLhttp();
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var report = JSON.parse(xmlhttp.responseText);
				if(report.courseName=="No Quiz Marks" || report.studentID == null){
					alert("No Quiz Report Available");
					return;
				}else{
					window.location = "report.jsp?cid=" + cid;
				}
			}
		};	
		xmlhttp.open("GET", "../../rest/quiz/result/"+cid+"/"+sid+"/local", false);
		xmlhttp.send();
	}

	function checkCourse(StudentCourse,autoSubmitAlert) {
		if(autoSubmitAlert=="true"){
			if(StudentCourse == "No Active Course"){
				alert("No Active Course");
				document.getElementById("quizbtn").disabled = true;
				document.getElementById("quizbtn").className = "disabledmenu";
				document.getElementById("pollbtn").disabled = true;
				document.getElementById("pollbtn").className = "disabledmenu";
				document.getElementById("raisebtn").disabled = true;
				document.getElementById("raisebtn").className = "disabledmenu";
				}else{
					alert(StudentCourse);
					document.getElementById("quizbtn").disabled = false;
					document.getElementById("pollbtn").disabled = false;
					document.getElementById("raisebtn").disabled = false;
					}
		}else{
			if(StudentCourse == "No Active Course"){
				document.getElementById("quizbtn").disabled = true;
				document.getElementById("quizbtn").className = "disabledmenu";
				document.getElementById("pollbtn").disabled = true;
				document.getElementById("pollbtn").className = "disabledmenu";
				document.getElementById("raisebtn").disabled = true;
				document.getElementById("raisebtn").className = "disabledmenu";
				}else{
					document.getElementById("quizbtn").disabled = false;
					document.getElementById("pollbtn").disabled = false;
					document.getElementById("raisebtn").disabled = false;
					}
			}
		
	}
	
	function isQuizLaunched(cid){
		getXMLhttp();
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var quiz = JSON.parse(xmlhttp.responseText);
				if(quiz.courseId=="0"){
					alert("Quiz Not Launched");
				}else if(quiz.quizrecordId==getCookie(quiz.quiztype + "lastattempted")){
					alert("Already Attempted this Quiz");
				}else if(quiz.quiztype=="instant"){
					window.location="iquiz.jsp";
				}else if(quiz.quiztype=="normal"){
					window.location="quiz.jsp";
				}
			}
		};	
		xmlhttp.open("GET", "../../rest/quiz/"+cid+"/local", false);
		xmlhttp.send();
	}
	function getCookie(cname) {
	    var name = "clickerquiz" + cname + "=";
	    var ca = document.cookie.split(';');
	    for(var i=0; i<ca.length; i++) {
	        var c = ca[i];
	        while (c.charAt(0)==' ') c = c.substring(1);
	        if (c.indexOf(name) != -1) return c.substring(name.length,c.length);
	    }
	    return "";
	}
	function getpollCookie(cname) {
	    var name = cname + "=";
	    var ca = document.cookie.split(';');
	    //alert("::::::: name: " + document.cookie); 
	    for(var i=0; i<ca.length; i++) {
	        var c = ca[i];
	        while (c.charAt(0)==' ') c = c.substring(1);
	        if (c.indexOf(name) != -1) return c.substring(name.length,c.length);
	    }
	    return "";
	}
	
	function checkpoll(studcourse,mode){
		var xmlhttp1;
	  	xmlhttp1=new XMLHttpRequest();
		xmlhttp1.onreadystatechange=function()
		{
			
			if (xmlhttp1.readyState==4 && xmlhttp1.status==200)
			{
				var polljson=JSON.parse(xmlhttp1.responseText);
				var pollid=polljson.pollid;
				var pollquestion=polljson.pollquestion;
				var launchtime=polljson.launchtime; 
				var currenttime=polljson.currenttime;
				var courseId=polljson.courseId;
				var quizTime=polljson.quizTime;
				
				//alert(pollquestion+" @ "+launchtime+" @ "+currenttime+" @ "+courseId+" @ "+quizTime);
				if(pollid==0 && pollquestion=="" && launchtime=="" && currenttime=="" && courseId=="" && quizTime=="")
				{
					alert("Poll has not launched");				
				}
				else if(pollid==getpollCookie("polllastattempted")){
					alert("Poll Already Attempted");
				}
				else
				{
					pollquestion=pollquestion.replace(/'/g, "\\'");
					//pollquestion1=pollquestion.replace(/"/g, '\\"');
					//alert(pollquestion1);
					document.getElementById("pollquestion").value=pollquestion;
					document.getElementById("polljson").value=launchtime+"@"+currenttime+"@"+courseId+"@"+quizTime+"@"+pollid;
					document.getElementById("pollform").submit();
					//window.location = "poll.jsp?pollquestion="+pollquestion+"&polljson="+launchtime+"@"+currenttime+"@"+courseId+"@"+quizTime+"@"+pollid;
				}
			}
		};
		xmlhttp1.open("GET","../../rest/quiz/poll/"+studcourse+"/"+mode,false);
		xmlhttp1.send(); 
	}
</script>
<style type="text/css">
body {
	position: relative;
	text-align: center;
	width: 100%;
	height: 100%;
	margin: auto;
	background-color: #404040;
}

#main_container {
	margin: auto;
	width: 1320px;
	height: 628px;
}

.homemenu {
	width: 250px;
	height: 200px;
	background-color: #9bbb59;
	margin: auto;
	border-radius: 30px;
	text-align: center;
	color: balck;
	font-size: 35px;
}

.disabledmenu {
	width: 250px;
	height: 200px;
	background-color: #626262;
	margin: auto;
	border-radius: 30px;
	text-align: center;
	color: black;
	font-size: 35px;
}

#homemaintable {
	width: 1200px;
	height: 620px;
	text-align: center;
	margin-left: 60px;
}

.ui-loginbutton {
	background: #E46C0A;
	color: balck;
	height: 70px;
	width: 210px;
	border-radius: 10px;
	font-size: 30px;
}

.courseBtn{
	background-color: #9bbb59;		
	float: left;
	margin-top: 18px;
	width: 260px;
	height: 60px;
	text-align: center;
	font-size: 20px;
	font-weight: bold;
}
.ui-dialog-title{
	font-size: 30px;
}
#StudentCourse{
	width: 240px;
	height: 40px;
	font-size: 30px;
}
#CourseIDform input{
	width: 180px;
	height: 45px;
	font-size: 30px;
	background-color: #9bbb59;	
}
#CourseIDform{
	font-size: 25px;
}
</style>
</head>
<body onload="checkCourse('<%=studcourse%>','<%=autoSubmitAlert%>')">
<form id="pollform" action="poll.jsp" method="post">
<input type="hidden" id="pollquestion" name="pollquestion"/>
<input type="hidden" id="polljson" name="polljson"/>
</form>
	<div id="main_container">
		<table id="homemaintable">
			<tr style="height: 110px;">
				<td style="width: 300px;"><font size=5px; color="#9bbb59">Course
						ID<br><%=studcourse%>
				</font></td>
				<td colspan="2"><font size=35px; color="#E46C0A">CLICKER
						V4</font></td>
				<td style="width: 300px;"><font size=5px; color="#9bbb59">Student
						ID<br><%=sid%></font></td>
			</tr>
			<tr style="height: 300px;">
				<td><button class="homemenu" id="quizbtn"
						onclick="isQuizLaunched('<%=studcourse%>')">
						<span>Quiz</span>
					</button></td>
				<td><button class="homemenu" id="pollbtn"
						onclick="checkpoll('<%=studcourse%>','local')">
						<span>Poll</span>
					</button></td>
				<td><button class="homemenu" id="reportbtn"
						onclick="getCourseList('<%=sid%>')">
						<span>Report</span>
					</button></td>
				<td><button class="homemenu" id="raisebtn"
						onclick="window.location.href='raisehand.jsp'">
						<span>Raise</span>
					</button></td>
			</tr>
			<tr>
				<td colspan="4"><button id="exit" type="submit"
						class="ui-loginbutton" onclick="window.location.href='login.jsp'">
						<span>EXIT</span>
					</button></td>
			</tr>
			<tr>
				<td></td>
				<td colspan="2"><font color="#ffffff">Designed and
						Developed by Clicker Software Team, IIT Bombay.</font></td>
				<td><div style="float: left; margin-left: 50px;">
						<input id="refresh-div" type="image" src="../../img/refresh_course.png"
							alt="Submit" onclick="getActiveCourseList('<%=sid%>')">
					</div>
					<div style="float: left; margin-left: 50px;">
						<input id="help-btn" type="image" src="../../img/Queston05.png" alt="Submit"
							onclick="window.location.href='help.jsp'">
					</div></td>
			</tr>
		</table>
		<div id="rep_courselist" style="display: none;margin-left: 10px;"></div>
		<div id="activeCourseListDiv" style="display: none;">
		<div id="test">
</div></div>
	</div>
	<%if(session.getAttribute("autoSubmitAlert").toString().equals("true")){
	session.setAttribute("autoSubmitAlert","false");
}
%>
</body>
</html>