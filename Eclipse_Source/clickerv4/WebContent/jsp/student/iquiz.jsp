<%--@author rajavel, Clicker Team, IDL Lab - IIT Bombay
	This jsp file is used for student quiz results--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Instant Quiz</title>
<script src="../../js/div.js" type="text/javascript"></script>
<%
	if (session.getAttribute("StudentID") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	String studentID = session.getAttribute("StudentID").toString();
	String studcourse = session.getAttribute("StudentCourse").toString();
%>
<style type="text/css">
body{
	position:relative;
	text-align:center;	
	margin:auto;
	background-color: #404040;
}
#main_container{
	margin:auto;
	width:1320px;
	height:628px;	
}
#tabs{
	width:1310px;
	height:520px;
	margin-top:5px;
	float:left; 
	margin-left:5px;
}
#tabholder{
	width: 900px; height: 75px;
	margin-left:10px;
	overflow: hidden;
	float: left;
}
.qtab{ 	
 	box-shadow:3px 0px 2px 0px #fff;	 	
 	margin-left: 4px;
  	font-size: 35px;	
	padding-top: 15px;
	width: 85px;
	height: 65px;
	text-align:center;
  	float: left;
  	-webkit-touch-callout: none;
	-webkit-user-select: none;
	-khtml-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
  	cursor: pointer;
}  
.qtabDefault{
	background-color:#ccc;
}
.qtabSelected{
	background-color:#CDDDAC;
}
.qtabAnswered{
	background-color:#9bbb59;
}
.qtabRevise{
	background-color:#E46C0A;
}
#tabholder .qtab:hover{
 	background-color:#CDDDAC;
}
.qtab:active {background-color:#CDDDAC;}
.qtab:focus {background-color:#CDDDAC;}
.qtab:focus:hover {background-color:#CDDDAC;}
.scroll_btn_div{
	width: 80px; 
	height: 75px; 
	float: left;
	margin-left: 10px;
}
.scroll_btn {
	width: 75px; 
	height: 70px; 
	font-size: 40px;
	background:#E46C0A; 
	margin: 2px;
}
.scroll_btn_dis{
	width: 75px; 
	height: 70px; 
	font-size: 40px;
	background:#ccc; 
	margin: 2px;
}
#qcontainer{
	background-color:#fff;
	height: 425px;
	margin-top: -10px;
	overflow: auto;
}
.question_div{
	display: none;
	font-size: 35px;
}
.bigchk{
	font-size:50px;
	width: 30px;
	height: 30px;
}
.ui-loginbutton{
	background:#E46C0A;
	color: balck;
	height:90px;
	width:210px;
	border-radius:10px;
	font-size:35px;	
} 
.gray-btn{
	background:#ccc;	
} 
.green-btn{
	background:#9bbb59;	
}
.orange-btn{
	background:#E46C0A;	
}
.q_div{
	margin-left: 10px;
	margin-top: 10px;
}
.option_div{
	margin-top: 10px;
	margin-left: 30px;
}
.option_div input{
	margin-left: 30px;
}
.disp_none{
	display: none;
}
.disp_block{
	display: block inline;
}
.disp_inline_block{
	display: inline-block;
}
.vsbl_hdn{
	visibility: hidden;
}
.vsbl_vsbl{
	visibility: visible;
}

/* RADIO */
.regular-radio {
	display: none;
}
.regular-radio + label {
	-webkit-appearance: none;
	background-color: #fafafa;
	border: 1px solid #cacece;
	box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px -13px 8px -10px rgba(0,0,0,0.05);
	padding: 9px;
	border-radius: 35px;
	display: inline-block;
	position: relative;
}
.regular-radio:checked + label:after {
	content: ' ';
	width: 10px;
	height: 10px;
	border-radius: 30px;
	position: absolute;
	top: 3px;
	background: #00FF00;
	box-shadow: inset 0px 0px 8px rgba(0,0,0,0.3);
	text-shadow: 0px;
	left: 3px;
	font-size: 32px;
}
.regular-radio:checked + label {
	background-color: #e9ecee;
	color: #99a1a7;
	border: 1px solid #adb8c0;
	box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px -13px 8px -10px rgba(0,0,0,0.05), inset 13px 8px -10px rgba(255,255,255,0.1), inset 0px 0px 8px rgba(0,0,0,0.1);
}
.regular-radio + label:active, .regular-radio:checked + label:active {
	box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.1);
}
.big-radio + label {
	padding: 12px;
}
.big-radio:checked + label:after {
	width: 15px;
	height: 15px;
	left: 5px;
	top: 5px;
}
/* Check box*/
.regular-checkbox {
	display: none;
}
.regular-checkbox + label {
	background-color: #fafafa;
	border: 1px solid #cacece;
	box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px -15px 10px -12px rgba(0,0,0,0.05);
	padding: 9px;
	border-radius: 2px;
	display: inline-block;
	position: relative;
}
.regular-checkbox + label:active, .regular-checkbox:checked + label:active {
	box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.1);
}
.regular-checkbox:checked + label {
	background-color: #e9ecee;
	border: 1px solid #adb8c0;
	box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px -15px 10px -12px rgba(0,0,0,0.05), inset 15px 10px -12px rgba(255,255,255,0.1);
	color: #99a1a7;
}
.regular-checkbox:checked + label:after {
	content: '\2714';
	font-size: 12px;
	position: absolute;
	top: 0px;
	left: 2px;
	color: #00FF00;
}
.big-checkbox + label {
	padding: 13px 13px;
}
.big-checkbox:checked + label:after {
	font-size: 26px;
	left: 2px;
}
.tag {
	font-family: Arial, sans-serif;
	width: 200px;
	position: relative;
	top: 5px;
	font-weight: bold;
	text-transform: uppercase;
	display: block;
	float: left;
}
.radio-1 {
	width: 193px;
}
.button-holder {
	float: left;
}
</style>

