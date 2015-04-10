<!-- Author : Dipti, Clicker Team, IDL LAB ,IIT Bombay
* This page is used for paticipant home page.
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <script src="../../js/div.js" type="text/javascript"></script>
<!-- <link rel="stylesheet" href="../../js/jquery-ui-dialog-tab.min.css">
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/jquery-ui-dialog-tab.min.js"></script> -->
<%

	if (session.getAttribute("ParticipantId") == null) {
		response.sendRedirect("participantexit.jsp");
		return;
	}
	String pid = session.getAttribute("ParticipantId").toString();
	String autoSubmitAlert=session.getAttribute("autoSubmitAlert").toString();
	session.setAttribute("UserSessionID",session.getId());
	String participantworkshop = "";
	if (request.getParameter("ParticipantWorkshop") != null) {
		participantworkshop = request
				.getParameter("ParticipantWorkshop");
		session.setAttribute("ParticipantWorkshop", participantworkshop);
	} else {
		participantworkshop = session
				.getAttribute("ParticipantWorkshop").toString();
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

	function activeCourseName(coursename,autoSubmitAlert){
	if(autoSubmitAlert=="true"){
		if(coursename=="No Active Course(s)"){
			alert("No Active Course(s)");
			document.getElementById("quizbtn").disabled = true;
			document.getElementById("pollbtn").disabled = true;
			document.getElementById("reportbtn").disabled = false;
			document.getElementById("reportbtn").className = "homemenu";
			}else{
				alert(coursename);
				document.getElementById("quizbtn").disabled = false;
				document.getElementById("quizbtn").className = "homemenu";
				document.getElementById("pollbtn").disabled = false;
				document.getElementById("pollbtn").className = "homemenu";
				document.getElementById("reportbtn").disabled = false;
				document.getElementById("reportbtn").className = "homemenu";
				}
	}else{
		if(coursename=="No Active Course(s)"){
			document.getElementById("quizbtn").disabled = true;
			document.getElementById("pollbtn").disabled = true;
			document.getElementById("reportbtn").disabled = false;
			document.getElementById("reportbtn").className = "homemenu";
			}else{
				document.getElementById("quizbtn").disabled = false;
				document.getElementById("quizbtn").className = "homemenu";
				document.getElementById("pollbtn").disabled = false;
				document.getElementById("pollbtn").className = "homemenu";
				document.getElementById("reportbtn").disabled = false;
				document.getElementById("reportbtn").className = "homemenu";
				}
		}
	///**************************************** 
	
	var remotepreviouspollresponse = getpollresponseCookie("remotepreviouspollresponse");
	//alert("remotepreviouspollresponse : "+remotepreviouspollresponse); 

			if (remotepreviouspollresponse!="") {
			//alert("in prev if");
			getXMLhttp();
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
				{
					//alert( xmlhttp.status );
					var ack = xmlhttp.responseText;
					//alert("in if alert"+ack);
				}
			};
			xmlhttp.open("POST", "../../rest/quiz/poll",false);
			xmlhttp.setRequestHeader("Content-type",
			"application/x-www-form-urlencoded");
			xmlhttp.send(remotepreviouspollresponse);
			
		
			}
			removeCookie("remotepreviouspollresponse");
		}
	
	function getpollCookie(cname) {
	    var name = cname + "=";
	    var ca = document.cookie.split(';');
	    for(var i=0; i<ca.length; i++) {
	        var c = ca[i];
	        while (c.charAt(0)==' ') c = c.substring(1);
	        if (c.indexOf(name) != -1) return c.substring(name.length,c.length);
	    }
	    return "";
	}
	function getpollresponseCookie(cname) {
	    var name = cname + "=";
	    var ca = document.cookie.split(';');
	    for(var i=0; i<ca.length; i++) {
	        var c = ca[i];
	        while (c.charAt(0)==' ') c = c.substring(1);
	        if (c.indexOf(name) != -1) return c.substring(name.length,c.length);
	    }
	    return "";
	}
	function removeCookie(cname) {
		document.cookie = cname+ "=; expires=Thu, 01 Jan 1970 00:00:00 UTC";
	}
	function checkpoll(studcourse, mode) {
		var xmlhttp1;
		xmlhttp1 = new XMLHttpRequest();
		xmlhttp1.onreadystatechange = function() 
		{

			if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) 
			{
				var polljson = JSON.parse(xmlhttp1.responseText);
				var pollid = polljson.pollid;
				var pollquestion = polljson.pollquestion;
				var launchtime = polljson.launchtime;
				var currenttime = polljson.currenttime;
				var workshopid = polljson.courseId;
				var quizTime = polljson.quizTime;

				if (pollid == 0 && pollquestion == "" && launchtime == "" && currenttime == "" && workshopid == "" && quizTime == "") 
				{
					alert("Poll has not launched");
				}
				else if(pollid==getpollCookie("remotepolllastattempted"))
				{
					alert("Poll Already Attempted");
				}
				else
				{
					pollquestion = pollquestion.replace(/'/g, "\\'");
					document.getElementById("pollquestion").value=pollquestion;
					document.getElementById("polljson").value=launchtime + "@"+ currenttime + "@" + workshopid + "@" + quizTime+"@"+pollid;
					document.getElementById("pollform").submit();
				}
			}
		};
		xmlhttp1.open("GET", "../../rest/quiz/poll/" + studcourse + "/" + mode,
				false);
		xmlhttp1.send();
	}

	function getActiveWorkshopList(pid) {
		var truecount=0;
	
		getXMLhttp();
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {	
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
								window.location.href="remotehome.jsp";
						}
					};

					xmlhttp2
							.open(
									"POST",
									"workshopsetter.jsp",
									false);
					xmlhttp2.setRequestHeader("Content-type",
							"application/x-www-form-urlencoded");
					xmlhttp2.send("WorkshopListForLogin="+ xmlhttp.responseText
							+ "&ParticipantId="+pid+"&autoSubmitAlert=true");
					return true;

					
				}
				
				else if(truecount<1||truecount==0){
					
					var xmlhttp2;
					xmlhttp2 = new XMLHttpRequest();
					xmlhttp2.onreadystatechange = function() {

						if (xmlhttp2.readyState == 4
								&& xmlhttp2.status == 200) {
								window.location.href="remotehome.jsp";
						}
					};

					xmlhttp2
							.open(
									"POST",
									"workshopsetter.jsp",
									false);
					xmlhttp2.setRequestHeader("Content-type",
							"application/x-www-form-urlencoded");
					xmlhttp2.send("WorkshopListForLogin="+ xmlhttp.responseText
							+ "&ParticipantId="+pid+"&autoSubmitAlert=true");
					return true;
					
					
					}
				else{
					document.getElementById("homemaintable").style.pointerEvents = "none";			
					document.getElementById("homemaintable").style.opacity = 3/10;
				
					url = "workshopsetter.jsp?WorkshopListForLogin="
							+ xmlhttp.responseText + "&ParticipantId=" + pid+"&autoSubmitAlert=true";
					var divToOpen = "activeWorkshopListDiv";
					var popupSetting = {width : '300',height : '250',title : 'Workshop List',isFixed : true};
					document.getElementById("test").innerHTML = '<object type="text/html" data='+url+'></object>';
					ShowPopup(divToOpen, popupSetting, "0");
				}
				
			}
		};
		xmlhttp.open("GET", "../../rest/quiz/courselist/" + pid, false);
		xmlhttp.send();
	}
	
	function isQuizLaunched(wid, pid){
		getXMLhttp();
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var quiz = JSON.parse(xmlhttp.responseText);
				if(quiz.courseId=="0"){
					alert("Quiz Not Launched");
				}else if(quiz.courseId=="-2"){
					alert("Already Attempted this Quiz");
				}else if(quiz.quizrecordId==getCookie(quiz.quiztype + "lastattempted")){
					alert("Already Attempted this Quiz");
				}else if(quiz.quiztype=="instant"){
					window.location="remoteiquiz.jsp";
				}else if(quiz.quiztype=="normal"){
					window.location="remotequiz.jsp";
				}
			}
		};	
		xmlhttp.open("GET", "../../rest/quiz/"+wid+"/remote/"+pid, false);
		xmlhttp.send();
	}
	function getCookie(cname) {
	    var name = "remoteclickerquiz" + cname + "=";
	    var ca = document.cookie.split(';');
	    for(var i=0; i<ca.length; i++) {
	        var c = ca[i];
	        while (c.charAt(0)==' ') c = c.substring(1);
	        if (c.indexOf(name) != -1) return c.substring(name.length,c.length);
	    }
	    return "";
	}
	
	function getCourseList(sid){
		getXMLhttp();
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var courselist = xmlhttp.responseText.trim().split("@");
				var CoruseButtons = "<div style='height: 250px;overflow-y: scroll;overflow-x: hidden;overflow-y:auto;'>";
				for(var i=0;i<courselist.length-1;i++){
					CoruseButtons += "<input class='courseBtn' type='button' onclick='showReport(\""+courselist[i].trim()+"\" , \""+sid+"\")' value='"+courselist[i].trim()+"'>";
				}
				CoruseButtons+="</div>";
				document.getElementById("rep_courselist").innerHTML = CoruseButtons;
				document.getElementById("rep_courselist").style.display = 'block';				
			    document.getElementById("homemaintable").style.pointerEvents = "none";			
				document.getElementById("homemaintable").style.opacity = 3/10;
				var divToOpen = "rep_courselist";
				var popupSetting = { width: '310', height: '330', title: 'Course List',isFixed:true };
				
				ShowPopup(divToOpen, popupSetting,"0");
				
			}
		};	
		xmlhttp.open("GET", "participanthelper.jsp?helperText=getWorkshopList&pid="+sid, false);
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
					window.location = "remotereport.jsp?wid=" + cid;
				}
			}
		};	
		xmlhttp.open("GET", "../../rest/quiz/result/"+cid+"/"+sid+"/remote", false);
		xmlhttp.send();
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
	width: 300px;
	height: 200px;
	background-color: #9bbb59;
	margin: auto;
	border-radius: 30px;
	text-align: center;
	color: balck;
	font-size: 35px;
}

