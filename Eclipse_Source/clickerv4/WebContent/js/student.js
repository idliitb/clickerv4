var d_n;
var d_id, dept_id;
var d_n;
var h;

var ins_id;
var priv, priv2;
var email;
var course_id;
var courseOpt;

function trimstr(s) {
	return s.replace(/^\s+|\s+$/g, '');
}

function search_result() {

	var search = document.getElementById("search_box").value;
	if (search == "") {
		alert("enter name!!");
		return false;
	}
	$("#my_table").remove();
	document.getElementById("addnew").style.visibility = 'hidden';
	var xmlhttp;
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("wrapper").innerHTML = xmlhttp.responseText;
		}
	}
	xmlhttp.open("GET", "search.jsp?search=" + search + "&type=student", true);
	xmlhttp.send();
}

var dropdownValue;
function getListValue(value) { // function for yes/no
	dropdownValue = value;
}
var currentCourse;
function getCourseValue(value) {
	currentCourse = value;
	var courselist = 0; // new Array( );
	document.getElementById("currCourse").value = "" + currentCourse;
	var xmlhttp = false;
	if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
	} else {// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.open("GET", "getCourseList.jsp?deptid=" + currentCourse+"&cid="+encodeURIComponent(courseOpt), true);
	xmlhttp.send();
	xmlhttp.onreadystatechange = addCourseList;

	function addCourseList() {
		var courseSelect=document.getElementById("text61");
		
		courseSelect.options.length = 0;
		var option=document.createElement("option");
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			courselist = xmlhttp.responseText;
		}
		courselist = trimstr(courselist);
		var courseArr = courselist.split(";");
		for ( var i = 0; i < courseArr.length-1; i++) {
			option.text=courseArr[i];
			courseSelect.options[courseSelect.options.length] = new Option(courseArr[i], courseArr[i]);
		}
	}

}


function add_new() {
	
	document.getElementById("btn_delc").value = "5";

	var l = document.getElementById("count").value;
	
	document.getElementById("addnew").removeAttribute("onClick");
	$('#my_table > tbody:last').after('<tr><td width= "10%"><input type="text" id="new_value_1" name="new_value_1"  size= "8"  style="border:none "/></td><td width= "10%"><input type="text" style="border:none " id="new_value_2" name="new_value_2" size= "8"/></td><td width= "13%"><input type="text" style="border:none " id="new_value_3" name="new_value_3" size= "12"/></td><td width= "10%"><input type="text" style="border:none " id="new_value_4" name="new_value_4" size= "8" maxlength = "4"/></td><td width= "10%"><select id = "new_value_5" name = "new_value_5" onchange="getListValue(this.value)"><option value ="-1">Select</option><option value="1">Yes</option><option value="0">No</option></select></td><td width= "10%"><select name="new_value_6" id="new_value_6" onchange="getCourseValue(this.value)"></select></td><td width = "10%"><input type="text" id="new_value_7" name="new_value_7"  size= "8"  style="border:none "/></td><td width= "10%"><select name="text61" id="text61" ><option value ="-1">Select</option></select></td><td width="8%"><img src="save.jpg" height="32" width="32" value = "s" onclick= "s_add()" alt="button" title = "Save"></td><td width="6%"><img src="del.png" height="37" width="37" value="cancel" title = "Cancel" onClick="window.location.reload()"/></td></tr>');
	$('#dept option').clone().appendTo('#new_value_6');
	$('#course option').clone().appendTo('#new_value_8');

	document.getElementById("new_value_1").focus();
}
function s_add() {
	
	
	document.getElementById("hid").value = "2";
	
	var stud_id = document.getElementById("new_value_1").value;
	
	var roll = document.getElementById("new_value_2").value;
	
	var priv = document.getElementById("new_value_5").value;
	
	var year = document.getElementById("new_value_4").value;
	
	var email = document.getElementById("new_value_7").value;
	
	var course = document.getElementById("text61").value;
	
	
	var atpos = email.indexOf("@");
	var dotpos = email.lastIndexOf(".");
	if (stud_id == "" || (isNaN(stud_id) == true)) {
		alert("Please Enter a Valid Student Id !!!");
		return false;
	} else if (roll == "" || (isNaN(roll) == true)) {
		alert("Please Enter the Valid Roll No.!!!");
		return false;
	} else if (document.getElementById("new_value_3").value == "") {
		alert("Please Enter the Student Name !!!");
		return false;
	} else if (year < 1950 || year > 2030 || (isNaN(year) == true)) {
		alert("Enter the Valid Year of Joining !!");
		return false;
	} else if (priv == "" || (isNaN(priv) == true)) {
		alert("Please Enter the Valid Priviledges !!!");
		return false;
	} else if (document.getElementById("new_value_6").value == "") {
		alert("Please Enter the Dept ID !!!");
		return false;
	} else if (atpos < 1 || dotpos < atpos + 2 || email == "") {
		alert("Not a valid e-mail address !!!");
		return false;
	}
	document.forms["my_form"].submit();
}