<script type="text/javascript">
var perv_qid;
var qids = new Array();
var prevTabColorCN = "qtabDefault";
var qattempted = 0, totquestions=0;
var randomshuffary = new Array();
var responseJSON = {};
var quiz = "";
var reviseQuestions= new Array();
function showQuestion(qid){
	ClosePopupDiv("palette", 2);
	document.getElementById(perv_qid+"q").style.display = "none";
	document.getElementById(qid+"q").style.display = "block";
	var prevqdiv = document.getElementById(perv_qid);	
	prevqdiv.className = prevqdiv.className.replace("qtabSelected", prevTabColorCN.substring(prevTabColorCN.lastIndexOf("qtab")));
	var qdiv = document.getElementById(qid);
	//alert(qids.indexOf(perv_qid) + " " + qids.indexOf(qid));
	var ppos = Math.floor(qids.indexOf(perv_qid) / 10);
	var cpos = Math.floor(qids.indexOf(qid)/10);
	//alert(ppos + " " + cpos);
	var tabholder = document.getElementById('tabholder');
	//alert(cpos*80 + " " + tabholder.scrollTop)
	if(ppos < cpos && cpos*80 > tabholder.scrollTop){
		move_up(cpos-ppos);
	}else if(ppos > cpos && cpos*80 < tabholder.scrollTop){
		move_down(ppos-cpos);
	}else if(cpos*80 > tabholder.scrollTop){
		move_up(1);
	}else if(cpos*80 < tabholder.scrollTop){
		move_down(1);
	}
	prevTabColorCN = qdiv.className;
	qdiv.className = qdiv.className.replace("qtabDefault", "qtabSelected");
	qdiv.className = qdiv.className.replace("qtabAnswered", "qtabSelected");
	document.getElementById("revise"+perv_qid).className =document.getElementById("revise"+perv_qid).className.replace("disp_block", "disp_none");
	document.getElementById("revise"+qid).className =document.getElementById("revise"+qid).className.replace("disp_none", "disp_block");
	document.getElementById("rbc"+perv_qid).style.display="none";
	document.getElementById("rbc"+qid).style.display = "inline-block";
	perv_qid = qid;
	var curindex = qids.indexOf(perv_qid);
	var pbtn = document.getElementById("previous");
	var nbtn = document.getElementById("next");
	if(curindex>=1){
		pbtn.className="vsbl_vsbl";
	}else{
		pbtn.className="vsbl_hdn";
	}
	if(curindex==qids.length-1){
		nbtn.className="vsbl_hdn";
	}else{
		nbtn.className="vsbl_vsbl";
	}
}

function move_up(num) {
	var tabholder = document.getElementById('tabholder');
	tabholder.scrollTop += 80*num;
	if(tabholder.scrollTop>=tabholder.scrollHeight-80)
	{
		document.getElementById('rightbtn').disabled=true;
		document.getElementById('rightbtn').className="scroll_btn_dis";
	}
	if(tabholder.scrollTop>=80)
	{
		document.getElementById('leftbtn').disabled=false;
		document.getElementById('leftbtn').className="scroll_btn";
	}
}

function move_down(num) {
	var tabholder = document.getElementById('tabholder');
	tabholder.scrollTop -= 80*num;
	if(tabholder.scrollTop==0)
	{
		document.getElementById('leftbtn').disabled=true;
		document.getElementById('leftbtn').className="scroll_btn_dis";
	}
	if(tabholder.scrollTop<tabholder.scrollHeight-80)
	{
		document.getElementById('rightbtn').disabled=false;
		document.getElementById('rightbtn').className="scroll_btn";
	}
}

function createDOMInputElement(type, name, id, value){
	var element = document.createElement("INPUT");
	element.setAttribute("type", type);	
	element.setAttribute('name', name);	
	element.setAttribute('id', id);
	element.setAttribute('value',value);	
	return element;
}

function createDOMElementIDClass(ele, id, eclass){
	var element = document.createElement(ele);
	element.setAttribute('id',id);
	element.setAttribute('class',eclass);
	return element;
}

function createDOMElementIDClassStyle(ele, id, eclass, style){
	var element = document.createElement(ele);
	element.setAttribute('id',id);
	element.setAttribute('class',eclass);
	element.setAttribute('style',style);
	return element;
}

