/*
 * Author : Rajavel, Clicker Lab
 * This Java Script file is used for Quiz conduction
 */



function showtip(e,Q_count,N_Ques,Marks)
{

 var x=0;
 var y=0;
 var m;
 var h; 
 if(!e)
   var e=window.event;
   if(e.pageX||e.pageY)
    {
	 x=e.pageX;
	 y=e.pageY;
	 }
 else 
  if(e.clientX||e.clientY)
   {
    x=e.clientX+document.body.scrollLeft+document.documentElement.scrollLeft;
	y=e.clientY+document.body.scrollTop+document.documentElement.scrollTop;
   }
   
   m=document.getElementById('tooltip');
  // alert(y);
  messageHeigth=-10;
   if((y>10)&&(y<510))
    {
	 m.style.top=y-messageHeigth+"px";
	 //alert(m.style.top);
	}
   if(x<850){
     m.style.left=x+10+"px";
	 }
   else{
    m.style.left=x-170+"px";
	}
   var Message=Q_count+"~"+N_Ques+"~"+Marks;
    $('#tooltip').load("../../jsp/quiz/quizhelper.jsp?helpContent=quizdetail&Quiz_msg="+encodeURIComponent(Message));
	m.style.display="block";
	m.style.zIndex=203;
	}
  
  	

function hidetip()
{
  var m;
  m=document.getElementById('tooltip');
  m.style.display="none";
}


function conduct_quiz(quizid,q_name)
{
	
	var Q_Name=quizid+"~"+q_name;
	
	window.location.href="quiz.jsp?quizname="+Q_Name;

}

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
};

function getQuizList(courseID, instructorID){
	$('#quizList').load("../../jsp/quiz/quizhelper.jsp?helpContent=quizList&courseID="+encodeURIComponent(courseID) + "&instructorID="+instructorID);
}

function isValidCourse(){
	var elt = document.getElementById("quizname");
	if(elt.options[elt.selectedIndex].text == "No Quiz Available"){
		alert("Quiz is not available create quiz");
		return false;
    }else{
    	return true;
    }
}

function quizPreview(quizID, courseID){
	$('#quizPreview').load("../../jsp/quiz/quizhelper.jsp?helpContent=quizPreview&courseID="+encodeURIComponent(courseID) + "&quizID="+quizID);
	$('#tempdata').load("../../jsp/quiz/quizhelper.jsp?helpContent=getquiztime&quizID="+quizID + "&courseID="+encodeURIComponent(courseID), function (){
		var quizsec = document.getElementById("tempdata").innerHTML.trim();
		document.getElementById('minutes').value = parseInt(quizsec/60);
		document.getElementById('seconds').value = quizsec - (document.getElementById('minutes').value * 60);
	});
}

function showOptions(check){
	if(check.checked)
		$(".optns").css("display","block");
	else
		$(".optns").css("display","none");
}

function launchQuiz(courseID){
	document.getElementById("isShowAns").disabled=true;
	var min=document.getElementById("minutes").value.trim();
 	var sec=document.getElementById("seconds").value.trim(); 	
 	$('#tempdata').load("../../jsp/quiz/quizhelper.jsp?helpContent=iscourseactive&courseID="+encodeURIComponent(courseID), function(){
 		var isactive = document.getElementById("tempdata").innerHTML.trim(); 
 		if(isactive=="inactive"){
 			alert("Kindly active the course before launching Quiz");
 		 	return false;
 		}
 		if(min==""){min=0;}if(sec==""){sec=0;}
 	 	if(min==0 && sec==0){
 		 	alert("Kindly give quiz time");
 		 	return false;
 		}else if(isNaN(min) || isNaN(sec)){
 	 		alert("Enter Valid Quiz Time");
 	 		return false;
 	 	}else if(min<0 || sec<0){
 	 		alert("Negative Value is not allowed");
 	 		return false;
 	 	}else if(min.indexOf(".")!=-1 || sec.indexOf(".")!=-1){
 	 		alert("Floating is not allowed");
 	 		return false;
 	 	}
 	 	var isnegativemarking = 0;
 	 	if(document.getElementById("negativemarking").checked){
 	 		isnegativemarking = 1;
 	 	}
 	 	var isShowAns = document.getElementById("isShowAns").checked;
 		$('#quizrecordid').load("../../jsp/quiz/quizhelper.jsp?helpContent=setQuizLaunchTime&courseID="+encodeURIComponent(courseID) + "&min="+min + "&sec="+sec + "&isnegativemarking="+ isnegativemarking + "&isShowAns="+isShowAns);
 		$("#quizLauncher").css("display","none");
 		$("#endquiz_div").css("display","block");
 		$(".optns").css("display","block");	
 		document.getElementById("showQOptions").checked = true;
 		startTimer(isShowAns);
 	}); 	
}

