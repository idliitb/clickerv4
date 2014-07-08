var xmlhttp;


function QuizPollListener(){
	$(document).ready(function() {
	    setInterval(function() {
	    	 jQuery.get("../../jsp/remotejsp/remoteListener.jsp", function (response) {
	        	if(response.trim()!=null){

	            	if(response.trim()=="quizlaunch"){
	            		window.location.href="../../jsp/remotejsp/remotequiz.jsp";
	            		
	                	}
	            	if(response.trim()=="polllaunch"){
	            		window.location.href="";
	            		
	            	}
	        	}
	    	});
	    }, 1000);
	});
	}  





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

function uploadXLS() {
	
var WS=document.getElementById("WS_id").value;
	
if((WS == "No workshop Available"))
{
alert("No workshop Available!! you Cant Add!!");
return false;
}
else if ((WS== "No Workshop, Wrong URL"))
{
 alert("Wrong URL!! you Cant Add!!");
return false;		
}
	setTimeout("previewXLS()",1000);
	//
    var xlsFile = document.getElementById("file").files[0];
    //alert("xlsfile: " + xlsFile);
    var formdata = new FormData();
    formdata.append("file", xlsFile);
    var xhr = new XMLHttpRequest();       
    xhr.open("POST","../../participantfileuploader", true);
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
	//var ws = (document.getElementById("wsselect").options[document.getElementById("wsselect").selectedIndex].value);
	//alert(document.getElementById("WS_id").value);
	var ws=document.getElementById("WS_id").value;
	document.getElementById("workshopid").value = ws;
	//alert("in preview");
	$("#dialog").dialog({
		modal:true,
		height:530,
		position:"absolute",
	    width:800,
	    autoOpen:false
	});
	var url=getXlsUrl();
	//alert("url: " + url);
	if(url!=null&&url!=""){
		/*$("#uploadForm").css("height", "90%");
		$("#uploadForm").css("width", "100%");*/
		$("#frame").css("height","87%");
		$("#frame").css("width","100%");
		$("#frame").attr("src","../../participantpreviewXLS?xls="+url + "&workshop=" + ws);
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

function getlist( )
{
	
	var ws = (document.getElementById("wsselect").options[document.getElementById("wsselect").selectedIndex].value);
	var wscount = document.getElementById("plist").value;
	
	$('#participantlist').load("participantlist.jsp?workshopid=" + encodeURIComponent(ws) + "&wscount=" + wscount);
	
}

function nospaces(t){
	

	if(t.value.match(/\s/g)){

	alert('Sorry, you are not allowed to enter any spaces');

	t.value=t.value.replace(/\s/g,'');

	}

	}

function add_part()
{
	var P_ID=document.getElementById("Part_id").value;
	var P_name=document.getElementById("Part_name").value;
	var WS=document.getElementById("WS_id").value;
	if((WS == "No workshop Available"))
		{
		alert("No workshop Available!! you Cant Add!!");
		return false;
		}
	else if ((WS== "No Workshop, Wrong URL"))
		{
		 alert("Wrong URL!! you Cant Add!!");
		return false;		
		}
	if(P_ID == "")
		{
		alert("Enter Participant ID");
		return false;
		}
	if(P_name == "")
		{		
		alert("Enter Participant name");
		}
	//alert(P_ID +"=="+P_name);
	
	getXMLhttp();
	// var e;
	// e = document.getElementById("raise_hand_id");

	{

		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			}
		};

		var where_to = confirm("Do you really want to Add Participant?");
		{
			if (where_to == true) {
               
				xmlhttp.open("GET", "../../ParticipantDetails?participantid="+ P_ID + "&participantname="+P_name+"&wsselect="+encodeURIComponent(WS)+"&Flag=ADD", true);			
				var sTempTableRow="<tr><td>"+P_ID+" </td><td align='left'>"+P_name+"</td></tr>";
			     $('#Part_table').append(sTempTableRow);
			   

			} else {
				return false;
			}
		}

		xmlhttp.send();
	}
	document.getElementById("Part_id").value="";
	document.getElementById("Part_name").value="";
	//document.getElementById("WS_id").value;
}

function delete_part()
{
	//alert("gobi");
	var P_ID=document.getElementById("Part_box").value;
	var WS=document.getElementById("WS_id").value;
	if(P_ID=="")
		{
		alert("Enter participant Id");
		return false;
		}
	getXMLhttp();
	// var e;
	// e = document.getElementById("raise_hand_id");

	{

		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			}
		};

		var where_to = confirm("Do you really want to Delete Participant?");
		{
			if (where_to == true) {
               
				xmlhttp.open("GET", "../../ParticipantDetails?participantid="+ P_ID + "&wsselect="+encodeURIComponent(WS)+"&Flag=DELETE", true);			
				var row = document.getElementById(P_ID);
				row.parentNode.removeChild(row);
				

			} else {
				return false;
			}
		}

		xmlhttp.send();
	}
	document.getElementById("Part_box").value="";
	//windows.location.reload();

	//document.getElementById("WS_id").value;
	

}


function remove_mac()
{
	
	var P_ID=document.getElementById("Part_box").value;
	var WS=document.getElementById("WS_id").value;
	if(P_ID=="")
		{
		alert("Enter participant Id");
		return false;
		}
	getXMLhttp();
	// var e;
	// e = document.getElementById("raise_hand_id");

	{

		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			}
		};

		var where_to = confirm("Do you  want to Remove the MAC?");
		{
			if (where_to == true) {
               
				xmlhttp.open("GET", "../../ParticipantDetails?participantid="+ P_ID + "&wsselect="+encodeURIComponent(WS)+"&Flag=REMOVE_MAC", true);			
				
				

			} else {
				return false;
			}
		}

		xmlhttp.send();
	}
	document.getElementById("Part_box").value="";
	//windows.location.reload();

	//document.getElementById("WS_id").value;

}



function delete_all()
{
	var WS=document.getElementById("WS_id").value;
	if(WS == "")
		{
		alert("enter Participant ID");
		return false;		
		}
	
	getXMLhttp();
	// var e;
	// e = document.getElementById("raise_hand_id");

	{

		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			}
		};

		var where_to = confirm("Do you really want to Add Participant?");
		{
			if (where_to == true) {
               
				xmlhttp.open("GET", "../../ParticipantDetails?wsselect="+encodeURIComponent(WS)+"&Flag=DELETE_ALL", true);			
				
				$('#Part_table tbody').remove();
				

			} else {
				return false;
			}
		}

		xmlhttp.send();
	}
	//document.getElementById("Part_box").value="";
	//windows.location.reload();

	//document.getElementById("WS_id").value;
	

}