function createDOMElementIDClassEvent(ele, id, eclass, event){
	var element = document.createElement(ele);
	element.setAttribute('id',id);
	element.setAttribute('class',eclass);
	element.setAttribute('onclick',event);
	return element;
}

function createDOMElementClass(ele, eclass){
	var element = document.createElement(ele);
	element.setAttribute('class',eclass);
	return element;
}

var xmlhttp;
//This method will get the XMLHTTP object for work with ajax
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

function isQuizLaunched(cid, sid){
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var quiz = JSON.parse(xmlhttp.responseText);
			if(quiz.courseId=="0"){
				alert("Quiz Not Launched");
			}else if(quiz.quizrecordId==getCookie(quiz.quiztype + "lastattempted")){
				alert("Already Attempted this Quiz");
			}else if(quiz.quiztype=="instant"){
				getQuiz(cid, sid);
			}else if(quiz.quiztype=="normal"){
				window.location="quiz.jsp";
			}
		}
	};	
	xmlhttp.open("GET", "../../rest/quiz/"+cid+"/local", false);
	xmlhttp.send();
}

function getQuiz(cid, sid){
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			quiz = JSON.parse(xmlhttp.responseText);
			if(quiz.courseId=="0"){
				alert("Quiz Not Launched");
				window.location="home.jsp";
			}else if(quiz.quizrecordId==getCookie(quiz.quiztype + "lastattempted")){
				alert("Already Attempted this Quiz");
				window.location="home.jsp";
			}else if(quiz.quiztype=="normal"){
				window.location="quiz.jsp";
			}
			responseJSON.courseid=cid;
			responseJSON.mode="local";
			var response = {};
			response.quizID = quiz.quizId;
			response.quizrecordId = quiz.quizrecordId;
			response.quiztype = quiz.quiztype;
			response.studId =sid;
			var options=[];			
			response.options = options;
			responseJSON.response=response;			
			showIQuiz(quiz);
		}
	};	
	xmlhttp.open("GET", "../../rest/quiz/"+cid+"/local", false);
	xmlhttp.send();
}
function sendCookieResponse() {
	var name = "clickerquizqr";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
    	var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) != -1) {
        	sendPreviousResponse(c.substring(c.indexOf("=")+1,c.length));
        }
    }
}	
function sendPreviousResponse(response){
	var quizTiming;
	if(response!=""){
		var responseJSON = JSON.parse(response);			
		quizTiming = JSON.parse(getCookie("timing"+responseJSON.response.quizrecordId));
		var ct = new Date(quizTiming.currenttime);
		var now = new Date();
		var seconds =  (now-ct)/1000;
		var qtime = parseInt(quizTiming.quizTime);
		if(qtime<=seconds){
			getXMLhttp();
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					removeCookie("qr" + responseJSON.response.quizrecordId);
					removeCookie("timing" +responseJSON.response.quizrecordId);
					setCookie(responseJSON.response.quiztype + "lastattempted", responseJSON.response.quizrecordId, 7);
				}
			};	
			xmlhttp.open("POST", "../../rest/quiz/responseweb", false);
			xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
			xmlhttp.send(JSON.stringify(responseJSON));
		}
	}		
}

