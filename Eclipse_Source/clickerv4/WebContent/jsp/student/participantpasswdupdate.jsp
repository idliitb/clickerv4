<!-- Author : Dipti, Clicker Team, IDL LAB ,IIT Bombay
* This page is used updating password.
 -->
<!DOCTYPE html>
<html>
<head>
<%
if (session.getAttribute("ParticipantId") == null) {
		response.sendRedirect("participantexit.jsp");
		return;
	}
	String pid = session.getAttribute("ParticipantId").toString();
	
 %>
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
	height: 120px;
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

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g, "");
};

function updatepassword(id) {
	var cpwd = document.getElementById("cpwd").value.trim();
	var newpwd = document.getElementById("newpwd").value.trim();
	var confirmpwd = document.getElementById("confirmpwd").value.trim();
	if (cpwd == "" || cpwd == " ") {
		alert("Please, enter current password");
		document.getElementById("cpwd").value = "";
		return false;
	}
	if (newpwd == "" || newpwd == " ") {
		alert("Please, enter new password");
		document.getElementById("newpwd").value = "";
		return false;
	}
	if (confirmpwd == "" || confirmpwd == " ") {
		alert("Please, enter new password again");
		document.getElementById("confirmpwd").value = "";
		return false;
	}
	if(newpwd!=confirmpwd){
		alert("Password in Confirm password field doesnot not match password in New password field");
		document.getElementById("confirmpwd").value = "";
		return false;
		}
	
	var xmlhttp1;
	xmlhttp1 = new XMLHttpRequest();
	xmlhttp1.onreadystatechange = function() {
		if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
			if(xmlhttp1.responseText == "WrongPassword"||xmlhttp1.responseText==""){
				alert("You have enter wrong current password.");
				document.getElementById("cpwd").value = "";
				return false;
				}
			if(xmlhttp1.responseText == "success"){
				alert("You have successfully updated your password");
				window.location.href = "remotehome.jsp";
				}
		}
	};
	xmlhttp1.open("GET", "../../rest/quiz/updatepwd/" + id + "/"+ cpwd+"/"+newpwd+"/"+confirmpwd, false);
	xmlhttp1.send();
}
</script>
</head>
<body>
<div id="main_container">
		<div id="dialog345" style="display: none">
			
			<div id="test"></div>
		</div>
		<table id="login_table" class="ui-table_green">
			<tr>
				<td class="td-name">Current Password</td>

				<td><input type="password" id="cpwd" name="cpwd"
					class="td-textbox" placeholder="Current Password" required autofocus />
				</td>
			</tr>
			<tr>
				<td class="td-name">New Password</td>

				<td><input type="password" id="newpwd" name="newpwd"
					class="td-textbox" placeholder="New Password" required autofocus /></td>
			</tr>
			<tr>
				<td class="td-name">Confirm Password</td>

				<td><input type="password" id="confirmpwd" name="confirmpwd"
					class="td-textbox" placeholder="Confirm Password" required autofocus /></td>
			</tr>

			<tr style="padding-left: 50px;">
				<td colspan="2">
					<button id="update" type="submit"
						 class="ui-loginbutton"
						onclick="updatepassword('<%=pid%>')">
						<span>Update</span>
					</button>
				</td>
			</tr>
		</table>
		
		<div style="height:70px; width:70px;  float:right ; margin-right:12px;">
		<img style="width:70px; height:70px;" src="../../img/Home05.png" onclick="window.location.href='remotehome.jsp'">
		</div>
	</div>
</body>
</html>