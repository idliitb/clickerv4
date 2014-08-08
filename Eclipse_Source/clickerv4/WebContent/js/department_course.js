var xmlhttp;
var Student_ID = null;
var CurrentSelectedRow = 0;
var previousSelectedRow = 0;
var previousSelectedColor = "#ffffff";
var CourseCurrentSelectedRow = 0;
var CoursepreviousSelectedRow = 0;
var CoursepreviousSelectedColor = "#ffffff";


function nospaces(t){

	if(t.value.match(/\s/g)){

	alert('Sorry, you are not allowed to enter any spaces');

	t.value=t.value.replace(/\s/g,'');

	}
	
	t.value = t.value.toUpperCase();

	}

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
	if (previousSelectedRow != 0) {
		 document.getElementById(pid).style.background = previousSelectedColor;
		 previousSelectedColor = document.getElementById(cid).style.background;
		 document.getElementById(cid).style.background = "#33CC33";
		 previousSelectedRow = SelectedRow;
	     CourseCurrentSelectedRow = 0;
		 CoursepreviousSelectedRow = 0;
		 open_course();
	} else {
		previousSelectedColor = document.getElementById(cid).style.background;
		document.getElementById(cid).style.background = "#33CC33";
		previousSelectedRow = SelectedRow;
		open_course();
	}
}

function open_course()
{
	var inst_count=document.getElementById("instcount").value;
	
	if(inst_count=="1")
		{
		
		window.location.assign("../../jsp/admin/institute.jsp");
		}
	
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {			
			document.getElementById("course_div").innerHTML = xmlhttp.responseText;			
		}
	};
	xmlhttp.open("GET", "course.jsp?Dept_ID="+CurrentSelectedRow, true);
	xmlhttp.send();
}



function add_new_Department()
{
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			document.getElementById("department_dialog").style.visibility = 'visible';
			document.getElementById("department_dialog").title = "Add New Department";
			document.getElementById("department_dialog").innerHTML = xmlhttp.responseText;
			$("#department_dialog").dialog({
				height : 250,
				width : 500,
				draggable : false,
				modal : true
			});
		}
	};

	xmlhttp.open("GET", "add_department.jsp", true);
	xmlhttp.send();


}




function add_depart()
{

var depart_id = document.getElementById('Department_id').value;




var Department_name = document.getElementById('Department_name').value;


var hod = document.getElementById('hod').value;

if(depart_id == "")
	alert("enter Department ID");
else if (Department_name =="")
	alert("Enter Department Name");
else if(hod == "")
	{
	alert("Enter HOD Name")
	}else


{
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

		}
	};

	// document.getElementById('mac_txt').value = "";
	var where_to = confirm("Do you really want to add Department?");
	{
		if (where_to == true) {	
			
			xmlhttp.open("GET", "../../DepartmentCourse?DepartmentID="+ depart_id + "&Department_name="+Department_name+"&HOD=" + hod +"&Flag=Department_Add", true);
			var sTempTableRow="<tr><td >"+depart_id+" </td><td align='left'>"+Department_name+"</td><td align='left'>"+hod+"</td></tr>";
		    $('#department_table').append(sTempTableRow);
		    //alert("Department Added Successfully");
		   // window.location.reload();
		} else {
			return false;
		}
	}
	xmlhttp.send();

document.getElementById('Department_id').value="";


document.getElementById('Department_name').value="";


 document.getElementById('hod').value="";
}
}

function delete_Department()
{	
	
	getXMLhttp();
	if(CurrentSelectedRow !=0)
		{
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
		}
	};
	var where_to = confirm("Do you want to Delete the Department?");
	{
		if (where_to == true) {
			//alert("../../DepartmentCourse?DepartmentID="+ CurrentSelectedRow +"&Flag=Department_Delete");
       		xmlhttp.open("GET", "../../DepartmentCourse?DepartmentID="+ CurrentSelectedRow +"&Flag=Department_Delete", true);
			//$('#department_dialog').dialog("close");	
       		var row = document.getElementById(CurrentSelectedRow);
			row.parentNode.removeChild(row);
			previousSelectedRow = 0;
			CurrentSelectedRow = 0;
			//location.reload();
		} else {
			return false;
		}
	}
		xmlhttp.send();
		}else
			alert("Select Department");
}

