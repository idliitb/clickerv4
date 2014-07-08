/*
 *   Author      : Gobinath M
 *   Description :  Java script function Used for Dash board 
 * 
 * 
 */

var xmlhttp;
var Student_ID = null;

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

function GetSelectedID(id) {
	// alert(id);
	getXMLhttp();
	// var e;
	// e = document.getElementById("raise_hand_id");
	Student_ID = id;
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("raisehand_dialog").style.visibility = 'visible';
			document.getElementById("raisehand_dialog").title = "RaiseHand";
			document.getElementById("raisehand_dialog").title = "RaiseHand";
			document.getElementById("raisehand_dialog").innerHTML = xmlhttp.responseText;
			$j("#raisehand_dialog").dialog({
				height : 400,
				width : 600,
				draggable : false,
				modal : true
			});
		}
	};

	xmlhttp.open("GET", "raise_hand.jsp?studentID=" + Student_ID, true);
	xmlhttp.send();

}

function quiz_detail(quizid,q_name) {

	/*getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("Quiz_dialog").style.visibility = 'visible';
			document.getElementById("Quiz_dialog").title = "Quiz Details";
			// document.getElementById("Quiz_dialog").title = "RaiseHand";
			document.getElementById("Quiz_dialog").innerHTML = xmlhttp.responseText;
			$j("#Quiz_dialog").dialog({
				height : 300,
				width : 450,
				draggable : false,
				modal : true
			});
		}
	};

	xmlhttp.open("GET", "displayquizdetails.jsp?quizID=" + id, true);
	xmlhttp.send();
*/
	
var Q_Name=quizid+"~"+q_name;
	
	window.location.href="../quiz/quiz.jsp?quizname="+Q_Name;

	
}

function test_sam() {
	//var id="CSE101";
	// alert(id);
	document.getElementById("report_dialog").style.visibility = 'visible';
	document.getElementById("report_dialog").title = "Report";
	$j("#report_dialog").dialog({
		height : 450,
		width : 600,
		draggable : false,
		modal : true
	});
	document.getElementById("report_dialog").innerHTML = "<iframe width=550 height=350 src='studentperformance.jsp'></iframe>";
}



function report_get(id) {

	// alert("======"+id);
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("report_dialog").style.visibility = 'visible';
			document.getElementById("report_dialog").title = "Report";
			// document.getElementById("Quiz_dialog").title = "RaiseHand";
			document.getElementById("report_dialog").innerHTML = xmlhttp.responseText;
			$j("#report_dialog").dialog({
				height : 600,
				width : 550,
				draggable : false,
				modal : true
			});
		}
	};

	xmlhttp.open("GET", "studentperformance.jsp?Course_ID=" + encodeURIComponent(id), true);
	xmlhttp.send();

}




function Get_Attendance() {
	var student_count = document.getElementById('student_count').value;
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("attendance_div").innerHTML = xmlhttp.responseText;

		}
	};
	xmlhttp.open("GET", "attendance.jsp?Count="+student_count, false);
	xmlhttp.send();
}
var refreshId = setInterval(Get_Attendance, 2000);

function show_attendance(courseid) {
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("attendance_dialog").style.visibility = 'visible';
			document.getElementById("attendance_dialog").title = "ATTENDANCE";
			document.getElementById("attendance_dialog").innerHTML = xmlhttp.responseText;
			$j("#attendance_dialog").dialog({
				height : 550,
				width : 750,
				draggable : false,
				modal : true
			});
		}
	};
	xmlhttp.open("GET", "attendanceDetails.jsp?Course_ID=" + encodeURIComponent(courseid), true);
	xmlhttp.send();

}


