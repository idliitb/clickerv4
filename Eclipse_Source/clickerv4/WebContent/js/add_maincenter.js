var CurrentSelectedRow = 0;
var graphResponses;
var xmlhttp;
var previousSelectedRow = 0;
var previousSelectedColor = "#ffffff";
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


function rowSelected(SelectedRow) {

	CurrentSelectedRow = SelectedRow;
	var cid = SelectedRow;
	var pid = previousSelectedRow;
	// var pid = previousSelectedRow;

	// document.getElementById(SelectedRow).style.background =
	// previousSelectedColor;
	// alert("gobinath===>"+previousSelectedColor);
	if (previousSelectedRow != 0) {
		document.getElementById(pid).style.background = previousSelectedColor;
		previousSelectedColor = document.getElementById(cid).style.background;
		document.getElementById(cid).style.background = "#88ff99";
		previousSelectedRow = SelectedRow;
	} else {
		previousSelectedColor = document.getElementById(cid).style.background;
		document.getElementById(cid).style.background = "#88ff99";
		previousSelectedRow = SelectedRow;
	}
}

function QuizPollListener(){
	$(document).ready(function() {
	    setInterval(function() {
	    	 jQuery.get("../../jsp/remotejsp/remoteListener.jsp", function (response) {
	        	if(response.trim()!=null){

	            	if(response.trim()=="quizlaunch"){
	            		window.location.href="../../jsp/remotejsp/remotequiz.jsp";
	            		
	                	}
	            	if(response.trim()=="polllaunch"){
	            		window.location.href="../../jsp/remotejsp/remotepoll.jsp";	            		
	            	}
	            	if(response.trim()=="launchinstantquiz"){
	            		window.location.href="../../jsp/remotejsp/instantquiz.jsp";
	            		
	                	}
	        	}
	    	});
	    }, 1000);
	});
	}  


function ADD_Center()
{
	//var M_id = document.getElementById('maincenter_id').value;
	var M_name = document.getElementById('Maincenter_name').value;
	var M_state = document.getElementById('Maincenter_state').value;
	var M_city = document.getElementById('Maincenter_city').value;
	var M_url = document.getElementById('mainurl').value;	
	
	
    if(M_name == "")
		alert("Enter Main Center Name");
	else if(M_state == "")
		alert("Enter The State");
	else if(M_city == "")
		alert("Enter the City");
	else if(M_url== "")
		alert("Enter Maincenter URL");
	else
		{
		
		
		getXMLhttp();	
	{
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			}
		};

	
		var where_to = confirm("Do you really want to add MainCenter?");
		{
			if (where_to == true) {
				
				xmlhttp.open("GET", "../../AddMainCenter?MainCentername="+ M_name + "&MainCentercity="+M_city+"&MainCenterstate=" + M_state+ "&mainurl=" + M_url +"&Flag=ADD", true);
				//xmlhttp.open("GET", "redirectHelper.jsp?URL=instrutor_details.jsp", true);
			    // alert("instructer add sucessfully");
			     //window.location.reload();
			     
			} else {
				return false;
			}
		}
		
		xmlhttp.send();
	}
}


	
	
}


function Delete_RC()
{
	//alert(CurrentSelectedRow);
	getXMLhttp();	
	{
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			}
		};

	
		var where_to = confirm("Do you really want to delete MainCenter?");
		{
			if (where_to == true) {
				
				xmlhttp.open("GET", "../../AddMainCenter?MainCenterID="+ CurrentSelectedRow + "&Flag=DELETE", true);
				//xmlhttp.open("GET", "redirectHelper.jsp?URL=instrutor_details.jsp", true);
			    // alert("instructer add sucessfully");
			     //window.location.reload();
			     
			} else {
				return false;
			}
		}
		
		xmlhttp.send();
	}

}


function update_MC()
{
	var M_name = document.getElementById('mc_name').value;
	
	var M_url = document.getElementById('main_url').value;	
	
	var main_ID = document.getElementById('mc_id').value;	
	//alert(M_name+""+ M_state+""+ M_city+"=="+ M_url);
	
    if(M_name == "")
		alert("Alert Main Center Name");
	else if(M_url== "")
		alert("Enter Maincenter URL");
	else
{
	getXMLhttp();	
	{
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			}
		};

	
		var where_to = confirm("Do you really want to Update MainCenter?");
		{
			if (where_to == true) {
				alert("../../AddMainCenter?MainCentername="+ M_name + "&mainurl=" + M_url +"&MainCenterID="+main_ID+"&Flag=UPDATE");
				xmlhttp.open("GET", "../../AddMainCenter?MainCentername="+ M_name + "&mainurl=" + M_url +"&MainCenterID="+main_ID+"&Flag=UPDATE", true);
					//xmlhttp.open("GET", "redirectHelper.jsp?URL=instrutor_details.jsp", true);
			    // alert("instructer add sucessfully");
			     //window.location.reload();
			     
			} else {
				return false;
			}
		}
		
		xmlhttp.send();
	}
}

}


function edit_rc()
{
	
if(CurrentSelectedRow == 0)
{
alert("Select the Main Center");
return false;
}
	getXMLhttp();

	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("u_MC").style.visibility = 'visible';
			document.getElementById("u_MC").title = "Main Center";
			document.getElementById("u_MC").innerHTML = xmlhttp.responseText;
			$("#u_MC").dialog({
				height : 300,
				width : 500,
				draggable : false,
				modal : true
			});
		}
	};

	xmlhttp.open("GET", "mainCenter_edit.jsp?MainCenter_ID="+ CurrentSelectedRow, true);
	xmlhttp.send();
}
function Clear_data()
{
	 document.getElementById('maincenter_id').value="";
	 document.getElementById('Maincenter_name').value="";
	 document.getElementById('Maincenter_state').value="";
	 document.getElementById('Maincenter_city').value="";
	 document.getElementById('mainurl').value="";


}


function close_MC()
{
	$(u_MC).parent().remove();
	document.getElementById("u_MC").style.visibility = 'hidden';
	document.getElementById("u_MC").style.width = "0px";
	document.getElementById("u_MC").style.height = "0px";
windows.location.reload();

}