var i_id;
var i_n;
var doj;
var d_id;
var desg;
var e_id;
var mobile;
var admin_pri;
var course;

var currentCourse;
function trimstr(s) {
	return s.replace(/^\s+|\s+$/g, '');
}

function getCourseValueInst(value) {
	
	currentCourse = value;
	var courselist = 0;
	document.getElementById("currCourseinst").value = "" + currentCourse;
	
	var xmlhttp = false;
	if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else {// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.open("GET", "getCourseListInst.jsp?deptinstid=" + currentCourse, true);
	xmlhttp.send();
	xmlhttp.onreadystatechange = addInstructorCourseList;

	function addInstructorCourseList() {
		var courseInstSelect=document.getElementById("text69");
		
		courseInstSelect.options.length = 0;
		var option=document.createElement("option");
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			courselist = xmlhttp.responseText;
		}
		courselist = trimstr(courselist);
		var courseArr = courselist.split(";");
		for ( var i = 0; i < courseArr.length-1; i++) {
			option.text=courseArr[i];
			courseInstSelect.options[courseInstSelect.options.length] = new Option(courseArr[i], courseArr[i]);
		}
	}

}
function edit_value(n)
{
	document.getElementById("btn_del_inst").value = "5";
	var l = document.getElementById("count").value;	
	document.getElementById("addnew").removeAttribute("onClick");
	if ((document.getElementById("btn_edit_inst").value == "6") ||  document.getElementById("btn_delc").value == "5")
	{
		alert("Please Save the Data First");
	}
		
else
	{
	$('#my_table tr#check_'+n).append('<td width = "1%"><img src="save.jpg" height="32" width="32" value = "s" onclick= "save_values()" alt="button" title = "Save"></td>'); 
	i_id =  $('tr#check_'+n).find('td#td1_'+n).html();
	i_n =  $('tr#check_'+n).find('td#td2_'+n).html();
	doj =  $('tr#check_'+n).find('td#td3_'+n).html();
	d_id =  $('tr#check_'+n).find('td#td4_'+n).html();
	desg =  $('tr#check_'+n).find('td#td5_'+n).html();
	e_id =  $('tr#check_'+n).find('td#td6_'+n).html();
	mobile=  $('tr#check_'+n).find('td#td7_'+n).html();
	admin_pri =  $('tr#check_'+n).find('td#td8_'+n).html();
	course =  $('tr#check_'+n).find('td#td9_'+n).html();

	course = trimstr(course);
	
	document.getElementById("oldinstCourseId").value = course;
	$('#check_'+n+ ' td#td1_'+n).empty();
	$('tr#check_'+n+ ' td#td1_'+n).append('<input type="text" id="text9" name = "edit2_txt1" style = "border:none; width:45px; "readonly/>');
	document.getElementById("text9").value = i_id;
	$('#check_'+n+ ' td#td2_'+n).empty();
	$('tr#check_'+n+ ' td#td2_'+n).append('<input type="text" id="text10" name = "edit2_txt2" size= "30" style = "border:none; width:145px;"/>');
	document.getElementById("text10").value = i_n;
	document.getElementById("text10").focus();
	$('#check_'+n+ ' td#td3_'+n).empty();
	$('tr#check_'+n+ ' td#td3_'+n).append('<input type="text" id="text11" size= "8" name = "edit2_txt3" style = "border:none; width:100px;" onfocus = "show_calender()"/>');
	document.getElementById("text11").value = doj;
	
	//Dept ID
	$('#check_'+n+ ' td#td4_'+n).empty();
    $('tr#check_'+n+ ' td#td4_'+n).append('<select type="text" id="text12" name = "edit2_txt4" onchange="getCourseValueInst(this.value)" style = "width:90px;"></select>');
	document.getElementById("text12").value = d_id;
    $('#dept option').clone().appendTo('#text12');
    
    
    
	$('#check_'+n+ ' td#td5_'+n).empty();
	//$('#dept option').clone().appendTo('#text4');
	$('tr#check_'+n+ ' td#td5_'+n).append('<input type="text" id="text5" name = "edit2_txt5"  size= "11" style = "border:none"/>');
	document.getElementById("text5").value = desg;
	$('#check_'+n+ ' td#td6_'+n).empty();
	$('tr#check_'+n+ ' td#td6_'+n).append('<input type="text" id="text6" name = "edit2_txt6" size= "12" style = "border:none"/>');
	document.getElementById("text6").value = e_id;
	//document.getElementById("text2").focus();
	$('#check_'+n+ ' td#td7_'+n).empty();
	$('tr#check_'+n+ ' td#td7_'+n).append('<input type="text" id="text7" size= "10" name = "edit2_txt7" style = "border:none" maxlength = "10"/>');
	document.getElementById("text7").value = mobile;
	$('#check_'+n+ ' td#td8_'+n).empty();
	$('tr#check_'+n+ ' td#td8_'+n).append('<input type="text" id="text8" name = "edit2_txt8" size= "3" style = "border:none" maxlength = "1"/>');
	document.getElementById("text8").value = admin_pri;
	
	
	
	//Course name
	$('#check_'+n+ ' td#td9_'+n).empty();
    $('tr#check_'+n+ ' td#td9_'+n).append('<select name="edit_txt9" id="text69" style = "width:90px;"></select>');
	$('#course option').clone().appendTo('#text69');
	
	
	
	document.getElementById("text12").value = d_id;
	document.getElementById("text69").value = course;
	
	var opt = document.createElement("option");
	document.getElementById("text69").options.add(opt);
   opt.text = course;
    opt.value = course;
  document.getElementById("text69").value=course;

	}
	document.getElementById("btn_edit_inst").value = "6";

	
}
function show_calender()
{
	$('#text11').datepicker();
}
function save_values()
{
	document.getElementById("hid").value = "1";
	var email = document.getElementById("text6").value;
	var atpos=email.indexOf("@");
	var dotpos=email.lastIndexOf(".");
	var admin = document.getElementById("text8").value;
	if(document.getElementById("text9").value== "")
		{
		alert("Please Enter the InstrID!!!");
		return false;
		}
	else if(document.getElementById("text10").value== "")
		{
			alert("Please Enter the Instructor Name!!!");
			return false;
		}
	else if(document.getElementById("text11").value== "")
	{
		alert("Please Enter the Date of Joining!!!");
		return false;
	}
	else if(document.getElementById("text12").value== "")
	{
		alert("Please Enter the DeptID !!!");
		return false;
	}
	else if(document.getElementById("text5").value== "")
	{
		alert("Please Enter the Designation !!!");
		return false;
	}
	else if (atpos<1 || dotpos<atpos+2 || email == "")
	{
		  alert("Not a valid e-mail address !!!");
		  return false;
	}
	else if(admin.length<1 || (isNaN(admin)== true))
	{
		alert("Please Enter the valid Admin Priviledges!!!");
		return false;
	}
	else if(mobile.length<10 || (isNaN(mobile)==true))
	{
	   alert("Enter a Valid Mobile No. !!");
	   return false; 
	}

	if(i_n == document.getElementById("text10").value &&  doj == document.getElementById("text11").value && d_id == document.getElementById("text12").value && desg == document.getElementById("text5").value && e_id == document.getElementById("text6").value && mobile == document.getElementById("text7").value && admin_pri == document.getElementById("text8").value && course == document.getElementById("text69").value)
	
	{
		var r = confirm("You have not done any changes.Do you want to close edit");
		if(r == true)
			{
			   window.location = "./instructor.jsp";
			   return true;
			}
		else
			{
			   
			   return false;
			
			}
		
	}
	
	document.forms["my_form"].submit();
	
	
}
function add_new()
{
	
	document.getElementById("hid").value = "2";
	
	document.getElementById("btn_delc").value = "5";	
	
	
	var l = document.getElementById("count").value;
	
	$('#my_table > tbody:last').after('<tr><td width= "4%"><input type="text" id="new_value_1" name="new_value_1"  size= "4" style="border:none "/></td> '
			  +' <td width= "10%"><input type="text" style="border:none " id="new_value_2" name="new_value_2" size= "15"/></td> '
			   +'<td width= "10%"><input type="text" style="border:none " id="new_value_3" name="new_value_3" size= "9"/></td> '
			   +'<td width= "10%"><select name="new_value_4" id="new_value_4" onchange="getCourseValueInst(this.value)"><option value ="-1">Select</option></select></td> '
			   +'<td width= "10%"><input type="text" id="new_value_5" name="new_value_5"  size= "10" style="border:none "/></td>'
			   +'<td width= "10%"><input type="text" id="new_value_6" name="new_value_6"  size= "12" style="border:none "/></td>'
			   +'<td width= "10%"><input type="text" id="new_value_7" name="new_value_7"  size= "10" style="border:none " maxlength = "10"/></td>'
			   +'<td width= "10%"><input type="text" id="new_value_8" name="new_value_8" maxlength = "1" size= "3" style="border:none "/></td>'
			   +'<td width= "10%"><select name="text69" id="text69"></select></td>'
			   +'<td width= "6%"><img src="save.jpg" height="32" width="32" value = "s" onclick= "s_add()" alt="button" title = "Save"></td>'
			   +'<td width="6%"><img src="del.png" height="37" width="37"value="cancel" title = "Cancel" onClick="window.location.reload()"/></td></tr>');
	
	document.getElementById("new_value_1").focus();
	$('#dept option').clone().appendTo('#new_value_4');
	$('#course option').clone().appendTo('#text69');
}
function s_add()
{
document.getElementById("hid").value = "2";
var email = document.getElementById("new_value_6").value;
var atpos=email.indexOf("@");
var dotpos=email.lastIndexOf(".");
var mobile = document.getElementById("new_value_7").value;
var admin = document.getElementById("new_value_8").value;

	if(document.getElementById("new_value_1").value== "")
		{
		alert("Please Enter the InstrID!!!");
		return false;
		}
	else if(document.getElementById("new_value_2").value== "")
		{
			alert("Please Enter the Instructor Name!!!");
			return false;
		}
	else if(document.getElementById("new_value_3").value== "")
	{
		alert("Please Enter the Date of Joining!!!");
		return false;
	}
	else if(document.getElementById("new_value_4").value== "")
	{
		alert("Please Enter the DeptID !!!");
		return false;
	}
	else if(document.getElementById("new_value_5").value== "")
	{
		alert("Please Enter the Designation !!!");
		return false;
	}
	else if (atpos<1 || dotpos<atpos+2 || email == "")
	  {
	  alert("Not a valid e-mail address !!!");
	  return false;
	  }
	else if(admin.length<1 || (isNaN(admin)== true))
	{
		alert("Please Enter the Admin Priviledges!!!");
		return false;
	}
	else if(mobile.length<10 || (isNaN(mobile)==true))
	{
	   alert("Enter a Valid Mobile No. !!");
	   return false; 
	}
	document.forms["my_form"].submit();

}
function delete_values_inst(a){

	var coursedel =  $('tr#check_'+a).find('td#td9_'+a).html();
	alert(coursedel);
	coursedel = trimstr(coursedel);

	alert("Course " + coursedel);
	document.getElementById("oldinstCourseId").value =  coursedel;
	
	
	
	if(document.getElementById("btn_del_inst").value == "5"  ||  document.getElementById("btn_delc").value == "5")
	{
		alert("Please Save the Data First");
	
	}
else
	{
	
	document.getElementById("hid").value = "3" ;
	var where_to= confirm("Do you really want to delete?");
	{
		if (where_to== true)
		 {
			alert("Record Deleted Successfully !!!");
		 }
		else
			{
			return false;
			}
		}

   var i_id =  $('tr#check_'+a).find('td#td1_'+a).html();
    document.getElementById("hid1").value = i_id;
    $('tr#check_'+a).remove();
    document.forms["my_form"].submit();
    document.getElementById("btn_del_inst").value = "0";	
	}
	 
 }
function search_result_inst()
{
	
	var search=document.getElementById("search_box").value;
	
	if(search=="")
	{
	alert("enter the name!!");
	return false;
	}
	
	$("#my_table").remove();
	
	document.getElementById("addnew").style.visibility='hidden';
	var xmlhttp;
	if (window.XMLHttpRequest)
	  { 
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	    document.getElementById("wrapper").innerHTML=xmlhttp.responseText;
	    }
	  }
	
	xmlhttp.open("GET","search.jsp?search="+search+"&type=inst",true);
	xmlhttp.send();
	
}	
