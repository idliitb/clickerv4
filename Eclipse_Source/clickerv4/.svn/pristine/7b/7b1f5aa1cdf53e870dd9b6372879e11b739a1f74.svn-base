var CurrentSelectedRow = 0;
var graphResponses;
var xmlhttp;
var previousSelectedRow = 0;
var previousSelectedColor = "#ffffff";
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



function editValue() {

	if (CurrentSelectedRow == "0") {
		alert("select Instructor....");
	} else {

		getXMLhttp();

		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("instr_dialog").style.visibility = 'visible';
				document.getElementById("instr_dialog").title = "Instructor Details";
				document.getElementById("instr_dialog").innerHTML = xmlhttp.responseText;
				$("#instr_dialog").dialog({
					height : 500,
					width : 500,
					draggable : false,
					modal : true
				});
			}
		};

		xmlhttp.open("GET", "instrutor_details.jsp?instructor_id="
				+ CurrentSelectedRow, true);
		xmlhttp.send();
	}

}



function add_instr() {

	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			document.getElementById("instr_dialog").style.visibility = 'visible';
			document.getElementById("instr_dialog").title = "Add Instructor";

			document.getElementById("instr_dialog").innerHTML = xmlhttp.responseText;
			$("#instr_dialog").dialog({
				height : 500,
				width : 500,
				draggable : false,
				modal : true
			});
		}
	};

	xmlhttp.open("GET", "addinstructor.jsp", true);
	xmlhttp.send();

}

function search_inst() {
	
	var search = document.getElementById("search_box").value;
	if (search == "") {
		alert("enter the Instructor");
	} else {
		getXMLhttp();
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

				document.getElementById("instr_dialog").style.visibility = 'visible';
				document.getElementById("instr_dialog").title = "Instructor Details";
				document.getElementById("instr_dialog").innerHTML = xmlhttp.responseText;
				$("#instr_dialog").dialog({
					height : 550,
					width : 500,
					draggable : false,
					modal : true
				});
			}
		};
		xmlhttp.open("GET", "instrutor_details.jsp?instructor_id=" + search,
				true);
		xmlhttp.send();
	}

}

function add_instr_details() {
	

	var Instructor_id = document.getElementById('instr_id').value;

	var year_of_join = document.getElementById('instr_doj').value;

	var instr_email_id = document.getElementById('instr_email_id').value;

	var instr_name = document.getElementById('instr_name').value;

	var Desg=document.getElementById('instr_Designation').value;
	
	//var Desg=document.getElementById('instr_Desg').options[document.getElementById('instr_Desg').selectedIndex].text;;
	
	var mobile_no=document.getElementById('instr_mobile_no').value;
	
	var course = document.getElementById('instr_course_list').options[document.getElementById('instr_course_list').selectedIndex].text;
	
	var admin = document.getElementById('instr_Admin').options[document.getElementById('instr_Admin').selectedIndex].text;
	
	

	var dept_id = $(instr_Dept_id).children(":selected").attr("id");
	
	if(Instructor_id == "")
		alert("Enter Instructor ID");
	else if (year_of_join == "")
		alert("Enter Year of ");
	else if(instr_email_id == "")
		alert("Enter Mail Id");		
	else if(instr_name == "")
		alert("Enter Instructor Name");		
	else if(Desg == "")
		alert("Enter Designation");
	else if(mobile_no =="")
		alert("Enter Mobile NO");
	else if(course == "SELECT")
		alert("Select the Course");
	else if(dept_id == "SELECT")
		alert("Select the Department");
	else
		{
		
		var x=instr_email_id;
		//alert(x);
		var atpos=x.indexOf("@");
		var dotpos=x.lastIndexOf(".");
		if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length)
		  {
		  alert("Not a valid e-mail address");
		  return false;
		  }
		var re = /^(\+91-|\+91|0)?\d{10}$/;
		if (mobile_no.match(re))
			{
			//alert("match");
			}
		else
		{
			alert("Enter Proper Mobile No");
		    return false;
			}
		}
		
	{
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			}
		};
       
		// document.getElementById('mac_txt').value = "";
		var where_to = confirm("Do you want to add Instructor?");
		{
			if (where_to == true) {
				
				xmlhttp.open("GET", "../../Instructor?InstructorID="+ Instructor_id + "&Instructor_name="+instr_name+"&DOJ=" + year_of_join+ "&email_id=" + instr_email_id +"&dept_id=" + dept_id + "&Desgination=" + Desg+ "&mobile_no="+mobile_no+"&Admin_pre="+admin+"&Course="+course+"&Flag=Add", true);
				var sTempTableRow="<tr><td>"+Instructor_id+" </td><td align='left'>"+instr_name+"</td><td>"+dept_id+"</td></tr>";
			     $('#instructor_table').append(sTempTableRow);
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



function delete_de()
{
	
	if (CurrentSelectedRow != "0") {

		// var student_id=document.getElementById('student_id').value;
		getXMLhttp();
		// var e;
		// e = document.getElementById("raise_hand_id");

		{

			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

				}
			};

			var where_to = confirm("Do you really want to Delete Instructor?");
			{
				if (where_to == true) {
                    //  alert("../../Instructor?InstructorID="+ CurrentSelectedRow + "&Flag=Delete");
					xmlhttp.open("GET", "../../Instructor?InstructorID="+ CurrentSelectedRow + "&Flag=Delete", true);

					var row = document.getElementById(CurrentSelectedRow);
					row.parentNode.removeChild(row);
					previousSelectedRow = 0;
					CurrentSelectedRow = 0;
					
					

				} else {
					return false;
				}
			}

			xmlhttp.send();
		}
	} else {
		alert("select ");
	}

}
function delete_values_inst() {
	
	
	
	if (CurrentSelectedRow != "0") {

		// var student_id=document.getElementById('student_id').value;
		getXMLhttp();
		// var e;
		// e = document.getElementById("raise_hand_id");

		{

			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

				}
			};

			var where_to = confirm("Do you really want to Delete Instructor?");
			{
				if (where_to == true) {
                      
					xmlhttp.open("GET", "../../Instructor?InstructorID="+ CurrentSelectedRow + "&Flag=Delete", true);

					var row = document.getElementById(CurrentSelectedRow);
					row.parentNode.removeChild(row);
					previousSelectedRow = 0;
					CurrentSelectedRow = 0;
					$('#instr_dialog').dialog("close");
					

				} else {
					return false;
				}
			}

			xmlhttp.send();
		}
	} else {
		alert("select ");
	}

	// alert(CurrentSelectedRow);
}




