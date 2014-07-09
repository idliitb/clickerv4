/*
 * Author : Rajavel, Clicker Team, IDL Lab - IIT Bombay
 * This Java Script file is used for instant quiz response
 */

var xmlhttp;
// This method will get the XMLHTTP object for work with ajax
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
var reloadinstantchartmqcount=0;
var reloadinstantchartcount=0;
function updateAutoTestChartMQ(instrid, questinids, charttype){
	reloadinstantchart=setInterval(function(){getNewAutoTestChartMQ(instrid, questinids, charttype);},5000);
}

function getNewAutoTestChartMQ(instrid, questinids, charttype){
	reloadinstantchartmqcount++;
	if(reloadinstantchartmqcount>=2){
		clearInterval(reloadinstantchart);
	}
	getXMLhttp();
	var questions = questinids.split("@");
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			//var quiz = xmlhttp.responseText;
			//var quizJson = JSON.parse(quiz);
			var images="";
			for(var i=0;i<(questions.length-1);i++){				
				images += "<img alt='No Response...' src='../../"+instrid+"/Chart"+i+".jpeg?"+new Date().getTime()+"' onclick='showResponsesDialog("+questions[i]+")'> <br/><br/>";
			}
			document.getElementById("quizresponse").innerHTML = images;
		}
	};
	xmlhttp.open("GET", "../../RemoteGenerateResponseChart?quiztype=autotest&charttype="+charttype, false);
	xmlhttp.send();
}

function getAutoTestChartMQ(instrid, questinids, charttype){
	getXMLhttp();
	var questions = questinids.split("@");
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			//var quiz = xmlhttp.responseText;
			//var quizJson = JSON.parse(quiz);
			var images="";
			for(var i=0;i<(questions.length-1);i++){
				images += "<img alt='No Response...' src='../../"+instrid+"/Chart"+i+".jpeg?"+new Date().getTime()+"' onclick='showResponsesDialog("+questions[i]+")'> <br/><br/>";
			}
			document.getElementById("quizresponse").innerHTML = images;	
			updateAutoTestChartMQ(instrid, questinids, charttype);
		}
	};
	xmlhttp.open("GET", "../../RemoteGenerateResponseChart?quiztype=autotest&charttype="+charttype, false);
	xmlhttp.send();
}
var responsecount=0;
var idlesec = 0;

function checkResponse(instrid, questinids){
	resposeidlecheck=setInterval(function(){checkIdle(instrid, questinids);},1000);
}
function checkIdle(instrid, questinids){
	getXMLhttp();
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{		
			var newresponsecount = xmlhttp.responseText;	
			if(newresponsecount>responsecount){
				idlesec=0;
				responsecount = newresponsecount;
			}
			idlesec++;
			if(idlesec>=3){
				clearInterval(resposeidlecheck);
				sendResponse(instrid, questinids);
			}			
		}
	};
	xmlhttp.open("GET", "../../jsp/remotejsp/remoteresponsehelper.jsp?helpContent=autotestresponsecount", true);
	xmlhttp.send();
}

function sendResponse(instrid, questinids){
	getXMLhttp();
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{		
			xmlhttp.responseText;		
			getAutoTestChartMQ(instrid, questinids, 'withoutcorrect');
		}
	};
	xmlhttp.open("GET", "../../jsp/remotejsp/remoteresponsehelper.jsp?helpContent=sendautotestresponse", true);
	xmlhttp.send();
}

function showResponsesDialog(QuestionID) {	
	getXMLhttp();
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			document.getElementById("ResponseDialog").innerHTML = xmlhttp.responseText;
			document.getElementById("ResponseDialog").style.visibility = 'visible';
			document.getElementById("ResponseDialog").title ="Responses";
			$("#ResponseDialog").dialog({height: 400, width: 600, modal: true});
		}
	};	
	xmlhttp.open("GET", "../../jsp/remotejsp/remoteresponsehelper.jsp?helpContent=responseDialogAutoTest&questionid="+QuestionID, true);
	xmlhttp.send();
}

function readMainCenter()
{
	var listenerInterval=1;
	$(document).ready(function() {
		listenerInterval = setInterval(function() {
	    	 jQuery.get("remoteListener.jsp", function (response) {
	        	if(response.trim()!=null){
	        		if(response.trim()=="quizlaunch"){
	        			clearInterval(listenerInterval);
	            		window.location.href="remotequiz.jsp";
	                	}
	        		else if(response.trim()=="launchinstantquiz"){
	        			clearInterval(listenerInterval);
	            		window.location.href="instantquiz.jsp";
	        		}
	        	}
	    	});
	    }, 1000);
	});
}