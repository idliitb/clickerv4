/*
 * Author : Rajavel, Clicker Lab
 * This Java Script file is used for report information
 */

/*
 * Reference :
 * 		www.w3schools.com
 */

var xmlhttp;

// This method will get the XMLHTTP object for work with ajax
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

function participantInfo(id){
	if (id == "") {		
		return;
	}
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var studinfo = xmlhttp.responseText;
			var stud = studinfo.split("~");
			var studdetails = "<table border='1px' style='margin:auto;border-radius:5px;''> <tr> <td>Participant Name </td><td> " + stud[0];
				studdetails += "</td></tr><tr><td> Mac Address </td><td> " + stud[1] + "</td></tr></table>";
				document.getElementById("studentinfo").innerHTML = studdetails;
		}
	};
	xmlhttp.open("GET", "../../jsp/remotereport/reporthelper.jsp?helpcontent=participantinfo&id=" + id,	true);
	xmlhttp.send();	
}

function fillQuiz(courseID, date, dates) {
	var selecteddate = document.getElementById("quiz_datepicker").value;
	if(selecteddate==""){
		return false;
	}
	var dateArray = selecteddate.split("/");
	selecteddate = dateArray[2] + "-" + dateArray[0] +"-"+ dateArray[1];
	if(dates.indexOf(selecteddate)==-1){
		return false;
	}
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var resps = xmlhttp.responseText;
			document.getElementById("quizname").innerHTML = resps;
		}
	};
	var dateArray = date.split("/");
	date = dateArray[2] + "-" + dateArray[0] +"-"+ dateArray[1];
	xmlhttp.open("GET",	"../../jsp/remotereport/reporthelper.jsp?helpcontent=quizname&courseID="+ encodeURIComponent(courseID) +"&date="+date, true);
	xmlhttp.send();
}

function fillQuizTime(quizid) {
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var response = xmlhttp.responseText;
			document.getElementById("quiztime").innerHTML = response;			
			var quiztimeselect=document.getElementById("quiztimeselect");
			var responselen = quiztimeselect.length;
			var quizradio = document.getElementsByName("quizrpt");
			var reportname = "";
			for ( var i = 0; i < quizradio.length; i++) {
				if (quizradio[i].checked)
					reportname = quizradio[i].value;
			}
			if(reportname=="QuizDetail"){
				if(responselen ==2){
					document.getElementById("quiztime").style.display = "none";
					document.getElementById("hide_qts").value = quiztimeselect.options[1].text;
				}
			}
			else if(responselen ==2){
				document.getElementById("quiztime").style.display = "none";
				document.getElementById("hide_qts").value = quiztimeselect.options[1].text;
			}else if (responselen > 2){
				document.getElementById("quiztime").style.display = "block";
			}			
		}
	};
	var date =  document.getElementById("quiz_datepicker").value;
	var dateArray = date.split("/");
	date = dateArray[2] + "-" + dateArray[0] +"-"+ dateArray[1];
	xmlhttp.open("GET", "../../jsp/remotereport/reporthelper.jsp?helpcontent=quiztime&qid="+ quizid + "&qdate="+date, true);
	xmlhttp.send();	
}

function fillInstantQuizTime() {
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var response = xmlhttp.responseText;
			document.getElementById("quiztime").innerHTML = response;			
			var quiztimeselect=document.getElementById("quiztimeselect");
			var responselen = quiztimeselect.length;
			if(responselen ==2){
				document.getElementById("quiztime").style.display = "none";
				document.getElementById("hide_qid").value = quiztimeselect.options[1].value;
				document.getElementById("hide_qts").value = quiztimeselect.options[1].text;
			}else if (responselen > 2){
				document.getElementById("quiztime").style.display = "block";
			}			
		}
	};
	var date =  document.getElementById("quiz_datepicker").value;
	var dateArray = date.split("/");
	date = dateArray[2] + "-" + dateArray[0] +"-"+ dateArray[1];
	xmlhttp.open("GET", "../../jsp/remotereport/reporthelper.jsp?helpcontent=instantquiztime&qdate="+date, true);
	xmlhttp.send();	
}