function update_instr_details()
{
	// var student_id=document.getElementById('student_id').value;
	
	var Instructor_id = document.getElementById('I_id').value;
	
	var instr_name = document.getElementById('I_name').value;

	var year_of_join = document.getElementById('I_year_of_join').value;

	var instr_email_id = document.getElementById('I_email_id').value;

	

	var Desg=document.getElementById('I_Desg').value;
	
	//var Desg=document.getElementById('instr_Desg').options[document.getElementById('instr_Desg').selectedIndex].text;;
	
	var mobile_no=document.getElementById('I_Mobile_no').value;
	
	
	if(Instructor_id == "")
		alert("Enter Instructor ID");
	else if(instr_name == "")
		alert("Enter Instructor Name");	
	else if (year_of_join == "")
		alert("Enter Year of ");
	else if(instr_email_id == "")
		alert("Enter Mail Id");		
		
	else if(Desg == "")
		alert("Enter Designation");
	else if(mobile_no =="")
		alert("Enter Mobile NO");
	else
		{
		
		
		
		var x=instr_email_id;
		//alert(x);
		var atpos=x.indexOf("@");
		var dotpos=x.lastIndexOf(".");
		if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length)
		  {
		  alert("Not a valid e-mail address");
		  return false;
		  }
		var re = /^(\+91-|\+91|0)?\d{10}$/;
		if (mobile_no.match(re))
			{
			//alert("match");			
			}
		else
		{
			alert("Enter Proper Mobile No");
		    return false;
			}
		
	getXMLhttp();
	// var e;
	// e = document.getElementById("raise_hand_id");
//alert("upadte");
	{

		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			}
		};

		var where_to = confirm("Do you really want to Update Instructor?");
		{
			if (where_to == true) {
               // alert("../../Instructor?InstructorID="+ CurrentSelectedRow +  "&Instructor_name="+instr_name+"&DOJ=" + year_of_join+ "&email_id=" + instr_email_id +"&Desgination=" + Desg+ "&mobile_no="+mobile_no+"&Flag=Update");
				xmlhttp.open("GET", "../../Instructor?InstructorID="+ CurrentSelectedRow +  "&Instructor_name="+instr_name+"&DOJ=" + year_of_join+ "&email_id=" + instr_email_id +"&Desgination=" + Desg+ "&mobile_no="+mobile_no+"&Flag=Update", true);

				//var row = document.getElementById(CurrentSelectedRow);
		//		row.parentNode.removeChild(row);
			//	previousSelectedRow = 0;
				//CurrentSelectedRow = 0;

			} else {
				return false;
			}
		}

		xmlhttp.send();
	}
		}
}

