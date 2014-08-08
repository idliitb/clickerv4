/*
 * Author : rajavel, Clicker Team, IDL Lab - IIT Bombay  
 * This Java Script file is used for report information for HOD
 */
function displayQuestion(noofquestions){
	var questionoptions ="";
	for(var i=0;i<noofquestions;i++){
		questionoptions +="<div id='questiondiv"+i+"' style='margin-left:60px;'><table><tr><td>";
		questionoptions += (i+1) +"). Question Type : <select name='qtype"+i+"' id='qtype"+i+"' onclick='displayOptions(this.value,"+i+")'>" +
			"<option value='0' selected>Question Type</option>" +
			"<option value='1'>Single Choice Correct</option>" +
			"<option value='2'>Multiple Choice Correct</option>" + 
			"<option value='3'>Numeric Answer</option>" +
			"<option value='4'>True or False</option></select>" +
			"</td><td><div id='optionsdiv"+i+"' style='display: inline;'>No. of Options : <select name='noofoptions"+i+"' id='noofoptions"+i+"' onclick='displayAns(this.value, "+i+")'>" ;
		questionoptions += "<option value='0'>Noof.Options</option>";
		for (var j=0;j<5;j++){
			questionoptions += "<option value='"+(j+2)+"'>"+(j+2)+"</option>";				
		}
		questionoptions += "</select></div>";				
		questionoptions += "<div id='ansdiv"+i+"' style='display: inline;'> Correct Ans : <select name='ans"+i+"' id='ans"+i+"'>" ;
		questionoptions += "<option value='0'>Answer</option>";
			for (var j=0;j<2;j++){
				questionoptions += "<option value='"+String.fromCharCode(65 + j)+"'>"+String.fromCharCode(65 + j)+"</option>";				
			}
		questionoptions += "</select></div></td></tr></table></div><br/>";
	}
	document.getElementById("questionoptions").innerHTML = questionoptions;
}

function displayOptions(questiontype, questionindex){
	if(questiontype=="3" || questiontype=="4"){
		document.getElementById("optionsdiv"+questionindex).style.display = "none";			
	}else{
		document.getElementById("optionsdiv"+questionindex).style.display = "inline-block";			
	}
	loadoptions(questiontype,questionindex);
}

function loadoptions(questiontype,questionindex){
	if(questiontype=="4"){
		var truefalse = " Correct Ans : <select name='ans"+questionindex+"' id='ans"+questionindex+"'>" ;
		truefalse += "<option value='0'>Answer</option>";
		truefalse += "<option value='1'>True</option>";				
		truefalse += "<option value='2'>False</option></select>";
		document.getElementById("ansdiv"+questionindex).innerHTML = truefalse;
	}else if(questiontype=="3"){
		document.getElementById("ansdiv"+questionindex).innerHTML = " Correct Ans :<input type='text' id='ans"+questionindex + "' name='ans"+questionindex + "'/>";
	}else if(questiontype=="1" || questiontype=="2"){
		displayAns(document.getElementById("noofoptions"+questionindex).value, questionindex);
	}
}

function displayAns(noofoptions, questionindex){
	var questiontype =document.getElementById("qtype"+questionindex).value;
	if(questiontype=="1"){
		var singlecorrect = "Correct Ans : <select name='ans"+questionindex+"' id='ans"+questionindex+"'>" ;
		singlecorrect += "<option value='0'>Answer</option>";
		for (var j=0;j<noofoptions;j++){
			singlecorrect += "<option value='"+String.fromCharCode(65 + j)+"'>"+String.fromCharCode(65 + j)+"</option>";				
		}
		singlecorrect += "</select>";
		document.getElementById("ansdiv"+questionindex).innerHTML = singlecorrect;
	}else if(questiontype=="2"){
		var multicorrect = "Correct Ans :";
		for(var i=0;i<noofoptions;i++){
			multicorrect +="<input type='checkbox' name='optns' value='"+String.fromCharCode(65 + i)+"'/>"+String.fromCharCode(65 + i);
		}
		document.getElementById("ansdiv"+questionindex).innerHTML = multicorrect;
	}
}

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
};