function showIQuiz(quiz){	
	sendCookieResponse();
	var ct = new Date(quiz.currenttime);
	var lt = new Date(quiz.launchtime);
	var seconds =  (ct- lt)/1000;
	var qtime = parseInt(quiz.quizTime);
	var quiztiming = {};
	quiztiming.currenttime = new Date();
	quiztiming.quizTime = qtime - seconds;
	setCookie("timing"+quiz.quizrecordId, JSON.stringify(quiztiming), 7);
	if(qtime>seconds){
		startTimer(qtime-seconds);
	}else{
		alert("Quiz Over");
		window.location="home.jsp";
		return;
	}			
	if(quiz.questions.length<=10){
		document.getElementById('rightbtn').disabled=true;
		document.getElementById('rightbtn').className="scroll_btn_dis";
	}			
	totquestions=quiz.questions.length;
	if(totquestions==1){
		var nbtn = document.getElementById("next");
		nbtn.className="vsbl_hdn";
	}
	document.getElementById("attempted").innerHTML = "Attempted 0/"+totquestions;
	var qtabColor = "";	var checkboxdisplay="";
	if(getCookie("qr" +responseJSON.response.quizrecordId)!=""){
		responseJSON = JSON.parse(getCookie("qr" +responseJSON.response.quizrecordId));
		reviseQuestions = JSON.parse(getCookie("revise" +responseJSON.response.quizrecordId));
		for(var i=0;i<totquestions;i++){
			var question =quiz.questions[i];
			//responseJSON.response.options[i]= "Z";
			qids.push("q" + question.id);
			var qtabdiv, qc;
			var reviseCBdisplay = "none";			
			if(i!=0){
				qtabColor = "qtabDefault";		
				checkboxdisplay = "disp_none";
				qc = createDOMElementIDClass("div", 'q'+question.id+"q", 'question_div');					
			}else{
				qtabColor = "qtabSelected";		
				checkboxdisplay = "disp_block";
				reviseCBdisplay = "inline-block";
				perv_qid ='q'+question.id;
				qc = createDOMElementIDClassStyle("div", 'q'+question.id+"q", 'question_div', 'display:block');
			}			
			if(responseJSON.response.options[i] != "Z" && responseJSON.response.options[i] != ""){
				qtabColor = "qtabAnswered";
				qattempted++;
				document.getElementById("attempted").innerHTML = "Attempted "+ qattempted + "/"+totquestions;
			}
			qtabdiv = createDOMElementIDClassEvent("div", 'q'+question.id, 'qtab '+qtabColor, "showQuestion('q"+question.id+"')");
			qtabdiv.innerHTML= "Q" + (i+1);
			var questiondiv =  createDOMElementClass("div", 'q_div');
			questiondiv.innerHTML = "Q"+(i+1)+ ". "+ question.text;
			var labelContainer = document.createElement('label');			
			var reviseCheckbox = createDOMInputElement("checkbox","reviseq"+question.id , "reviseq"+question.id, "revise");
			reviseCheckbox.setAttribute("class", 'regular-checkbox big-checkbox ' + checkboxdisplay);
			reviseCheckbox.setAttribute("onchange", "reviseQuestion()");
			var brlabel = document.createElement('label');
			brlabel.setAttribute("id", "rbcq"+question.id);
			brlabel.setAttribute("style", "display:"+reviseCBdisplay);
			brlabel.htmlFor = "reviseq"+question.id;			
			if(reviseQuestions[i]==1){
				qtabdiv.setAttribute("class", 'qtab qtabRevise');
				reviseCheckbox.setAttribute("checked", "checked");
			}
			labelContainer.appendChild(reviseCheckbox);
			labelContainer.appendChild(brlabel);			
			document.getElementById("revise_div").appendChild(labelContainer);
			var optionsdiv =  createDOMElementClass("div", 'option_div');	
			if(question.type==1 || question.type==4){
				for(var j=0;j<question.options.length;j++){
					var questionoption = question.options[j];
					var labelContainer = document.createElement('label');
					var option = createDOMInputElement("radio",'q'+question.id+"q_radio", "q"+question.id+"o"+questionoption.optionid, questionoption.optiontext);
					option.setAttribute('onchange',"ansSelected('q"+question.id+"q_radio', '"+"q"+question.id+"', "+i+")");
					option.setAttribute("class", 'regular-radio big-radio');
					var brlabel = document.createElement('label');
					brlabel.htmlFor = "q"+question.id+"o"+questionoption.optionid;			
					brlabel.setAttribute("style", 'margin-top:0px');
					var oblabel = document.createElement('label');
					oblabel.htmlFor = "q"+question.id+"o"+questionoption.optionid;
					oblabel.appendChild(document.createTextNode("  " + questionoption.optiontext));
					var optionIndex = document.createElement('label');
					optionIndex.htmlFor = "q"+question.id+"o"+questionoption.optionid;
					if(responseJSON.response.options[i] == String.fromCharCode(65+j)){
						option.setAttribute('checked', "checked");						
					}
					optionIndex.appendChild(document.createTextNode( String.fromCharCode(65+j)+ " "));
					labelContainer.appendChild(optionIndex);
					labelContainer.appendChild(option);
					labelContainer.appendChild(brlabel);
					labelContainer.appendChild(oblabel);
					optionsdiv.appendChild(labelContainer);
					optionsdiv.appendChild(document.createElement("br"));
				}
				qc.appendChild(questiondiv);
				qc.appendChild(optionsdiv);
				document.getElementById("qcontainer").appendChild(qc);
			}else if(question.type==2){
				for(var j=0;j<question.options.length;j++){
					var labelContainer = document.createElement('label');								
					var questionoption = question.options[j];
					var option = createDOMInputElement("checkbox",'q'+question.id+"q_radio", "q"+question.id+"o"+questionoption.optionid, questionoption.optiontext);
					option.setAttribute('onchange',"ansSelected('q"+question.id+"q_radio', '"+"q"+question.id+"', "+i+")");
					option.setAttribute("class", 'regular-checkbox big-checkbox');
					var brlabel = document.createElement('label');
					brlabel.htmlFor = "q"+question.id+"o"+questionoption.optionid;			
					var oblabel = document.createElement('label');
					oblabel.htmlFor = "q"+question.id+"o"+questionoption.optionid;
					oblabel.appendChild(document.createTextNode(" " +questionoption.optiontext));
					var optionIndex = document.createElement('label');
					optionIndex.htmlFor = "q"+question.id+"o"+questionoption.optionid;
					if(responseJSON.response.options[i].indexOf(String.fromCharCode(65+j)) != -1){
						option.setAttribute('checked', "checked");						
					}
					optionIndex.appendChild(document.createTextNode( String.fromCharCode(65+j)+ " "));
					labelContainer.appendChild(optionIndex);
					labelContainer.appendChild(option);
					labelContainer.appendChild(brlabel);
					labelContainer.appendChild(oblabel);
					optionsdiv.appendChild(labelContainer);
					optionsdiv.appendChild(document.createElement("br"));
				}
				qc.appendChild(questiondiv);
				qc.appendChild(optionsdiv);
				document.getElementById("qcontainer").appendChild(qc);
			}else if(question.type==3){
				for(var j=0;j<question.options.length;j++){
					var questionoption = question.options[j];
					var option = createDOMInputElement("text",'q'+question.id+"q_txt", "q"+question.id+"o"+questionoption.optionid, "");
					option.setAttribute("onkeypress","return IsNumeric(event, 'q"+question.id+"o"+questionoption.optionid+"', '"+"q"+question.id+"')");
					option.setAttribute("onkeyup","ansEntered('q"+question.id+"o"+questionoption.optionid+"', '"+"q"+question.id+"', "+i+")");
					option.setAttribute("style", "width:320px;height:40px;font-size:30px;");
					var Ans = document.createElement('label');
					if(responseJSON.response.options[i] != 'Z'){
						option.setAttribute('value', responseJSON.response.options[i]);						
					}
					Ans.htmlFor = "q"+question.id+"o"+questionoption.optionid;
					Ans.appendChild(document.createTextNode("Enter Answer : "));
					optionsdiv.appendChild(Ans);
					optionsdiv.appendChild(option);
				}
				qc.appendChild(questiondiv);
				qc.appendChild(optionsdiv);
				document.getElementById("qcontainer").appendChild(qc);
			}
			document.getElementById("tabholder").appendChild(qtabdiv);
		}
		var chlabel = document.createElement('label');
		chlabel.appendChild(document.createTextNode("Revise Later"));
		document.getElementById("revise_div").appendChild(chlabel);		
		setCookie("revise"+responseJSON.response.quizrecordId, JSON.stringify(reviseQuestions), 7);
	}else{
		for(var i=0;i<totquestions;i++){
			var question =quiz.questions[i];
			responseJSON.response.options[i]= "Z";
			qids.push("q" + question.id);
			reviseQuestions.push(0);			
			var qtabdiv, qc;
			var reviseCBdisplay = "none";
			if(i!=0){
				qtabColor = "qtabDefault";
				checkboxdisplay = "disp_none";
				qc = createDOMElementIDClass("div", 'q'+question.id+"q", 'question_div');									
			}else{
				qtabColor = "qtabSelected";			
				checkboxdisplay = "disp_block";
				reviseCBdisplay = "inline-block";
				perv_qid ='q'+question.id;
				qc = createDOMElementIDClassStyle("div", 'q'+question.id+"q", 'question_div', 'display:block');
			}
			qtabdiv = createDOMElementIDClassEvent("div", 'q'+question.id, 'qtab '+qtabColor, "showQuestion('q"+question.id+"')");
			qtabdiv.innerHTML= "Q" + (i+1);
			var questiondiv =  createDOMElementClass("div", 'q_div');
			questiondiv.innerHTML = "Q"+(i+1)+ ". "+ question.text;
			var labelContainer = document.createElement('label');			
			var reviseCheckbox = createDOMInputElement("checkbox","reviseq"+question.id , "reviseq"+question.id, "revise");
			reviseCheckbox.setAttribute("class", 'regular-checkbox big-checkbox ' + checkboxdisplay);
			reviseCheckbox.setAttribute("onchange", "reviseQuestion()");			
			var brlabel = document.createElement('label');
			brlabel.setAttribute("id", "rbcq"+question.id);
			brlabel.setAttribute("style", "display:"+reviseCBdisplay);
			brlabel.htmlFor = "reviseq"+question.id;			
			labelContainer.appendChild(reviseCheckbox);
			labelContainer.appendChild(brlabel);			
			document.getElementById("revise_div").appendChild(labelContainer);			
			var optionsdiv =  createDOMElementClass("div", 'option_div');				
			if(question.type==1 || question.type==4){
				for(var j=0;j<question.options.length;j++){
					var questionoption = question.options[j];
					var labelContainer = document.createElement('label');
					var option = createDOMInputElement("radio",'q'+question.id+"q_radio", "q"+question.id+"o"+questionoption.optionid, questionoption.optiontext);
					option.setAttribute('onchange',"ansSelected('q"+question.id+"q_radio', '"+"q"+question.id+"', "+i+")");
					option.setAttribute("class", 'regular-radio big-radio');
					var brlabel = document.createElement('label');
					brlabel.htmlFor = "q"+question.id+"o"+questionoption.optionid;			
					var oblabel = document.createElement('label');
					oblabel.htmlFor = "q"+question.id+"o"+questionoption.optionid;
					oblabel.appendChild(document.createTextNode(" " +questionoption.optiontext));
					var optionIndex = document.createElement('label');
					optionIndex.htmlFor = "q"+question.id+"o"+questionoption.optionid;
					if(responseJSON.response.options[i] == String.fromCharCode(65+j)){
						option.setAttribute('checked', "checked");						
					}
					optionIndex.appendChild(document.createTextNode( String.fromCharCode(65+j)+" "));
					labelContainer.appendChild(optionIndex);
					labelContainer.appendChild(option);
					labelContainer.appendChild(brlabel);
					labelContainer.appendChild(oblabel);
					optionsdiv.appendChild(labelContainer);
					optionsdiv.appendChild(document.createElement("br"));			
				}
				qc.appendChild(questiondiv);
				qc.appendChild(optionsdiv);
				document.getElementById("qcontainer").appendChild(qc);
			}else if(question.type==2){
				for(var j=0;j<question.options.length;j++){
					var questionoption = question.options[j];
					var labelContainer = document.createElement('label');					
					var option = createDOMInputElement("checkbox",'q'+question.id+"q_radio", "q"+question.id+"o"+questionoption.optionid, questionoption.optiontext);
					option.setAttribute('onchange',"ansSelected('q"+question.id+"q_radio', '"+"q"+question.id+"', "+i+")");
					option.setAttribute("class", 'regular-checkbox big-checkbox');
					var brlabel = document.createElement('label');
					brlabel.htmlFor =  "q"+question.id+"o"+questionoption.optionid;			
					var oblabel = document.createElement('label');
					oblabel.htmlFor = "q"+question.id+"o"+questionoption.optionid;
					oblabel.appendChild(document.createTextNode(" " + questionoption.optiontext));
					var optionIndex = document.createElement('label');
					optionIndex.htmlFor = "q"+question.id+"o"+questionoption.optionid;
					optionIndex.appendChild(document.createTextNode( String.fromCharCode(65+j) + " " ));
					labelContainer.appendChild(optionIndex);
					labelContainer.appendChild(option);
					labelContainer.appendChild(brlabel);
					labelContainer.appendChild(oblabel);
					optionsdiv.appendChild(labelContainer);
					optionsdiv.appendChild(document.createElement("br"));
				}
				qc.appendChild(questiondiv);
				qc.appendChild(optionsdiv);
				document.getElementById("qcontainer").appendChild(qc);
			}else if(question.type==3){
				for(var j=0;j<question.options.length;j++){
					var questionoption = question.options[j];
					var option = createDOMInputElement("text",'q'+question.id+"q_txt", "q"+question.id+"o"+questionoption.optionid, "");
					option.setAttribute("onkeypress","return IsNumeric(event, 'q"+question.id+"o"+questionoption.optionid+"', '"+"q"+question.id+"')");
					option.setAttribute("onkeyup","ansEntered('q"+question.id+"o"+questionoption.optionid+"', '"+"q"+question.id+"', "+i+")");
					option.setAttribute("style", "width:320px;height:40px;font-size:30px;");
					var Ans = document.createElement('label');
					Ans.htmlFor = "q"+question.id+"o"+questionoption.optionid;
					Ans.appendChild(document.createTextNode("Enter Answer : "));
					optionsdiv.appendChild(Ans);
					optionsdiv.appendChild(option);
				}
				qc.appendChild(questiondiv);
				qc.appendChild(optionsdiv);
				document.getElementById("qcontainer").appendChild(qc);
			}
			document.getElementById("tabholder").appendChild(qtabdiv);
		}
		var chlabel = document.createElement('label');
		chlabel.appendChild(document.createTextNode("Revise Later"));
		document.getElementById("revise_div").appendChild(chlabel);
		setCookie("revise"+responseJSON.response.quizrecordId, JSON.stringify(reviseQuestions), 7);
	}
}

