var xmlhttp;
var Student_ID = null;
var CurrentSelectedRow = 0;

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

	if (previousSelectedRow != 0) {
		document.getElementById(pid).style.background = previousSelectedColor;
		previousSelectedColor = document.getElementById(cid).style.background;
		document.getElementById(cid).style.background = "#33CC33";
		previousSelectedRow = SelectedRow;
	} else {
		previousSelectedColor = document.getElementById(cid).style.background;
		document.getElementById(cid).style.background = "#33CC33";
		previousSelectedRow = SelectedRow;
	}
}

function ind_radio() {

	document.getElementById("search_box2").disabled = false;
	document.getElementById("course_btn").disabled = false;
	document.getElementById("course_file").disabled = true;

	document.getElementById("pre_btn").disabled = true;

}

function grp_radio() {
	document.getElementById("course_file").disabled = false;
	document.getElementById("search_box2").disabled = true;
	document.getElementById("course_btn").disabled = true;
	document.getElementById("pre_btn").disabled = false;
	

}
function do_it() {
	
	var student_id = document.getElementById("search_box2").value;
	
	if(student_id == "")
		alert("Enter the Student ID");
	else
		{
	document.getElementById("search_box2").disabled = true;
	document.getElementById("course_btn").disabled = true;

	getXMLhttp();
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("cou_div").innerHTML = xmlhttp.responseText;
			document.getElementById("Course_div").style.visibility = 'visible';
			$("#Course_div").show();
			$("#Course_div").animate({
				"height" : "125px",
				"width" : "285px"
			}, "slow");

		}
	};

	xmlhttp
			.open("GET", "student_course_list.jsp?studentID=" + student_id,
					true);
	xmlhttp.send();
		}

}
function stu_close() {
	$("#Course_div").animate({
		"height" : "0px",
		"width" : "0px"
	}, "slow");
	$("#Course_div").hide();
	document.getElementById("search_box2").disabled = false;
	document.getElementById("course_btn").disabled = false;
}



function delete_student_details()
{
	

if (CurrentSelectedRow != "0")
{
		getXMLhttp();

		{

			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

				}
			};
			var student_id = CurrentSelectedRow;;

			
			var where_to = confirm("Do you really want to Delete Student?");
			{
				if (where_to == true) {
					xmlhttp.open("GET", "../../addstudentcourse?StudentID="
							+ student_id + "&Flag=6", true);
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



function Add_course() {

	var student_id = document.getElementById('student_id').value;
	var course = document.getElementById('course_select').options[document
			.getElementById('course_select').selectedIndex].text;
	var year_of_join = new Date().getFullYear();

	getXMLhttp();

	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

		}
	};

	var where_to = confirm("Do you want to Add Course ?" + course);
	{
		if (where_to == true) {
			xmlhttp.open("GET", "../../addstudentcourse?StudentID="
					+ student_id + "&CourseID=" + course + "&year_of_join="
					+ year_of_join + "&Flag=0", true);
			document.getElementById("course_select").innerHTML;
			alert("Course Added Successfully !!!");

			remove_option_course_select();

		} else {
			return false;
		}
	}

	xmlhttp.send();

}

function ind_add_course(studentid) {

	var student_id = studentid;
	var course = document.getElementById('ind_course_select').options[document
			.getElementById('ind_course_select').selectedIndex].text;
	var year_of_join = new Date().getFullYear();

	getXMLhttp();

	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

		}
	};

	var where_to = confirm("Do you want to Add Course ?" + course);
	{
		if (where_to == true) {
			xmlhttp.open("GET", "../../addstudentcourse?StudentID="
					+ student_id + "&CourseID=" + course + "&year_of_join="
					+ year_of_join + "&Flag=0", true);
			document.getElementById("ind_course_select").innerHTML;
			alert("Course Added Successfully !!!");

			remove_option_ind_course_select1();

		} else {
			return false;
		}
	}

	xmlhttp.send();

}

function ind_delete_course(student) {

	var student_id = student;

	var course = document.getElementById('ind_stud_course').options[document
			.getElementById('ind_stud_course').selectedIndex].text;

	getXMLhttp();

	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

		}
	};

	var where_to = confirm("Do you want to Add Course ?" + course);
	{
		if (where_to == true) {
			xmlhttp.open("GET", "../../addstudentcourse?StudentID="
					+ student_id + "&CourseID=" + course + "&Flag=1", true);
			document.getElementById("ind_stud_course").innerHTML;
			alert("Course Added Successfully !!!");

			remove_option_ind_course_select();

		} else {
			return false;
		}
	}

	xmlhttp.send();

}