function fillPollTime() {
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var response = xmlhttp.responseText;
			document.getElementById("polltime").innerHTML = response;	
			var polltimeselect=document.getElementById("polltimeselect");
			var responselen = polltimeselect.length;
			if(responselen ==2){
				document.getElementById("polltime").style.display = "none";
				document.getElementById("hide_pid").value = polltimeselect.options[1].value;
				document.getElementById("hide_pts").value = polltimeselect.options[1].text;
			}else if (responselen > 2){
				document.getElementById("polltime").style.display = "block";
			}			
		}
	};
	var date =  document.getElementById("poll_datepicker").value;
	var dateArray = date.split("/");
	date = dateArray[2] + "-" + dateArray[0] +"-"+ dateArray[1];
	xmlhttp.open("GET", "../../jsp/remotereport/reporthelper.jsp?helpcontent=polltime&qdate="+date, true);
	xmlhttp.send();	
}

function setQuizTime() {	
	var quiztime_op = document.getElementById("quiztimeselect");
	var quiztime = quiztime_op.options[quiztime_op.selectedIndex].text;
	document.getElementById("hide_qts").value = quiztime;
}

function setInstantQuizTime() {	
	var quiztime_op = document.getElementById("quiztimeselect");
	var quizid = quiztime_op.options[quiztime_op.selectedIndex].value;
	document.getElementById("hide_qid").value = quizid;
	var quiztime = quiztime_op.options[quiztime_op.selectedIndex].text;
	document.getElementById("hide_qts").value = quiztime;
}

function setPollTime() {	
	var quiztime_op = document.getElementById("polltimeselect");
	var quizid = quiztime_op.options[quiztime_op.selectedIndex].value;
	document.getElementById("hide_pid").value = quizid;
	var quiztime = quiztime_op.options[quiztime_op.selectedIndex].text;
	document.getElementById("hide_pts").value = quiztime;
}

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
};

function quizReportType(){
	var quizradio = document.getElementsByName("quizrpt");
	var reportname = "";
	for ( var i = 0; i < quizradio.length; i++) {
		if (quizradio[i].checked)
			reportname = quizradio[i].value;
	}
	var quiztimeselect=document.getElementById("quiztimeselect");
	var responselen = quiztimeselect.length;
	if(reportname=="QuizDetail"){
		document.getElementById("quiztime").style.display = "none";
	}else{
		if(responselen ==2){
			document.getElementById("quiztime").style.display = "none";
		}else if (responselen > 2){
			document.getElementById("quiztime").style.display = "block";
		}
	}
}

function quizReport(dates) {
	var selecteddate = document.getElementById("quiz_datepicker").value;
	if(selecteddate==""){
		alert("Kindly select date !!!");
		return false;
	}
	var dateArray = selecteddate.split("/");
	selecteddate = dateArray[2] + "-" + dateArray[0] +"-"+ dateArray[1];
	if(dates.indexOf(selecteddate)==-1){
		alert("Quiz is not conducted on selected date");
		return false;
	}
	var quiztimeselect=document.getElementById("quiztimeselect");
	var quizname_op = document.getElementById("quiznameselect");
	var quizid = quizname_op.options[quizname_op.selectedIndex].value;
	var qtsselect = quiztimeselect.options[quiztimeselect.selectedIndex].value;
	var timestamp_display = document.getElementById("quiztime").style.display;
	if (quizid.trim() == "Quiz Name"){
		alert("Select Name of the Quiz");
		return false;
	}else if (qtsselect.trim() == "Time Stamp" && timestamp_display=="block"){
		alert("Select Quiz Timestamp");
		return false;
	}
	var quizradio = document.getElementsByName("quizrpt");
	var reportname = "";
	for ( var i = 0; i < quizradio.length; i++) {
		if (quizradio[i].checked)
			reportname = quizradio[i].value;
	}
	if(reportname==""){
		alert("Choose the Report Type");
		return false;
	}
	document.getElementById("quizreport").innerHTML = "<img style='text-align:center;margin-top:200px;' src='../../img/loading.gif'></img><div style='text-align:center;'>Report is generating...</div>";
	if(reportname=="QuizDetail"){
		generateQuizReport(reportname);	
	}else{
		var qts = document.getElementById("hide_qts").value;		
		getXMLhttp();
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				generateQuizReport(reportname);			
			}
		};
		xmlhttp.open("GET", "../../ChartRemote?report=quizreport&qid="+ quizid + "&qts="+qts + "&charttype="+reportname+"Chart", false);
		xmlhttp.send();
	}
}

