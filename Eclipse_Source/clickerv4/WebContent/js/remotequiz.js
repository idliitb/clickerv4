/*
 *  author : Dipti.G  from Clicker Team, IDL LAB -IIT Bombay
 */

String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
};

function readMainCenter(){
$(document).ready(function() {
    listener = setInterval(function() {
    	 jQuery.get("../../jsp/remotejsp/remoteListener.jsp", function (response) {
        	if(response.trim()!=null){
        		if(response.trim()=="notreachable"){
            		$('#listenerDiv').html("<h2><br/><br/>Network is unreachable or<br/><br/>Connection refused. <br/>This happen due to-"
                    		+"<br/>1. Web server is down or stop at IIT Bombay <br/>or 2. Internet Connection "
                    		+"problem at (your side) Remote Coordinator Center.<br/>Please re-check and Login again.<br/></h2>");
                	}
        		else if(response.trim()=="noproperserverip"){
            		$('#listenerDiv').html("<h2><br/><br/>Network is unreachable or<br/><br/>Connection refused. <br/>This happen due to-"
                    		+"<br/>1. Web server is down or stop at IIT Bombay <br/>or 2. Internet Connection "
                    		+"problem at (your side) Remote Coordinator Center.<br/>OR<br/>You have specified wrong main center URL while adding maincenter detail.<br/>Please re-check main server URL for participular maincenter using admin module.<br/> and Login again.<br/></h2>");
                	}
        		else if(response.trim()=="noliveworkshop"){
            		$('#listenerDiv').html("<h2><br/><br/>Status of Workshop <br/><br/><br/>Currently this workshop is not running or live at Main Center.</h2>");
                	}
        		else if(response.trim()=="nopollnoquiz"){
            		$('#listenerDiv').html("<h2><br/><br/>Waiting For Main Center's Instructor<br/><br/>Quiz or Poll is not launched from main center</h2>");
                	}
        		else if(response.trim()=="quizlaunch"){
            		window.location.href="../../jsp/remotejsp/remotequiz.jsp";
            		clearInterval(listener);
                	}
        		else if(response.trim()=="polllaunch"){
            		window.location.href="../../jsp/remotejsp/remotepoll.jsp";    
            		clearInterval(listener);
            	}else if(response.trim()=="launchinstantquiz"){
            		window.location.href="../../jsp/remotejsp/instantquiz.jsp";    
            		clearInterval(listener);
            	}           		
        	}
    	});
    }, 1000);
});
}  


function readstatus(state){
	$(document).ready(function() {
	        	
	        		if(state=="nomaincenter"){
	            		$('#listenerDiv').html("<h2><br/><br/>You have to add maincenter detail first.<br/>then only you will receive available workshop list.<br/>So add Maincenter Details using admin module. And then Login again<br/></h2>");
	                	}
	        		else if(state=="notreachable"){
	        			$('#listenerDiv').html("<h2><br/><br/>Network is unreachable or<br/><br/>Connection refused. <br/>This happen due to-"
	                    		+"<br/>1. Web server is down or stop at Main Center <br/> 2. Internet Connection "
	                    		+"problem at (your side) Remote Coordinator Center.<br/>OR<br/>You have specified wrong main center URL while adding maincenter detail.<br/>" +
	                    				"Please re-check main server URL for particular maincenter using admin module.<br/> and Login again.<br/></h2>");
	                	}
	        		else if(state=="noworkshopavailable"){
	            		$('#listenerDiv').html("<h2><br/><br/>Currently, Maincenter you selected, does not have any workshop running <br/> <br/></h2>");
	                	}        		     		
	});
	    
	}  


function InsideResponseReadForQuizPoll(){
	$(document).ready(function() {
	   listener2= setInterval(function() {
		   jQuery.get("../../jsp/remotejsp/remoteListener.jsp", function (response) {
	        	if(response.trim()!=null){
	            	if(response.trim()=="quizlaunch"){
	            		window.location.href="../../jsp/remotejsp/remotequiz.jsp";
	            		clearInterval(listener2);
	                }else if(response.trim()=="polllaunch"){
	            		window.location.href="../../jsp/remotejsp/remotepoll.jsp";
	            		clearInterval(listener2);
	            	}else if(response.trim()=="launchinstantquiz"){
	            		window.location.href="../../jsp/remotejsp/instantquiz.jsp";
	            		clearInterval(listener2);
	            	}
	        	}
	    	});
	    }, 1000);
	});
}  


function startTimer(quiztype) {
	//alert("status: " + document.getElementById("autostatus").value);
	
		$(document).ready(function() {
	 	down=setInterval(function(){countDown(quiztype);},1000);
		});	
}

function startautoTimer(quiztype) {
	//alert("status: " + document.getElementById("autostatus").value);
	if((document.getElementById("autostatus").value) == 1)
	{
		$(document).ready(function() {
	 	down=setInterval(function(){countDown(quiztype);},1000);
		});
	}
	else
	{
		alert("Auto Test is currently disabled from the Main Center.");
		window.location.href = "../home/remotehome.jsp";
	}
}

function countDown(quiztype) {	
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
		if(quiztype=="normalquiz"){
			$("#quizLauncher").css("display","block");
			window.location = "../../jsp/remotejsp/newremoteresponsechart.jsp";			
		}else if(quiztype=="instantquiz"){
			$("#quizLauncher").css("display","block");
			window.location = "../../jsp/remotejsp/newinstantchart.jsp";
		}else if(quiztype=="autotest"){
			window.location = "../../jsp/remotejsp/autotestchart.jsp";
		}
	}
	$('#quizresponsestatus').load("../../jsp/remotejsp/remoteresponsehelper.jsp?helpContent=getquizresponsestatus");
}


function endQuiz(quiztype) {
	var min=document.getElementById("minutes").value.trim();
 	var sec=document.getElementById("seconds").value.trim();
 	var quiztime = (min*60) + sec;
	$('#tempdata').load("../../jsp/remotejsp/remoteresponsehelper.jsp?helpContent=endquiz&quizRtime="+quiztime, function(){
		clearInterval(down);
		document.getElementById("timer").innerHTML = "00 : 00";
		clearInterval(down);
		if(quiztype=="normalquiz"){
			$("#quizLauncher").css("display","block");
			window.location = "../../jsp/remotejsp/newremoteresponsechart.jsp";			
		}else if(quiztype=="instantquiz"){
			$("#quizLauncher").css("display","block");
			window.location = "../../jsp/remotejsp/newinstantchart.jsp";
		}else if(quiztype=="autotest"){
			window.location = "../../jsp/remotejsp/autotestchart.jsp";
		}		
	});
		
}

function onlySendResponse() {
	$('#tempdata').load("../../jsp/remotejsp/remoteresponsehelper.jsp?helpContent=sendnormalquizresponse", function(){
		
	});
		
}

function onlySendInstantResponse() {
	$('#tempdata').load("../../jsp/remotejsp/remoteresponsehelper.jsp?helpContent=sendinstantquizresponse", function(){
		
	});
		
}