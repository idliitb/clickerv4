<%--@author kirti, Clicker Team, IDL Lab - IIT Bombay
	This jsp file is used for displaying help menu for students--%>
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
	margin-top:36px;
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
  var intromsg="<p>Aakash Clicker V-4 is native participant response system. Instructor and participants will have Aakash tablets through which both can access Aakash Clicker V-4 using web URL. Instructor and participants both will be having different authorities. Advantage of using Aakash tablets in participant response system is that participants will be able to view question and options unlike, only question number and type in Clicker devices.\n As Aakash Clicker V-4 is REST based there no more necessity of using any other hardware for collecting responses entered by participants. Instructor can view reports of participants from any place.</p>";
  var quizmsg="<p>Quiz module on participant device is where the participants answer the quiz conducted by Instructor. On this page the user can press right and left arrow situated to the right and left margins of the tablet screen to shuffle between the questions. The user can also press the question number from the list above the question to directly jump the desired question. In case of more questions in the quiz the buttons below the question can be pressed to jump directly to the desired set of question. No home button is provided on quiz page as the participants are required to answer the quiz and nothing else.</p>";
  var pollmsg="<p>Polls on participant module are the means communication between instructor and participants. The instructor can conduct polls during sessions to get the overview of participants perspective. The user has to just give his/her vote which will be collected anonymously so as to keep polls discrete.</p>";
  var reportmsg="<p>Results on the participant module are for viewing purpose only. The user can go to results page and select the course for which he/she wants to view results. The results can be downloaded in the pdf format.</p>";
  var raisemsg="<p>Raise hand is the feature to ask doubts/questions to the instructor via the tablet. This feature allows the participant to ask doubts without disturbing the session. The answer for the participants doubts will be given by instructor at his/her perusal.</p>";
  var tutsmsg="<p>Tutorial anhi is cursus. Maecenas ligula eros, blandit nec, pharetra at, semper at, magna. Nullam ac lacus. Nulla facilisi. Praesent viverra justo vitae neque. Praesent blandit adipiscing velit. Suspendisse potenti. Donec mattis, pede vel pharetra blandit, magna ligula faucibus eros, id euismod lacus dolor eget odio. Nam scelerisque. Donec non libero sed nulla mattis commodo. Ut sagittis. Donec nisi lectus, feugiat porttitor, tempor ac, tempor vitae, pede. Aenean vehicula velit eu tellus interdum rutrum. Maecenas commodo. Pellentesque nec elit. Fusce in lacus. Vivamus a libero vitae lectus hendrerit hendrerit.</p><p>Pellentesque nec elit. Fusce in lacus. Vivamus a libero vitae lectus hendrerit hendrerit.</p><p>Pellentesque nec elit. Fusce in lacus. Vivamus a libero vitae lectus hendrerit hendrerit.</p>";
	
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
				<button id="raise" type="submit" class="ui-loginbutton" style="background-color: #9bbb59;" onclick="changecontent('raise');">
			 	<span >Raise</span>
		 	</button>
			<button id="tuts" type="submit" class="ui-loginbutton" style="background-color: #9bbb59;" onclick="changecontent('tuts');">
			 	<span >Tutorial</span>
		 	</button>	
		</div>
		
		<div id="content"></div>
	</div>
	<div style="height:70px; width:70px;  float:right ; margin-right:12px;">
	<img style="width:70px; height:70px;" src="../../img/Home05.png" onclick="window.location.href='home.jsp'">
	</div>
</div>
</body>
</html>