function edit_value(n) {
	
	document.getElementById("btn_del").value = "5";

	d_n = $('tr#check_' + n).find('td#td2_' + n).html();
	

	var l = document.getElementById("count").value;
	
	document.getElementById("addnew").removeAttribute("onClick");
	if (document.getElementById("btn_edit").value == "6"
			|| document.getElementById("btn_delc").value == "5") {
		alert("Please Save the Data First");

	} else {
		
		$('#my_table tr#check_' + n)
				.append(
						'<td width = "1%"><img src="save.jpg" height="32" width="32" value = "s" onclick ="save_values()" alt="button" title = "Save"></td>');
		d_id = $('tr#check_' + n).find('td#td1_' + n).html();
		d_n = $('tr#check_' + n).find('td#td2_' + n).html();
		h = $('tr#check_' + n).find('td#td3_' + n).html();
		ins_id = $('tr#check_' + n).find('td#td4_' + n).html();
		courseOpt = $('tr#check_' + n).find('td#td8_' + n).html();
		dept_id = $('tr#check_' + n).find('td#td6_' + n).html();
		dept_id = trimstr(dept_id);
		courseOpt = trimstr(courseOpt);
		
		document.getElementById("oldCourseId").value = courseOpt;
	

		priv = $('tr#check_' + n).find('td#td5_' + n).html();
		priv2 = priv;
		document.getElementById("privhid").value = priv2;
		

		email = $('tr#check_' + n).find('td#td7_' + n).html();
		
		course_id = $('tr#check_' + n).find('td#td8_' + n).html();

		$('#check_' + n + ' td#td1_' + n).empty();
		$('tr#check_' + n + ' td#td1_' + n)
				.append(
						'<input type="text" id="text11" name = "edit_txt1"  size= "12" style = "border:none; width:35px;" readonly/>');
		document.getElementById("text11").value = d_id;
		$('#check_' + n + ' td#td2_' + n).empty();
		$('tr#check_' + n + ' td#td2_' + n)
				.append(
						'<input type="text" id="text8" name = "edit_txt2" size= "10" style = "border:none; width:90px;"/>');
		document.getElementById("text8").value = d_n;
		document.getElementById("text8").focus();
		$('#check_' + n + ' td#td3_' + n).empty();
		$('tr#check_' + n + ' td#td3_' + n)
				.append(
						'<input type="text" id="text9" size= "8" name = "edit_txt3" style = "border:none; width:90px;"/>');
		document.getElementById("text9").value = h;
		$('#check_' + n + ' td#td4_' + n).empty();
		$('tr#check_' + n + ' td#td4_' + n)
				.append(
						'<input type="text" id="text10" name = "edit_txt4" size= "5" style = "border:none; width:70px;" maxlength = "4" />');
		document.getElementById("text10").value = ins_id;
		$('#check_' + n + ' td#td5_' + n).empty();
		
		// yes or no
		$('tr#check_' + n + ' td#td5_' + n)
				.append(
						'<select id = "edit_txt5" name = "edit_txt5" onchange="getListValue(this.value)"><option value ="-1">Select</option><option value="1">Yes</option><option value="0">No</option></select>');
		
		// Dept Id
		$('#check_' + n + ' td#td6_' + n).empty();
		$('tr#check_' + n + ' td#td6_' + n)
				.append(
						'<select name="edit_txt6" id="text6" onchange="getCourseValue(this.value)" style = "width:90px;"></select>');
		$('#dept option').clone().appendTo('#text6');

		$('#check_' + n + ' td#td7_' + n).empty();
		$('tr#check_' + n + ' td#td7_' + n)
				.append(
						'<input type="text" id="text7" name = "edit_txt7" size= "10" style = "border:none" />');
		document.getElementById("text7").value = email;
		$('#check_' + n + ' td#td8_' + n).empty();

		// Course Option
		$('tr#check_' + n + ' td#td8_' + n)
				.append(
						'<select name="edit_txt8" id="text61" style = "width:90px;"><option value ="-1">Select</option></select>');
		$('#course option').clone().appendTo('#text61');

		document.getElementById("text6").value = dept_id;

        var opt = document.createElement("option");
		document.getElementById("text61").options.add(opt);
        opt.text = courseOpt;
        opt.value = courseOpt;
        document.getElementById("text61").value=courseOpt;
		
	}

	document.getElementById("btn_edit").value = "6";

}
function save_values() {
	
	
	document.getElementById("hid").value = "1";
	var stud_id = document.getElementById("text11").value;
	var roll = document.getElementById("text8").value;
	var year = document.getElementById("text10").value;
	var emailnew = document.getElementById("text7").value;
	var course = document.getElementById("text61").value;
	var atpos = emailnew.indexOf("@");
	var dotpos = emailnew.lastIndexOf(".");
	if (stud_id == "") {
		alert("Please Enter a Valid Student Id" + stud_id);
		return false;
	} else if (roll == "") {
		alert("Please Enter the Valid Roll No.!!!");
		return false;
	} else if (document.getElementById("text9").value == "") {
		alert("Please Enter the Student Name !!!");
		return false;
	} else if ((isNaN(year) == true) || year < 1950 || year > 2030) {
		alert("Enter the Valid Year of Joining !!");
		return false;
	} else if (priv == "" || (isNaN(priv) == true)) {
		alert("Please Enter the Valid Priviledges !!!");
		return false;
	} else if (document.getElementById("text6").value == "-1") {
		alert("Please select Department ID !!!");
		return false; 
	} else if (atpos < 1 || dotpos < atpos + 2 || emailnew == "") {
		alert("Not a valid e-mail address !!!");
		return false;
	}
	
	if (d_n == document.getElementById("text8").value && h == document.getElementById("text9").value && ins_id == document.getElementById("text10").value && document.getElementById("edit_txt5").value == -1 && email == document.getElementById("text7").value && document.getElementById("text61").value == courseOpt && document.getElementById("text6").value == dept_id) {

		document.getElementById("privhid2").value = "1";

		var r = confirm("You have not done any changes.Do you want to close edit");
		if (r) {
			
			window.location = "./student.jsp";
			return true;
		} else {
			return false;

		}

	} else {
		if (document.getElementById("edit_txt5").value == -1) {

			
			document.getElementById("edit_txt5").value = priv2;
			document.getElementById("text61").value;
			document.getElementById("text6").value;
			
		}
	}

	document.forms["my_form"].submit();
}
function delete_values_stu(a) {

	
	var courseOpt = $('tr#check_' + a).find('td#td8_' + a).html();
	
	
	document.getElementById("oldCourseId").value =  courseOpt;
	
	if (document.getElementById("btn_del").value == "5"
			|| document.getElementById("btn_delc").value == "5") {
		alert("Please Save the Data First");

	} else {

		document.getElementById("hid").value = "3";
		var where_to = confirm("Do you really want to delete ?");
		{
			if (where_to == true) {
				alert("Record Deleted Successfully !!!");
			} else {
				return false;
			}
		}
		
		var stud_id = $('tr#check_' + a).find('td#td1_' + a).html();
		var rollno = $('tr#check_' + a).find('td#td2_' + a).html();
		var stud_name = $('tr#check_' + a).find('td#td3_' + a).html();
		var year = $('tr#check_' + a).find('td#td4_' + a).html();
		var priviledge = $('tr#check_' + a).find('td#td5_' + a).html();
		var dept_id = $('tr#check_' + a).find('td#td6_' + a).html();
		document.getElementById("hid1").value = stud_id;

		$('tr#check_' + a).remove();
		document.forms["my_form"].submit();
		document.getElementById("btn_del").value = "0";

	}

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