function generateQuizReport(reportname){
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var response = xmlhttp.responseText;
			document.getElementById("quizreport").innerHTML = response;
		}
	};
	var quizname_op = document.getElementById("quiznameselect");
	var quizid = quizname_op.options[quizname_op.selectedIndex].value;
	var qts = document.getElementById("hide_qts").value;
	xmlhttp.open("GET", "../../RemoteReport?report=quizreport&qid="+ quizid + "&qts="+qts + "&reportname="+reportname, true);
	xmlhttp.send();
}

function instantQuizReport(dates) {
	var selecteddate = document.getElementById("quiz_datepicker").value;
	if(selecteddate==""){
		alert("Kindly select date !!!");
		return false;
	}
	var dateArray = selecteddate.split("/");
	selecteddate = dateArray[2] + "-" + dateArray[0] +"-"+ dateArray[1];
	if(dates.indexOf(selecteddate)==-1){
		alert("Quiz is not conducted on selected date");
		return false;
	}
	var quiztimeselect=document.getElementById("quiztimeselect");
	var qtsselect = quiztimeselect.options[quiztimeselect.selectedIndex].value;
	var timestamp_display = document.getElementById("quiztime").style.display;
	if (qtsselect.trim() == "Time Stamp" && timestamp_display=="block"){
		alert("Select Quiz Timestamp");
		return false;
	}
	var quizradio = document.getElementsByName("instantquizrpt");
	var reportname = "";
	for ( var i = 0; i < quizradio.length; i++) {
		if (quizradio[i].checked)
			reportname = quizradio[i].value;
	}
	if(reportname==""){
		alert("Choose the Report Type");
		return false;
	}
	document.getElementById("quizreport").innerHTML = "<img style='text-align:center;margin-top:200px;' src='../../img/loading.gif'></img><div style='text-align:center;'>Report is generating...</div>";
	var qid = document.getElementById("hide_qid").value;
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			generateInstantQuizReport(reportname);			
		}
	};
	xmlhttp.open("GET", "../../ChartRemote?charttype=InstantQuizResponseChart&qid="+ qid, false);
	xmlhttp.send();	
}

function generateInstantQuizReport(){
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var response = xmlhttp.responseText;
			document.getElementById("quizreport").innerHTML = response;
		}
	};
	var qid = document.getElementById("hide_qid").value;
	var qts = document.getElementById("hide_qts").value;
	xmlhttp.open("GET", "../../RemoteReport?report=instantquizreportnew&qid="+ qid + "&qts="+qts, true);
	xmlhttp.send();
}

function pollReport(dates) {
	var selecteddate = document.getElementById("poll_datepicker").value;
	if(selecteddate==""){
		alert("Kindly select date !!!");
		return false;
	}
	var dateArray = selecteddate.split("/");
	selecteddate = dateArray[2] + "-" + dateArray[0] +"-"+ dateArray[1];
	if(dates.indexOf(selecteddate)==-1){
		alert("Poll is not conducted on selected date");
		return false;
	}
	var polltimeselect=document.getElementById("polltimeselect");
	var polselect = polltimeselect.options[polltimeselect.selectedIndex].value;
	var timestamp_display = document.getElementById("polltime").style.display;
	if (polselect.trim() == "Time Stamp" && timestamp_display=="block"){
		alert("Select Quiz Timestamp");
		return false;
	}
	var pollradio = document.getElementsByName("pollrpt");
	var reportname = "";
	for ( var i = 0; i < pollradio.length; i++) {
		if (pollradio[i].checked)
			reportname = pollradio[i].value;
	}
	if(reportname==""){
		alert("Choose the Report Type");
		return false;
	}
	document.getElementById("pollreport").innerHTML = "<img style='text-align:center;margin-top:200px;' src='../../img/loading.gif'></img><div style='text-align:center;'>Report is generating...</div>";
	var pid = document.getElementById("hide_pid").value;
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			generatePollReport();			
		}
	};
	xmlhttp.open("GET", "../../ChartRemote?charttype=PollResponseChart&pid="+ pid, false);
	xmlhttp.send();	
}

function generatePollReport(){
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var response = xmlhttp.responseText;
			document.getElementById("pollreport").innerHTML = response;
		}
	};
	var pid = document.getElementById("hide_pid").value;
	var pts = document.getElementById("hide_pts").value;
	xmlhttp.open("GET", "../../RemoteReport?report=pollreport&pid="+ pid + "&pts="+pts, true);
	xmlhttp.send();
}

/**
 * This method is used to get current couse name and set value in hidden fields of course report and show or hide attendance time stamp based on selection
 */
