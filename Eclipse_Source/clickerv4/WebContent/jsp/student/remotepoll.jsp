<%--@author kirti, Clicker Team, IDL Lab - IIT Bombay
	This jsp file is used for displaying poll for students--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="clicker.v4.poll.*" %>
 <%@page import=" java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Poll</title>
<%
String pid = session.getAttribute("ParticipantId").toString();
//String sid="T65";
//String studcourse  = session.getAttribute("StudentCourse").toString();
String pollquestion=request.getParameter("pollquestion");
String polljson = request.getParameter("polljson");

String[] polldetailsarray=polljson.split("@");
//String pollquestion =polldetailsarray[0];
String launchtime= polldetailsarray[0];
String currenttime= polldetailsarray[1]; 
String workshopid=polldetailsarray[2]; 
String quizTime=polldetailsarray[3]; 
int pollid=Integer.parseInt(polldetailsarray[4]);

long pollt=Long.parseLong(quizTime);
long time=0;
String newpolldetails=null;

SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
Date d1 = null;
Date d2 = null;


	try {
		d1 = format.parse(currenttime);
		d2 = format.parse(launchtime);
	} catch (java.text.ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	
	
	long time_difference = d1.getTime() - d2.getTime();
	System.out.println("Time Difference-------------------"+time_difference);
	long diff_sec =time_difference/1000;
	
	if(diff_sec < 8)
	{
		//time= pollt;
		newpolldetails=pid+"@"+workshopid+"@"+quizTime+"@"+pollid;
	}
	else
	{
		time = pollt-(diff_sec);
		System.out.println("remaining time is -------------------"+time +" seconds");
		String newpolltime=Long.toString(time);
		newpolldetails=pid+"@"+workshopid+"@"+newpolltime+"@"+pollid;
	}
	
	
%>


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
.ui-table_green{
	width:1100px;
	height:520px;
	float:left;
	background-color: #9bbb59;
	border-radius:45px;	
	margin-left: 110px;	
	margin-top:10px;
}
.ui-loginbutton{
	background:#D8D8D8;
	color: balck;
	height:70px;
	width:210px;
	border-radius:10px;
	font-size:30px;	
}
.questiondiv
{ 
	font-size:25px;
	margin-left:75px;
	margin-top:40px;
	width:950px;
	height:170px;
	float: left;
}
</style>
<script type="text/javascript" >
var secs;
var participantid;
var workshopid;
var ans;
var pollid;
var mode="remote";
	function showpollquestion(pollquestion,newpolldetails)	{
				
				var polldetails=newpolldetails.split("@");
				participantid=polldetails[0];
				workshopid=polldetails[1];
				var quizTime=polldetails[2];
				pollid=polldetails[3];
				secs=quizTime;
				
				
				document.getElementById("question").innerHTML = pollquestion;
				down=setInterval(function(){Decrement();},1000);
				
	}
	function Decrement()
	{
		//alert("decrementing");
		var seprater="";
	 	if(secs<10){seprater = " 00 : 0";}else{seprater= " 00 : ";}
	 	
			//seconds = document.getElementById("seconds");		
			//seconds.value = "00:"+getseconds();
			document.getElementById("seconds").innerHTML = ""+seprater + getseconds();
		
		secs=secs-1;
		if(secs<0)
		{
			sendans();
			
		}
	}
	function sendans(){
		clearInterval(down);			
		if (document.getElementById('yes').checked) {
			  ans = document.getElementById('yes').value;
			}
		else if(document.getElementById('no').checked){
			 ans = document.getElementById('no').value;
		}
		else{
			ans=2;
		}
		
		var xmlhttp1;
		xmlhttp1 = new XMLHttpRequest();
		xmlhttp1.onreadystatechange = function() {

			if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
				var ack = xmlhttp1.responseText;
				alert(ack);
				setCookie("remotepolllastattempted",pollid, 7);
					window.location="remotehome.jsp";

			}
		};

		xmlhttp1.open("POST", "../../rest/quiz/poll", false);
		xmlhttp1.setRequestHeader("Content-type",
				"application/x-www-form-urlencoded");
		
		xmlhttp1.send('poll_res={"stuid":'+participantid+',"option":'+ans+'}&courseId='+workshopid+'&mode='+mode);
		
		
	}
	function getseconds() {
		return secs;
		}
	function enable()
	{
		document.getElementById("submit").disabled = false;
		document.getElementById("submit").style.backgroundColor="#E46C0A"; 
	}
	//Source : w3schools, 023-09-2014 http://www.w3schools.com/js/js_cookies.asp 
	function setCookie(cname, cvalue, exdays) {
	    var d = new Date();
	    d.setTime(d.getTime() + (exdays*24*60*60*1000));
	    var expires = "expires="+d.toUTCString();
	    document.cookie = cname + "=" + cvalue + "; " + expires;
	}
</script>
</head>
<body onload="showpollquestion('<%=pollquestion%>','<%=newpolldetails%>')">

<div id="main_container">

	<h1 id="seconds" style=" width:200px; float:left; background-color:#404040; color:#ffffff; font-size:40px;  text-align:center; margin-left:550px;" >00:00</h1>

<div class="ui-table_green">
	<div class="questiondiv" id="question"></div>
	<div style="text-align:center; height:100px; width:870px; margin-top:80px;margin-left:100px; float: left;"> 
		<input type="radio" id="yes" name="choice" value="1" style="width:2em; height:2em; "  onclick="enable()"><label style="color: #FCF9F9; font-size:40px; margin-left:10px;">YES</label>
		<input type="radio" id="no" name="choice" value="0" style="margin-left:100px; width:2em; height:2em; "  onclick="enable()"><label  style="color: #FCF9F9;  font-size:40px; margin-left:10px;">NO</label>
	</div>
	<div  style="margin-top:10px; margin-left: 450px; float: left;">
		<button id="submit" type="submit" class="ui-loginbutton" disabled onclick="sendans()">
		 	<span >Submit</span>
	 	</button>
	</div>		
</div>

</div>
</body>
</html>