function Delete_course() {

	var student_id = document.getElementById('student_id').value;

	var course = document.getElementById('stud_course').options[document
			.getElementById('stud_course').selectedIndex].text;
	getXMLhttp();

	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
		}
	};

	var where_to = confirm("Do you really want to delete ?");
	{
		if (where_to == true) {
			xmlhttp.open("GET", "../../addstudentcourse?StudentID="
					+ student_id + "&CourseID=" + course + "&Flag=1", true);
			document.getElementById("stud_course").innerHTML;
			alert("Record Deleted Successfully !!! ");
			remove_option_course_select1();

		} else {
			return false;
		}
	}

	xmlhttp.send();

}

function remove_mac() {

	getXMLhttp();

	if (document.getElementById('mac_txt').value == "")
		alert("MAC Address Not Assign !!!!");
	else {

		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			}
		};
		var student_id = document.getElementById('student_id').value;

		document.getElementById('mac_txt').value = "";
		var where_to = confirm("Do you really want to Remove Mac Address?");
		{
			if (where_to == true) {
				xmlhttp.open("GET", "../../addstudentcourse?StudentID="
						+ student_id + "&Flag=3", true);

			} else {
				return false;
			}
		}

		xmlhttp.send();
	}
}

function update_student() {

	var student_id = document.getElementById('student_id').value;

	var year_of_join = document.getElementById('year_of_join').value;

	var email_id = document.getElementById('email_id').value;

	var Student_name = document.getElementById('student_name').value;

	var roll_no = document.getElementById('roll_no').value;
	var TA = document.getElementById('TA_select').options[document
			.getElementById('TA_select').selectedIndex].text;
	
	
	
	if(student_id == "")
		alert("Enter Student ID");
	else if(year_of_join == "")
		alert("Enter Year of Joinning");
	else if(email_id == "")
		alert("Enter Email ID");
	else if(Student_name == "")
		 alert("Enter Student Name");
	else if(roll_no== "")
		alert("Enter Roll No");
	else
		{
		
		var x=email_id;
		//alert(x);
		var atpos=x.indexOf("@");
		var dotpos=x.lastIndexOf(".");
		if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length)
		  {
		  alert("Not a valid e-mail address");
		  return false;
		  }
		/*
		  var re = /^(\+91-|\+91|0)?\d{10}$/;
		if (mobile_no.match(re))
			alert("match");
		else
		{
			alert("Enter Proper Mobile No");
		    return false;
			}
			*/

	getXMLhttp();

	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

		}
	};

	document.getElementById('mac_txt').value = "";
	var where_to = confirm("Do you really want to Update?");
	{
		if (where_to == true) {
			xmlhttp.open("GET", "../../addstudentcourse?StudentID="
					+ student_id + "&Student_name=" + Student_name
					+ "&email_id=" + email_id + " &roll_no=" + roll_no
					+ " &year_of_join= " + year_of_join + "&TA=" + TA
					+ "&Flag=4", true);

		} else {
			return false;
		}
	}

	xmlhttp.send();
		}
}

function search_edit_student() {

	var search = document.getElementById("search_box").value;
	if(search== "")
{
alert("Enter the Student ID");
return false;
}
	getXMLhttp();

	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			document.getElementById("student_dialog").style.visibility = 'visible';
			document.getElementById("student_dialog").title = "Student Details";

			document.getElementById("student_dialog").innerHTML = xmlhttp.responseText;
			$("#student_dialog").dialog({
				height : 550,
				width : 500,
				draggable : false,
				modal : true
			});
		}
	};

	xmlhttp.open("GET", "student_details.jsp?studentID=" + search, true);
	xmlhttp.send();

}

function edit_student() {
    
	var id = CurrentSelectedRow;
	
	if(id == "")
		{
		alert("Select the Student");
		return false;		
		}
	getXMLhttp();

	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			document.getElementById("student_dialog").style.visibility = 'visible';
			document.getElementById("student_dialog").title = "Student Details";

			document.getElementById("student_dialog").innerHTML = xmlhttp.responseText;
			$("#student_dialog").dialog({
				height : 550,
				width : 500,
				draggable : false,
				modal : true
			});
		}
	};

	xmlhttp.open("GET", "student_details.jsp?studentID=" + id, true);
	xmlhttp.send();
}

function sam(id) {
	var id = SelectedRow;

	getXMLhttp();

	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			document.getElementById("student_dialog").style.visibility = 'visible';
			document.getElementById("student_dialog").title = "Student Details";

			document.getElementById("student_dialog").innerHTML = xmlhttp.responseText;
			$("#student_dialog").dialog({
				height : 550,
				width : 500,
				draggable : false,
				modal : true
			});
		}
	};

	xmlhttp.open("GET", "student_details.jsp?studentID=" + id, true);
	xmlhttp.send();
}

