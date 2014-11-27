<%--@author Kirti, Clicker Team, IDL Lab - IIT Bombay
	This jsp file is used for displaying tutorials for students--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tutorial</title>
<style type="text/css">
body{
	position:relative;
	text-align:center;
	width:100%;
	height:100%;
	margin:auto;
	background-color: #404040;
	}
#main_container{
margin:auto;
width:1320px;
height:628px; 
}
</style>
<script type="text/javascript">
var pictures= ["../../img/1registration.jpg","../../img/2Refresh.jpg","../../img/3home.jpg","../../img/4quiz.jpg","../../img/5quiztab.jpg","../../img/6Palette.jpg","../../img/7response.jpg","../../img/8Quizresult.jpg","../../img/9poll.jpg","../../img/10raise.jpg","../../img/11report.jpg"];
var counter = 0;
function displaytuts(){	
	  imageObj = new Image();
	  
	  for(var i=0; i<=10; i++) 
	     {
	          imageObj.src=pictures[i];
	     }
}
function next(){
	document.getElementById("previousbutton").style.visibility = "visible";
//increments the counter and shows the next description
	counter++;
	if (counter >= 10){
		counter = 10;
		document.getElementById("nextbutton").style.visibility = "hidden";
	} 
	document.getElementById('imgDisplay').src = pictures[counter];

} // end upDate
			
function previous(){
	document.getElementById("nextbutton").style.visibility = "visible";
	counter--;
	if (counter <= 0){
		counter = 0;
		document.getElementById("previousbutton").style.visibility = "hidden";
		} // end if
	document.getElementById('imgDisplay').src = pictures[counter];
} 
</script>

</head>
<body onload="displaytuts()">
<div id="main_container">
<table style="height:625px; width:1310px;">
<tr>
	<td><div style="width:100px;"  onclick = "previous()"><img src="../../img/1Arrow_Left.png" id="previousbutton" style="visibility:hidden;" height = 300 width = 100 ></div></td>
	<td><img src = "../../img/1registration.jpg" id = "imgDisplay"  height = 580 width = 1100></td>
	<td><div style="width:100px; margin-top:150px; " onclick = "next()"><img src="../../img/1Arrow_Right.png" id="nextbutton" style="" height = 300 width = 100  ></div>
		<div  style="width:100px; margin-top:40px;"><img src="../../img/Queston05.png"  style="" height = 100 width = 100  onClick = "window.location.href='help.jsp'"></div>
	</td>
</tr>
</table>
</div>
</body>
</html>