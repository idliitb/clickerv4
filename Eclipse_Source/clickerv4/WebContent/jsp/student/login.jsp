<!-- Author : Dipti, Clicker Team, IDL LAB ,IIT Bombay
* This page is used for login for both local and remote mode of student.
 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="../../js/div.js" type="text/javascript"></script>
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

.ui-table_green {
	width: 1100px;
	height: 500px;
	background-color: #9bbb59;
	border-radius: 45px;
	float: left;
	margin-left: 110px;
	margin-top: 60px;
}

.ui-loginbutton {
	background: #E46C0A;
	color: balck;
	height: 70px;
	width: 210px;
	border-radius: 10px;
	font-size: 30px;
}

.td-name {
	text-align: center;
	width: 480px;
	height: 180px;
	font-size: 40px;
}

.td-textbox {
	width: 460px;
	height: 55px;
	font-size: 25px;
	float: left;
}
</style>
<title>Login</title>
<script type="text/javascript">
	function loginload() {
		var id = document.getElementById("uid").value;
		var password = document.getElementById("pwd").value;
		if (id == "" || id == " ") {
			alert("Please, enter ID");
			document.getElementById("uid").value = "";
			return false;
		}
		if (password == "" || password == " ") {
			alert("Please, enter password");
			document.getElementById("pwd").value = "";
			return false;
		}
		var xmlhttp1;
		xmlhttp1 = new XMLHttpRequest();
		xmlhttp1.onreadystatechange = function() {
			if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
				if (xmlhttp1.responseText == "WrongUsername") {
					alert("Please, enter correct username.");
					document.getElementById("uid").value = "";
					return false;
				} else if (xmlhttp1.responseText == "WrongPassword") {
					alert("Please, enter correct password.");
					document.getElementById("pwd").value = "";
					return false;
				} else {
					sendCookieResponse();
					var courselist = xmlhttp1.responseText;
					var courselistjson = JSON.parse(courselist);

					if (courselistjson.Mode.replace(/</g, "&lt;") == "local") {
						if(courselistjson.loggedIn){
							if(confirm('You are already Loggedin Or you have not logged out. Do you want to login again ?')){
								}
							else {
								return false;
							}
						}
					
						var truecount = 0;
						for (var i = 0; i < courselistjson.courseIDs.length; i++) {
							if (courselistjson.isActive[i]) {
								truecount++;
								courseName = courselistjson.courseIDs[i];
							}
						}
						if (truecount == 1) {
							
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
							xmlhttp2.send("CourseList=" + xmlhttp1.responseText
									+ "&StudentID=" + id
									+ "&autoSubmitAlert=true");
							return true;

						} else if (truecount < 1 || truecount == 0) {
							
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
							xmlhttp2.send("CourseList=" + xmlhttp1.responseText
									+ "&StudentID=" + id
									+ "&autoSubmitAlert=true");
							return true;

						} else {
							
							var url = "coursesetter.jsp?CourseList="
									+ xmlhttp1.responseText + "&StudentID="
									+ id + "&autoSubmitAlert=true";
							document.getElementById("register").disabled = true;
							document.getElementById("login_table").style.opacity = 3 / 10;
							var divToOpen = "dialog345";
							var popupSetting = {
								width : '300',
								height : '250',
								title : 'Login Dialog',
								isFixed : true
							};
							document.getElementById("test").innerHTML = '<object type="text/html" data='+url+'></object>';
							ShowPopup(divToOpen, popupSetting, "1");
						}

					} else {

						//This is for remote login
						if(courselistjson.loggedIn){
							if(confirm('You are already Loggedin Or you have not logged out. Do you want to login again ?')){
								}
							else {
								return false;
							}
						}
						
						var truecount = 0;
							for (var i = 0; i < courselistjson.courseIDs.length; i++) {
								if (courselistjson.isActive[i]) {
									truecount++;

								}
							}

							if (truecount == 1) {

								var xmlhttp2;
								xmlhttp2 = new XMLHttpRequest();
								xmlhttp2.onreadystatechange = function() {

									if (xmlhttp2.readyState == 4
											&& xmlhttp2.status == 200) {
										window.location.href = "remotehome.jsp";
									}
								};

								xmlhttp2.open("POST", "workshopsetter.jsp",
										false);
								xmlhttp2.setRequestHeader("Content-type",
										"application/x-www-form-urlencoded");
								xmlhttp2.send("WorkshopListForLogin="
										+ xmlhttp1.responseText
										+ "&ParticipantId=" + id
										+ "&autoSubmitAlert=true");
								return true;

							} else if (truecount < 1 || truecount == 0) {
								
								var xmlhttp2;
								xmlhttp2 = new XMLHttpRequest();
								xmlhttp2.onreadystatechange = function() {

									if (xmlhttp2.readyState == 4
											&& xmlhttp2.status == 200) {
										window.location.href = "remotehome.jsp";
									}
								};

								xmlhttp2.open("POST", "workshopsetter.jsp", false);
								xmlhttp2.setRequestHeader("Content-type",
										"application/x-www-form-urlencoded");
								xmlhttp2.send("WorkshopListForLogin="
										+ xmlhttp1.responseText
										+ "&ParticipantId=" + id
										+ "&autoSubmitAlert=true");
								return true;

							}

							else {

								var url = "workshopsetter.jsp?WorkshopListForLogin="
										+ xmlhttp1.responseText
										+ "&ParticipantId="
										+ id
										+ "&autoSubmitAlert=true";
								document.getElementById("register").disabled = true;
								document.getElementById("login_table").style.opacity = 3 / 10;
								var divToOpen = "dialog345";
								var popupSetting = {
									width : '300',
									height : '250',
									title : 'Login Dialog',
									isFixed : true
								};
								document.getElementById("test").innerHTML = '<object type="text/html" data='+url+'></object>';
								ShowPopup(divToOpen, popupSetting, "1");
							}
						

					}

				}
			}
		};
		xmlhttp1.open("GET", "../../rest/quiz/courselist/" + id + "/"
				+ password, false);
		xmlhttp1.send();
	}
	function setCookie(cname, cvalue, exdays) {
		var d = new Date();
		d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
		var expires = "expires=" + d.toUTCString();
		document.cookie = "clickerquiz" + cname + "=" + cvalue + "; " + expires;
	}
	function getCookie(cname) {
		var name = "clickerquiz" + cname + "=";
		var ca = document.cookie.split(';');
		for (var i = 0; i < ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0) == ' ')
				c = c.substring(1);
			if (c.indexOf(name) != -1)
				return c.substring(name.length, c.length);
		}
		return "";
	}
	function removeCookie(cname) {
		document.cookie = "clickerquiz" + cname
				+ "=; expires=Thu, 01 Jan 1970 00:00:00 UTC";
	}
	function sendCookieResponse() {
		var name = "clickerquizqr";
		var ca = document.cookie.split(';');
		for (var i = 0; i < ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0) == ' ')
				c = c.substring(1);
			if (c.indexOf(name) != -1) {
				sendResponse(c.substring(c.indexOf("=") + 1, c.length));
			}
		}
	}
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
	function sendResponse(response) {
		var quizTiming;
		if (response != "") {
			var responseJSON = JSON.parse(response);
			quizTiming = JSON.parse(getCookie("timing"
					+ responseJSON.response.quizrecordId));
			var ct = new Date(quizTiming.currenttime);
			var now = new Date();
			var seconds = (now - ct) / 1000;
			var qtime = parseInt(quizTiming.quizTime);
			if (qtime <= seconds) {
				getXMLhttp();
				xmlhttp.onreadystatechange = function() {
					if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
						var ack = xmlhttp.responseText;
						alert(ack);
						removeCookie("qr" + responseJSON.response.quizrecordId);
						removeCookie("timing"
								+ responseJSON.response.quizrecordId);
						setCookie(responseJSON.response.quiztype
								+ "lastattempted",
								responseJSON.response.quizrecordId, 7);
					}
				};
				xmlhttp.open("POST", "../../rest/quiz/responseweb", false);
				xmlhttp.setRequestHeader("Content-Type",
						"application/json;charset=UTF-8");
				xmlhttp.send(JSON.stringify(responseJSON));
			}
		}
	}
