/*
 *  Author:Kirti, Dipti , Rajavel
 * This Java Script file is used for POLL validation
 */
String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
};

function Start(pollquestiontext){
	document.getElementById("searchbox").disabled='true';
	document.getElementById("createqbtn1").disabled='true';
	$('#chart_div').load("showpollquestion.jsp?pollquestion="+ encodeURIComponent(pollquestiontext));
}

function Validate(CourseID){
	
	var pollquestiontext=document.getElementById('searchbox').value;	
	if(CourseID!=null){
		$('#tempdatapoll').load("../../jsp/quiz/quizhelper.jsp?helpContent=iscourseactive&courseID="+encodeURIComponent(CourseID), function(){
		var isactive =  document.getElementById("tempdatapoll").innerHTML.trim(); 
		if(isactive=="inactive"){
			alert("Kindly active the course before launching Quiz");
		 	return false;
		}else if(pollquestiontext.length==0){
			alert("Please enter a valid poll question!");
			return false;
		}else{
			Start(pollquestiontext);
		}
	});
	}
}





    