function ansSelected(groupName, id, respindex){
	var qdiv = document.getElementById(id);
	var radios = document.getElementsByName( groupName );
	var flag=false;
	var resp="";
	for(var i = 0; i < radios.length; i++ ) {
		if( radios[i].checked ) {
			flag = true;
		  	resp += String.fromCharCode(65+i);
	   	}
	}
	if(flag){
		if(responseJSON.response.options[respindex] == "Z" && resp!="Z")
			qattempted++;
		prevTabColorCN = "qtabAnswered";
		responseJSON.response.options[respindex] = resp;
	}else{
		qdiv.className = qdiv.className.replace("qtabAnswered", "qtabSelected");
		prevTabColorCN = "qtabDefault";
		qattempted--;
		responseJSON.response.options[respindex] = "Z";
	}	
	setCookie("qr" +responseJSON.response.quizrecordId, JSON.stringify(responseJSON), 7);
	document.getElementById("attempted").innerHTML = "Attempted "+ qattempted + "/"+totquestions;
}
function isAnsChecked( groupName ) {
    var radios = document.getElementsByName( groupName );
    for(var i = 0; i < radios.length; i++ ) {
        if( radios[i].checked ) {
            return true;
        }
    }
    return false;
}
function IsNumeric(evt) {
	var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode!=46)
    	return false;
    return true;
}
function ansEntered(id, tid, respindex){
	var txtbox = document.getElementById(id);
	var qdiv = document.getElementById(tid);
	var txtlen = txtbox.value.length;	
	if(responseJSON.response.options[respindex] == "Z" && txtlen==1){
		qattempted++;
		prevTabColorCN = "qtabAnswered";
	}	
	if(txtlen>0){
		responseJSON.response.options[respindex] = txtbox.value;
	}else{
		qdiv.className = qdiv.className.replace("qtabAnswered", "qtabSelected");
		if(responseJSON.response.options[respindex] != "Z" && txtlen==0)
			qattempted--;
		prevTabColorCN = "qtabDefault";		
		responseJSON.response.options[respindex] = 'Z';		
	}
	/*if(((qdiv.className.indexOf("qtabSelected")!=-1)) && prevTabColorCN.indexOf("qtabAnswered") == -1 && (txtlen==1) || (qdiv.className.indexOf("qtabRevise") != -1 && prevTabColorCN.indexOf("qtabSelected") != -1  && txtlen==1)){
		qattempted++;
		prevTabColorCN = "qtabAnswered";
	}*/	
	document.getElementById("attempted").innerHTML = "Attempted "+ qattempted + "/"+totquestions;
	setCookie("qr" +responseJSON.response.quizrecordId, JSON.stringify(responseJSON), 7);
}
function prev_question(){
	var curindex = qids.indexOf(perv_qid);
	showQuestion(qids[curindex-1]);
}
function next_question(){
	var curindex = qids.indexOf(perv_qid);
	showQuestion(qids[curindex+1]);
}
function deselect(){
	var radios = document.getElementsByName( perv_qid+"q_radio" );
	var flag=false; 
    for(var i = 0; i < radios.length; i++ ) {
        if( radios[i].checked ) {
        	radios[i].checked = false;
        	flag=true;
        }
    }
    if(radios.length>0){
    	var qdiv = document.getElementById(perv_qid);
    	qdiv.className = qdiv.className.replace("qtabAnswered", "qtabSelected");
    	prevTabColorCN = "qtabDefault";
    	if(flag){
    		qattempted--;
    		document.getElementById("attempted").innerHTML = "Attempted "+ qattempted + "/"+totquestions;
    		var curindex = qids.indexOf(perv_qid);
    		responseJSON.response.options[curindex]="Z";
    		setCookie("qr" + responseJSON.response.quizrecordId, JSON.stringify(responseJSON), 7);
    	}
    }
}

