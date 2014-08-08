/* @ Author: Harshavardhan, Clicker Team, IDL, IIT Bombay */

var questions = null;

function uploadXLS() {
	setTimeout("previewXLS()",1000);
	//alert("In Upload");
    var xlsFile = document.getElementById("file").files[0];
    //alert("xlsfile: " + xlsFile);
    var formdata = new FormData();
    formdata.append("file", xlsFile);
    var xhr = new XMLHttpRequest();       
    xhr.open("POST","../../fileuploader", true);
    xhr.send(formdata);
    //window.location.href="../../jsp/QuestionBank/questionbank.jsp";
}

function getXlsUrl(){
	var url=$("#file").val();
	//alert("URL: " + url);
	if(url.lastIndexOf("\\")!=-1){
		url=url.slice(url.lastIndexOf("\\")+1);
	}
	return url;
}

function previewXLS() {
	//alert("in preview");
	$("#dialog").dialog({
		modal:true,
		height:530,
		position:"absolute",
	    width:640,
	    autoOpen:false
	});
	var url=getXlsUrl();
	//alert("url: " + url);
	if(url!=null&&url!=""){
		/*$("#uploadForm").css("height", "90%");
		$("#uploadForm").css("width", "100%");*/
		$("#frame").css("height","87%");
		$("#frame").css("width","100%");
		$("#frame").attr("src","../../previewXLS?xls="+url);
		$("#xls").attr("value",url);
		$("#dialog").css("visibility","visible"); 	
	    $("#dialog").dialog("open",function(){
	  	    $("#dialog").css("visibility","hidden"); 	
	    }); 	
	}
	else{
		alert("Please select an XLS file first");
	}
}
function closeDialog(){
	$('#dialog').dialog("close");
}