function delete_student() {

	getXMLhttp();

	{

		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			}
		};
		var student_id = document.getElementById('student_id').value;

		document.getElementById('mac_txt').value = "";
		var where_to = confirm("Do you really want to Delete Student?");
		{
			if (where_to == true) {
				xmlhttp.open("GET", "../../addstudentcourse?StudentID="
						+ student_id + "&Flag=6", true);
				var row = document.getElementById(CurrentSelectedRow);
				row.parentNode.removeChild(row);
				previousSelectedRow = 0;
				CurrentSelectedRow = 0;
				$('#student_dialog').dialog("close");
				

			} else {
				return false;
			}
		}

		xmlhttp.send();
	}

}

function close_div() {
	$(student_dialog).parent().remove();
	document.getElementById("student_dialog").style.visibility = 'hidden';
	//alert("gobi");
	location.reload();

}

function add_new_student() {

	getXMLhttp();

	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			document.getElementById("student_dialog").style.visibility = 'visible';
			document.getElementById("student_dialog").title = "Add New Student";

			document.getElementById("student_dialog").innerHTML = xmlhttp.responseText;
			$("#student_dialog").dialog({
				height : 500,
				width : 500,
				draggable : false,
				modal : true
			});
		}
	};

	xmlhttp.open("GET", "addstudent.jsp", true);
	xmlhttp.send();

}

function add_student() {
	var student_id = document.getElementById('student_id').value;

	var year_of_join = document.getElementById('year_of_join').value;

	var email_id = document.getElementById('email_id').value;

	var Student_name = document.getElementById('student_name').value;

	var roll_no = document.getElementById('roll_no').value;
	var TA = document.getElementById('TA_select').options[document
			.getElementById('TA_select').selectedIndex].text;
	var course = document.getElementById('course_list').options[document
			.getElementById('course_list').selectedIndex].text;
	var m_no = document.getElementById('m_n').value;

	var dept_id = $(Dept_id).children(":selected").attr("id");

	// alert(student_id +"--"+ Student_name +"--"+ email_id+"--"+
	// year_of_join+"--"+ roll_no+"--"+ TA+"--"+course+"=="+dept_id );
	
	
	if(student_id == "")
		alert("Enter Student ID");
	else if(year_of_join == "")
		alert("Enter Year of Joinning");
	else if(email_id == "")
		alert("Enter Email ID");
	else if(Student_name == "")
		 alert("Enter Student Name");
	else if(roll_no== "")
		alert("Enter Roll No");
	else if(course== "SELECT")
		alert("Select Course");
	else if(dept_id == "SELECT")
		alert("Select Department");
	else
		{
	
		var x=email_id;
		//alert(x);
		var atpos=x.indexOf("@");
		var dotpos=x.lastIndexOf(".");
		if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length)
		  {
		  alert("Not a valid e-mail address");
		  return false;
		  }
	
	{
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

			}
		};
		var student_id = document.getElementById('student_id').value;
		document.getElementById('mac_txt').value = "";
		var where_to = confirm("Do you really want to add Student?");
		{
			if (where_to == true) {
				xmlhttp.open("GET", "../../addstudentcourse?StudentID="
						+ student_id + "&year_of_join=" + year_of_join
						+ "&email_id=" + email_id + "&Student_name="
						+ Student_name + "&roll_no=" + roll_no + "&CourseID="
						+ course + "&dept_id=" + dept_id + "&TA=" + TA
						+ "&m_no="+m_no+"&Flag=5", true);
				
			document.getElementById('student_id').value="";

				 document.getElementById('year_of_join').value="";

				 document.getElementById('email_id').value="";

				document.getElementById('student_name').value="";

				 document.getElementById('roll_no').value="";
				
				
			 document.getElementById('m_n').value="";

				;
			} else {
				return false;
			}
		}

		xmlhttp.send();
	}

}
}

function getCourse(s)
{
var id = $(s).children(":selected").attr("id");
getCourseValue1(id);
}

var currentCourse;
function getCourseValue1(value) {

	currentCourse = value;
	var courselist = 0;

	getXMLhttp();

	xmlhttp.open("GET", "getCourseList.jsp?deptid=" + value, true);
	xmlhttp.send();
	xmlhttp.onreadystatechange = addCourseList;

	function addCourseList() {

		var courseSelect = document.getElementById("course_list");
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
function trimstr(s) {
	return s.replace(/^\s+|\s+$/g, '');
}

function sam1() {

	var id = document.getElementById('search_box').value;

	if (id == "")
		alert("Enter The Student ID!!");
	else {

		getXMLhttp();

		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

				document.getElementById("student_dialog").style.visibility = 'visible';
				document.getElementById("student_dialog").title = "Student_info";
				document.getElementById("student_dialog").innerHTML = xmlhttp.responseText;
				$("#student_dialog").dialog({
					height : 550,
					width : 500,
					draggable : false,
					modal : true
				});
			}
		};

		xmlhttp.open("GET", "student_details.jsp?studentID=" + id, true);
		xmlhttp.send();
	}
}

