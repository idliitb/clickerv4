//Author : Kirti, Clicker Team, IDL LAB ,IIT Bombay 

function checkLoginStatus() {
	window.history.forward();
	document.getElementById("error").innerHTML = "";
	var query = window.location.href.split("?")[1];
	var errorStatus = query.split("=")[1];
	if (errorStatus == "error") {
		document.getElementById("error").innerHTML="Please, enter correct username and password.";
		
	}
}