function update_D()
{
	
	var new_dept_id = document.getElementById('U_Depart_id').value;
	
	var Dept_name = document.getElementById('U_Depart_name').value;
	
	var hod= document.getElementById('U_Dept_hod').value;
	//alert("gobi");
	getXMLhttp();
	
	
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			}
		};
		var where_to = confirm("Do you want to Update  Department?");
		{
			if (where_to == true) {
				//alert("../../DepartmentCourse?DepartmentID="+ CurrentSelectedRow +"&NewDeptID="+new_dept_id+"&Department_name="+Dept_name+"&HOD="+hod+"&Flag=Department_Update");
                 //xmlhttp.open("GET", "../../Instructor?InstructorID="+ CurrentSelectedRow + "&Flag=Delete", true);
				xmlhttp.open("GET", "../../DepartmentCourse?DepartmentID="+ CurrentSelectedRow +"&NewDeptID="+new_dept_id+"&Department_name="+Dept_name+"&HOD="+hod+"&Flag=Department_Update", true);
				//$('#department_dialog').dialog("close");	
			} else {
				return false;
			}
		}
			xmlhttp.send();
			document.getElementById('U_Depart_id').value="";
			
			 document.getElementById('U_Depart_name').value="";
			
			 document.getElementById('U_Dept_hod').value="";
}

function delete_course()
{
	
	if (CourseCurrentSelectedRow != 0) {
		// var student_id=document.getElementById('student_id').value;
		getXMLhttp();
		// var e;
		// e = document.getElementById("raise_hand_id");
		{
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				}
			};
			var where_to = confirm("Do you really want to Delete Course?");
			{
				if (where_to == true) {
	                 //xmlhttp.open("GET", "../../Instructor?InstructorID="+ CurrentSelectedRow + "&Flag=Delete", true);
					xmlhttp.open("GET", "../../DepartmentCourse?courseID="+ CourseCurrentSelectedRow +"&Flag=Course_Delete", true);
								
				} else {
					return false;
				}
			}
				xmlhttp.send();
				var row = document.getElementById(CourseCurrentSelectedRow);
				row.parentNode.removeChild(row);
				CoursepreviousSelectedRow = 0;
				CourseCurrentSelectedRow = 0;
		}
	} else {
		alert("select ");
	}
}


function update_DC()
{
	if(CourseCurrentSelectedRow != 0)
		{
	var Course_id=document.getElementById('course_id').value;	
	var Course_name=document.getElementById('course_name').value;
	var Course_desc=document.getElementById('course_desc').value;
    getXMLhttp();
    xmlhttp.onreadystatechange = function() {
	if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
	}
};
var where_to = confirm("Do you want to Update  Course?");
{
	if (where_to == true) {
		
         //xmlhttp.open("GET", "../../Instructor?InstructorID="+ CurrentSelectedRow + "&Flag=Delete", true);
		xmlhttp.open("GET", "../../DepartmentCourse?courseID="+ CourseCurrentSelectedRow +"&New_courseID="+Course_id+"&CourseName="+Course_name+"&CourseDesc="+Course_desc+"&Flag=Course_Update", true);
		//$('#department_dialog').dialog("close");	
		
	} else {
		return false;
	}
}

xmlhttp.send();
document.getElementById('course_id').value="";	
document.getElementById('course_name').value="";
document.getElementById('course_desc').value="";
		}else
			alert("Select the Course");
}

function delete_course_btn()
{
	

//alert(CourseCurrentSelectedRow+" == Press");
if (CurrentSelectedRow != 0) {
	// var student_id=document.getElementById('student_id').value;
	getXMLhttp();
	// var e;
	// e = document.getElementById("raise_hand_id");
	{
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			}
		};
		var where_to = confirm("Do you really want to Delete Course?");
		{
			if (where_to == true) {
                xmlhttp.open("GET", "../../DepartmentCourse?courseID="+ CourseCurrentSelectedRow +"&Flag=Course_Delete", true);
				//alert("Department Deleted Successfully");
                var row = document.getElementById(CourseCurrentSelectedRow);
				//alert("Department Deleted Successfully");
				//window.location.reload();
				row.parentNode.removeChild(row);
				coursepreviousSelectedRow = 0;
				courseCurrentSelectedRow = 0;	
				window.location.reload();							
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


function edit_dept()
{
	
	var id=document.getElementById('D_search_box').value;
	
	if(id == "")
		{
		alert("Enter the ID");
		return false;
		}
	
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("department_dialog").style.visibility = 'visible';
			document.getElementById("department_dialog").title = "Department Details";
			document.getElementById("department_dialog").innerHTML = xmlhttp.responseText;
			$("#department_dialog").dialog({
				height : 250,
				width : 500,
				draggable : false,
				modal : true
			});
		}
	};

	xmlhttp.open("GET", "department_details.jsp?Dept_ID="+id, true);
	xmlhttp.send();
}




function edit_Department()
{
	if(CurrentSelectedRow != 0)
		{
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			document.getElementById("department_dialog").style.visibility = 'visible';
			document.getElementById("department_dialog").title = "Department Details";
			document.getElementById("department_dialog").innerHTML = xmlhttp.responseText;
			$("#department_dialog").dialog({
				height : 250,
				width : 500,
				draggable : false,
				modal : true
			});
		}
	};

	xmlhttp.open("GET", "department_details.jsp?Dept_ID="+CurrentSelectedRow, true);
	xmlhttp.send();
		}
	else
		alert("Select Department");
		}




