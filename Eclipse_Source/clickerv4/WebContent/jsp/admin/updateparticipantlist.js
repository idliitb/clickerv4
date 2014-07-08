var pid, participantname, check = 0;

function trimfield(str) 
{ 
	 	return str.replace(/^\s+|\s+$/g,''); 
}

function edit(rows, col) {
	
	
	if(check == 1)
	{
		alert("Please save the current data first!");
		return false;
	}
	var row = (rows-3);
	check = 1;
			
		$('#participanttable tr#rc_tr' + row)
				.append(
						'<td><button id = "save" type = "button" value = "Save" onclick ="save_values()" alt="button" title = "Save"><span>Save</span></button></td>');
		pid = $('tr#rc_tr' + row).find('td#rc_td' + (col-2) + row).html();
		participantname = $('tr#rc_tr' + row).find('td#rc_td' + (col-1) + row).html();
		
		
		pid = trimfield(pid);
		participantname = trimfield(participantname);
		
		$('#rc_tr' + row + ' td#rc_td' + (col-2) + row).empty();
		$('tr#rc_tr' + row + ' td#rc_td' + (col-2) + row)
				.append(
						'<input type="text" id="pid" name = "edit_txt1"  style = "border:none; width:50px;" />');
		document.getElementById("pid").value = pid;
		
		$('#rc_tr' + row + ' td#rc_td' + (col-1) + row).empty();
		$('tr#rc_tr' + row + ' td#rc_td' + (col-1) + row)
				.append(
						'<input type="text" id="participantname" name = "edit_txt1"  style = "border:none; width:200px;" />');
		document.getElementById("participantname").value = participantname;
			
				
}

function save_values() {
	
	var xmlhttp;
	var newpid = document.getElementById("pid").value;
	var newpname = document.getElementById("participantname").value;
	
	//alert("CID: " + cid);
	if (trimfield(newpname) == '') {
		alert("Please Enter a Valid Center ID");
		return false;
	} else if (trimfield(newpid) == '') {
		alert("Please Enter a Valid Participant ID.!!!");
		return false;
	}	
	if (participantname == document.getElementById("participantname").value && pid == document.getElementById("pid").value) {

		var r = confirm("You have not done any changes. Do you want to close edit");
		if (r) {
			check = 0;
			window.location = "addremoteparticipant.jsp";
			return true;
		} else {
			return false;

		}

	} 
	else
	{
		if(window.XMLHttpRequest)
		{
			xmlhttp=new XMLHttpRequest();
		}
		else
		{
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		
		xmlhttp.open("Post", "../../getparticipantlist?pid=" + pid + "&newpid=" + newpid + "&newpname=" + newpname + "&select=1", true);
		xmlhttp.send( );
		
		xmlhttp.onreadystatechange=function()
		{
			if(xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					check = 0;
					//alert("response text: " + xmlhttp.responseText);
					if(!(xmlhttp.responseText)){
						alert("Participant information edited Successfully");
						window.location = "addremoteparticipant.jsp";
					}
					else
						alert("This Remote Center ID does not exist. Kindly add this Remote Center first");
					
				}
		}
	}
}

function del_entry(rows, col)
{
	if(check == 1)
	{
		alert("Please save the current data first!");
		return false;
	}
	var row = (rows-3);
	pid = $('tr#rc_tr' + row).find('td#rc_td' + (col-2) + row).html();
	pid = trimfield(pid);
	//alert("CID: " + cid);
	var xmlhttp;
	var r = confirm("Confirm Delete of this Participant?");
	
	if(r)
	{
		if(window.XMLHttpRequest)
		{
			xmlhttp=new XMLHttpRequest();
		}
		else
		{
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		
		xmlhttp.open("Post", "../../getparticipantlist?pid=" + pid + "&select=2", true);
		xmlhttp.send( );
		
		xmlhttp.onreadystatechange=function()
		{
			if(xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					check = 0;
					window.location = "addremoteparticipant.jsp";
				}
		}
	}
	else
		return false;

}