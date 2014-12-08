/*
 * Author : Rajavel, Clicker Lab
 * This Java Script file is used for Quiz conduction
 */


// This method is used to show tip window on mouse hover to the quiz box in conduct quiz
function showtip(e,Q_count,N_Ques,Marks)
{

 var x=0;
 var y=0;
 var m;

 if(!e)
    e=window.event;
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
  
  	
/**
 * Hid the tip on mouse out
 */
function hidetip()
{
  var m;
  m=document.getElementById('tooltip');
  m.style.display="none";
}

/*
 * Redirect the page to quiz 
 */
function conduct_quiz(quizid,q_name)
{
	
	var Q_Name=quizid+"~"+q_name;
	
	window.location.href="quiz.jsp?quizname="+Q_Name;

}

/*
 * Trim the string
 */
String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
};

/*
 * Get the lust of quiz for an instructor
 */
function getQuizList(courseID, instructorID){
	$('#quizList').load("../../jsp/quiz/quizhelper.jsp?helpContent=quizList&courseID="+encodeURIComponent(courseID) + "&instructorID="+instructorID);
}

/*
 * Checks whether the quiz available or not  
 */
function isValidCourse(){
	var elt = document.getElementById("quizname");
	if(elt.options[elt.selectedIndex].text == "No Quiz Available"){
		alert("Quiz is not available create quiz");
		return false;
    }else{
    	return true;
    }
}

/*
 * show the quiz preview
 */
function quizPreview(quizID, courseID){
	$('#quizPreview').load("../../jsp/quiz/quizhelper.jsp?helpContent=quizPreview&courseID="+encodeURIComponent(courseID) + "&quizID="+quizID);
	$('#tempdata').load("../../jsp/quiz/quizhelper.jsp?helpContent=getquiztime&quizID="+quizID + "&courseID="+encodeURIComponent(courseID), function (){
		var quizsec = document.getElementById("tempdata").innerHTML.trim();
		document.getElementById('minutes').value = parseInt(quizsec/60);
		document.getElementById('seconds').value = quizsec - (document.getElementById('minutes').value * 60);
	});
}

/*
 * show or not show the options for a question
 */
function showOptions(check){
	if(check.checked)
		$(".optns").css("display","block");
	else
		$(".optns").css("display","none");
}

/*
 * Launch the quiz with timer start and send request to store quiz record details 
 */
function launchQuiz(courseID){
	var min=document.getElementById("minutes").value.trim();
 	var sec=document.getElementById("seconds").value.trim(); 	
 	$('#tempdata').load("../../jsp/quiz/quizhelper.jsp?helpContent=iscourseactive&courseID="+encodeURIComponent(courseID), function(){
 		var isactive = document.getElementById("tempdata").innerHTML.trim(); 
 		if(sec==""){sec="0";document.getElementById("seconds").value=0;}
 		if(isactive=="inactive"){
 			alert("Kindly active the course before launching Quiz");
 		 	return false;
 		}
 		if(min==""){
 			alert("Enter value for minute");
 			return false; 			
 		}else if(parseInt(min)==0 && parseInt(sec)==0){
 			alert("Enter the Quiz Time");
 			return false;
 		}else if(sec>59){
 			alert("Enter value for seconds in the range (0 to 59)");
 			return false;
 		}else if(isNaN(min) || isNaN(sec)){
 	 		alert("Enter Valid Quiz Time");
 	 		return false;
 	 	}else if(min<0 || sec<0){
 	 		alert("Negative Value is not allowed");
 	 		return false;
 	 	}else if(min.indexOf(".")!=-1 || sec.indexOf(".")!=-1){
 	 		alert("Decimal value is not allowed");
 	 		return false;
 	 	}
 		var isnegativemarking = 0;
 	 	if(document.getElementById("negativemarking").checked){
 	 		isnegativemarking = 1;
 	 	}
 	 	document.getElementById("isShowAns").disabled=true; 		
 	 	var isShowAns = document.getElementById("isShowAns").checked;
 		$('#quizrecordid').load("../../jsp/quiz/quizhelper.jsp?helpContent=setQuizLaunchTime&courseID="+encodeURIComponent(courseID) + "&min="+min + "&sec="+sec + "&isnegativemarking="+ isnegativemarking + "&isShowAns="+isShowAns);
 		$("#quizLauncher").css("display","none");
 		$("#endquiz_div").css("display","block");
 		$(".optns").css("display","block");	
 		document.getElementById("showQOptions").checked = true;
 		startTimer(isShowAns);
 	}); 	
}
/*
 * Start quiz timer with 1 sec interval
 */
function startTimer(isShowAns) {  	
 	down=setInterval(function(){countDown(isShowAns);},1000);
}

/*
 * Count down the quiz timer
 */
function countDown(isShowAns) {	
	var min=parseInt(document.getElementById("minutes").value.trim());
 	var sec=parseInt(document.getElementById("seconds").value.trim());
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
		$("#endquiz_div").css("display","none");
	}
	if(sec%5==0){
		$('#quizresponsestatus').load("../../jsp/quiz/quizhelper.jsp?helpContent=getquizresponsestatus");
	}
}

/*
 * End the quiz on clicke of endquiz button and send request to stop quiz in rest service
 */
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
	window.location.href= "../../jsp/quiz/newresponsechart.jsp?isShowAns="+isShowAns;;
}

function displayOptions(optionNmbr){
	var options ="";
	for(var i=0;i<optionNmbr;i++){
		options +="<label style='margin-left: 25px;'><input type='radio' name=optns class='regular-radio big-radio' value='"+String.fromCharCode(65 + i)+"'/><label for='radio-2-1'></label><span style='font-size: 24px'> "+String.fromCharCode(65 + i)+" </span></label>";
	}
	document.getElementById("optionscorrect").innerHTML = options;
}