function close_dept_div()
{
	location.reload();
	$('#department_dialog').dialog("close");
}



function CourserowSelected(CourseSelectedRow)
{
	CourseCurrentSelectedRow = CourseSelectedRow;
	
	
	var cid = CourseSelectedRow;
	var pid = CoursepreviousSelectedRow;
	if (CoursepreviousSelectedRow != 0) {
		document.getElementById(pid).style.background = CoursepreviousSelectedColor;
		CoursepreviousSelectedColor = document.getElementById(cid).style.background;
		document.getElementById(cid).style.background = "#33CC33";
		CoursepreviousSelectedRow = CourseSelectedRow;
		//open_course();
	} else {
		CoursepreviousSelectedColor = document.getElementById(cid).style.background;
		document.getElementById(cid).style.background = "#33CC33";
		CoursepreviousSelectedRow = CourseSelectedRow;
		//open_course();
	}
	
}



function add_new_course()
{
	
//alert("add new Course");
		
	if(CurrentSelectedRow !=0)
		{
getXMLhttp();
xmlhttp.onreadystatechange = function() {
	if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

		document.getElementById("course_div_dialog").style.visibility = 'visible';
		document.getElementById("course_div_dialog").title = "Add New Course";
		document.getElementById("course_div_dialog").innerHTML = xmlhttp.responseText;
		$("#course_div_dialog").dialog({
			height : 350,
			width : 500,
			draggable : false,
			modal : true
		});
	}
};

xmlhttp.open("GET", "add_course.jsp?Dept_ID="+CurrentSelectedRow , true);
xmlhttp.send();
		}
	else
		alert("Select Department First");

}


function add_course()
{


var course_id = document.getElementById('course_id').value;


var course_name = document.getElementById('course_name').value;


var course_desc = document.getElementById('course_desc').value;

var dept_id = document.getElementById('dep_id').value;

if(course_id == "")
	{
	alert("Enter Course ID");
	return false;
	}
if(course_name=="")
	{
	alert("Enter Course Name");
	return false;	
	}
if(course_desc=="")
	{
	alert("Enter couse Description");
	return false;
	}

		





{
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

		}
	};

	
	var where_to = confirm("Do you really want to add course?");
	{
		if (where_to == true) {
			
			
			xmlhttp.open("GET", "../../DepartmentCourse?courseID="+ course_id + "&CourseName="+course_name+"&CourseDesc=" + course_desc + "&DepartmentID="+dept_id+"&Flag=Course_Add", true);
			var sTempTableRow="<tr><td >"+course_id+" </td><td align='left'>"+course_name+"</td></tr>";
		    $('#Course_table').append(sTempTableRow);
		} else {
			return false;
		}
	}
	xmlhttp.send();
}
 document.getElementById('course_id').value="";


 document.getElementById('course_name').value="";


 document.getElementById('course_desc').value="";

 document.getElementById('dep_id').value="";


}


function edit_course_DC()
{
	if(CourseCurrentSelectedRow !=0)
		{
	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			document.getElementById("course_div_dialog").style.visibility = 'visible';
			document.getElementById("course_div_dialog").title = "Course Detail";
			document.getElementById("course_div_dialog").innerHTML = xmlhttp.responseText;
			$("#course_div_dialog").dialog({
				height : 300,
				width : 500,
				draggable : false,
				modal : true
			});
		}
	};

	xmlhttp.open("GET", "course_details.jsp?course_ID="+CourseCurrentSelectedRow , true);
	xmlhttp.send();
		}
	else
		alert("Select the Course");



}



function close_add_course_div()
{
	
	location.reload();
	$('#course_div_dialog').dialog("close");
	

}

function close_course_div()
{
	location.reload();
	$('#course_div_dialog').dialog("close");
	
}