function startTimer(seconds) {
 	down=setInterval(function(){countDown(seconds--);},1000);
}

function countDown(seconds) {
	var min=0;sec=0;
	if(seconds<=0){
		document.getElementById("submit").disabled = true;
		clearInterval(down);
		sendResponse("timeout");
		document.respSub.submit();	
	}else{
		min = Math.floor(seconds/60);
		sec = seconds%60;		
	}
	if(sec<10){
		document.getElementById("timer").innerHTML = min +":0" + sec;
	}else{
		document.getElementById("timer").innerHTML = min +":" + sec;
	}
}

function submitResponse(){
	var res = confirm("Do you want to conform your response submition ?");
	if(res){
		document.getElementById("submit").disabled = true;
		clearInterval(down);
		document.getElementById("timer").innerHTML = "00:00";
		sendResponse("submit");
	}
}

function sendResponse(submitType){
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var ack = xmlhttp.responseText;
			alert(ack);
			removeCookie("qr" +responseJSON.response.quizrecordId);
			removeCookie("timing" +responseJSON.response.quizrecordId);
			removeCookie("revise"+responseJSON.response.quizrecordId);
			setCookie(responseJSON.response.quiztype + "lastattempted", responseJSON.response.quizrecordId, 7);
			if(submitType=="timeout" && quiz.isShowAns){
				showQuizStastics();
				document.getElementById("hdn_responseJSON").value = JSON.stringify(responseJSON);
				document.getElementById("hdn_quiz").value = JSON.stringify(CAQuiz);				
			}
			else{
				window.location="home.jsp";
			}
		}
	};	
	xmlhttp.open("POST", "../../rest/quiz/responseweb", false);
	xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	xmlhttp.send(JSON.stringify(responseJSON));
}
var CAQuiz;
function showQuizStastics(){
	getXMLhttp();
	var noofcorrect=0;
	var noofincorrect=0;
	var noofZ=0;
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			CAQuiz = JSON.parse(xmlhttp.responseText);
			totquestions=CAQuiz.questions.length;
			for(var i=0;i<totquestions;i++){
				var question =CAQuiz.questions[i];
				if(responseJSON.response.options[i]== "Z" || responseJSON.response.options[i] == ""){
					noofZ++;
				}else if(question.correctAns==responseJSON.response.options[i]){
					noofcorrect++;
				}else{
					noofincorrect++;
				}
			}
			alert("Total Questions : " + totquestions + "\nNo.of Question Attempted : " + (noofcorrect + noofincorrect) + "\nNo of Correct ans : " + noofcorrect + "\nNo of InCorrect Ans : "+ noofincorrect + "\nNo of Non-Response : "+noofZ);
		}
	};	
	xmlhttp.open("POST", "studenthelper.jsp", false);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("helperText=quizCA");
}

