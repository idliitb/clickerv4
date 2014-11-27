<!-- Author : Dipti, Clicker Team, IDL LAB ,IIT Bombay
* This page is used for submitting raisehand for student.
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if (session.getAttribute("StudentID") == null) {
	response.sendRedirect("studentexit.jsp");
	return;
}
	String StudentID = session.getAttribute("StudentID").toString();
	String CourseID = session.getAttribute("StudentCourse").toString();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

.ui-loginbutton {
	background: #E46C0A;
	color: balck;
	height: 70px;
	width: 210px;
	border-radius: 10px;
	font-size: 30px;
	margin-top: 5px;
}
</style>

<script type="text/javascript">
	String.prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g, "");
	};

	function sendRaiseHand(StudentID, CourseID) {

		var question = document.getElementById("raisedquestion").value.trim();
		if (question == "" || question == " ") {
			alert("Please, enter your question.");
			document.getElementById("raisedquestion").value = "";
			return false;
		} else {

			var xmlhttp1;
			xmlhttp1 = new XMLHttpRequest();
			xmlhttp1.onreadystatechange = function() {

				if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
					if (xmlhttp1.responseText == "Your doubt is submitted successfully") {
						alert("Your doubt is submitted successfully");
						document.getElementById("raisedquestion").value = "";

					}
				}
			};

			xmlhttp1.open("POST", "../../rest/quiz/raisequestion/", false);
			xmlhttp1.setRequestHeader("Content-type",
					"application/x-www-form-urlencoded");
			xmlhttp1.send("studentid=" + StudentID + "&courseid=" + CourseID
					+ "&questiontext=" + question);
		}

	}

	function checkDoubtAnswer(StudentID, CourseID) {

		var xmlhttp1;
		xmlhttp1 = new XMLHttpRequest();
		xmlhttp1.onreadystatechange = function() {

			if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
				if (xmlhttp1.responseText != null) {
					document.getElementById("repliedDoubt").value = xmlhttp1.responseText;
					document.getElementById("repliedDoubtForm").submit();

				} else {
					alert("No reply for your doubt");

				}
			}
		};
		xmlhttp1.open("GET", "../../rest/quiz/replydoubt" + "/" + StudentID
				+ "/" + CourseID, false);
		xmlhttp1.send();

	}
</script>


<title>Raisehand</title>
</head>
<body>
	<div id="main_container">
		<div style="height: 90px; width: 100px; margin-left: 1170px;">
			<img style="float: right; width: 70px; height: 70px;"
				src="../../img/Home05.png" onclick="window.location.href='home.jsp'">
		</div>


		<textarea id="raisedquestion" name="raisedquestion"
			style="font-size: 30px; width: 1000px; height: 400px; margin-left: 20px; margin-top: 10px; background-color: #9bbb59; text-align: justify;"
			placeholder="Please Raise your Question here." autofocus></textarea>


		<div
			style="height: 60px; width: 1120px; margin-top: 20px; margin-left: 160px;">
			<button id="raise" type="submit" class="ui-loginbutton"
				onclick="sendRaiseHand('<%=StudentID%>','<%=CourseID%>')">
				<span>Raise</span>
			</button>
			
			<form id="repliedDoubtForm" name="repliedDoubtForm" action="reply.jsp" method="post" style="float: right; height: 100px">
				<input type="hidden" name="repliedDoubt" id="repliedDoubt"value="default" /> 
				<img style="float: right;"src="../../img/Check05.png"
					onclick="checkDoubtAnswer('<%=StudentID%>','<%=CourseID%>')">
			</form>
			
		</div>
	</div>

</body>
</html>