</script>
</head>
<body>


	<div id="main_container">

		<div id="dialog345" style="display: none">
			<!-- <table style="margin-top: 0px;width: 200px;height:30px;">
<tr>
<td style="width: 70%;background-color: black;"></td>
<td style="width: 25%;background-color:red;"></td>
</tr>


</table> -->
			<div id="test"></div>
		</div>
		<table id="login_table" class="ui-table_green">
			<tr>
				<td class="td-name">Enrollment ID</td>

				<td><input type="text" id="uid" name="userid"
					class="td-textbox" placeholder="Enrollment ID" required autofocus />
				</td>
			</tr>
			<tr>
				<td class="td-name">Password</td>

				<td><input type="password" id="pwd" name="password"
					class="td-textbox" placeholder="Password" required autofocus /></td>
			</tr>
			<!-- <tr >
		<td class="td-name">Server URL/IP </td>
		<td><input type="text" id= "serverip" name="servername" onkeyup="ValidateForm()" onchange="" class="td-textbox" placeholder="Server URL/IP" required  />
		<br><span id="validate_ip"></span></td>
		
	</tr> -->

			<tr style="padding-left: 50px;">
				<td colspan="2">
					<button id="register" type="submit" data-toggle="modal"
						data-target="#myModal" class="ui-loginbutton"
						onclick="loginload()">
						<span>Register</span>
					</button>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>