// Source : w3schools, 023-09-2014 http://www.w3schools.com/js/js_cookies.asp
function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = "clickerquiz" + cname + "=" + cvalue + "; " + expires;
}
function getCookie(cname) {
    var name = "clickerquiz" + cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) != -1) return c.substring(name.length,c.length);
    }
    return "";
}
function removeCookie(cname){
	document.cookie = "clickerquiz" + cname + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC";
}
function reviseQuestion(){
	var qdiv = document.getElementById(perv_qid);
	var curindex = qids.indexOf(perv_qid);	
	if(document.getElementById("revise"+perv_qid).checked){
		prevTabColorCN = qdiv.className;
		qdiv.className = qdiv.className.replace("qtabSelected", "qtabRevise");	
		reviseQuestions[curindex]=1;
	}else{
		prevTabColorCN = qdiv.className;
		qdiv.className = qdiv.className.replace("qtabRevise", "qtabSelected");
		ansSelectedorNot(perv_qid+"q_radio", perv_qid, curindex);
		reviseQuestions[curindex]=0;
	}
	setCookie("revise"+responseJSON.response.quizrecordId, JSON.stringify(reviseQuestions), 7);
}
function ansSelectedorNot(groupName, id, respindex){
	var qdiv = document.getElementById(id);
	var radios = document.getElementsByName( groupName );
	if(radios.length>0){
		var flag=false;
		for(var i = 0; i < radios.length; i++ ) {
		  	if( radios[i].checked ) {
	   			flag = true;
	   			break;
	  		}
		}
		if(flag){
			prevTabColorCN = "qtabAnswered";
		}else{
			qdiv.className = qdiv.className.replace("qtabAnswered", "qtabSelected");
			prevTabColorCN = "qtabDefault";
		}
	}else{
		var txtbox = document.getElementsByName(groupName.replace("radio", "txt"))[0];
		var txtlen = txtbox.value.length;
		if(txtlen>0){
			prevTabColorCN = "qtabAnswered";					
		}else{
			prevTabColorCN = "qtabDefault";					
		}
		qdiv.className = qdiv.className.replace("qtabAnswered", "qtabSelected");
	}
}