function startTimer(isShowAns) {  	
 	down=setInterval(function(){countDown(isShowAns);},1000);
}

function countDown(isShowAns) {	
	var min=document.getElementById("minutes").value.trim();
 	var sec=document.getElementById("seconds").value.trim();
 	if(min==""){min=0;}if(sec==""){sec=0;};
 	var seprater="";
 	if(sec<10){seprater = " : 0";}else{seprater= " : ";}
 	document.getElementById("timer").innerHTML = "" +min + seprater + sec;
	sec--;
	document.getElementById("seconds").value = sec;
	if(sec==-1) { 
	sec=59; min--; 
	document.getElementById("seconds").value = sec;
	document.getElementById("minutes").value = min;
	}
	if(min<0)
	{
		clearInterval(down);
		$("#quizLauncher").css("display","block");
		document.getElementById("launcher").innerHTML = "<button class='ui-conductquiz-button'  id='pre' type='button' onclick='showResponse("+isShowAns+")' style='margin-left:460px;'>" +
			"<span>Show Response</span>	</button>";		
	}
	if(sec%5==0){
		$('#quizresponsestatus').load("../../jsp/quiz/quizhelper.jsp?helpContent=getquizresponsestatus");
	}
}

function endQuiz(quiztype) {
	var min=document.getElementById("minutes").value.trim();
 	var sec=document.getElementById("seconds").value.trim();
 	var quiztime = (min*60) + sec;
	$('#tempdata').load("../../jsp/quiz/quizhelper.jsp?helpContent=endquiz&quizRtime="+quiztime, function(){
		clearInterval(down);
		$("#quizLauncher").css("display","block");
		$("#endquiz_div").css("display","none");
		document.getElementById("timer").innerHTML = "00 : 00";
		var isShowAns = document.getElementById("isShowAns").checked;
		if(quiztype=="normalquiz"){
			document.getElementById("launcher").innerHTML = "<button class='ui-conductquiz-button'  id='pre' type='button' onclick='showResponse("+isShowAns+")' style='margin-left:460px;'>" +
						"<span>Show Response</span>	</button>";
		}else if(quiztype=="instantquiz"){
			document.getElementById("launcher").innerHTML = "<button class='ui-conductquiz-button'  id='pre' type='button' onclick='showInstantQuizResponse()' style='margin-left:460px;'>" +
				"<span>Show Response</span>	</button>";
		}		
	});
		
}

function showResponse(isShowAns){
	window.location = "../../jsp/quiz/newresponsechart.jsp?isShowAns="+isShowAns;
}

function displayOptions(optionNmbr){
	var options ="";
	for(var i=0;i<optionNmbr;i++){
		options +="<label style='margin-left: 25px;'><input type='radio' name=optns class='regular-radio big-radio' value='"+String.fromCharCode(65 + i)+"'/><label for='radio-2-1'></label><span style='font-size: 24px'> "+String.fromCharCode(65 + i)+" </span></label>";
	}
	document.getElementById("optionscorrect").innerHTML = options;
}