function getinstrCourseValue(s) {
	var id = $(s).children(":selected").attr("id");
  
	getCourseVal(id);
}

var currentCourse;
function trimstr(s) {
	return s.replace(/^\s+|\s+$/g, '');
}
function getCourseVal(value) {
    
	currentCourse = value;
	var courselist = 0;

	getXMLhttp();

	xmlhttp.open("GET", "getCourseList.jsp?deptid=" + value, true);
	xmlhttp.send();
	xmlhttp.onreadystatechange = addCourseList;

	function addCourseList() {

		var courseSelect = document.getElementById("instr_course_list");
		courseSelect.options.length = 0;
		var option = document.createElement("option");
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			courselist = xmlhttp.responseText;
		}
		courselist = trimstr(courselist);
		var courseArr = courselist.split(";");
		for ( var i = 0; i < courseArr.length - 1; i++) {	
			option.text = courseArr[i];
			courseSelect.options[courseSelect.options.length] = new Option(
					courseArr[i], courseArr[i]);
		}
	}

}

function add_course()
{
	var Instructor_id = document.getElementById('I_id').value;
	var course = document.getElementById('I_course_select').options[document.getElementById('I_course_select').selectedIndex].text;
  //  alert(Instructor_id);
  //  alert(course);
    
 
	getXMLhttp();	
	{
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			}
		};

		var where_to = confirm("Do you really want to Add Course?");
		{
			if (where_to == true) {

				xmlhttp.open("GET", "../../Instructor?InstructorID="+ Instructor_id + "&Course="+course+"&Flag=Add_Course", true);				
				
			} else {
				return false;
			}
		}

		xmlhttp.send();
	} 
    
	remove_option_I_course_select();
    

}



function remove_option_I_course_select() {

	var htmlSelect = document.getElementById('I_course_select');
	var htmlSelect1 = document.getElementById('I_course');

	var optionDisplaytext = document.getElementById('I_course_select').options[document
			.getElementById('I_course_select').selectedIndex].text;

	var optionValue = "optionDisplaytext";

	var selectBoxOption = document.createElement("option");
	selectBoxOption.value = optionValue.value;
	selectBoxOption.text = optionDisplaytext;
	htmlSelect1.add(selectBoxOption, null);

	if (htmlSelect.options.length == 0) {
		alert('You have already removed all list items');
		return false;
	}

	var optionToRemove = htmlSelect.options.selectedIndex;
	htmlSelect.remove(optionToRemove);

	if (htmlSelect.options.length > 0) {
		htmlSelect.options[0].selected = true;
	}

	return true;

}



function delete_course()
{
	var Instructor_id = document.getElementById('I_id').value;
	var course = document.getElementById('I_course').options[document.getElementById('I_course').selectedIndex].text;
    
 
	getXMLhttp();	
	{
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			}
		};

		var where_to = confirm("Do you really want to Delete Course?");
		{
			if (where_to == true) {

				xmlhttp.open("GET", "../../Instructor?InstructorID="+ Instructor_id + "&Course="+course+"&Flag=Remove_Course", true);				
				
			} else {
				return false;
			}
		}

		xmlhttp.send();
	} 
    
	remove_option_I_course();
    

}

function remove_option_I_course() {

	var htmlSelect = document.getElementById('I_course');
	var htmlSelect1 = document.getElementById('I_course_select');

	var optionDisplaytext = document.getElementById('I_course').options[document
			.getElementById('I_course').selectedIndex].text;

	var optionValue = "optionDisplaytext";

	var selectBoxOption = document.createElement("option");
	selectBoxOption.value = optionValue.value;
	selectBoxOption.text = optionDisplaytext;
	htmlSelect1.add(selectBoxOption, null);

	if (htmlSelect.options.length == 0) {
		alert('You have already removed all list items');
		return false;
	}

	var optionToRemove = htmlSelect.options.selectedIndex;
	htmlSelect.remove(optionToRemove);

	if (htmlSelect.options.length > 0) {
		htmlSelect.options[0].selected = true;
	}

	return true;

}

function close_add_div()
{	

$(instr_dialog).parent().remove();
document.getElementById("instr_dialog").style.visibility = 'hidden';
location.reload();
}