function showpalette(){
	document.getElementById("palette").innerHTML = document.getElementById("tabholder").innerHTML;
	document.getElementById("palette").style.display = 'block';
	document.getElementById("main_container").style.opacity = 3/10;
	document.getElementById("main_container").style.pointerEvents = "none";
	var popupSetting = { width: '500', height: '330', title: 'Quiz palette',isFixed:true};	
	ShowPopup("palette", popupSetting,"2");
}
</script>
</head>
<body onload="getQuiz('<%=studcourse%>', '<%=studentID%>')">
<div id="main_container">
<table id="tabs" border="1">
	<tr style= "height:50px;" >
		<td style="width:1100px; text-align: left;padding: 0px;">
			<div class="scroll_btn_div">
				<button id="leftbtn" disabled="disabled" class="scroll_btn_dis" onclick="move_down(1)">&lt;&lt;</button></div> 
        	<div id="tabholder" >         		
        	</div>
        	<div class="scroll_btn_div">
        		<button id="rightbtn" class="scroll_btn" onclick="move_up(1)">&gt;&gt;</button>
        	</div>	
		</td>
		<td style="background-color:#2980b9; color:#ffffff;">
			<div id="timer" style="font-size:45px; text-align:center;">00:00</div>
			<div id="attempted" style="font-size:23px; text-align:center;">Attempted: 0/0</div>
		</td>
	</tr>	
	<tr>
		<td colspan="2" style="padding: 0px;">
			<div id="qcontainer">                        
            </div>
		</td>
	</tr>
</table>
<div style=" margin-top:3px; height: 100px; width:1310px; margin-left:5px; float:left;">
	<div id="previous" class="vsbl_hdn" style="float:left; margin-left: 20px; margin-top: 0px;" onclick="prev_question()">
		<img src="../../img/LArrow96.png">
	</div>		 
	<button id="deselect" type="submit" class="ui-loginbutton" style=" float:left; margin-left:50px;" onclick="deselect()">
	<span >Deselect</span>
	</button>
	<div id="revise_div" style="width: 200px; height: 50px; float: left; margin-left: 100px; margin-top: 20px; color: #fff">
	</div>	
	
	<div id="next" style="float:right; margin-right: 20px;" onclick="next_question()">
		<img src="../../img/RArrow96.png">
	</div>			 		
	<button id="submit" type="submit" class="ui-loginbutton" style="float:right; margin-right:50px;" onclick="submitResponse();" >
		<span >Submit</span>
	</button>
	<button id="palette_btn" type="submit" class="ui-loginbutton" style="float:right; margin-right:20px;" onclick="showpalette()">
	<span>Quiz Palette</span>
	</button>
</div> 
</div>
<div id="palette" style="display: none; overflow: scroll; height: 240px;overflow-x:hidden;">		
</div>
<form style="display: none;" id="respSub" name="respSub" action="response.jsp" method="post">			 		
	<input type="hidden" name="hdn_responseJSON" id="hdn_responseJSON" style="display: none">
	<input type="hidden" name="hdn_quiz" id="hdn_quiz" style="display: none">
</form>	
</body>
</html>