function loadQuestion(InstrID, courseid)
{
	/*
	This code just loads the xmlhttp request object that will fetch the contents from the server.
	*/
	var selector;
	if(document.getElementById("allquest").checked)
		selector = 01;
	else
		selector = 00;
	var xmlhttp;
	if(window.XMLHttpRequest)
		{
			xmlhttp=new XMLHttpRequest();
		}
	else
		{
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	//Now we have xmlhttp object ready now we can fetch data from the server asynchronously.
	var value = (document.getElementById("questiontype").options[document.getElementById("questiontype").selectedIndex].value);
	//alert("instructor: " + InstrID + " qtype: " + value);
	if(selector == 00)
	{
		//alert("in 00");
		if(document.getElementById("archived").checked)
			xmlhttp.open("GET","../../jsp/questionbank/getallquestions.jsp?archived=enabled&question_type=" + value+"&InstrID="+InstrID + "&courseid=" + encodeURIComponent(courseid)
					+ "&selector=00", true);
		else
			xmlhttp.open("GET","../../jsp/questionbank/getallquestions.jsp?question_type=" + value+"&InstrID="+InstrID + "&courseid=" + encodeURIComponent(courseid) + "&selector=00", true);
	}
	else
	{
		if(document.getElementById("archived").checked)
			xmlhttp.open("GET","../../jsp/questionbank/getallquestions.jsp?archived=enabled&question_type=" + value+"&InstrID="+InstrID + "&courseid=" + encodeURIComponent(courseid)
					+ "&selector=01", true);
		else
			xmlhttp.open("GET","../../jsp/questionbank/getallquestions.jsp?question_type=" + value+"&InstrID="+InstrID + "&courseid=" + encodeURIComponent(courseid) + "&selector=01", true);
	}
	//Here the request will be send to the server.
	xmlhttp.send();
	//This function is called everytime the state changes which is typically 4 times.
	xmlhttp.onreadystatechange=function()
	{
		if(xmlhttp.readyState==4 && xmlhttp.status==200)
			{			
				questions=(xmlhttp.responseText).trim();
			
				if(questions != ""){
					filterQuestions(2);	//Distinguish between search question and load question; Argument value 1: Search is active; Argument value 2: Only Load Questions			
				}
				else
					alert("Question are not available for this Question type");
			
			}
	};
}
var totalquestions = 0;
function filterQuestions(flag)
{	
	var header = null;
	var opts_div = null;
	var textnode = null;
	var qid = null;
	var query=document.getElementById("searchbox").value;
	var quest = questions.split("#@");
	var question=quest[0].split("@@");
	var credits = quest[1].split("!@");	
	var quest_credits = credits[0].split("#");
	var shuffle = credits[1].split("$@");
	var opts_shuffle = shuffle[0].split("!");
	var question_repeated = shuffle[1].split("$");
	
	//alert("quest length: " + question.length);
	//alert("filter" + question[1]);
			
	if(flag == 1) //Distinguish between search question and load question; Argument value 1: Search is active; Argument value 2: Only Load Questions
	{
		document.getElementById("quest").innerHTML="";		
	}
	
	for(var i = 0;i < question.length - 1;i++)
	{
		if(question[i].toUpperCase().indexOf(query.toUpperCase())!=-1)
			{				
				qid=question[i].split("@~");
				
				var j = i + 1;
				
				header = document.createElement("h3");
				opts_div = document.createElement("div");
				textnode = document.createTextNode(qid[0]);
				checkbox = document.createElement("input");
				del_button = document.createElement("input");
				edit_button = document.createElement("input");
				quest_div = document.createElement("div");
				buttons_div = document.createElement("div");				
				options = document.createElement("div");
				credits_div = document.createElement("div");
				credits_textnode = document.createTextNode("Credits: " + quest_credits[i]);
				question_repeated_div = document.createElement("div");
				question_repeated_textnode = document.createTextNode("Question in Quizzes: " + question_repeated[i]);
				info_div = document.createElement("div");
				shuffle_div = document.createElement("div");
				shuffle_textnode = null;
				if(opts_shuffle[i] == 1)
					shuffle_textnode = document.createTextNode("Options Shuffling: Yes");
				else
					shuffle_textnode = document.createTextNode("Options Shuffling: No");
				
				quest_div.setAttribute("style", "width: 880px;");
				quest_div.appendChild(textnode);
								
				buttons_div.setAttribute("id", "buttons");
				buttons_div.setAttribute("style", "margin-top: -25px; float: right;");				
								
				del_button.setAttribute("type", "image");
				del_button.setAttribute("id", "del_button" + qid[1]);
				del_button.setAttribute("style", "height: 25px; width: 25px;");
				del_button.setAttribute("class", "del_toggle");
				del_button.setAttribute("onclick", "javascript:deleteQuestion('" + qid[1] + "')");
				del_button.setAttribute("src", "../../img/delete01.png");
				
				edit_button.setAttribute("type", "image");
				edit_button.setAttribute("id", "edit_button" + qid[1]);
				edit_button.setAttribute("style", "height: 25px; width: 25px;");
				edit_button.setAttribute("class", "edit_toggle");
				edit_button.setAttribute("onclick", "javascript:editQuestion('" + qid[1] + "')");
				edit_button.setAttribute("src", "../../img/edit1.png");
				
				checkbox.setAttribute("type", "checkbox");
				checkbox.setAttribute("id", "checkbox" + qid[1]);
				checkbox.setAttribute("class", "checkbox_toggle");
				checkbox.setAttribute("style", "float: right; display: none;");
				checkbox.setAttribute("onclick", "javascript:selectquizQuestions('" + qid[1] + "');");
				checkbox.setAttribute("value", qid[1]);
				checkbox.setAttribute("name", "checkbox");
				
				buttons_div.appendChild(edit_button);
				buttons_div.appendChild(del_button);
				buttons_div.appendChild(checkbox);
																
				header.setAttribute("id", "header" + qid[1]);
				header.setAttribute("onclick", "javascript:loadOptions(" + qid[1] + ")");
				header.setAttribute("style", "border-color: #F5C06B; text-align: left;");
				header.setAttribute("class", "quest_header");
				
				header.appendChild(quest_div);
				header.appendChild(buttons_div);				
				
				options.setAttribute("id", "opts" + j);
								
				opts_div.setAttribute("id", "options" + qid[1]);
				opts_div.setAttribute("style", "float: left; min-height: 100px; border: 1px solid; width: 760px; " +
									  "border-color: #F5C06B; text-align: left;");
				opts_div.setAttribute("class", "opts_div");
				
				credits_div.setAttribute("id", "credits" + qid[1]);
				credits_div.setAttribute("style", "margin-left: -78px;");
				credits_div.appendChild(credits_textnode);
				
				shuffle_div.setAttribute("id", "shuffle" + qid[1]);
				shuffle_div.setAttribute("style", "margin-left: -7px;");
				shuffle_div.appendChild(shuffle_textnode);
				
				question_repeated_div.setAttribute("id", "question_repeated" + qid[1]);
				question_repeated_div.setAttribute("style", "");
				question_repeated_div.appendChild(question_repeated_textnode);
				
				info_div.setAttribute("style", "margin: auto; float: right;");
				info_div.appendChild(credits_div);
				info_div.appendChild(shuffle_div);
				info_div.appendChild(question_repeated_div);
				
				
				var parent = document.getElementById("quest");
				//alert("last child:" + document.getElementById("options").id);
				parent.appendChild(header);
				parent.appendChild(options);
				
				//alert("question: " + qid[1]);
				document.getElementById("opts" + j).appendChild(opts_div);				
				document.getElementById("opts" + j).appendChild(info_div);								
				//alert("options: " + document.getElementById("header" + qid[1]).nextSibling.id);
								
			}
		
	}
	
	$(function() {
	    $("#quest").accordion({
	      collapsible: true,
	      heightStyle: "content",
	      active: false,
	    });	    
	  });
	
	$( "#quest" ).accordion( "refresh" );
	
	$(".checkbox_toggle").click(function(event){
	    event.stopPropagation();
	});
	$(".edit_toggle").click(function(event){
	    event.stopPropagation();
	});
	$(".del_toggle").click(function(event){
	    event.stopPropagation();
	});
	
	if(document.getElementById("quiz").style.display == 'block')
	{
		var check_toggle = document.getElementsByName("checkbox");		
		//var question_selected = document.getElementsByClassName("quiz_questions");
		//alert(parseInt((check_toggle[0].id).replace(/[^0-9\.]/g, ''),10));
		//var max_value = Math.max(check_toggle.length, question_selected.length);				
		
		for(var i = 0; i < check_toggle.length; i++)
		{			
			try
			{
				(check_toggle[i]).style.display = 'block';
				
				if(parseInt((check_toggle[i].id).replace(/[^0-9\.]/g, ''), 10) == (document.getElementById("hidden" + parseInt((check_toggle[i].id).replace(/[^0-9\.]/g, ''), 10)).value))
					check_toggle[i].checked = true;
			}
			catch(err)
			{
				//alert(err.message);				
			}
		}
		
	}
	
	/*$(function() {
	    $(selector).pagination({
	        items: 100,
	        itemsOnPage: 10,
	        cssStyle: 'light-theme'
	    });
	});*/
}

function loadOptions(qid)
{
	//alert("in load options!" + qid);
	var xmlhttp;
	if(window.XMLHttpRequest)
	{
		xmlhttp=new XMLHttpRequest();
	}
	else
	{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function()
	{
			if(xmlhttp.readyState==4 && xmlhttp.status==200)
			{
		    	document.getElementById("options" + qid).innerHTML=xmlhttp.responseText;
		    	//alert("OPtions: " + xmlhttp.responseText);
			}
	};
	xmlhttp.open("GET","../../retrieveOptions?questionID="+ qid,true);
	xmlhttp.send();

}

function createquiz( )
{//alert("in create quiz");
	
	if(questions != "")
	{
		if(document.getElementById("quiz").style.display == 'none')
		{		
			document.getElementById("cq_span").innerHTML = "Cancel Quiz";
			document.getElementById("cq_button").style.background = "#C40000";
			document.getElementById("quiz").style.display = "block";
			
			var check_toggle = document.getElementsByName("checkbox");
			
			for(var i = 0; check_toggle.length; i++)
				(check_toggle[i]).style.display = 'block';		
		}
		else
		{
			document.getElementById("cq_span").innerHTML = "Create Quiz";
			document.getElementById("cq_button").style.background = "#f1690a";
			document.getElementById("quiz").style.display = "none";
			document.getElementById("quizName").value = "";
			document.getElementById("durationM").value = "";
			document.getElementById("durationS").value = "";
			
			var check_toggle = document.getElementsByName("checkbox");
							
					if(document.getElementById("count").value > 0)
					{
						document.getElementById("count").value = 0;		
						
						$('.quiz_questions').remove( );
						//alert("Count: " + document.getElementsByClassName("quiz_questions").length);					
					}
					for(var i = 0; check_toggle.length; i++)
					{
						if((check_toggle[i]).checked == true)
							(check_toggle[i]).checked = false;
							
						(check_toggle[i]).style.display = 'none';	
					}
		
		}
	}
	else
		alert("Please add some question(s) to Create Quiz");
}

var counter = 0;
function selectquizQuestions(qid)
{	
	parent_div = document.getElementById("quiz");
	if(document.getElementById("checkbox" + qid).checked)
	{
		var input = document.createElement("input");
		
		input.setAttribute("id", "hidden" + qid);
		input.setAttribute("type", "hidden");
		input.setAttribute("value", qid);
		input.setAttribute("name", "" + (++counter));
		input.setAttribute("class", "quiz_questions");		
		//alert("In if, Counter Value: " + counter);
		
		parent_div.appendChild(input);
		document.getElementById("count").value = counter;
	}
	else
	{
		parent_div.removeChild(document.getElementById("hidden" + qid));
		document.getElementById("count").value = (--counter);
		//alert("In else, Counter Value: " + counter);
	}
}

function getQuestions(instructor_id, course_id)
{	
	document.getElementById("quest").innerHTML = "";
	loadQuestion(instructor_id, course_id);
}

function displayAddbox( )
{
	$("#addquestions").dialog({
		title:"Add Questions",
		modal:true,		
		height:535,
		position: {my: "center", at: "center", of: window},
	    width:1060,
	    autoOpen:false
	});
	
	$("#addquestframe").css("height","84%");
	$("#addquestframe").css("width","100%");
	
	$("#addquestions").css("display","block"); 	
    $("#addquestions").dialog("open",function(){
  	$("#addquestions").css("display","block"); 	
    });
    addQuestions( );
}

function addQuestions( )
{
	var qtype = (document.getElementById("qtypeselect").options[document.getElementById("qtypeselect").selectedIndex].value);
	var url = null;
	
	try
	{
		switch(qtype)
		{
			case '1': url = "singlechoice.jsp";
			break;
			case '2': url = "multichoice.jsp";
			break;
			case '3': url = "numeric.jsp";
			break;
			case '4': url = "truefalse.jsp";
			break;
		}
	}
	catch(err)
	{
		alert("Error: " + err);
	}
	
	$("#addquestframe").load(url);
}

function editQuestion(qid)
{
	$("#editquestions").dialog({
		title:"Edit Question",
		modal:true,
		height:516,
		//position:"absolute",
	    width:848,
	    autoOpen:false
	});
	
	$("#editbox").css("height","87%");
	$("#editbox").css("width","100%");
	$("#editbox").load("editquestion.jsp?qid=" + qid);
	
	$("#editquestions").css("display","block"); 	
    $("#editquestions").dialog("open",function(){
  	$("#editquestions").css("display", "block"); 	
    });    
}

function deleteQuestion(qid)
{
	var answer = confirm('Are you sure, you want to delete this question.');
	if(answer){
       	url = "../../deletequestion?qid=" + escape(qid);
		window.location.href=url;
	}
}

function deleteQuiz( )
{
	$("#deletequiz").dialog({
		title:"Delete Quiz",
		modal:true,
		//height:761,
		position: {my: "center", at: "top", of: window},
	    width:1150,
	    autoOpen:false,
	    resizable: false
	});
	
	$("#deletequizbox").css("height","87%");
	$("#deletequizbox").css("width","100%");
	$("#deletequizbox").load("../managequiz/delete.jsp");
	
	$("#deletequiz").css("display","block"); 	
	$("#deletequiz").dialog("open",function(){
  	$("#deletequiz").css("display", "block"); 	
    });
}

function validateQuiz(InstrID) {
	
	var x = document.forms["createquizform"].elements["quizName"].value;	
	var y = document.forms["createquizform"].elements["durationM"].value;
	var w = document.forms["createquizform"].elements["durationS"].value;	
	var cnt = document.getElementById("count").value;
	//alert("count: " + cnt);
	
	if (cnt == 0) {
		alert("Please add some questions");
		return false;
	}
	else if (x == null || x == "" || x.trim() == "") {
		alert("Please Fill Quiz name!!!");
		return false;

	} else if (((y == null || y == "" || y.trim() == "") && 
			(w == null || w == "" || w.trim() == "")) || isNaN(w) == true 
			|| isNaN(y) == true || (w < 0) || (y < 0) || (w.indexOf(".") != -1) || (y.indexOf(".") != -1)) {
		alert("Invalid time");
		return false;
	}
	 else {
		alert("You have successfully Added a new Quiz.\nThank you");
		
	}
	
}

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
  messageHeigth= 20;
   if((y>10)&&(y<200))
    {
	 m.style.top=y-messageHeigth+"px";
	 //alert(m.style.top);
	}
   else
	   m.style.top=y-(5*messageHeigth)+"px";
   if(x<850){
     m.style.left=x - 500+"px";
	 }
   else{
    m.style.left=x-500+"px";
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

function quizname(quizname, quiz_id)
{	
	var quiz_div_color = document.getElementsByClassName('Q_div');
	var quiz_div_color1 = document.getElementsByClassName('Q_div1');
			
		if(quiz_div_color.length > 0)
			for(var i = 0; i < (quiz_div_color.length); i++)
				if($(document.getElementById(quiz_div_color[i].id)).css('background-color') == 'rgb(255, 99, 8)' || document.getElementById(quiz_div_color[i].id).style.background == '' || document.getElementById(quiz_div_color[i].id).style.background == null)
					document.getElementById(quiz_div_color[i].id).style.background = '';
		
		if(quiz_div_color1.length > 0)
			for(var i = 0; i < (quiz_div_color1.length); i++)
				if($(document.getElementById(quiz_div_color1[i].id)).css('background-color') == 'rgb(255, 99, 8)' || document.getElementById(quiz_div_color1[i].id).style.background == '' || document.getElementById(quiz_div_color1[i].id).style.background == null)
					document.getElementById(quiz_div_color1[i].id).style.background = '';
			
	document.getElementById(quiz_id).style.background = 'rgb(255, 99, 8)';
		
	document.getElementById("quizdetails").innerHTML = "";
	var xmlhttp;
	if(window.XMLHttpRequest)
		{
			xmlhttp=new XMLHttpRequest();
		}
	else
		{
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
	xmlhttp.open("GET", "../../jsp/managequiz/deletequizdisplay.jsp?quizid=" + escape(quiz_id), true);
	xmlhttp.send( );
	
	var quiz_info, quiz_info_split;
	var questions_split, questions, quests_split, opts;
	var quiz_info_split;
	var timestamp;
	var quest_table, timestamp_table; 

	quest_table = "<table id = 'quiz_details' class = 'table1' border = '1' style = 'width: 1050px; margin-top: 10px; border: 3px solid #e46c0a;'> <tr><td><div id = 'details' style='font-size: 18px; height:400px;overflow: auto; text-align: justify;'>";
	timestamp_table = "<div class='table1' style='max-height: 97px; width: 250px; margin-top: 0px; overflow: auto;'" + 
					  "'height: 150px; text-align: justify; border: 3px solid #e46c0a;'>" +
					  "<div style='margin-left: 10px; font-size:18px;'>Quiz Conduction Record</div>";
					  
	xmlhttp.onreadystatechange=function()
	{
		if(xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				quiz_info = (xmlhttp.responseText).trim();
				//alert("quiz info: " + quiz_info);
				quiz_info_split = quiz_info.split("$$");
				questions = quiz_info_split[0].split("@@");
				
				//alert("TS: " + quiz_info_split[1]);
				for(var i = 0; i < questions.length; i++)
				{
					if(questions[i].indexOf("!@") > -1)
					{
						quests_split = questions[i].split("!@");
						//alert("TS: " + questions.length);
						//alert("TS: " + quests_split[1]);
						quest_table += "<font style = 'font-weight: bold'>Question " + (i + 1) + "</font>: " + quests_split[0] + "<br>";
						
						opts = quests_split[1].split("!!");
						//alert("TS: " + opts.length);
						for(var j = 0; j < opts.length; j++)
						{
							quest_table += "<font style = 'font-weight: bold'>Option " + (j + 1) + "</font>: " + opts[j] + "<br>";
						}
						quest_table += "<br>";
					}
					else
						quest_table += "<font style = 'font-weight: bold'>Question " + (i + 1) + "</font>: " + questions[i] + "<br><br>";
											
				}
				quest_table += "</div></td></tr></table>";
				
				if(quiz_info_split[1] != "1")
				{
					timestamp = quiz_info_split[1].split("#");
					
					timestamp_table += "<table  border='1' style='border-radius:5px;'><tr style  = 'font-size'" +
					 	 			   "': 14px;'><th>Sr.No.</th><th>Quiz Conducted On</th></tr>";
					 	 			   
					for(var k = 0; k < timestamp.length; k++)
					{
						timestamp_table +=  "<tr style = 'font-size : 13px'><td style = 'text-align: center;'>" + (k + 1) + "</td>" +
											"<td style = 'text-align: center;'>" + timestamp[k] + "</td></tr>";
					}
					timestamp_table += "</table></div>";
				}
				else
					timestamp_table += "<div style = 'margin:10px 0px 0px -20px; color:red; font-size: 18px; text-align: center;'> This Quiz has not been conducted till date </div></div>";
			}
		document.getElementById("quizdetails").innerHTML = quest_table;
		document.getElementById("quiz_conduction_record").innerHTML = timestamp_table;
	};

	document.getElementById("delete_quiz_button").style.display = "block";
	document.getElementById("QuizID").value = quiz_id;
	
}