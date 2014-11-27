<%--@author Kirti, Clicker Team, IDL Lab - IIT Bombay
	This jsp file is used for displaying help menu for participants--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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
 .ui-table_green
{
	width:1150px;
	height:560px;
	background-color: #9bbb59;
	border-radius:45px;
	border: 3px solid #9bbb59;
	background-color:#404040;
	margin-left:80px;
	float:left;
	margin-top:30px;
}
 .ui-loginbutton{
	background:#E46C0A;
	color: balck;
	height:50px;
	width:160px;
	border-radius:10px;
	font-size:25px;
	margin-top:50px;
}
p{ 
	color:#ffffff; 
	text-align:justify; 
	font-size:25px;
}
#content{
	float:left; 
	margin:1em 1em;
	width:910px;
	height:520px; 
	overflow : auto;
	
}
</style>
  
<script type="text/javascript">
  var name=null;
  var intromsg="<p>Clicker software aims at using a paperless technology to initiate the interaction between participants and instructor. This software is developed in open-source within I.I.T Bombay.</p>";
  var quizmsg="<p>This feature enables the participant to attend the quiz launched by the co-ordinator. Participants can toggle between the questions using navigation buttons.</p><br><img src=\"../../img/1help_quiz1.jpg\"  height = 300 width = 700 >";
  var pollmsg="<p>This feature enables the participant to respond to a poll conducted by the co-ordinator.The default time to respond is <b>60 seconds</b>.</p><br><img src=\"../../img/1help_poll.png\"  height = 300 width = 700 >";
  var reportmsg="<p>This feature enables the participants to view their overall performance in the quiz.The report can be downloaded in the pdf format.</p><br><img src=\"../../img/2help_Report.png\"  height = 330 width = 800 >";
    
  function changecontent(name)
  {
	  var help_div_color = document.getElementsByClassName('ui-loginbutton');
	  
	  if(help_div_color.length > 0)
			for(var i = 0; i < (help_div_color.length); i++)
				{
				if(document.getElementById(help_div_color[i].id).style.backgroundColor == 'rgb(228, 108, 10)' || document.getElementById(help_div_color[i].id).style.backgroundColor == '' || document.getElementById(help_div_color[i].id).style.backgroundColor == null)
					document.getElementById(help_div_color[i].id).style.backgroundColor = 'rgb(155, 187, 89)';
				
				}
				
	  
	  document.getElementById(name).style.backgroundColor = 'rgb(228, 108, 10)';
	  if(name=='intro')
		{
		
		document.getElementById('content').innerHTML=intromsg;
		 // sets up the array with some startin values
		  // Andy Harris
		  
		}
	  else if(name=='quiz')
		{
			
		document.getElementById('content').innerHTML=quizmsg;
		
		}
	  else if(name=='poll')
		{
			
		document.getElementById('content').innerHTML=pollmsg;
		
		}
	  else if(name=='report')
		{
		document.getElementById('content').innerHTML=reportmsg;
		
		}
	  else if(name=='raise')
		{
		document.getElementById('content').innerHTML=raisemsg;
		
		}
	  else if(name=='tuts')
		{
		document.getElementById('content').innerHTML=tutsmsg;
		
		}
	  
  }
  

  
  
</script>
<title>Help</title>
</head>
<body onload="changecontent('intro');">
<div id="main_container">
	<div class="ui-table_green">
		<div style="width:200px; height:555px; float:left; border: 3px solid #9bbb59; border-radius:40px;">
			<button id="intro" type="submit" class="ui-loginbutton" style="background-color: #9bbb59;" onclick="changecontent('intro');">
			 	<span >Intro</span>
		 	</button>
			<button id="quiz" type="submit" class="ui-loginbutton" style="background-color: #9bbb59;" onclick="changecontent('quiz');">
			 	<span >Quiz</span>
		 	</button>
			<button id="poll" type="submit" class="ui-loginbutton" style="background-color: #9bbb59;" onclick="changecontent('poll');">
			 	<span >Poll</span>
		 	</button>
			<button id="report" type="submit" class="ui-loginbutton" style="background-color: #9bbb59;" onclick="changecontent('report');">
			 	<span >Report</span>
		 	</button>
			<button id="tuts" type="submit" class="ui-loginbutton" style="background-color: #9bbb59;" onclick="window.location.href='remotetutorial.jsp'">
			 	<span >Tutorial</span>
		 	</button>	
		</div>
		
		<div id="content"></div>
	</div>
	<div style="height:70px; width:70px;  float:right ; margin-right:12px;">
	<img style="width:70px; height:70px;" src="../../img/Home05.png" onclick="window.location.href='remotehome.jsp'">
	</div>
</div>
</body>
</html>