.disabledmenu {
	width: 300px;
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

.courseBtn {
	background-color: #9bbb59;
	float: left;
	margin-top: 18px;
	width: 280px;
	height: 60px;
	text-align: center;
	font-size: 30px;
	font-weight: bold;
}

.ui-dialog-title {
	font-size: 30px;
}

#StudentCourse {
	width: 240px;
	height: 40px;
	font-size: 30px;
}

#CourseIDform input {
	width: 180px;
	height: 45px;
	font-size: 30px;
	background-color: #9bbb59;
}

#CourseIDform {
	font-size: 25px;
}
</style>

</head>

<body onload="activeCourseName('<%=participantworkshop%>','<%=autoSubmitAlert%>');">
	<div id="main_container">
		<table id="homemaintable">
			<tr style="height: 110px;">
				<td style="width: 400px;"><font size=5px; color="#9bbb59">Workshop
						ID<br><%=participantworkshop%>
				</font></td>
				<td><font size=35px; color="#E46C0A">CLICKER V4</font></td>
				<td style="width: 400;"><font size=5px; color="#9bbb59">Participant
						ID<br><%=pid%></font></td>
			</tr>
			<tr style="height: 300px;">
				<td><button class="disabledmenu" id="quizbtn" onclick="isQuizLaunched('<%=participantworkshop%>', '<%=pid%>')">
						<span>Quiz</span>
					</button></td>
				<td><button class="disabledmenu" id="pollbtn"
						onclick="checkpoll('<%=participantworkshop %>','remote')">
						<span>Poll</span>
					</button></td>
				<td><button class="disabledmenu" id="reportbtn" onclick="getCourseList('<%=pid%>')">
						<span>Report</span>
					</button></td>

			</tr>
			<tr>
				<td colspan="3"><button id="exit" type="submit"
						class="ui-loginbutton" onclick="window.location.href='participantexit.jsp'">
						<span>EXIT</span>
					</button></td>
			</tr>
			<tr>
				<td colspan="3">
					<table style="width: 1200px; text-align: center;" >
						<tr>
							<td style="width: 310px;"></td>
							<td colspan="2"><font color="#ffffff">Designed and
									Developed by Clicker Software Team, IIT Bombay.</font></td>
							<td style="width: 310px;"><div
									style="float: left;">
									<input id="refresh-div" type="image"
										src="../../img/Refresh.png" alt="Submit"
										onclick="getActiveWorkshopList('<%=pid%>')">
								</div>
								<div style="float: left; ">
									<input id="help-btn" type="image" src="../../img/Queston05.png"
										alt="Submit" onclick="window.location.href='remotehelp.jsp'">
								</div>
								<div style="float: left;">
									<input id="help-btn" type="image" src="../../img/F.png"
										alt="Submit" onclick="window.location.href='participantpasswdupdate.jsp'">
								</div>
								</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<div id="rep_courselist" style="display: none;margin-left: 10px;"></div>
		<div id="activeWorkshopListDiv" style="display: none;">
			<div id="test"></div>
		</div>
	</div>
<%if(session.getAttribute("autoSubmitAlert").toString().equals("true")){
	session.setAttribute("autoSubmitAlert","false");
}
%>
<form id="pollform" action="remotepoll.jsp" method="post">
<input type="hidden" id="pollquestion" name="pollquestion"/>
<input type="hidden" id="polljson" name="polljson"/>
</form> 

</body>
</html>