function launchInstantQuiz(courseID, instrID){
	document.getElementById("isShowAns").disabled=true;
	$('#tempdata').load("../../jsp/quiz/quizhelper.jsp?helpContent=iscourseactive&courseID="+encodeURIComponent(courseID), function(){
 		var isactive = document.getElementById("tempdata").innerHTML.trim(); 
 		if(isactive=="inactive"){
 			alert("Kindly active the course before launching Quiz");
 		 	return false;
 		}
 		var noofquestion = document.getElementById("noofQuestion").value;
 		var instantquiz = {};
 		var questions = [];
 		instantquiz.questions = questions;
 		for(var i=0;i<noofquestion;i++){
 			var qtype = document.getElementById("qtype"+i).value;
 			if(qtype==0){
 				alert("Kindly select proper quiz type");
 	 	 		return false;
 			}
 			var noofoptions = "0";
 			var ans = "Z";
 			if(qtype==1 || qtype==2){
 				noofoptions = document.getElementById("noofoptions"+i).value;
 				if(noofoptions==0){
 	 				alert("Kindly select number of options");
 	 	 	 		return false;
 	 			}
 			} 			
 			if(qtype==2){
 				ans="";
 				var checkbox = document.getElementsByName("optns");
 		 	 	var numoptions = checkbox.length;
 		 	 	for(var j = 0;j < numoptions; j++) {
 		 	 		if(checkbox[j].checked)
 		 	 		{
 		 	 			ans += String.fromCharCode(65 + j); 		 	 			
 		 	 		}
 		 	 	}
 		 	 	if(ans==""){
 	 				alert("Kindly select correct ans");
 	 	 	 		return false;
 	 			}
 			}else if(qtype==3){
 				ans = document.getElementById("ans"+i).value;
 				if(ans=="" || isNaN(ans)){
 	 				alert("Kindly enter proper numeric ans");
 	 	 	 		return false;
 	 			}
 			}else if(qtype==1){
 				ans = document.getElementById("ans"+i).value;
 				if(ans=="0"){
 	 				alert("Kindly select correct ans");
 	 	 	 		return false;
 	 			}
 			}else if(qtype==4){
 				ans = document.getElementById("ans"+i).value;
 				if(ans=="0"){
 	 				alert("Kindly select correct ans");
 	 	 	 		return false;
 	 			}else if (ans=="1"){
 	 				ans = "A";
 	 			}else{
 	 				ans = "B";
 	 			} 				
 			}
 			var question = {
 					"qno" : i+1,
 	 				"qtype" : qtype,
 	 				"noofoptions" : noofoptions,
 	 				"ans" : ans
 	 		};
 			instantquiz.questions.push(question); 			
 		}
 		var IQuiz = JSON.stringify(instantquiz);
 		var min=document.getElementById("minutes").value.trim();
 	 	var sec=document.getElementById("seconds").value.trim();
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
 	 	var time = (parseInt(min) * 60)  + parseInt(sec);
 	 	var isShowAns = document.getElementById("isShowAns").checked;
 	 	$('#quizrecordid').load("../../jsp/quiz/quizhelper.jsp?helpContent=setInstantQuizDetailNew&courseID="+encodeURIComponent(courseID) + "&instrID="+encodeURIComponent(instrID) + "&quiztime="+time +"&IQuiz="+IQuiz + "&isShowAns="+isShowAns);
 	 	$("#quizLauncher").css("display","none");
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
		document.getElementById("launcher").innerHTML = "<button class='ui-conductquiz-button'  id='pre' type='button' onclick='showInstantQuizResponse("+isShowAns+")' style='margin-left:460px;'>" +
				"<span>Show Response</span>	</button>";		
	}
	if(sec%5==0){
		$('#quizresponsestatus').load("../../jsp/quiz/quizhelper.jsp?helpContent=getquizresponsestatus");
	}
}


function showInstantQuizResponse(isShowAns){
	window.location = "../../jsp/quiz/newinstantchart.jsp?isShowAns="+isShowAns;
}