function courseDetail() {
	var quizradio = document.getElementsByName("courserpt");
	var reportname = "";
	var i;
	for (i = 0; i < quizradio.length; i++) {
		if (quizradio[i].checked){
			reportname = quizradio[i].value;
			
			break;
		}
	}
	if (reportname == "Attendance")
		{
		document.getElementById("courseAttDate").style.display = "block";
		var attendancetimestamp=document.getElementById("attendancetimestamp");
		if (attendancetimestamp.length>2){
			document.getElementById("att_ts").style.display="block";
		}
		document.getElementById("studentQueryDate").style.display = "none";
		}
	else if (reportname == "StudentQuery")
	{		
		document.getElementById("studentQueryDate").style.display = "block";
		document.getElementById("courseAttDate").style.display = "none";
		document.getElementById("att_ts").style.display="none";
	}
	else{
		document.getElementById("studentQueryDate").style.display = "none";
		document.getElementById("courseAttDate").style.display = "none";
		document.getElementById("att_ts").style.display="none";
	}
	document.getElementById("hide_crptname").value = reportname;
}

function fillAttenDetail(courseID, date) {
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var resps = xmlhttp.responseText;
			document.getElementById("att_ts").innerHTML = resps;
			var attendancetimestamp=document.getElementById("attendancetimestamp");
			var atttimestamplen = attendancetimestamp.length;
			if(atttimestamplen<2){
				document.getElementById("att_ts").style.display="none";				
				return;
			}
			else if (atttimestamplen==2){
				document.getElementById("att_ts").style.display="none";
			}
			else if (atttimestamplen>2){
				document.getElementById("att_ts").style.display="block";
			}
		}
	};
	var dateArray = date.split("/");
	date = dateArray[2] + "-" + dateArray[0] +"-"+ dateArray[1];
	xmlhttp.open("GET",	"../../jsp/remotereport/reporthelper.jsp?helpcontent=atteninfo&cid="+ encodeURIComponent(courseID) + "&date="+date, true);	
	xmlhttp.send();	
}

function coruseRport(cid){
	var courseradio = document.getElementsByName("courserpt");
	var reportname = "";
	for ( var i = 0; i < courseradio.length; i++) {
		if (courseradio[i].checked)
			reportname = courseradio[i].value;
	}
	if(reportname == "Attendance"){		
		var attendancetimestamp=document.getElementById("attendancetimestamp");
		var atttimestamplen = attendancetimestamp.length;
		if(atttimestamplen<2){
			alert("No attendance is available on this day");			
			return;
		}
		var atttime = attendancetimestamp.options[attendancetimestamp.selectedIndex].text;
		if(atttimestamplen==2){
			atttime =  attendancetimestamp.options[1].text;
		}		
		getXMLhttp();
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				generateCourseReport(reportname);
			}
		};
		xmlhttp.open("GET", "../../ChartRemote?charttype=RemoteAttendance&cid=" + encodeURIComponent(cid) + "&ats=" + atttime, false);
		xmlhttp.send();
	}else{
		generateCourseReport(reportname);
	}
}

function generateCourseReport(reportname){
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var response = xmlhttp.responseText;
			document.getElementById("coursereport").innerHTML = response;
		}
	};
	var date = "";
	var atttime = "";
	if(reportname=="Attendance"){
		var attendancetimestamp=document.getElementById("attendancetimestamp");	
		atttime = attendancetimestamp.options[attendancetimestamp.selectedIndex].text;	
		var atttimestamplen = attendancetimestamp.length;
		if(atttimestamplen==2){
			atttime =  attendancetimestamp.options[1].text;
		}
	}
	xmlhttp.open("GET", "../../RemoteReport?report=corusereport&ats="+ atttime + "&reportname="+reportname + "&date=" +date, true);
	xmlhttp.send();
}

function InsideResponseReadForQuizPoll(){
	$(document).ready(function() {
	    setInterval(function() {
	    	 jQuery.get("../../jsp/remotejsp/remoteListener.jsp", function (response) {	    		
	    		 if(response.trim()!=null){
	            	if(response.trim()=="quizlaunch"){
	            		window.location.href="../../jsp/remotejsp/remotequiz.jsp";	            		
	                }else if(response.trim()=="polllaunch"){
	            		window.location.href="../../jsp/remotejsp/remotepoll.jsp";
	            	}else if(response.trim()=="launchinstantquiz"){
	            		window.location.href="../../jsp/remotejsp/instantquiz.jsp";            		
	            	}
	        	}
	    	});
	    }, 500);
	});
}