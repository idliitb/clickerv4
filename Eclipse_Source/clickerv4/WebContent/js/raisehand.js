/*
 * Dipti.G  from Clicker Team, IDL LAB -IIT Bombay
 */

function loadPendingDoubts(status)
{
	 document.getElementById("raiseques").innerHTML = "";
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
		    	document.getElementById("raiseques").innerHTML=xmlhttp.responseText;
			}
	};
	if(status=='Pending'){
		document.getElementById("activeraise").selectedIndex=-1;
		xmlhttp.open("GET","../../retrieveAPRaiseHand?StudentIDandTimeStamp="+encodeURIComponent(document.getElementById("pendingraise").options[document.getElementById("pendingraise").selectedIndex].value)+"&Status="+status,true);
	
	}else{
		document.getElementById("pendingraise").selectedIndex=-1;
		xmlhttp.open("GET","../../retrieveAPRaiseHand?StudentIDandTimeStamp="+encodeURIComponent(document.getElementById("activeraise").options[document.getElementById("activeraise").selectedIndex].value)+"&Status="+status,true);
		
	}
	xmlhttp.send();
}