function load_data() {
	alert("gobinath");
}

function remove_option() {

	var htmlSelect = document.getElementById('stud_course');
	var htmlSelect1 = document.getElementById('course_select');
	var optionDisplaytext = document.getElementById('stud_course').options[document
			.getElementById('stud_course').selectedIndex].text;

	var selectBoxOption = document.createElement("option");
	selectBoxOption.value = optionDisplaytext;
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

function add_option() {

	var htmlSelect = document.getElementById('stud_course');
	var optionValue = document.getElementById('txtYearValue');
	var optionDisplaytext = document.getElementById('course_select').options[document
			.getElementById('course_select').selectedIndex].text;

	if (optionDisplaytext.value == '') {
		alert('please select value');
		optionValue.focus();
		return false;
	}

	var selectBoxOption = document.createElement("option");
	selectBoxOption.value = optionValue.value;
	selectBoxOption.text = optionDisplaytext.value;
	htmlSelect.add(selectBoxOption, null);

	return true;

}
function isOptionAlreadyExist(listBox, value) {
	var exists = false;
	for ( var x = 0; x < listBox.options.length; x++) {
		if (listBox.options[x].value == value
				|| listBox.options[x].text == value) {
			exists = true;
			break;
		}
	}
	return exists;
}

function remove_option_course_select() {

	var htmlSelect = document.getElementById('course_select');
	var htmlSelect1 = document.getElementById('stud_course');

	var optionDisplaytext = document.getElementById('course_select').options[document
			.getElementById('course_select').selectedIndex].text;

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

function remove_option_course_select1() {

	var htmlSelect = document.getElementById('stud_course');
	var htmlSelect1 = document.getElementById('course_select');

	var optionDisplaytext = document.getElementById('stud_course').options[document
			.getElementById('stud_course').selectedIndex].text;

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

function remove_option_ind_course_select() {

	var htmlSelect = document.getElementById('ind_stud_course');
	var htmlSelect1 = document.getElementById('ind_course_select');

	var optionDisplaytext = document.getElementById('ind_stud_course').options[document
			.getElementById('ind_stud_course').selectedIndex].text;

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

function remove_option_ind_course_select1() {

	var htmlSelect = document.getElementById('ind_course_select');
	var htmlSelect1 = document.getElementById('ind_stud_course');

	var optionDisplaytext = document.getElementById('ind_course_select').options[document
			.getElementById('ind_course_select').selectedIndex].text;

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

function upload_courseXLS() {
	setTimeout("preview_courseXLS()", 1000);

	var xlsFile = document.getElementById("course_file").files[0];

	var formdata = new FormData();
	formdata.append("file", xlsFile);
	var xhr = new XMLHttpRequest();
	xhr.open("POST", "../../fileuploader", true);
	xhr.send(formdata);

}

function preview_courseXLS() {

	$("#student_course_div").dialog({
		modal : true,
		height : 530,
		position : "absolute",
		width : 640,
		autoOpen : false
	});
	var url = get_courseXlsUrl();

	if (url != null && url != "") {

		$("#frame2").css("height", "87%");
		$("#frame2").css("width", "100%");
		$("#frame2").attr("src", "../../StudentcoursePreview?xls=" + url);
		$("#xls1").attr("value", url);
		$("#student_course_div").css("visibility", "visible");
		$("#student_course_div").dialog("open", function() {
			$("#student_course_div").css("visibility", "hidden");
		});
	} else {
		alert("Please select an XLS file first");
	}
}

function get_courseXlsUrl() {
	var url = $("#course_file").val();

	if (url.lastIndexOf("\\") != -1) {
		url = url.slice(url.lastIndexOf("\\") + 1);
	}

	return url;
}


function uploadXLS() {
	
	setTimeout("previewXLS()",1000);
	//alert("In Upload");
    var xlsFile = document.getElementById("file").files[0];
    //alert("xlsfile: " + xlsFile);
    var formdata = new FormData();
    formdata.append("file", xlsFile);
    var xhr = new XMLHttpRequest();       
    xhr.open("POST","../../studentfileuploader", true);
    xhr.send(formdata);
    //window.location.href="../../jsp/QuestionBank/questionbank.jsp";
}

function previewXLS() {
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
		$("#frame").attr("src","../../studentpreviewXLS?xls="+url);
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
function getXlsUrl(){
	var url=$("#file").val();
	//alert("URL: " + url);
	if(url.lastIndexOf("\\")!=-1){
		url=url.slice(url.lastIndexOf("\\")+1);
	}
	return url;
}
